//
//  MNFAPIRequest.m
//  Meniga-ios-sdk
//
//  Created by Aske Bendtsen on 05/01/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFAPIRequest.h"
#import "MNFJsonAdapter.h"
#import "MNFObject_Private.h"
#import "Meniga.h"

@implementation MNFAPIRequest

+ (MNFJob *)requestWithAPIPath:(NSString *)path
                     pathQuery:(NSDictionary *)pathQuery
                      jsonBody:(nullable NSData *)jsonBody
                    HTTPMethod:(NSString *)httpMethod
                    completion:(MNFCompletionHandler)completion {
    [completion copy];
    [Meniga setApiURL:[Meniga apiURL] forService:MNFServiceNameNone];
    __block MNFJob *job = [[self class] apiRequestWithPath:path
                                                 pathQuery:pathQuery
                                                  jsonBody:jsonBody
                                                HTTPMethod:httpMethod
                                                   service:MNFServiceNameNone
                                                completion:^(MNFResponse *_Nullable response) {
                                                    [self executeOnMainThreadWithJob:job
                                                                          completion:completion
                                                                           parameter:response];
                                                }];

    return job;
}

+ (MNFJob *)requestWithBaseUrl:(NSString *)baseURL
                       APIPath:(NSString *)path
                     pathQuery:(NSDictionary *)pathQuery
                      jsonBody:(NSData *)jsonBody
                    HTTPMethod:(NSString *)httpMethod
                    completion:(MNFCompletionHandler)completion {
    [Meniga setApiURL:baseURL forService:MNFServiceNameNone];
    [completion copy];
    __block MNFJob *job = [[self class] apiRequestWithPath:path
                                                 pathQuery:pathQuery
                                                  jsonBody:jsonBody
                                                HTTPMethod:httpMethod
                                                   service:MNFServiceNameNone
                                                completion:^(MNFResponse *_Nullable response) {
                                                    [self executeOnMainThreadWithJob:job
                                                                          completion:completion
                                                                           parameter:response];
                                                }];

    return job;
}

@end
