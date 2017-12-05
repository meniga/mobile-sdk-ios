//
//  MNFJobTest.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 02/11/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNFNetwork.h"
#import "MNFNetworkProtocolForTesting.h"
#import "MNFJob.h"
#import "MNFURLConstructor.h"
#import "MNFRequest.h"
#import "MNFURLRequestConstants.h"
#import "MNFInternalImports.h"

@interface MNFJobTest : XCTestCase

@end

@implementation MNFJobTest

- (void)setUp {
    [super setUp];
    [MNFNetwork initializeForTesting];
}

- (void)tearDown {
    [MNFNetwork flushForTesting];
    [super tearDown];
}

-(void)testCancel {
    [MNFNetworkProtocolForTesting setDelay];
    [MNFNetworkProtocolForTesting setObjectType:MNFNetworkObject];
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    NSURL *url = [MNFURLConstructor URLFromBaseUrl:@"http://www.example.com" path:kMNFApiPathTransactions pathQuery:nil];
    NSURLRequest *request = [MNFRequest urlRequestWithURL:url httpMethod:@"POST" httpHeaders:nil parameters:nil];
    MNFJob *job = [self sendRequest:request];
    [job cancelWithCompletion:^{
        [MNFNetwork getAllTasks:^(NSArray<NSURLSessionDataTask *> * _Nonnull tasks) {
//            NSLog(@"All tasks: %@",tasks);
        }];
        XCTAssertTrue([job isCancelled]);
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:10 handler:nil];
}
-(void)testPauseAndResume {
    [MNFNetworkProtocolForTesting setDelay];
    [MNFNetworkProtocolForTesting setObjectType:MNFNetworkObject];
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    NSURL *url = [MNFURLConstructor URLFromBaseUrl:@"http://www.example.com" path:kMNFApiPathTransactions pathQuery:nil];
    NSURLRequest *request = [MNFRequest urlRequestWithURL:url httpMethod:@"POST" httpHeaders:nil parameters:nil];
    MNFJob *job = [self sendRequest:request];
    [job pauseWithCompletion:^{
        [MNFNetwork getAllTasks:^(NSArray<NSURLSessionDataTask *> * _Nonnull tasks) {
//            NSLog(@"All tasks: %@",tasks);
        }];
        XCTAssertTrue([job isPaused]);
        [job resumeWithCompletion:^{
            XCTAssertTrue(job.isResumed);
            [expectation fulfill];
        }];
    }];
    [self waitForExpectationsWithTimeout:5 handler:nil];
}
-(MNFJob*)sendRequest:(NSURLRequest*)request {
    MNFJob *job = [MNFJob jobWithRequest:request];
    [MNFNetwork sendRequest:request withCompletion:^(MNFResponse * _Nonnull response) {
        if (![job isCancelled]) {
            if (response.error == nil){
//                NSLog(@"No error");
                [job setResult:response.result];
            }
            else {
//                NSLog(@"Totally error: %@",response.error);
                [job setError:response.error];
            }
        }
        else {
//            NSLog(@"The job was cancelled");
        }
    }];
    
    return job;
}
@end
