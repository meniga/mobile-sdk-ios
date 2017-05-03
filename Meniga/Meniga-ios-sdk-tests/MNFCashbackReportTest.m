//
//  MNFCashbackReportTest.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 25/11/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNFCashbackReport.h"
#import "MNFNetwork.h"
#import "MNFNetworkProtocolForTesting.h"

@interface MNFCashbackReportTest : XCTestCase

@end

@implementation MNFCashbackReportTest

- (void)setUp {
    [super setUp];
    [MNFNetwork initializeForTesting];
}

- (void)tearDown {
    [MNFNetwork flushForTesting];
    [super tearDown];
}

-(void)testFetchCashbackReportWithCompletion {
    [MNFNetworkProtocolForTesting setObjectType:MNFCashbackReportObject];
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    [MNFCashbackReport fetchReportWithCompletion:^(MNFCashbackReport * _Nullable cashbackReport, NSError * _Nullable error) {
        XCTAssertNotNil(cashbackReport);
        XCTAssertNil(error);
        XCTAssertNotNil(cashbackReport.totalCashback);
        XCTAssertNotNil(cashbackReport.totalForPayout);
        XCTAssertNotNil(cashbackReport.acceptedOffers);
        XCTAssertNotNil(cashbackReport.redeemedOffers);
        XCTAssertNotNil(cashbackReport.revenue);
        XCTAssertNotNil(cashbackReport.offersSent);
        XCTAssertNotNil(cashbackReport.offersSeen);
        XCTAssertNotNil(cashbackReport.uniqueImpressions);
        XCTAssertNotNil(cashbackReport.uniqueClicks);
        XCTAssertNotNil(cashbackReport.cashbackActive);
        XCTAssertNotNil(cashbackReport.cashbackActiveStatusLastSet);
        XCTAssertNotNil(cashbackReport.hasAcceptedTAndC);
        XCTAssertNotNil(cashbackReport.offersNotSeen);
        XCTAssertNotNil(cashbackReport.scheduledRepayments);
        XCTAssertNotNil(cashbackReport.hasInvalidRepaymentAccount);
        XCTAssertNotNil(cashbackReport.redemptions);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}
-(void)testFetchCashbackReportWithJob {
    [MNFNetworkProtocolForTesting setObjectType:MNFCashbackReportObject];
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    MNFJob *job = [MNFCashbackReport fetchReport];
    [job.task continueWithBlock:^id(MNF_BFTask *task) {
        XCTAssertNotNil(task.result);
        XCTAssertNil(task.error);
        MNFCashbackReport *cashbackReport = task.result;
        XCTAssertNotNil(cashbackReport.totalCashback);
        XCTAssertNotNil(cashbackReport.totalForPayout);
        XCTAssertNotNil(cashbackReport.acceptedOffers);
        XCTAssertNotNil(cashbackReport.redeemedOffers);
        XCTAssertNotNil(cashbackReport.revenue);
        XCTAssertNotNil(cashbackReport.offersSent);
        XCTAssertNotNil(cashbackReport.offersSeen);
        XCTAssertNotNil(cashbackReport.uniqueImpressions);
        XCTAssertNotNil(cashbackReport.uniqueClicks);
        XCTAssertNotNil(cashbackReport.cashbackActive);
        XCTAssertNotNil(cashbackReport.cashbackActiveStatusLastSet);
        XCTAssertNotNil(cashbackReport.hasAcceptedTAndC);
        XCTAssertNotNil(cashbackReport.offersNotSeen);
        XCTAssertNotNil(cashbackReport.scheduledRepayments);
        XCTAssertNotNil(cashbackReport.hasInvalidRepaymentAccount);
        XCTAssertNotNil(cashbackReport.redemptions);
        [expectation fulfill];
        return nil;
    }];
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}
-(void)testRefreshCashbackReportWithCompletion {
    [MNFNetworkProtocolForTesting setObjectType:MNFCashbackReportObject];
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    [MNFCashbackReport fetchReportWithCompletion:^(MNFCashbackReport * _Nullable cashbackReport, NSError * _Nullable error) {
        [cashbackReport refreshWithCompletion:^(NSError * _Nullable error) {
            XCTAssertNotNil(cashbackReport);
            XCTAssertNil(error);
            XCTAssertNotNil(cashbackReport.totalCashback);
            XCTAssertNotNil(cashbackReport.totalForPayout);
            XCTAssertNotNil(cashbackReport.acceptedOffers);
            XCTAssertNotNil(cashbackReport.redeemedOffers);
            XCTAssertNotNil(cashbackReport.revenue);
            XCTAssertNotNil(cashbackReport.offersSent);
            XCTAssertNotNil(cashbackReport.offersSeen);
            XCTAssertNotNil(cashbackReport.uniqueImpressions);
            XCTAssertNotNil(cashbackReport.uniqueClicks);
            XCTAssertNotNil(cashbackReport.cashbackActive);
            XCTAssertNotNil(cashbackReport.cashbackActiveStatusLastSet);
            XCTAssertNotNil(cashbackReport.hasAcceptedTAndC);
            XCTAssertNotNil(cashbackReport.offersNotSeen);
            XCTAssertNotNil(cashbackReport.scheduledRepayments);
            XCTAssertNotNil(cashbackReport.hasInvalidRepaymentAccount);
            XCTAssertNotNil(cashbackReport.redemptions);
            [expectation fulfill];
        }];
    }];
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}
-(void)testRefreshCashbackReportWithJob {
    [MNFNetworkProtocolForTesting setObjectType:MNFCashbackReportObject];
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    [[MNFCashbackReport fetchReport].task continueWithBlock:^id(MNF_BFTask *task) {
        MNFCashbackReport *cashbackReport = task.result;
        [[cashbackReport refresh].task continueWithBlock:^id(MNF_BFTask *task) {
            XCTAssertNil(task.error);
            XCTAssertNotNil(cashbackReport.totalCashback);
            XCTAssertNotNil(cashbackReport.totalForPayout);
            XCTAssertNotNil(cashbackReport.acceptedOffers);
            XCTAssertNotNil(cashbackReport.redeemedOffers);
            XCTAssertNotNil(cashbackReport.revenue);
            XCTAssertNotNil(cashbackReport.offersSent);
            XCTAssertNotNil(cashbackReport.offersSeen);
            XCTAssertNotNil(cashbackReport.uniqueImpressions);
            XCTAssertNotNil(cashbackReport.uniqueClicks);
            XCTAssertNotNil(cashbackReport.cashbackActive);
            XCTAssertNotNil(cashbackReport.cashbackActiveStatusLastSet);
            XCTAssertNotNil(cashbackReport.hasAcceptedTAndC);
            XCTAssertNotNil(cashbackReport.offersNotSeen);
            XCTAssertNotNil(cashbackReport.scheduledRepayments);
            XCTAssertNotNil(cashbackReport.hasInvalidRepaymentAccount);
            XCTAssertNotNil(cashbackReport.redemptions);
            [expectation fulfill];
            return nil;
        }];
        return nil;
    }];
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

@end
