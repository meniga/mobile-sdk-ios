//
//  MenigaNetworkProtocolForTesting.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 20/10/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFNetworkProtocolForTesting.h"

static float delayTime = 1.0;
static BOOL delay = NO;
static MNFObjectType s_objectType;
static NSData *s_responseData;
static NSError *s_responseError;

@implementation MNFNetworkProtocolForTesting


+(void)setDelay {
    delay = YES;
}

+(void)removeDelay {
    delay = NO;
}
+(void)setObjectType:(MNFObjectType)type {
    s_objectType = type;
}

+(void)setResponseData:(NSData *)data{
    s_responseData = data;
}

+(void)setError:(NSError *)theError {
    s_responseError = theError;
}

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
    
    NSDictionary *headers = @{@"Content-type":@"application/json"};
    
    if (s_responseData == nil && s_responseError == nil) {
        NSString *jsonPath = [self jsonResourcePathForObjectType:s_objectType];
        if (jsonPath != nil) {
            s_responseData = [NSData dataWithContentsOfFile:jsonPath];
        }
    }
    
    NSHTTPURLResponse *response;
    if (s_responseError != nil) {
        response = [[NSHTTPURLResponse alloc] initWithURL:request.URL statusCode:s_responseError.code HTTPVersion:@"HTTP/1.1" headerFields:headers];
    }
    else {
        response = [[NSHTTPURLResponse alloc] initWithURL:request.URL statusCode:200 HTTPVersion:@"HTTP/1.1" headerFields:headers];
    }
    
    __weak typeof (self) wSelf = self;
    if (delay == YES) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [wSelf sendProtocolAnswerForClient:client withResponse:response];
        });
    }
    else {
        [self sendProtocolAnswerForClient:client withResponse:response];
    }
}
-(void)stopLoading {
    
}

-(void)sendProtocolAnswerForClient:(id <NSURLProtocolClient>)client withResponse:(NSURLResponse*)response {
    [client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
    if (s_responseData != nil) {
        [client URLProtocol:self didLoadData:[s_responseData copy]];
    }
    if (s_responseError != nil) {
        [client URLProtocol:self didFailWithError:s_responseError];
    }
    [client URLProtocolDidFinishLoading:self];
    [self clearResponseData];
}

-(NSString*)jsonResourcePathForObjectType:(MNFObjectType)theObjectType {
    
    NSString *jsonPath = nil;
    if(theObjectType == MNFAccountObject) {
        jsonPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"accountResponse" ofType:@"json"];
    }
    if(theObjectType == MNFUserObject) {
        jsonPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"userProfileResponse" ofType:@"json"];
    }
    if(theObjectType == MNFCategoryObject) {
        jsonPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"categoryResponse" ofType:@"json"];
    }
    if(theObjectType == MNFTransactionObject) {
        jsonPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"transactionResponse" ofType:@"json"];
    }
    if(theObjectType == MNFNetworkObject) {
        jsonPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"networkResponse" ofType:@"json"];
    }
    if(theObjectType == MNFUserEventObject) {
        jsonPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"userEventResponse" ofType:@"json"];
    }
    if(theObjectType == MNFOfferObject) {
        jsonPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"offerResponse" ofType:@"json"];
    }
    if(theObjectType == MNFFeedObject) {
        jsonPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"feedResponse" ofType:@"json"];
    }
    if(theObjectType == MNFTagObject) {
        jsonPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"tagResponse" ofType:@"json"];
    }
    if(theObjectType == MNFCashbackReportObject) {
        jsonPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"cashbackReportResponse" ofType:@"json"];
    }
    
    return jsonPath;
    
}

-(void)clearResponseData{
    s_responseData = nil;
    s_responseError = nil;
    s_objectType = MNFObjectTypeNone;
}
@end
