//
//  MNFAuthentication.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 08/05/2017.
//  Copyright © 2017 Meniga. All rights reserved.
//

#import "MNFObject.h"

NS_ASSUME_NONNULL_BEGIN

/**
 The MNFAuthentication class provides access to Meniga's default authentication system using JSON web tokens. If your Meniga system does not use this implementation for authentication you must request authentication independently. No matter which authentication system is used you must implement the authentication provider and pass authentication information to the rest of the sdk. See the github wiki for further information.
 */
@interface MNFAuthentication : MNFObject

///******************************
/// @name Immutable properties
///******************************

/**
 The access token.
 */
@property (nonatomic, copy, readonly) NSString *accessToken;

/**
 The refresh token.
 */
@property (nonatomic, copy, readonly) NSString *refreshToken;

///******************************
/// @name Authenticating
///******************************

/**
 Authenticate with an email and password pair.
 
 @param email The email for authentication.
 @param password The corresponding password.
 @param completion A completion handler returning an authentication object and an error.
 
 @return MNFJob A job containing an authentication object and an error.
 */
+ (MNFJob *)authenticateWithEmail:(NSString *)email
                         password:(NSString *)password
                       completion:(nullable MNFAuthenticationCompletionHandler)completion;

/**
 Authenticate with an email and password pair.
 
 @param email The email for authentication.
 @param password The corresponding password.
 @param clientId The id of the client if engaging in the refresh token flow.
 @param clientSecret The client secret if engaging in the refresh token flow.
 @param completion A completion handler returning an authentication object and an error.
 
 @return MNFJob A job containing an authentication object and an error.
 */
+ (MNFJob *)authenticateWithEmail:(NSString *)email
                         password:(NSString *)password
                         clientId:(nullable NSString *)clientId
                     clientSecret:(nullable NSString *)clientSecret
                       completion:(nullable MNFAuthenticationCompletionHandler)completion;

/**
 Perform post authentication tasks. Should be called after a user is successfully authenticated.
 
 @param userIdentifier The identifier of an authenticated user.
 @param realmIdentifier The identifier of the authenticated realm.
 @param parameters Any extra parameters needed for post authentication.
 @param completion A completion handler returning an error.
 
 @return MNFJob A job containing an error.
 */
+ (MNFJob *)authenticateAfterWithUserIdentifier:(nullable NSString *)userIdentifier
                                realmIdentifier:(nullable NSString *)realmIdentifier
                                     parameters:(nullable NSDictionary *)parameters
                                     completion:(nullable MNFErrorOnlyCompletionHandler)completion;

/**
 Authenticate with an SSO token of a specified type.
 
 @param token The security token used to authenticate.
 @param type The name of the AuthClaimsProvider that will create authentication claims from the security token.
 @param completion A completion handler returning an authentication object and an error.
 
 @return MNFJob A job containing an authentication object and an error.
 */
+ (MNFJob *)authenticateWithSSOToken:(NSString *)token
                              ofType:(NSString *)type
                      withCompletion:(nullable MNFAuthenticationCompletionHandler)completion;

/**
 Refresh authentication tokens by providing a refresh token.
 
 @param refreshToken The refresh token to authenticate.
 @param completion A completion handler returning an authentication object and an error.
 
 @return MNFJob A job containing an authentication object and an error.
 */
+ (MNFJob *)refreshTokensWithRefreshToken:(NSString *)refreshToken
                               completion:(nullable MNFAuthenticationCompletionHandler)completion;

/**
 Refresh authentication tokens by providing a refresh token.
 
 @param refreshToken The refresh token to authenticate.
 @param clientId The id of the client that the refresh token was issued for.
 @param clientSecret The client secret the refresh token was issued for.
 @param subject The subject the refresh token was issued.
 @param completion A completion handler returning an authentication object and an error.
 
 @return MNFJob A job containing an authentication object and an error.
 */
+ (MNFJob *)refreshTokensWithRefreshToken:(NSString *)refreshToken
                                 clientId:(nullable NSString *)clientId
                             clientSecret:(nullable NSString *)clientSecret
                                  subject:(nullable NSString *)subject
                               completion:(nullable MNFAuthenticationCompletionHandler)completion;

/**
 Refresh authentication tokens using the tokens of this authentication object.
 
 @param completion A completion handler returning an error.
 
 @return MNFJob A job containing an error.
 */
- (MNFJob *)refreshTokensWithCompletion:(nullable MNFErrorOnlyCompletionHandler)completion;

@end

NS_ASSUME_NONNULL_END
