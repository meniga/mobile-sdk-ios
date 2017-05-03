//
//  MNFPersistenceRequestTest.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 19/11/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNFPersistenceRequest.h"
#import "MNFRequest.h"
#import "MNFURLConstructor.h"
#import "Meniga.h"

@interface MNFPersistenceRequestTest : XCTestCase

@end

@implementation MNFPersistenceRequestTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    [super tearDown];
}

/*
-(void)testRequestFromRequest {
    NSData *data = [NSJSONSerialization dataWithJSONObject:@{@"account":@{@"id":@10,@"Name":@"testName",@"IsHidden":@0}} options:0 error:nil];
    NSURL *url = [MNFURLConstructor URLFromBaseUrl:@"www.example.com" path:@"%@/Api/testURL"];
    NSURLRequest *request = [MNFRequest urlRequestWithURL:url httpMethod:@"POST" httpHeaders:nil parameters:data];
    MNFPersistenceRequest *persistenceRequest = [[MNFPersistenceRequest alloc] initWithRequest:request];
    XCTAssertNotNil(persistenceRequest);
    XCTAssertNotNil(persistenceRequest.request);
    XCTAssertEqualObjects(persistenceRequest.request, @"testURL");
}
-(void)testDataFromRequest {
    NSData *data = [NSJSONSerialization dataWithJSONObject:@{@"account":@{@"id":@10,@"Name":@"testName",@"IsHidden":@0}} options:0 error:nil];
    NSURL *url = [MNFURLConstructor URLFromBaseUrl:@"www.example.com" path:@"Api/testURL"];
    NSURLRequest *request = [MNFRequest urlRequestWithURL:url httpMethod:@"POST" httpHeaders:nil parameters:data];
    MNFPersistenceRequest *persistenceRequest = [[MNFPersistenceRequest alloc] initWithRequest:request];
    XCTAssertNotNil(persistenceRequest.data);
    XCTAssertEqualObjects(persistenceRequest.data, [NSJSONSerialization JSONObjectWithData:data options:0 error:nil]);
}
-(void)testKeyFromRequest {
    NSData *data = [NSJSONSerialization dataWithJSONObject:@{@"account":@{@"id":@10,@"Name":@"testName",@"IsHidden":@0}} options:0 error:nil];
    NSURL *url = [MNFURLConstructor URLFromBaseUrl:@"www.example.com" path:@"Api/testURL"];
    NSURLRequest *request = [MNFRequest urlRequestWithURL:url httpMethod:@"POST" httpHeaders:nil parameters:data];
    MNFPersistenceRequest *persistenceRequest = [[MNFPersistenceRequest alloc] initWithRequest:request];
    XCTAssertNotNil(persistenceRequest.key);
    XCTAssertEqualObjects(persistenceRequest.key, @10);
}
-(void)testEncryptedDataFromRequest {
    MNFSettings *settings = [[MNFSettings alloc] initWithApiURL:@"www.example.com"];
    settings.localEncryptionPolicy = YES;
    [Meniga initWithSettings:settings];
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:@{@"id":@10,@"Name":@"testName",@"IsHidden":@0,@"Date":@"/Date(1441104123903+0000)/"} options:0 error:nil];
    NSURL *url = [MNFURLConstructor URLFromBaseUrl:@"www.example.com" path:@"Api/SaveAccounts"];
    NSURLRequest *request = [MNFRequest urlRequestWithURL:url httpMethod:@"POST" httpHeaders:nil parameters:data];
    MNFPersistenceRequest *persistenceRequest = [[MNFPersistenceRequest alloc] initWithRequest:request];
    XCTAssertNotNil(persistenceRequest.data);
    XCTAssertNotEqualObjects(persistenceRequest.data, [NSJSONSerialization JSONObjectWithData:data options:0 error:nil]);
}
 */

@end
