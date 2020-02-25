//
//  MNFTransactionSeriesIntegrationTest.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 20/04/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNFDemoUser.h"
#import "MNFIntegrationTestSetup.h"
#import "MNFSynchronization.h"
#import "MNFTransactionFilter.h"
#import "MNFTransactionSeries.h"
#import "MNFTransactionSeriesFilter.h"

@interface MNFTransactionSeriesIntegrationTest : MNFIntegrationTestSetup

@end

@implementation MNFTransactionSeriesIntegrationTest

- (void)setUp {
    [super setUp];

    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    [MNFDemoUser
        startSynchronizationWithWaitTime:@1000
                              completion:^(MNFSynchronization *_Nullable synchronization, NSError *_Nullable error) {
                                  dispatch_semaphore_signal(semaphore);
                              }];

    dispatch_semaphore_wait(semaphore, dispatch_time(DISPATCH_TIME_NOW, kMNFIntegrationTestWaitTime * NSEC_PER_SEC));
}

- (void)tearDown {
    [super tearDown];
}

- (void)testFetchTransactionSeries {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];

    MNFTransactionSeriesFilter *seriesFilter = [[MNFTransactionSeriesFilter alloc] init];

    MNFTransactionFilter *filter = [[MNFTransactionFilter alloc] init];
    filter.periodFrom = [NSDate dateWithTimeIntervalSinceNow:-120 * 24 * 60 * 60];
    filter.periodTo = [NSDate date];
    filter.categoryIds = @[@112];
    seriesFilter.transactionFilter = filter;

    seriesFilter.timeResolution = @"Month";
    seriesFilter.overTime = @YES;
    seriesFilter.includeTransactions = @NO;
    seriesFilter.includeTransactionIds = @NO;

    MNFTransactionFilter *selectorOne = [[MNFTransactionFilter alloc] init];

    MNFTransactionFilter *selectorTwo = [[MNFTransactionFilter alloc] init];
    selectorTwo.merchantIds = @[@10];

    MNFTransactionFilter *selectorThree = [[MNFTransactionFilter alloc] init];
    selectorThree.accountIds = @[@1];

    seriesFilter.seriesSelectors = @[selectorOne];

    MNFJob *job = [MNFTransactionSeries
        fetchTransactionSeriesWithTransactionSeriesFilter:seriesFilter
                                           withCompletion:^(NSArray<MNFTransactionSeries *> *_Nullable result,
                                                            NSError *_Nullable error) {
                                               XCTAssertNil(error);
                                               XCTAssertNotNil(result);
                                               [expectation fulfill];
                                           }];

    [job handleCompletion:^(id _Nullable result, id _Nullable metaData, NSError *_Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];

    [self waitForExpectationsWithTimeout:kMNFIntegrationTestWaitTime handler:nil];
}

@end
