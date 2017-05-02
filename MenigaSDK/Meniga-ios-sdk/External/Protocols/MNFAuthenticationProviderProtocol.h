//
//  MNFAuthenticationProviderProtocol.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 22/10/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 MNFAuthenticationProtocol is implemented by an authentication provider.
 */
@protocol MNFAuthenticationProviderProtocol <NSObject>

@required

/**
 @description Gets the authentication headers provided in an authentication provider and adds them to every URL request.
 
 @return NSDictionary A dictionary of headers.
 */
-(NSDictionary*)getHeaders;

/**
 @description Gets the cookies provided in an authentication provider and adds them to every URL request.
 
 @return NSArray An array of NSHTTPCookie.
 */
-(NSArray <NSHTTPCookie*> *)getCookies;

@optional

/**
 This method provides a chance to modify the url request before it is sent or do other preparation. If no modification is done simply return the preRequest parameter in the completion block.
 
 @param preRequest The request to be made before any modification.
 @param completion A completion block returning a new request to be used. This request can be the same requeste as preRequest or a modified version of it.
 */
-(void)prepareRequest:(NSURLRequest*)preRequest withCompletion:(void (^)(NSURLRequest *postRequest))completion;


@end
