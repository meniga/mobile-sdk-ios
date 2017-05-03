//
//  MNFTransactionSeriesTest.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 06/04/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNFTransactionSeries.h"
#import "MNFTransactionSeriesFilter.h"
#import "MNFNetworkProtocolForTesting.h"
#import "MNFNetwork.h"
#import "MNFTransactionFilter.h"

@interface MNFTransactionSeriesTest : XCTestCase

@end

@implementation MNFTransactionSeriesTest

- (void)setUp {
    [super setUp];
    [MNFNetwork initializeForTesting];
}

- (void)tearDown {
    [MNFNetwork flushForTesting];
    [super tearDown];
}

-(void)testTransactionSeriesCreation {
    MNFTransactionSeries *series = [[MNFTransactionSeries alloc] init];
    XCTAssertTrue(series.isNew == YES);
}

-(void)testFetchSeriesPopulatesObject {
    [MNFNetworkProtocolForTesting setResponseData:[self transactionSeriesResponse]];
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFTransactionFilter *filter = [[MNFTransactionFilter alloc] init];
    MNFTransactionFilter *s1 = [[MNFTransactionFilter alloc] init];
    MNFTransactionFilter *s2 = [[MNFTransactionFilter alloc] init];
    MNFTransactionSeriesFilter *sf = [[MNFTransactionSeriesFilter alloc] init];
    sf.transactionFilter = filter;
    sf.timeResolution = @"Month";
    sf.overTime = @YES;
    sf.seriesSelectors = @[s1,s2];
    sf.includeTransactions = @NO;
    sf.includeTransactionIds = @NO;
    
    MNFJob *job = [MNFTransactionSeries fetchTransactionSeriesWithTransactionSeriesFilter:sf withCompletion:^(NSArray * _Nullable result, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(error);
        XCTAssertTrue(result.count == 2);
        for (MNFTransactionSeries *series in result) {
            XCTAssertNotNil(series.timeResolution);
            XCTAssertNotNil(series.statistics);
            XCTAssertNotNil(series.values);
            XCTAssertNotNil(series.transactions);
            XCTAssertNotNil(series.transactionIds);
            XCTAssertTrue(series.isNew == NO);
        }
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

#pragma mark - helpers
-(NSData*)transactionSeriesResponse{
    return [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"transactionSeriesResponse" ofType:@"json"]];
}

@end
