//
//  MenigaObject.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 30/09/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFObject.h"
#import "MNFInternalImports.h"
#import "MNFNetwork.h"
#import "MNFURLConstructor.h"
#import "Meniga.h"
#import "MNFJob.h"
#import "MNFRouter.h"
#import "MNFObjectState.h"
#import "MNFJsonAdapterSubclassedProperty.h"
#import <objc/runtime.h>
#import "MNFJsonAdapter.h"

@interface MNFObject () <MNFJsonAdapterDelegate>

@property(nonatomic, copy, readonly) NSArray *mutableProperties;
@property(nonatomic) NSMutableDictionary *keyValueStore;
@property(nonatomic, readwrite, getter=isDirty) BOOL dirty;
@property(nonatomic, readwrite, getter=isDeleted) BOOL deleted;
@property(nonatomic, strong) MNFObjectState *objectstate;

@end

@implementation MNFObject{
    
    NSArray *_mutableProperties;
}

#pragma mark - Initializers

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self p_setupMNFObject];
        _isNew = YES;

    }
    return self;
}

-(instancetype)initNeutral {
    
    if (self = [super init]) {
        [self p_setupMNFObject];
        _isNew = NO;
    }
    
    return self;
}

-(void)p_setupMNFObject {
    self.deleted = NO;
    _objectstate = nil;
    self.dirty = NO;
    _objectstate = [[MNFObjectState alloc]init];
    [self p_registerStateObservers];
    _keyValueStore = [[NSMutableDictionary alloc] init];
}

#pragma mark - private constructors accessible from the MNFObject private header
+(nullable instancetype)initWithServerResult:(NSDictionary *)dictionary {
    
    if (dictionary != nil && [dictionary isKindOfClass:[NSDictionary class]] == YES && dictionary.allKeys.count != 0) {
        return [MNFJsonAdapter objectOfClass:[self class] jsonDict:dictionary option:kMNFAdapterOptionNoOption error:nil];
    }
    
    return nil;
}
+(nullable NSArray*)initWithServerResults:(NSArray *)array {
    
    if (array != nil && [array isKindOfClass:[NSArray class]] == YES) {
        return [MNFJsonAdapter objectsOfClass:[self class] jsonArray:array option:kMNFAdapterOptionNoOption error:nil];
    }
    
    return nil;
}

#pragma mark - Private methods

+(MNFJob *)apiRequestWithPath:(NSString *)path pathQuery:(nullable NSDictionary*)pathQuery jsonBody:(nullable NSData*)postData HTTPMethod:(NSString*)httpMethod service:(MNFServiceName)service completion:(MNFCompletionHandler)completion {
    [completion copy];

    NSString *baseURL = [Meniga apiURLForService: service];

    NSURL *url = [MNFURLConstructor URLFromBaseUrl:baseURL path:path pathQuery:pathQuery];

    NSMutableDictionary *mutableHeaders = [[NSMutableDictionary alloc] initWithDictionary: [self p_authenticationProviderForService:service]];
    if ([Meniga apiCulture] != nil) {
        [mutableHeaders setObject: [Meniga apiCulture] forKey: @"Accept-Language"];
        
    }
    
    mutableHeaders[@"Accept"] = @"application/json";
    mutableHeaders[@"Content-type"] = @"application/json";
    mutableHeaders[@"X-XSRF-Header"] = @"true";
    
    NSURLRequest *request = [MNFRequest urlRequestWithURL:url httpMethod:httpMethod httpHeaders: mutableHeaders parameters:postData];
    MNFLogDebug(@"request: %@", request);
    
    return [MNFRouter routeRequest:request withCompletion:completion];
}

+(MNFJob *)apiRequestWithPath:(NSString *)path pathQuery:(NSDictionary *)pathQuery jsonBody:(NSData *)postData HTTPMethod:(NSString *)httpMethod service:(MNFServiceName)service percentageEncode:(BOOL)percentageEncode completion:(MNFCompletionHandler)completion {
    [completion copy];
        
    NSString *baseURL = [Meniga apiURLForService: service];
    
    NSURL *url = [MNFURLConstructor URLFromBaseUrl:baseURL path:path pathQuery:pathQuery percentageEncoded: percentageEncode];
    
    NSMutableDictionary *mutableHeaders = [[NSMutableDictionary alloc] initWithDictionary: [self p_authenticationProviderForService:service]];
    
    if ([Meniga apiCulture] != nil) {
        [mutableHeaders setObject: [Meniga apiCulture] forKey: @"Accept-Language"];
    }
    
    mutableHeaders[@"Accept"] = @"application/json";
    mutableHeaders[@"Content-type"] = @"application/json";
    mutableHeaders[@"X-XSRF-Header"] = @"true";
    
    NSURLRequest *request = [MNFRequest urlRequestWithURL:url httpMethod:httpMethod httpHeaders: mutableHeaders parameters:postData];
    
    MNFLogDebug(@"request: %@", request);
    
    return [MNFRouter routeRequest:request withCompletion:completion];
    
}

+(MNFJob*)resourceRequestWithPath:(NSString *)path pathQuery:(nullable NSDictionary*)pathQuery jsonBody:(nullable NSData*)postData HTTPMethod:(NSString *)httpMethod service:(MNFServiceName)service completion:(MNFCompletionHandler)completion {
    
    NSString *baseURL = [Meniga apiURLForService: service];
    
    NSURL *url = [MNFURLConstructor URLFromBaseUrl:baseURL path:path pathQuery:pathQuery];
    
    NSMutableDictionary *mutableHeaders = [[NSMutableDictionary alloc] initWithDictionary: [self p_authenticationProviderForService:service]];
    if ([Meniga apiCulture] != nil) {
        [mutableHeaders setObject: [Meniga apiCulture] forKey: @"Accept-Language"];
    }
    
    mutableHeaders[@"Accept"] = @"image/png";
    mutableHeaders[@"Content-type"] = @"image/png";
    mutableHeaders[@"X-XSRF-Header"] = @"true";
    
    NSURLRequest *request = [MNFRequest urlRequestWithURL:url httpMethod:httpMethod httpHeaders: mutableHeaders parameters:postData];
    MNFLogDebug(@"request: %@", request);
    
    __block MNFJob *job = [MNFJob jobWithRequest:request];
    
    [[MNFNetwork sharedNetwork] sendDownloadRequest:request withCompletion:^(MNFResponse * _Nonnull response) {
        [job setResponse:response];
        
        if (completion != nil) {
            completion(response);
        }
    }];
    
    return job;
}


+(void)executeOnMainThreadWithCompletion:(void (^)(id))completion withParameter:(nullable id)parameter {
    [completion copy];
    
    if (completion != nil) {
        if ([NSThread isMainThread] == YES) {
            __block typeof (completion) subCompletion = completion;
            subCompletion(parameter);
            subCompletion = nil;
        }
        else {
            __block typeof (completion) subCompletion = completion;
            dispatch_async(dispatch_get_main_queue(), ^{
                subCompletion(parameter);
                subCompletion = nil;
            });
        }
    }
    
}
+(void)executeOnMainThreadWithCompletion:(void (^)(id,id))completion withParameters:(nullable id)firstParameter and:(nullable id)secondParameter {
    [completion copy];
    if (completion != nil) {
        
        if ([NSThread isMainThread] == YES) {
            __block typeof (completion) subCompletion = completion;
            subCompletion(firstParameter,secondParameter);
            subCompletion = nil;
        }
        else {
            __block typeof (completion) subCompletion = completion;
            dispatch_async(dispatch_get_main_queue(), ^{
                subCompletion(firstParameter,secondParameter);
                subCompletion = nil;
            });
        }
    }
}

+(void)executeOnMainThreadWithCompletion:(void (^)(id, id , id ))completion withParameters:(id)firstParameter andSecondParam:(id)secondParameter andThirdParam:(id)thirdParameter {
    [completion copy];
    
    __block typeof (completion) subCompletion = completion;
    
    if ([NSThread isMainThread] == YES) {
        subCompletion(firstParameter, secondParameter, thirdParameter);
        subCompletion = nil;
    }
    else {

        dispatch_async(dispatch_get_main_queue(), ^{
            subCompletion(firstParameter, secondParameter, thirdParameter);
            subCompletion = nil;
        });
    }
}


#pragma mark - Execution of Completion Blocks with Job
+(void)executeOnMainThreadWithJob:(MNFJob *)theJob completion:(void (^)(id _Nonnull))completion parameter:(id)parameter {
    [theJob setResult:parameter];
    [self executeOnMainThreadWithCompletion:completion withParameter:parameter];
}

+(void)executeOnMainThreadWithJob:(MNFJob *)theJob completion:(void (^)(id _Nonnull))completion error:(nullable NSError *)theError {
    
    [theJob setError:theError];
    
    
    [self executeOnMainThreadWithCompletion:completion withParameter:theError];
    
}

+(void)executeOnMainThreadWithJob:(MNFJob *)theJob completion:(void (^)(id _Nonnull, NSError * _Nullable))completion parameter:(id)parameter error:(NSError *)theError {
    
    if (theError == nil) {
        
        [theJob setResult:parameter];
        
    }
    else {
        
        [theJob setError:theError];
        
    }
    
    
    [self executeOnMainThreadWithCompletion:completion withParameters:parameter and:theError];
}
+(void)executeOnMainThreadWithJob:(MNFJob *)theJob completion:(void (^)(id _Nonnull, NSError * _Nullable))completion parameter:(id)parameter metaData:(id)metaData error:(NSError *)theError {
    if (theError == nil) {
        [theJob setResult:parameter metaData:metaData];
    }
    else {
        [theJob setError:theError];
    }
    
    [self executeOnMainThreadWithCompletion:completion withParameters:parameter and:theError];
}

+(void)executeOnMainThreadWithJob:(MNFJob *)theJob completion:(nonnull void (^)(id _Nonnull, id _Nonnull, NSError * _Nullable))completion resultParameter:(id)theResultParam metaDataParm:(id)theMetaDataParam error:(NSError *)theError {

    [theJob setResult:theResultParam metaData:theMetaDataParam error:theError];

    [self executeOnMainThreadWithCompletion: completion withParameters: theResultParam andSecondParam: theMetaDataParam andThirdParam: theError];
    
}

#pragma mark - saving

-(MNFJob *)updateWithApiPath:(NSString*)path pathQuery:(NSDictionary*)pathQuery jsonBody:(NSData*)data httpMethod:(NSString*)httpMethod service:(MNFServiceName)service completion:(MNFCompletionHandler)completion {
    [completion copy];
    
    if (self.isDeleted) {
        completion([MNFResponse responseWithData:nil error:[MNFErrorUtils errorForDeletedObject:self] statusCode:[MNFErrorUtils errorForDeletedObject:self].code headerFields:nil]);
        return [MNFJob jobWithError:[MNFErrorUtils errorForDeletedObject:self]];
    }
    
    MNFJob *job = [[self class] apiRequestWithPath:path pathQuery:pathQuery jsonBody:data HTTPMethod:httpMethod service:service completion:^(MNFResponse*  _Nullable response) {
        if (response.error == nil) {
            [self p_resetState];
        }
        if (completion != nil) {
            completion(response);
        }
    }];
    return job;
}

#pragma mark - deleting

-(MNFJob *)deleteWithApiPath:(NSString *)path pathQuery:(NSDictionary *)pathQuery jsonBody:(NSData *)data service:(MNFServiceName)service completion:(MNFCompletionHandler)completion{
    [completion copy];
    
    if (self.isDeleted == YES) {
        
        [MNFObject executeOnMainThreadWithCompletion:completion withParameter: [MNFResponse responseWithData:nil error: [MNFErrorUtils errorForDeletedObject:self]  statusCode:-100 headerFields:nil]];
        
        return [MNFJob jobWithError:[MNFErrorUtils errorForDeletedObject:self]];
    }
    
    MNFJob *job = [[self class] apiRequestWithPath:path pathQuery:pathQuery jsonBody:data HTTPMethod:kMNFHTTPMethodDELETE service:service completion:^(MNFResponse*  _Nullable response) {
        
        if (response.error == nil) {
            self.deleted = YES;
        }
        
        if (completion != nil) {
            completion(response);
        }
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        if (error == nil) {
            self.deleted = YES;
        }
    }];
    
    return job;
}

-(void)makeDeleted {
    _deleted = YES;
}


#pragma mark - reverting

-(id)thisClass{
    return objc_getClass([NSStringFromClass([self class]) UTF8String]);
}

-(void)revert{
    
    if (_objectstate == nil || !self.isDirty || _objectstate.serverData.count==0) {
        MNFLogError(@"[%@] object does not maintain a state. Aborting revert", NSStringFromClass([self class]));
        MNFLogInfo(@"[%@] object does not maintain a state. Aborting revert", NSStringFromClass([self class]));
        MNFLogDebug(@"[%@] object does not maintain a state. Aborting revert", NSStringFromClass([self class]));
        MNFLogVerbose(@"[%@] object does not maintain a state. Aborting revert", NSStringFromClass([self class]));
        return;
    }
    
    MNFLogDebug(@"Reverting to objectState: %@", _objectstate.serverData);
    MNFLogVerbose(@"Reverting to objectState: %@", _objectstate.serverData);
    
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
        
        free(propertyList);
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
        @try {
            [self removeObserver:self forKeyPath:mutableProperty];
        } @catch (NSException *exception) {
            MNFLogError(@"Exception caught: %@",exception.reason);
        } @finally {
        }
    }
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    if (self.isDeleted) {
        [self p_observeValueForKeyPath:keyPath ofDeletedObject:object change:change];
        return;
    }
    MNFLogInfo(@"Changed mutable object property: %@ newValue:%@ oldValue:%@",keyPath, [change objectForKey:NSKeyValueChangeNewKey], [change objectForKey:NSKeyValueChangeOldKey]);
    MNFLogDebug(@"Changed mutable object property: %@ newValue:%@ oldValue:%@",keyPath, [change objectForKey:NSKeyValueChangeNewKey], [change objectForKey:NSKeyValueChangeOldKey]);


    [self p_updateStateWithValue: [change objectForKey: NSKeyValueChangeOldKey] ForKey:keyPath];


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

// need this for transaction rules bug...
-(void)setIdentifier:(NSNumber *)identifier {
    _identifier = identifier;
}

#pragma mark - Helpers

+(NSDictionary*)p_authenticationProviderForService:(MNFServiceName)service {
    
    NSObject <MNFAuthenticationProviderProtocol> *authProvider = [Meniga authenticationProviderForService:service];
    if (authProvider == nil) {
        authProvider = [Meniga authenticationProvider];
    }
    
    NSMutableDictionary *authDict = [NSMutableDictionary dictionary];
    [authDict addEntriesFromDictionary:[authProvider getHeaders]];
    [authDict addEntriesFromDictionary:[NSHTTPCookie requestHeaderFieldsWithCookies:[authProvider getCookies]]];
    
    return [authDict copy];
}

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
    MNFLogInfo(@"Cannot mutate deleted object with id: %@ of class: %@", [self identifier], [self class]);
    MNFLogDebug(@"Cannot mutate deleted object with id: %@ of class: %@", [self identifier], [self class]);
    MNFLogVerbose(@"Cannot mutate deleted object with id: %@ of class: %@", [self identifier], [self class]);
    [self setValue:[change valueForKey:NSKeyValueChangeOldKey] forKey:keyPath];
}


#pragma mark - Json Adapter Delegate Neutral Init

+(id)objectToPopulate {
    return [[self alloc] initNeutral];
}

-(NSDictionary *)jsonKeysMapToProperties {
    return @{ @"identifier" : @"id" };
}

-(NSDictionary *)propertyKeysMapToJson {
    return @{ @"identifier" : @"id" };
}

-(NSSet *)propertiesToIgnoreJsonSerialization {
    
    return [NSSet setWithObjects:@"objectstate", @"mutableProperties", @"keyValueStore", @"deleted", @"isNew", @"dirty", nil];
}

-(NSSet *)propertiesToIgnoreJsonDeserialization {
    
    return [NSSet setWithObjects:@"objectstate", @"mutableProperties", @"keyValueStore", @"deleted", @"isNew", @"dirty", nil];
}
#pragma mark - deallocation

-(void)dealloc{
    [self p_unregisterObservers];
}

@end
