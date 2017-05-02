//
//  MNFModifiableObject.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 23/10/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFMutableObject.h"
#import "MNFMutableObject_Private.h"
#import "MNFNetwork.h"
#import "MNFURLConstructor.h"
#import "Meniga.h"
#import "MNFURLRequestConstants.h"
#import "MNFHTTPMethods.h"
#import "MNFJob.h"
#import "MNFObject_Private.h"
#import "MNFObjectState.h"
#import <objc/runtime.h>
#import "MNFConstants.h"
#import "MNFRouter.h"
#import "MNFLogger.h"

@interface MNFMutableObject (){

@public
    
}

@property(nonatomic, copy, readonly)NSArray *mutableProperties;
@property(nonatomic, copy)NSMutableDictionary *keyValueStore;
@property(nonatomic, readwrite, getter=isDirty)BOOL dirty;
@property(nonatomic, readwrite, getter=isDeleted)BOOL deleted;
@property(nonatomic, strong)MNFObjectState *objectstate;

@end

@implementation MNFMutableObject{

    NSArray *_mutableProperties;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.deleted = NO;
        _objectstate = nil;
        self.dirty = NO;
        _objectstate = [[MNFObjectState alloc]init];
        [self p_registerStateObservers];
        _keyValueStore = [[NSMutableDictionary alloc] init];
    }
    return self;
}

#pragma mark - saving


-(void)updateWithApiPath:(NSString*)path pathQuery:(NSDictionary*)pathQuery jsonBody:(NSData*)data httpMethod:(NSString*)httpMethod completion:(MNFCompletionHandler)completion {
    [completion copy];
    
    if (self.isDeleted) {
        completion([MNFResponse responseWithData:nil error:[MNFErrorUtils errorForDeletedObject:self] statusCode:[MNFErrorUtils errorForDeletedObject:self].code headerFields:nil]);
        return;
    }
    
    [[self class] apiRequestWithPath:path pathQuery:pathQuery jsonBody:data HTTPMethod:httpMethod completion:^(MNFResponse*  _Nullable response) {
        if (response.error == nil) {
            [self p_resetState];
        }
        if (completion != nil) {
            completion(response);
        }
    }];
}

-(MNFJob*)updateWithApiPath:(NSString*)path pathQuery:(NSDictionary*)pathQuery jsonBody:(NSData*)data httpMethod:(NSString*)httpMethod{
    
    if (self.isDeleted) {
        MNF_BFTaskCompletionSource *completion = [MNF_BFTaskCompletionSource taskCompletionSource];
        [completion setError:[MNFErrorUtils errorForDeletedObject:self]];
        return [MNFJob jobWithCompletionSource:completion];
    }

    
    MNFJob *job = [[self class] apiRequestWithPath:path  pathQuery:pathQuery jsonBody:data HTTPMethod:httpMethod];
    
    [job.task continueWithSuccessBlock:^id(MNF_BFTask *task) {
        [self p_resetState];
        return nil;
    }];
    
    return  job;
}

#pragma mark - deleting

-(void)deleteWithApiPath:(NSString *)path pathQuery:(NSDictionary *)pathQuery jsonBody:(NSData *)data completion:(MNFCompletionHandler)completion{
    [completion copy];
    
    if (self.isDeleted) {
        completion([MNFResponse responseWithData:nil error:[MNFErrorUtils errorForDeletedObject:self] statusCode:[MNFErrorUtils errorForDeletedObject:self].code headerFields:nil]);
        return;
    }
    
    [[self class] apiRequestWithPath:path pathQuery:pathQuery jsonBody:data HTTPMethod:kMNFHTTPMethodDELETE completion:^(MNFResponse*  _Nullable response) {
        if (response.error == nil) {
            self.deleted = YES;
        }
        if (completion != nil) {
            completion(response);
        }
    }];
    
}

-(MNFJob*)deleteWithApiPath:(NSString *)path pathQuery:(NSDictionary *)pathQuery jsonBody:(NSData *)data {

    if (self.isDeleted) {
        MNF_BFTaskCompletionSource *completion = [MNF_BFTaskCompletionSource taskCompletionSource];
        [completion setError:[MNFErrorUtils errorForDeletedObject:self]];
        return [MNFJob jobWithCompletionSource:completion];
    }
    
    MNFJob *job = [[self class] apiRequestWithPath:path  pathQuery:pathQuery jsonBody:data HTTPMethod:kMNFHTTPMethodDELETE];
    
    [job.task continueWithSuccessBlock:^id(MNF_BFTask *task) {
        self.deleted = YES;
        return nil;
    }];
    
    return  job;
    
}


#pragma mark - reverting

-(id)thisClass{
    return objc_getClass([NSStringFromClass([self class]) UTF8String]);
}

-(void)revert{
    
    if (_objectstate == nil || !self.isDirty || _objectstate.serverData.count==0) {
        MNFLogError(@"[%@] object does not maintain a state. Aborting revert", NSStringFromClass([self class]));
        return;
    }
    
    MNFLogDebug(@"Reverting to objectState: %@", _objectstate.serverData);
    
    for (NSString *mutableProperty in self.mutableProperties) {
        [self setValue:[_objectstate stateValueForKey:mutableProperty] forKey:mutableProperty];
    }
    [self p_resetState];
}


#pragma mark - private accessors

-(NSArray*)mutableProperties{
    if (_mutableProperties == nil) {
        
        NSMutableArray *placeHolder = [[NSMutableArray alloc]init];
        
        unsigned int outCount =0;
        objc_property_t *propertyList = class_copyPropertyList([self thisClass], &outCount);
        
        for (int i=0; i<outCount; i++) {
            objc_property_t property = propertyList[i];
            const char *attr = property_getAttributes(property);
            
            if (strstr(attr, "R") == NULL) {// Not read only
                NSString *propName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
                [placeHolder addObject:propName];
            }
            
        }
        _mutableProperties = [placeHolder copy];
    }
    
    return _mutableProperties;
}


#pragma mark - json adaptor setter modification

-(void)setValue:(id)value forKey:(NSString *)key{
    if ([self isMutablePropertyKey:key]) {
        [self setValue:value forKey:[NSString stringWithFormat:@"_%@", key]]; //Setting the value of the synthezised ivar to avoid executing the custom setters of the mutable properties (and thereby updating the state).
    }
    else{
        [super setValue:value forKey:key];
    }
}


#pragma mark - observers

-(void)p_registerStateObservers{
    
    for (NSString *mutableProperty in self.mutableProperties) {
        [self addObserver:self forKeyPath:mutableProperty options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    }
}

-(void)p_unregisterObservers{

    for (NSString *mutableProperty in self.mutableProperties) {
        [self removeObserver:self forKeyPath:mutableProperty];
    }
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    if (self.isDeleted) {
        [self p_observeValueForKeyPath:keyPath ofDeletedObject:object change:change];
        return;
    }
    MNFLogInfo(@"Changed mutable object property: %@ newValue:%@ oldValue:%@",keyPath, [change objectForKey:NSKeyValueChangeNewKey], [change objectForKey:NSKeyValueChangeOldKey]);
    [self p_updateStateWithValue:[change objectForKey:NSKeyValueChangeOldKey] ForKey:keyPath];
}


#pragma mark - state handling

-(void)p_resetState{
    [_objectstate clearState];
    self.dirty = NO;
}


-(void)p_updateStateWithValue:(id)value ForKey:(NSString*)key{
    [self p_setDirtyIfNeeded];
    [_objectstate setStateValue:value forKey:key];
}

-(void)p_setDirtyIfNeeded{
    if (!self.isDirty) {
        self.dirty = YES;
    }
}

-(void)p_setCleanIfNeeded{
    if (self.isDirty) {
        self.dirty = NO;
    }
}


#pragma mark - setters

-(void)setIsNew:(BOOL)isNew{
    _isNew = isNew;
}

#pragma mark - Helpers

-(BOOL)p_hasValueForKey:(NSString*)key{
    return [self valueForKey:key] != nil;
}

-(BOOL)isMutablePropertyKey:(NSString*)key{
    objc_property_t property = class_getProperty([self class], [key UTF8String]);
    if (property == NULL) {
        return NO;
    }
    
    const char *attr = property_getAttributes(property);
    return (strstr(attr, "R") == NULL);
}

//Used for test
-(MNFObjectState*)objectState{

    return _objectstate;
}

#pragma mark - deleted object behaviour

-(void)p_observeValueForKeyPath:(NSString *)keyPath ofDeletedObject:(id)object change:(NSDictionary<NSString *,id> *)change{
    MNFLogError(@"Cannot mutate deleted object with id: %@ of class: %@", [self identifier], [self class]);
    [self setValue:[change valueForKey:NSKeyValueChangeOldKey] forKey:keyPath];
}


#pragma mark - deallocation

-(void)dealloc{
    [self p_unregisterObservers];
}


@end