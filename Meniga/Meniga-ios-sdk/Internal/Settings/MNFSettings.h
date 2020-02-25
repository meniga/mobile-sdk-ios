//
//  MNFSettings.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 21/10/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MNFAuthenticationProviderProtocol.h"
#import "MNFConstants.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, MNFCachePolicy) {
    MNFCachePolicyNetworkOnly,
    MNFCachePolicyNetworkFirst,
    MNFCachePolicyPersistenceFirst
};

/**
 The MNFSettings class is used to construct the settings for the framework before initialization.
 
 When using the Meniga SDK the framework must be initialized with an MNFSettings object. You must provide an api URL with the settings object.
 All other properties can be left in their default state. The default state is as follows:
 authenticationProvider     MNFAuthenticationProvider
 persistenceProvider        MNFPersistenceProvider
 localEncryptionPolicy      NO
 MNFCachePolicy             MNFCachePolicyNetworkOnly
 MNFLogLevel                MNFLogLevelInfo
 */
@interface MNFSettings : NSObject

/**
 @abstract The authentication provider for the Meniga framework.
 
 @discussion The authentication provider must implement the MNFAuthenticationProviderProtocol. This protocol injects headers for authentication in every URL request.
 The default implementation uses the users email and password for authentication. They must be provided when the user logs in.
 */
@property (nonatomic) NSObject<MNFAuthenticationProviderProtocol> *authenticationProvider;

/**
 @abstract The local encryption policy for the Meniga framework.
 
 @discussion All user data can be encrypted before being stored in memory. To use the encryption set localEncryptionPolicy to YES. Using encryption may adversely affect performance. The default localEncryptionPolicy is NO.
 */
@property (nonatomic) BOOL localEncryptionPolicy;

/**
 @abstract The cache policy for the Meniga framework.
 
 @discussion The cache policy determines the behavior of the network. The policies are as follows:
 MNFCachePolicyNetworkOnly      Always queries the server and bypasses the persistence provider completely.
 MNFCachePolicyNetworkFirst     Queries the server and redirects to the persistence in case there is a problem with the server or internet connection.
 MNFCachePolicyPersistenFirst   Queries the persistence and redirects to the server if data is not found in persistence.
 The default policy is MNFCachePolicyNetworkOnly.
 */
@property (nonatomic) MNFCachePolicy cachePolicy;

/**
 @abstract The URL of the server that contains the PFM api.
 
 @discussion This property must be set prior to initialization of the Meniga framework. The default is nil and therefore no URL requests will give a response without this property being set.
 */
@property (nonatomic, strong) NSString *apiURL;

/**
 @abstract Culture to provide to the Accept-Language.
 */
@property (nonatomic, strong, nullable) NSString *culture;

/**
 @abstract The log level for the Meniga framework
 
 @discussion The Meniga framework comes with a custom logger for debugging. Set your preferred log level before initialization. The log levels are as follows:
 MNFLogLevelNone        No logs
 MNFLogLevelError       Only error logs
 MNFLogLevelInfo        Vital information logs
 MNFLogLevelDebug       Detailed logs of all operations.
 The default log level is MNFLogLevelInfo.
 */
@property (nonatomic) MNFLogLevel logLevel;

@property (nonatomic, strong) NSTimeZone *timeZone;
@property (nonatomic) NSTimeInterval requestTimeout;
@property (nonatomic) NSTimeInterval resourceTimeout;
@property (nonatomic, strong) NSURLSessionConfiguration *sessionConfiguration;
@property (nonatomic, weak) id<NSURLSessionDelegate> sessionDelegate;

@property (nonatomic, strong) NSMutableDictionary *apiURLsForClasses;
@property (nonatomic, strong) NSMutableDictionary *authenticationProvidersForClasses;
@property (nonatomic, strong) NSMutableDictionary *notificationCenterForStatusCode;
@property (nonatomic, strong) NSMutableDictionary *notificationNameForStatusCode;

@end

NS_ASSUME_NONNULL_END
