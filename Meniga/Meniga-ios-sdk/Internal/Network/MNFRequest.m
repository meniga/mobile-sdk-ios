//
//  MenigaRequest.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 30/09/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFRequest.h"
#import "MNFNetwork.h"
#import "Meniga.h"


@implementation MNFRequest

+ (NSURLRequest *)urlRequestWithURL:(NSURL *)url httpMethod:(NSString *)httpMethod httpHeaders:(nullable NSDictionary <NSString *,NSString *> *)httpHeaders parameters:(nullable NSData *)postdata {
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = httpMethod;
    request.HTTPBody = postdata;
    NSMutableDictionary *postHeaders = [NSMutableDictionary dictionaryWithDictionary:httpHeaders];
    [postHeaders addEntriesFromDictionary:@{@"Accept":@"application/json"}];
    [postHeaders addEntriesFromDictionary:@{@"X-XSRF-Header":@"true"}];
    
    
    
    [request setAllHTTPHeaderFields:postHeaders];
    
    return [request copy];
}

@end
