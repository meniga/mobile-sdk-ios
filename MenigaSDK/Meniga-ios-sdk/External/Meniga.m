//
//  Meniga.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 23/10/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "Meniga.h"
#import "MNFSettings.h"
#import "MNFCryptor.h"
#import "MNFLogger.h"
#import "MNFInternalImports.h"

@implementation Meniga

static MNFSettings *s_settings = nil;

+(NSString*)sdkVersion{

    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"MNF_SDK_VERSION"];
}


+(void)setAuthenticationProvider:(NSObject<MNFAuthenticationProviderProtocol> *)authenticationProvider {
    [self p_settings].authenticationProvider = authenticationProvider;
    MNFLogInfo(@"Setting authentication provider: %@",authenticationProvider);
    MNFLogDebug(@"Setting authentication provider: %@",authenticationProvider);
    MNFLogVerbose(@"Setting authentication provider: %@",authenticationProvider);
    
}
+(NSObject <MNFAuthenticationProviderProtocol> *)authenticationProvider {
    return [self p_settings].authenticationProvider;
}

+(void)setAuthenticationProvider:(NSObject<MNFAuthenticationProviderProtocol> *)authenticationProvider forService:(MNFServiceName)service {
    NSString *key = [NSString stringWithFormat:@"MenigaServiceName%ld",service];
    [[self p_settings].authenticationProvidersForClasses setObject:authenticationProvider forKey:key];
}
+(NSObject <MNFAuthenticationProviderProtocol> *)authenticationProviderForService:(MNFServiceName)service {
    
    NSString *key = [NSString stringWithFormat:@"MenigaServiceName%ld",service];
    NSObject <MNFAuthenticationProviderProtocol> *authenticationProvider = [[self p_settings].authenticationProvidersForClasses objectForKey:key];
    if (authenticationProvider == nil) {
        authenticationProvider = [self p_settings].authenticationProvider;
    }
    
    return authenticationProvider;
}

+(void)setApiURL:(NSString *)apiURL {
    [self p_settings].apiURL = apiURL;
    
    MNFLogInfo(@"Meniga iOS SDK Version: %@", [self sdkVersion]);
    MNFLogDebug(@"Meniga iOS SDK Version: %@", [self sdkVersion]);
    MNFLogVerbose(@"Meniga iOS SDK Version: %@", [self sdkVersion]);
    
    MNFLogInfo(@"Setting api URL: %@",apiURL);
    MNFLogDebug(@"Setting api URL: %@",apiURL);
    MNFLogVerbose(@"Setting api URL: %@",apiURL);
    
}

+(NSString*)apiURL {
    return [self p_settings].apiURL;
}

+(void)setApiURL:(NSString *)apiURL forService:(MNFServiceName)service {
    NSString *key = [NSString stringWithFormat:@"MenigaServiceName%ld",service];
    [[self p_settings].apiURLsForClasses setObject:apiURL forKey:key];
}

+(NSString*)apiURLForService:(MNFServiceName)service {
    NSString *key = [NSString stringWithFormat:@"MenigaServiceName%ld",service];
    NSString *url = [[self p_settings].apiURLsForClasses objectForKey:key];
    
    if (url == nil) {
        url = [self p_settings].apiURL;
    }
    return url;
}

+(void)setLogLevel:(MNFLogLevel)logLevel {
    [self p_settings].logLevel = logLevel;
}

+(MNFLogLevel)logLevel {
    return [self p_settings].logLevel;
}

+(void)setTimeZone:(NSTimeZone *)timeZone {
    [self p_settings].timeZone = timeZone;
}

+(NSTimeZone*)timeZone {
    return [self p_settings].timeZone;
}

+(void)setRequestTimeoutInterval:(NSTimeInterval)timeout {
    [self p_settings].requestTimeout = timeout;
}

+(NSTimeInterval)requestTimeoutInterval {
    return [self p_settings].requestTimeout;
}

+(void)setResourceTimeoutInterval:(NSTimeInterval)timeoutInterval {
    [self p_settings].resourceTimeout = timeoutInterval;
}

+(NSTimeInterval)resourceTimeoutInterval {
    return [self p_settings].resourceTimeout;
}

+(void)setNotificationName:(NSString *)notificationName withNotifiactionCenter:(NSNotificationCenter *)notificationCenter forStatusCode:(NSInteger)statusCode {
    
    if (notificationName == nil || notificationCenter == nil) {
        [[self p_settings].notificationNameForStatusCode removeObjectForKey:@(statusCode)];
        [[self p_settings].notificationCenterForStatusCode removeObjectForKey:@(statusCode)];
    }
    else {
        [[self p_settings].notificationNameForStatusCode setObject:notificationName forKey:@(statusCode)];
        [[self p_settings].notificationCenterForStatusCode setObject:notificationCenter forKey:@(statusCode)];
    }
}

+(NSString*)notificationNameForStatusCode:(NSInteger)statusCode {
    
    return [self p_settings].notificationNameForStatusCode[@(statusCode)];
}

+(NSNotificationCenter*)notificationCenterForStatusCode:(NSInteger)statusCode {
    
    return [self p_settings].notificationCenterForStatusCode[@(statusCode)];
}

#pragma mark - Private getters

+(MNFSettings*)p_settings {
    if (s_settings == nil) {
        s_settings = [[MNFSettings alloc] init];
        s_settings.logLevel = kMNFLogLevelInfo;
        return s_settings;
    }
    
    return s_settings;
}

@end
