//
//  MenigaNetworkTest.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 30/09/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "MNFNetwork.h"
#import "MNFResponse.h"
#import "MNFURLConstructor.h"
#import "MNFHTTPMethods.h"
#import "MNFURLRequestConstants.h"
//#import "MNFCryptor.h"
#import "MNFNetworkProtocolForTesting.h"
#import "MNFObjectTypes.h"

@interface MNFNetworkTest : XCTestCase 

@end

@implementation MNFNetworkTest

-(void)setUp {
    [super setUp];
    [MNFNetwork initializeForTesting];
}
-(void)tearDown {
    [MNFNetwork flushForTesting];
    [super tearDown];
}

-(void)testInitialize {
    XCTAssertNoThrow([MNFNetwork initialize]);
}
-(void)testSendRequest {
    [MNFNetworkProtocolForTesting removeDelay];
    [MNFNetworkProtocolForTesting setResponseData: [NSJSONSerialization dataWithJSONObject: @{ @"TestResponse" : @"NetworkTest", @"TestNumber" : @10 } options: 0 error: nil] ];
    [MNFNetworkProtocolForTesting setObjectType:MNFNetworkObject];
    XCTestExpectation *expectation = [self expectationWithDescription:@"Description"];
    NSURL *url = [MNFURLConstructor URLFromBaseUrl:@"http://www.menigais.test.meniga.net" path:kMNFGetUserProfile];
    
    NSDictionary *headers = [NSDictionary dictionaryWithObjectsAndKeys:@"true", @"X-XSRF-Header",@"application/json",@"Content-type",nil];
    NSURLRequest *request = [MNFRequest urlRequestWithURL:url httpMethod:kMNFHTTPMethodGET httpHeaders:headers parameters:nil];
    
    [MNFNetwork sendRequest:request withCompletion:^(MNFResponse *response){
        NSDictionary *testDict = @{@"TestResponse":@"NetworkTest",@"TestNumber":@10};
        XCTAssertEqualObjects(response.error, nil);
        XCTAssertTrue(response.statusCode == 200);
        XCTAssertEqualObjects(response.result, testDict);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:nil];
}

-(void)testCancelTask {
    [MNFNetworkProtocolForTesting setDelay];
    NSURL *url = [MNFURLConstructor URLFromBaseUrl:@"http://www.menigais.net" path:kMNFGetUserProfile];
                  //URLFromBaseUrl:@"http://www.menigais.net" path:kMNFGetUserProfile parameters:nil];
    NSDictionary *headers = [NSDictionary dictionaryWithObjectsAndKeys:@"true", @"X-XSRF-Header",nil];
    NSURLRequest *request = [MNFRequest urlRequestWithURL:url httpMethod:kMNFHTTPMethodGET httpHeaders:headers parameters:nil];
    
    [MNFNetwork sendRequest:request withCompletion:^(MNFResponse *response){
        
    }];
    
    [MNFNetwork cancelRequest:request withCompletion:^{
        [MNFNetwork getAllTasks:^(NSArray *tasks) {
            XCTAssert([tasks count] == 0);
        }];
    }];
}

//-(void)testSuspendAndResumeTask {
//    [MNFNetworkProtocolForTesting setDelay];
//    NSURL *url = [MNFURLConstructor URLFromBaseUrl:@"http://www.menigais.net" path:kMNFGetUserProfile];
//    NSDictionary *headers = [NSDictionary dictionaryWithObjectsAndKeys:@"true", @"X-XSRF-Header",nil];
//    NSURLRequest *request = [MNFRequest urlRequestWithURL:url httpMethod:kMNFHTTPMethodGET httpHeaders:headers parameters:nil];
//
//    [MNFNetwork sendRequest:request withCompletion:^(MNFResponse *response){
//
//    }];
//
//    [MNFNetwork pauseRequest:request withCompletion:^{
//        [MNFNetwork getAllTasks:^(NSArray *tasks) {
//
//            for (NSURLSessionDataTask *dataTask in tasks) {
//                XCTAssert(dataTask.state == NSURLSessionTaskStateSuspended);
//            }
//
//            [MNFNetwork resumeRequest:request withCompletion:^{
//                [MNFNetwork getAllTasks:^(NSArray *tasks) {
//                    for (NSURLSessionDataTask *dataTask in tasks) {
//                        XCTAssert(dataTask.state == NSURLSessionTaskStateRunning);
//                    }
//                }];
//            }];
//        }];
//    }];
//}

-(void)testCancelAllTasks {
    [MNFNetworkProtocolForTesting setDelay];
    NSURL *url = [MNFURLConstructor URLFromBaseUrl:@"http://www.menigais.net" path:kMNFGetUserProfile];
    NSDictionary *headers = [NSDictionary dictionaryWithObjectsAndKeys:@"true", @"X-XSRF-Header",nil];
    NSURLRequest *request = [MNFRequest urlRequestWithURL:url httpMethod:kMNFHTTPMethodGET httpHeaders:headers parameters:nil];
    
    [MNFNetwork sendRequest:request withCompletion:^(MNFResponse *response){
        
    }];
    
    url = [MNFURLConstructor URLFromBaseUrl:@"http://www.menigais.net" path:kMNFGetTransactions];
    request = [MNFRequest urlRequestWithURL:url httpMethod:kMNFHTTPMethodGET httpHeaders:headers parameters:nil];
    
    [MNFNetwork sendRequest:request withCompletion:^(MNFResponse *response){
        
    }];
    
    [MNFNetwork cancelAllRequestsWithCompletion:^{
        
        [MNFNetwork getAllTasks:^(NSArray *tasks) {
            
            XCTAssert([tasks count] == 0);
            
        }];
    }];
}

-(void)testSuspendAndResumeAllTasks {
    [MNFNetworkProtocolForTesting setDelay];
    NSURL *url = [MNFURLConstructor URLFromBaseUrl:@"http://www.menigais.net" path:kMNFGetUserProfile];
    NSDictionary *headers = [NSDictionary dictionaryWithObjectsAndKeys:@"true", @"X-XSRF-Header",nil];
    NSURLRequest *request = [MNFRequest urlRequestWithURL:url httpMethod:kMNFHTTPMethodGET httpHeaders:headers parameters:nil];
    
    [MNFNetwork sendRequest:request withCompletion:^(MNFResponse *response){
        
    }];
    
    url = [MNFURLConstructor URLFromBaseUrl:@"http://www.menigais.net" path:kMNFGetTransactions];
    request = [MNFRequest urlRequestWithURL:url httpMethod:kMNFHTTPMethodGET httpHeaders:headers parameters:nil];
    
    [MNFNetwork sendRequest:request withCompletion:^(MNFResponse *response){
        
    }];
    
    [MNFNetwork pauseAllRequestsWithCompletion:^{
        [MNFNetwork getAllTasks:^(NSArray *tasks) {
            for (NSURLSessionDataTask *dataTask in tasks) {
                XCTAssert(dataTask.state == NSURLSessionTaskStateSuspended);
            }
            [MNFNetwork resumeAllRequestsWithCompletion:^{
                [MNFNetwork getAllTasks:^(NSArray *tasks) {
                    for (NSURLSessionDataTask *dataTask in tasks) {
                        XCTAssert(dataTask.state == NSURLSessionTaskStateRunning);
                    }
                }];
            }];
        }];
    }];
}

-(void)testGetAllTasks {
    [MNFNetworkProtocolForTesting setDelay];
    [MNFNetwork getAllTasks:^(NSArray *tasks) {
        XCTAssertNotNil(tasks);
    }];
}

@end
