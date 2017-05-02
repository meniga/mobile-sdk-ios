//
//  MNFNetworkURLProtocol.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 24/11/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFNetworkURLProtocol.h"
#import "Meniga.h"

@implementation MNFNetworkURLProtocol

+(BOOL)canInitWithRequest:(NSURLRequest *)request {
    return YES;
}
+(NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    return request;
}
-(NSCachedURLResponse *)cachedResponse {
    return nil;
}
-(void)startLoading {
    id <NSURLProtocolClient> client = self.client;
    NSURLRequest *request = self.request;
    
    //NSObject <MNFPersistenceProviderProtocol> *provider = [Meniga persistenceProvider];
    NSObject <MNFPersistenceProviderProtocol> *provider = nil;
    
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyNever];
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    [sessionConfiguration setHTTPCookieStorage:nil];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {        
        
        NSURL *url = nil;
        if ([request.URL.path containsString:@"GetAccounts"]) {
            url = [NSURL URLWithString:[request.URL.path stringByReplacingOccurrencesOfString:@"GetAccounts" withString:@"SaveAccounts"]];
        }
        else if ([request.URL.path containsString:@"GetOffers"]) {
            url = [NSURL URLWithString:[request.URL.path stringByReplacingOccurrencesOfString:@"GetOffers" withString:@"SaveOffers"]];
        }
        else if ([request.URL.path containsString:@"GetTags"]) {
            url = [NSURL URLWithString:[request.URL.path stringByReplacingOccurrencesOfString:@"GetTags" withString:@"SaveTags"]];
        }
        else if ([request.URL.path containsString:@"GetTransactions"]) {
            url = [NSURL URLWithString:[request.URL.path stringByReplacingOccurrencesOfString:@"GetTransactions" withString:@"SaveTransactions"]];
        }
        else if ([request.URL.path containsString:@"GetUserFeed"]) {
            url = [NSURL URLWithString:[request.URL.path stringByReplacingOccurrencesOfString:@"GetUserFeed" withString:@"SaveUserFeed"]];
        }
        else if ([request.URL.path containsString:@"GetUserCategories"]) {
            url = [NSURL URLWithString:[request.URL.path stringByReplacingOccurrencesOfString:@"GetUserCategories" withString:@"SaveUserCategories"]];
        }
        else if ([request.URL.path containsString:@"GetTopCategoryIds"]) {
            url = [NSURL URLWithString:[request.URL.path stringByReplacingOccurrencesOfString:@"GetTopCategoryIds" withString:@"SaveTopCategoryIds"]];
        }
        else if ([request.URL.path containsString:@"GetPublicCategoryTree"]) {
            url = [NSURL URLWithString:[request.URL.path stringByReplacingOccurrencesOfString:@"GetPublicCategoryTree" withString:@"SavePublicCategoryTree"]];
        }
        else if ([request.URL.path containsString:@"GetUserCategoryTree"]) {
            url = [NSURL URLWithString:[request.URL.path stringByReplacingOccurrencesOfString:@"GetUserCategoryTree" withString:@"SaveUserCategoryTree"]];
        }
        else if ([request.URL.path containsString:@"GetUserProfile"]) {
            url = [NSURL URLWithString:[request.URL.path stringByReplacingOccurrencesOfString:@"GetUserProfile" withString:@"SaveUserProfile"]];
        }
        
        if (url != nil) {
            NSLog(@"url: %@",url);
            NSMutableURLRequest *newRequest = [NSMutableURLRequest requestWithURL:url];
            newRequest.HTTPBody = data;
            MNFPersistenceRequest *newPersReq = [[MNFPersistenceRequest alloc] initWithRequest:[newRequest copy]];
            if (newPersReq.data != nil) [provider saveWithRequest:newPersReq];
        }

        [client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
        [client URLProtocol:self didLoadData:data];
        [client URLProtocolDidFinishLoading:self];
    }];
    [task resume];
}
-(void)stopLoading {
    
}


@end
