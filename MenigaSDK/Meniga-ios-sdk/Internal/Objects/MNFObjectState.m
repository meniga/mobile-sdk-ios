//
//  MNFObjectState.m
//  Meniga-ios-sdk
//
//  Created by Aske Bendtsen on 30/10/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFObjectState.h"
#import "MNFLogger.h"

@interface MNFObjectState ()

@property(nonatomic, copy, readwrite)NSMutableDictionary *serverData;
@property(nonatomic, strong, readwrite)id targetClass;

@end

@implementation MNFObjectState{
    NSMutableDictionary *_serverData;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _serverData = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(instancetype)initForClass:(id)theClass withServerData:(NSDictionary *)dictionary{
    
    if ([self init]) {
        [self setState:dictionary];
        _targetClass = theClass;
    }
    
    return self;
    
}

+(instancetype)stateForClass:(id)theClass withServerData:(NSDictionary *)dictionary{
    return [[self alloc]initForClass:theClass withServerData:dictionary];
}

-(id)stateValueForKey:(NSString *)key{
    return _serverData[key];
}

-(void)setStateValue:(id)value forKey:(NSString *)key{
    if ([self stateValueForKey:key] == nil) {
        MNFLogDebug(@"Setting new state vale: %@ for key: %@", value, key);
        _serverData[key] = value;
    }
}

-(void)clearState{
    _serverData = nil;
}


#pragma mark - accessors

-(void)setState:(NSDictionary *)state{
    if (state != nil) {
        _serverData = [state mutableCopy];
    }
}

-(NSDictionary*)serverData{
    return [_serverData copy];
}


@end
