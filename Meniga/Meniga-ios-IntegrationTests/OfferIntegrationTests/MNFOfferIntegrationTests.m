//
//  MNFOfferIntegrationTests.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 5/17/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MENIGAAuthentication.h"
#import "MNFDemoUser.h"
#import "MNFIntegrationAuthProvider.h"
#import "MNFIntegrationTestSetup.h"
#import "MNFOffer.h"
#import "MNFOfferTransaction.h"
#import "MNFRedemptions.h"
#import "Meniga.h"

@interface MNFOfferIntegrationTests : MNFIntegrationTestSetup

@end

@implementation MNFOfferIntegrationTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.

    [super setUp];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testFetchOffersWithFilterEmpty {
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];

    MNFOfferFilter *filter = [[MNFOfferFilter alloc] init];
    filter.expiredWithCashbackOnly = @1;
    filter.offerIds = nil;
    filter.offerStates = nil;

    [MNFOffer fetchOffersWithFilter:filter
                               take:@100
                               skip:@0
                         completion:^(NSArray<MNFOffer *> *offers, NSDictionary *metadata, NSError *error) {
                             XCTAssertNotNil(offers);
                             XCTAssertTrue(offers.count == 0);
                             XCTAssertNil(error);

                             [expectation fulfill];
                         }];

    [self waitForExpectationsWithTimeout:30.0 handler:nil];
}

- (void)testFetchOffersWithNilFilter {
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];

    [MNFOffer fetchOffersWithFilter:nil
                               take:@100
                               skip:@0
                         completion:^(NSArray<MNFOffer *> *offers, NSDictionary *metadata, NSError *error) {
                             XCTAssertNotNil(offers);
                             XCTAssertTrue(offers.count == 0);
                             XCTAssertNil(error);

                             [expectation fulfill];
                         }];

    [self waitForExpectationsWithTimeout:30 handler:nil];
}

- (void)testEnableOffers {
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];

    [MNFOffer enableOffers:NO
                completion:^(NSError *error) {
                    XCTAssertNil(error);

                    [MNFOffer enableOffers:YES
                                completion:^(NSError *error) {
                                    XCTAssertNil(error);

                                    [expectation fulfill];
                                }];
                }];

    [self waitForExpectationsWithTimeout:50.0 handler:nil];
}

- (void)testAcceptOffersTermsAndConditions {
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];

    [MNFOffer acceptOffersTermsAndConditionsWithCompletion:^(NSError *error) {
        XCTAssertNil(error);

        [expectation fulfill];
    }];

    [self waitForExpectationsWithTimeout:30.0 handler:nil];
}

- (void)testFetchSomeData {
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];

    [MNFRedemptions fetchRedemptionsFromDate:[NSDate dateWithTimeIntervalSince1970:0]
                                      toDate:[NSDate date]
                                        skip:@0
                                        take:@1000
                                  completion:^(NSArray<MNFOfferTransaction *> *offerTransactions,
                                               MNFRedemptionsMetaData *metadata,
                                               NSError *error) {
                                      XCTAssertNil(error);
                                      XCTAssertNotNil(metadata);
                                      XCTAssertNotNil(offerTransactions);

                                      [expectation fulfill];
                                  }];

    [self waitForExpectationsWithTimeout:100 handler:nil];
}

@end
