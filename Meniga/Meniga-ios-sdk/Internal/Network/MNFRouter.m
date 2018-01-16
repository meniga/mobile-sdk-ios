//
//  MNFRouter.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 24/11/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFRouter.h"
#import "Meniga.h"
#import "MNFNetwork.h"
#import "MNFJob.h"
#import "MNFJob_Private.h"
#import "MNFErrorUtils.h"
#import "MNFLogger.h"

@implementation MNFRouter

+ (void)initialize
{
    if (self == [MNFRouter class]) {
        
    }
}

+(MNFJob*)routeRequest:(NSURLRequest *)request withCompletion:(MNFCompletionHandler)completion {
    [completion copy];
    
    return [self p_routeToServer:request withCompletion:completion];
}

+(MNFJob*)routeRequest:(NSURLRequest *)request {
    
    return [self p_routeToServer:request];
}

#pragma mark - Routing To Server

+(MNFJob *)p_routeToServer:(NSURLRequest*)request withCompletion:(MNFCompletionHandler)completion {
    [completion copy];
    
    __block MNFJob *job = [MNFJob jobWithRequest:request];
    
    NSObject <MNFAuthenticationProviderProtocol> *provider = [Meniga authenticationProvider];
    if ([provider respondsToSelector:@selector(prepareRequest:withCompletion:)]) {
        [provider prepareRequest:request withCompletion:^(NSURLRequest *postRequest) {
            [MNFNetwork sendRequest:postRequest withCompletion:^(MNFResponse * _Nonnull response) {
                
                [job setResponse:response];
                
                if (completion != nil) {
                    completion(response);
                }
            }];
        }];
    }
    else {
        [MNFNetwork sendRequest:request withCompletion:^(MNFResponse * _Nonnull response) {
            
            [job setResponse:response];
            
            if (completion != nil) {
                completion(response);
            }
        }];
    }

    return job;
}

+(MNFJob*)p_routeToServer:(NSURLRequest*)request {
    
    __block MNFJob *job = [MNFJob jobWithRequest:request];
    
    [MNFNetwork sendRequest:request withCompletion:^(MNFResponse * _Nonnull response) {
        [job setResponse:response];
    }];
    
    return job;
}

@end
