//
//  MNFNetworthIntegrationTest.m
//  Meniga-ios-sdk
//
//  Created by Aske Bendtsen on 22/04/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNFIntegrationTestSetup.h"
#import "MNFNetworthAccount.h"

@interface MNFNetworthIntegrationTest : MNFIntegrationTestSetup

@end

@implementation MNFNetworthIntegrationTest {
    NSDate *_startDate;
}

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    NSDateComponents *dateCompononets = [[NSDateComponents alloc] init];
    dateCompononets.month = -3;
    _startDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateCompononets toDate:[NSDate date] options:0];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testGetNetworthWithBlock {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];

    NSDate *endDate = [NSDate date];

    MNFJob *job = [MNFNetworthAccount
        fetchWithStartDate:_startDate
                   endDate:endDate
             interPolation:NO
                completion:^(NSArray<MNFNetworthAccount *> *_Nullable networthAccounts, NSError *_Nullable error) {
                    XCTAssertTrue(networthAccounts.count == 0);
                    XCTAssertNil(error);

                    [expectation fulfill];
                }];

    [job handleCompletion:^(id _Nullable result, id _Nullable metaData, NSError *_Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];

    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

- (void)testNetworthFirstEntryDateWithBlock {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];

    MNFJob *job = [MNFNetworthAccount
        firstEntrydateWithExcludedAccounts:YES
                                completion:^(MNFNetworthBalanceHistory *_Nullable networthBalanceHistory,
                                             NSError *_Nullable error) {
                                    XCTAssertNil(error);

                                    [expectation fulfill];
                                }];

    [job handleCompletion:^(id _Nullable result, id _Nullable metaData, NSError *_Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];

    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

- (void)testNetworthTypesWithBlock {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];

    MNFJob *job = [MNFNetworthAccount fetchNetworthTypesWithCompletion:^(
                                          NSArray<MNFAccountType *> *_Nullable accountTypes, NSError *_Nullable error) {
        XCTAssertNil(error);
        [expectation fulfill];
    }];

    [job handleCompletion:^(id _Nullable result, id _Nullable metaData, NSError *_Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];

    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

@end
