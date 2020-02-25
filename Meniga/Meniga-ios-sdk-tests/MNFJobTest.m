//
//  MNFJobTest.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 02/11/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNFInternalImports.h"
#import "MNFJob.h"
#import "MNFNetwork.h"
#import "MNFNetworkProtocolForTesting.h"
#import "MNFRequest.h"
#import "MNFURLConstructor.h"
#import "MNFURLRequestConstants.h"

@interface MNFJobTest : XCTestCase

@end

@implementation MNFJobTest

- (void)setUp {
    [super setUp];
    [[MNFNetwork sharedNetwork] initializeForTesting];
}

- (void)tearDown {
    [[MNFNetwork sharedNetwork] flushForTesting];
    [super tearDown];
}

- (void)testCancel {
    [MNFNetworkProtocolForTesting setDelay];
    [MNFNetworkProtocolForTesting setObjectType:MNFNetworkObject];
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];

    NSURL *url = [MNFURLConstructor URLFromBaseUrl:@"http://www.example.com"
                                              path:kMNFApiPathTransactions
                                         pathQuery:nil];
    NSURLRequest *request = [MNFRequest urlRequestWithURL:url httpMethod:@"POST" httpHeaders:nil parameters:nil];
    MNFJob *job = [self sendRequest:request];
    [job cancelWithCompletion:^{
        [[MNFNetwork sharedNetwork] getAllTasks:^(NSArray<NSURLSessionDataTask *> *_Nonnull tasks){
            //            NSLog(@"All tasks: %@",tasks);
        }];
        XCTAssertTrue([job isCancelled]);
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:10 handler:nil];
}

- (void)testPauseAndResume {
    [MNFNetworkProtocolForTesting setDelay];
    [MNFNetworkProtocolForTesting setObjectType:MNFNetworkObject];
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];

    NSURL *url = [MNFURLConstructor URLFromBaseUrl:@"http://www.example.com"
                                              path:kMNFApiPathTransactions
                                         pathQuery:nil];
    NSURLRequest *request = [MNFRequest urlRequestWithURL:url httpMethod:@"POST" httpHeaders:nil parameters:nil];
    MNFJob *job = [self sendRequest:request];
    [job pauseWithCompletion:^{
        [[MNFNetwork sharedNetwork] getAllTasks:^(NSArray<NSURLSessionDataTask *> *_Nonnull tasks){

        }];

        XCTAssertTrue([job isPaused]);

        [job resumeWithCompletion:^{
            XCTAssertTrue(job.isResumed);
            [expectation fulfill];
        }];
    }];
    [self waitForExpectationsWithTimeout:5 handler:nil];
}

- (MNFJob *)sendRequest:(NSURLRequest *)request {
    MNFJob *job = [MNFJob jobWithRequest:request];
    [[MNFNetwork sharedNetwork] sendRequest:request
                             withCompletion:^(MNFResponse *_Nonnull response) {
                                 if (![job isCancelled]) {
                                     if (response.error == nil) {
                                         [job setResult:response.result];
                                     } else {
                                         [job setError:response.error];
                                     }
                                 } else {
                                 }
                             }];

    return job;
}
@end
