//
//  MNFSynchronizationTest.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 15/12/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNFSynchronization.h"
#import "MNFNetworkProtocolForTesting.h"
#import "MNFNetwork.h"
#import "MNFJsonAdapter.h"
#import "GCDUtils.h"

@interface MNFSynchronizationTest : XCTestCase

@end

@implementation MNFSynchronizationTest {
    MNFSynchronization *_sut;
}

- (void)setUp {
    [super setUp];
    [MNFNetwork initializeForTesting];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[self synchronizationResponse] options:0 error:nil];
    NSDictionary *unwrap = [dict objectForKey:@"data"];
    _sut = [MNFJsonAdapter objectOfClass:[MNFSynchronization class] jsonDict:unwrap option:kMNFAdapterOptionNoOption error:nil];
}

- (void)tearDown {
    [MNFNetwork flushForTesting];
    _sut = nil;
    [super tearDown];
}

-(void)testStartSynchronizationWithCompletion {
    [MNFNetworkProtocolForTesting setResponseData:[self synchronizationResponse]];
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    MNFJob *job = [MNFSynchronization startSynchronizationWithWaitTime:@10 completion:^(MNFSynchronization * _Nullable synchronization, NSError * _Nullable error) {
        XCTAssertNil(error);
        XCTAssertNotNil(synchronization.syncHistoryId);
        XCTAssertNotNil(synchronization.isSyncDone);
        XCTAssertNotNil(synchronization.syncSessionStartTime);
        XCTAssertNotNil(synchronization.realmSyncResponses);
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

-(void)testSynchronizationRefreshWithCompletion {
    
    [MNFNetworkProtocolForTesting setResponseData:[self synchronizationResponse]];
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    MNFJob *job = [_sut refreshWithCompletion:^(NSError * _Nullable error) {
        XCTAssertNil(error);
        XCTAssertNotNil(_sut.syncHistoryId);
        XCTAssertNotNil(_sut.isSyncDone);
        XCTAssertNotNil(_sut.syncSessionStartTime);
        XCTAssertNotNil(_sut.realmSyncResponses);
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}
-(void)testRefreshWithNilCompletion {
    
    [MNFNetworkProtocolForTesting setResponseData:[self synchronizationResponse]];
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    [_sut refreshWithCompletion:nil];
    
    [GCDUtils dispatchAfterTime:0.1 completion:^{
        XCTAssertNotNil(_sut.syncHistoryId);
        XCTAssertNotNil(_sut.isSyncDone);
        XCTAssertNotNil(_sut.syncSessionStartTime);
        XCTAssertNotNil(_sut.realmSyncResponses);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
    
}

-(void)testGetCurrentSynchronizationStatusWithCompletion {
    [MNFNetworkProtocolForTesting setResponseData:[NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"synchronizationCurrentResponse" ofType:@"json"]]];
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    MNFJob *job = [MNFSynchronization fetchCurrentSynchronizationStatusWithCompletion:^(MNFSynchronization * _Nullable synchronization, NSError * _Nullable error) {
        XCTAssertNil(error);
        XCTAssertNotNil(synchronization.syncHistoryId);
        XCTAssertNotNil(synchronization.isSyncDone);
        XCTAssertNotNil(synchronization.syncSessionStartTime);
        XCTAssertNotNil(synchronization.realmSyncResponses);
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

-(void)testIsSynchronizationNeeded {
    
    [MNFNetworkProtocolForTesting setResponseData:[NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"synchronizationCurrentResponse" ofType:@"json"]]];
    
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];

    [MNFSynchronization fetchCurrentSynchronizationStatusWithCompletion:^(MNFSynchronization * _Nullable synchronization, NSError * _Nullable error) {
        XCTAssertNil(error);
        XCTAssertFalse([synchronization isSynchronizationNeeded]);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

#pragma mark - helpers

-(NSData*)synchronizationResponse {
    return [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"synchronizationResponse" ofType:@"json"]];
}

-(NSData*)synchronizationCurrentResponse {
    return [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"synchronizationCurrentResponse" ofType:@"json"]];
}

@end
