//
//  MNFSynchronizationIntegrationTest.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 20/04/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNFIntegrationTestSetup.h"
#import "MNFSynchronization.h"

@interface MNFSynchronizationIntegrationTest : MNFIntegrationTestSetup

@end

@implementation MNFSynchronizationIntegrationTest

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

-(void)testSynchronization {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFJob *job = [MNFSynchronization startSynchronizationWithWaitTime:@1000 completion:^(MNFSynchronization * _Nullable synchronization, NSError * _Nullable error) {
        XCTAssertNil(error);
        XCTAssertNotNil(synchronization);
        [synchronization refreshWithCompletion:^(NSError * _Nullable error) {
            XCTAssertNil(error);
            [expectation fulfill];
        }];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:kMNFIntegrationTestWaitTime handler:nil];
}

-(void)testCurrentSyncStatus {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFJob *job = [MNFSynchronization startSynchronizationWithWaitTime:@1000 completion:^(MNFSynchronization * _Nullable synchronization, NSError * _Nullable error) {
        XCTAssertNil(error);
        XCTAssertNotNil(synchronization);
        [MNFSynchronization fetchCurrentSynchronizationStatusWithCompletion:^(MNFSynchronization * _Nullable synchronization, NSError * _Nullable error) {
            XCTAssertNil(synchronization);
            XCTAssertNil(error);
            [expectation fulfill];
        }];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:kMNFIntegrationTestWaitTime handler:nil];
}

@end
