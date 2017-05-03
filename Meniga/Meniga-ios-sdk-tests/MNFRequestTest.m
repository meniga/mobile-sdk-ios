//
//  MenigaRequestTest.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 30/09/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNFRequest.h"
#import "MNFURLConstructor.h"
#import "MNFHTTPMethods.h"
#import "MNFURLRequestConstants.h"

@interface MNFRequestTest : XCTestCase

@end

@implementation MNFRequestTest

-(void)testInit {
    XCTAssertNotNil([[MNFRequest alloc] init]);
}

-(void)testUrlRequestWithURL {
    NSURL *url = [MNFURLConstructor URLFromBaseUrl:@"www.menigatest.is" path:kMNFHTTPMethodGET];
    NSDictionary *headers = [NSDictionary dictionaryWithObjectsAndKeys:@"true", @"X-XSRF-Header",nil];
    NSData *postdata = [NSJSONSerialization dataWithJSONObject:@{@"id":@"1"} options:0 error:nil];
    NSURLRequest *request = [MNFRequest urlRequestWithURL:url httpMethod:kMNFHTTPMethodPOST httpHeaders:headers parameters:postdata];
    
    XCTAssertNotNil(request);
    XCTAssertEqualObjects(request.URL, url);
    XCTAssertEqualObjects([request.allHTTPHeaderFields objectForKey:@"X-XSRF-Header"], @"true");
    XCTAssertEqualObjects(request.HTTPMethod, @"POST");
    XCTAssertEqualObjects(request.HTTPBody, postdata);
}

@end
