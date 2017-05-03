//
//  MenigaObject.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 30/09/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFObject.h"
#import "MNFNetwork.h"
#import "MNFURLConstructor.h"
#import "Meniga.h"
#import "MNFURLRequestConstants.h"
#import "MNFHTTPMethods.h"
#import "MNFJob.h"
#import "MNFJsonAdapter.h"
#import "MNFRouter.h"
#import "MNFLogger.h"
#import "NSObject+MNFObjectCreation.h"
#import "MNF_BFExecutor.h"

@implementation MNFObject

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark - Private methods

+(void)apiRequestWithPath:(NSString *)path pathQuery:(nullable NSDictionary*)pathQuery jsonBody:(nullable NSData*)postData HTTPMethod:(NSString*)httpMethod completion:(MNFCompletionHandler)completion {
    [completion copy];
    NSURL *url = [MNFURLConstructor URLFromBaseUrl:[Meniga apiURL] path:path pathQuery:pathQuery];
    NSDictionary *headers = [NSDictionary dictionaryWithObject:@"true" forKey:@"X-XSRF-Header"];
    NSURLRequest *request = [MNFRequest urlRequestWithURL:url httpMethod:httpMethod httpHeaders:headers parameters:postData];
    
    MNFLogDebug(@"Sending request: %@", request);
    
    [MNFRouter routeRequest:request withCompletion:completion];
}
+(MNFJob*)apiRequestWithPath:(NSString *)path pathQuery:(nullable NSDictionary*)pathQuery jsonBody:(nullable NSData*)postData HTTPMethod:(NSString*)httpMethod  {
    NSURL *url = [MNFURLConstructor URLFromBaseUrl:[Meniga apiURL] path:path pathQuery:pathQuery];
    NSDictionary *headers = [NSDictionary dictionaryWithObject:@"true" forKey:@"X-XSRF-Header"];
    NSURLRequest *request = [MNFRequest urlRequestWithURL:url httpMethod:httpMethod httpHeaders:headers parameters:postData];
    
    MNFLogDebug(@"Sending request: %@", request);

    return [MNFRouter routeRequest:request];
}


+(void)executeOnMainThreadWithCompletion:(void (^)(id _Nullable))completion withParameter:(nullable id)parameter {
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
+(void)executeOnMainThreadWithCompletion:(nullable void (^)(id _Nullable,id _Nullable))completion withParameters:(nullable id)firstParameter and:(nullable id)secondParameter {
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

@end
