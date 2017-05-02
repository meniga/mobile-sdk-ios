//
//  MNFRouterTest.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 25/11/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNFRouter.h"
#import "Meniga.h"
#import "MNFNetwork.h"
#import "MNFNetworkProtocolForTesting.h"

@interface MNFRouterTest : XCTestCase

@end

@implementation MNFRouterTest

- (void)setUp {
    [super setUp];
    [MNFNetwork initializeForTesting];
    [Meniga setApiURL:@"www.example.com"];
}

- (void)tearDown {
    [MNFNetwork flushForTesting];

    [super tearDown];
}

//-(void)testRouteRequestWithCompletion {
//    [MNFNetworkProtocolForTesting setObjectType:MNFNetworkObject];
//    XCTestExpectation *expectation = [self expectationWithDescription:@"RouterTest"];
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"www.example.com/api/GetTransactions"]];
//    [MNFRouter routeRequest:request withCompletion:^(MNFResponse *  _Nullable result) {
//        XCTAssertNotNil(result);
//        XCTAssertNil(result.error);
//        [expectation fulfill];
//    }];
//    
//    [self waitForExpectationsWithTimeout:10.0 handler:nil];
//}
//-(void)testRouteRequest {
//    [MNFNetworkProtocolForTesting setObjectType:MNFNetworkObject];
//    XCTestExpectation *expectation = [self expectationWithDescription:@"RouterTest"];
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"www.example.com/api/GetTransactions"]];
//    MNFJob *task = [MNFRouter routeRequest:request];
//    XCTAssertNotNil(task);
//    [task.task continueWithSuccessBlock:^id(MNF_BFTask *task) {
//        XCTAssertNotNil(task.result);
//        XCTAssertNil(task.error);
//        [expectation fulfill];
//        return nil;
//    }];
//    
//    [self waitForExpectationsWithTimeout:10.0 handler:nil];
//}

@end
