//
//  MNFAPIRequest.h
//  Meniga-ios-sdk
//
//  Created by Aske Bendtsen on 05/01/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MNFConstants.h"
#import "MNFObject.h"
#import "MNFResponse.h"

@class MNFJob;
@interface MNFAPIRequest : MNFObject

/**
 @abstract Performs a request to the API with specified path, parameters, JSON payload and HTTP method.
 @param path Path to the target API endpoint. The path should NOT include the base URL of the API URI. Only the path specified in the API documentation.
 @param pathQuery The URL query to be appended to the path. pathQuery should be passed as an NSDictionary containing keys and values. Boolean values should be passed as @"true" or @"false" strings.
 @param jsonBody The serialized json payload
 @param httpMethod The HTTP method specified by the API for the target endpoint.
 @param completion Completion containing an MNFResponse object.
 @return MNFJob with result or error.
 @discussion This method does not utilize the model objects of the SDK. The MNFResponse returns the deserialized JSON object on success.
 
 */
+ (nonnull MNFJob *)requestWithAPIPath:(nonnull NSString *)path
                             pathQuery:(nullable NSDictionary *)pathQuery
                              jsonBody:(nullable NSData *)jsonBody
                            HTTPMethod:(nonnull NSString *)httpMethod
                            completion:(nonnull MNFCompletionHandler)completion;

/**
 @abstract Performs a request to the API with specified path, parameters, JSON payload and HTTP method.
 @param baseURL The base URL to the target api endpoint.
 @param path Path to the target API endpoint. The path should NOT include the base URL of the API URI. Only the path specified in the API documentation.
 @param pathQuery The URL query to be appended to the path. pathQuery should be passed as an NSDictionary containing keys and values. Boolean values should be passed as @"true" or @"false" strings.
 @param jsonBody The serialized json payload
 @param httpMethod The HTTP method specified by the API for the target endpoint.
 @param completion Completion containing an MNFResponse object.
 @return MNFJob with result or error.
 @discussion This method does not utilize the model objects of the SDK. The MNFResponse returns the deserialized JSON object on success.
 
 */
+ (nonnull MNFJob *)requestWithBaseUrl:(nonnull NSString *)baseURL
                               APIPath:(nonnull NSString *)path
                             pathQuery:(nullable NSDictionary *)pathQuery
                              jsonBody:(nullable NSData *)jsonBody
                            HTTPMethod:(nonnull NSString *)httpMethod
                            completion:(nonnull MNFCompletionHandler)completion;

@end
