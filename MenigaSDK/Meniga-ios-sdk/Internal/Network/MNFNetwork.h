//
//  MenigaNetwork.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 30/09/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MNFRequest.h"
#import "MNFResponse.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^MenigaResponseBlock)(MNFResponse *response);

@interface MNFNetwork : NSObject <NSURLSessionDelegate>


+(void)initializeForTesting;
+(void)flushForTesting;

+(void)sendRequest:(NSURLRequest *)request withCompletion:(MenigaResponseBlock)block;
+(void)sendRequest:(NSURLRequest *)request overwrite:(BOOL *)overwrite withCompletion:(MenigaResponseBlock)block;
+(void)sendPriorityRequest:(NSURLRequest *)request withCompletion:(MenigaResponseBlock)block;

+(void)cancelRequest:(NSURLRequest *)request;
+(void)cancelRequest:(NSURLRequest *)request withCompletion:(void (^)(void))completionHandler;
+(void)pauseRequest:(NSURLRequest *)request;
+(void)pauseRequest:(NSURLRequest *)request withCompletion:(void (^)(void))completionHandler;
+(void)resumeRequest:(NSURLRequest *)request;
+(void)resumeRequest:(NSURLRequest *)request withCompletion:(void (^)(void))completionHandler;

+(void)cancelAllRequests;
+(void)cancelAllRequestsWithCompletion:(void (^)(void))completionHandler;
+(void)pauseAllRequests;
+(void)pauseAllRequestsWithCompletion:(void (^)(void))completionHandler;
+(void)resumeAllRequests;
+(void)resumeAllRequestsWithCompletion:(void (^)(void))completionHandler;

+(void)getAllTasks:(void (^)(NSArray <NSURLSessionDataTask *>* tasks))completion;
+(NSURLSession*)getSession;

@end

NS_ASSUME_NONNULL_END