//
//  MNFSettings.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 21/10/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFSettings.h"
#import "MNFResponse.h"
#import "MNFLogger.h"

@implementation MNFSettings

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.apiURLsForClasses = [NSMutableDictionary dictionary];
        self.authenticationProvidersForClasses = [NSMutableDictionary dictionary];
        self.notificationCenterForStatusCode = [NSMutableDictionary dictionary];
        self.notificationNameForStatusCode = [NSMutableDictionary dictionary];
        self.culture = nil;
    }
    return self;
}

-(void)setLogLevel:(MNFLogLevel)logLevel {
    _logLevel = logLevel;
    
    [MNFLogger setLogLevel:logLevel];
    
}

@end
