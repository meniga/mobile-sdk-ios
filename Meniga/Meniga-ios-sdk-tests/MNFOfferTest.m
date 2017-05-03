//
//  MNFOfferTest.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 05/11/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNFOffer.h"
#import "MNFNetwork.h"
#import "MNFNetworkProtocolForTesting.h"
#import "MNFObjectTypes.h"

@interface MNFOfferTest : XCTestCase

@end

@implementation MNFOfferTest

- (void)setUp {
    [super setUp];
    [MNFNetwork initializeForTesting];
}

- (void)tearDown {
    [MNFNetwork flushForTesting];
    [super tearDown];
}
- (void)testFetchOfferWithIdWithCompletion {
    [MNFNetworkProtocolForTesting setObjectType:MNFOfferObject];
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Description"];
    [MNFOffer fetchWithId:@10 completion:^(MNFOffer *offer, NSError *error) {
        XCTAssertEqualObjects(offer.offerId, @10);
        XCTAssertEqualObjects(offer.title, @"testTitle");
        XCTAssertEqualObjects(offer.offerDescription, @"testOfferDescription");
        XCTAssertEqualObjects(offer.validationToken, @"testToken");
        XCTAssertEqualObjects(offer.displayState, @1);
        XCTAssertEqualObjects(offer.validFrom, [NSDate dateWithTimeIntervalSince1970:1447804800]);
        XCTAssertEqualObjects(offer.offerCategory, @"testCategory");
        XCTAssertEqualObjects(offer.merchant, @"testMerchant");
        XCTAssertEqualObjects(offer.categoryDisplay, @"testCategoryDisplay");
        XCTAssertEqualObjects(offer.transactionContainer, @[]);
        XCTAssertEqualObjects(offer.lastPayment, @4000);
        XCTAssertEqualObjects(offer.lastPaymentDate, [NSDate dateWithTimeIntervalSince1970:1447804800]);
        XCTAssertEqualObjects(offer.nextPaymentDate, [NSDate dateWithTimeIntervalSince1970:1447805800]);
        XCTAssertEqualObjects(offer.nextPaymentScheduledAmount, @2000);
        XCTAssertEqualObjects(offer.partnerImageFilename, @"testFilename");
        XCTAssertEqualObjects(offer.merchantId, @23);
        XCTAssertEqualObjects(offer.validTo, [NSDate dateWithTimeIntervalSince1970:1447804800]);
        XCTAssertEqualObjects(offer.rewardType, @5);
        XCTAssertEqualObjects(offer.reward, @6);
        XCTAssertEqualObjects(offer.minimumPurchaseAmount, @7);
        XCTAssertEqualObjects(offer.maximumPurchaseEvents, @8);
        XCTAssertEqualObjects(offer.maximumCashbackPerPurchase, @9);
        XCTAssertEqualObjects(offer.maximumCashbackPerOffer, @10);
        XCTAssertEqualObjects(offer.minimumAccumulatedAmount, @11);
        XCTAssertEqualObjects(offer.totalRedeemedAmount, @12);
        XCTAssertEqualObjects(offer.totalRepayedAmount, @13);
        XCTAssertEqualObjects(offer.daysleft, @14);
        XCTAssertEqualObjects(offer.offerGoal, @15);
        XCTAssertEqualObjects(offer.offerReason, @"testReason");
        XCTAssertEqualObjects(offer.acceptanceDate, [NSDate dateWithTimeIntervalSince1970:1447804800]);
        XCTAssertEqualObjects(offer.availableFrom, [NSDate dateWithTimeIntervalSince1970:1447804800]);
        XCTAssertEqualObjects(offer.cashbackPrediction, @{});
        XCTAssertEqualObjects(offer.declineDate, [NSDate dateWithTimeIntervalSince1970:1447804800]);
        XCTAssertEqualObjects(offer.merchantDeclined, @2);
        XCTAssertEqualObjects(offer.offerCategoryId, @42);
        XCTAssertEqualObjects(offer.repaymentRecords, @[]);
        XCTAssertEqualObjects(offer.merchantWebsite, @"www.example.com");
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:nil];
}
-(void)testFetchOfferWithIdWithJob {
    [MNFNetworkProtocolForTesting setObjectType:MNFOfferObject];
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    [[MNFOffer fetchWithId:@10].task continueWithBlock:^id(MNF_BFTask *task) {
        XCTAssertNotNil(task.result);
        XCTAssertNil(task.error);
        MNFOffer *offer = task.result;
        XCTAssertEqualObjects(offer.offerId, @10);
        XCTAssertEqualObjects(offer.title, @"testTitle");
        XCTAssertEqualObjects(offer.offerDescription, @"testOfferDescription");
        XCTAssertEqualObjects(offer.validationToken, @"testToken");
        XCTAssertEqualObjects(offer.displayState, @1);
        XCTAssertEqualObjects(offer.validFrom, [NSDate dateWithTimeIntervalSince1970:1447804800]);
        XCTAssertEqualObjects(offer.offerCategory, @"testCategory");
        XCTAssertEqualObjects(offer.merchant, @"testMerchant");
        XCTAssertEqualObjects(offer.categoryDisplay, @"testCategoryDisplay");
        XCTAssertEqualObjects(offer.transactionContainer, @[]);
        XCTAssertEqualObjects(offer.lastPayment, @4000);
        XCTAssertEqualObjects(offer.lastPaymentDate, [NSDate dateWithTimeIntervalSince1970:1447804800]);
        XCTAssertEqualObjects(offer.nextPaymentDate, [NSDate dateWithTimeIntervalSince1970:1447805800]);
        XCTAssertEqualObjects(offer.nextPaymentScheduledAmount, @2000);
        XCTAssertEqualObjects(offer.partnerImageFilename, @"testFilename");
        XCTAssertEqualObjects(offer.merchantId, @23);
        XCTAssertEqualObjects(offer.validTo, [NSDate dateWithTimeIntervalSince1970:1447804800]);
        XCTAssertEqualObjects(offer.rewardType, @5);
        XCTAssertEqualObjects(offer.reward, @6);
        XCTAssertEqualObjects(offer.minimumPurchaseAmount, @7);
        XCTAssertEqualObjects(offer.maximumPurchaseEvents, @8);
        XCTAssertEqualObjects(offer.maximumCashbackPerPurchase, @9);
        XCTAssertEqualObjects(offer.maximumCashbackPerOffer, @10);
        XCTAssertEqualObjects(offer.minimumAccumulatedAmount, @11);
        XCTAssertEqualObjects(offer.totalRedeemedAmount, @12);
        XCTAssertEqualObjects(offer.totalRepayedAmount, @13);
        XCTAssertEqualObjects(offer.daysleft, @14);
        XCTAssertEqualObjects(offer.offerGoal, @15);
        XCTAssertEqualObjects(offer.offerReason, @"testReason");
        XCTAssertEqualObjects(offer.acceptanceDate, [NSDate dateWithTimeIntervalSince1970:1447804800]);
        XCTAssertEqualObjects(offer.availableFrom, [NSDate dateWithTimeIntervalSince1970:1447804800]);
        XCTAssertEqualObjects(offer.cashbackPrediction, @{});
        XCTAssertEqualObjects(offer.declineDate, [NSDate dateWithTimeIntervalSince1970:1447804800]);
        XCTAssertEqualObjects(offer.merchantDeclined, @2);
        XCTAssertEqualObjects(offer.offerCategoryId, @42);
        XCTAssertEqualObjects(offer.repaymentRecords, @[]);
        XCTAssertEqualObjects(offer.merchantWebsite, @"www.example.com");
        [expectation fulfill];
        return nil;
    }];
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}
-(void)testFetchOffersWithCompletion {
    [MNFNetworkProtocolForTesting setResponseData:[NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"offersResponse" ofType:@"json"]]];
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    [MNFOffer fetchOffersWithCompletion:^(MNFResponse *  _Nullable result) {
        XCTAssertNotNil(result);
        XCTAssertNil(result.error);
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}
-(void)testFetchOffersWithJob {
    [MNFNetworkProtocolForTesting setResponseData:[NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"offersResponse" ofType:@"json"]]];
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    [[MNFOffer fetchOffers].task continueWithBlock:^id(MNF_BFTask *task) {
        XCTAssertNotNil(task.result);
        XCTAssertNil(task.error);
        [expectation fulfill];
        return nil;
    }];
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}
-(void)testCreateRepaymentAccountWithCompletion {
    [MNFNetworkProtocolForTesting setObjectType:MNFOfferObject];
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    [MNFOffer createRepaymentAccountWithDisplayName:@"name" repaymentType:@"type" accountInfo:@"info" completion:^(MNFResponse *  _Nullable result) {
        XCTAssertNotNil(result);
        XCTAssertNil(result.error);
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}
-(void)testCreateRepaymentAccountWithJob {
    [MNFNetworkProtocolForTesting setObjectType:MNFOfferObject];
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    [[MNFOffer createRepaymentAccountWithDisplayName:@"string" repaymentType:@"type" accountInfo:@"info"].task continueWithBlock:^id(MNF_BFTask *task) {
        XCTAssertNotNil(task.result);
        XCTAssertNil(task.error);
        [expectation fulfill];
        return nil;
    }];
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}
-(void)testDeleteRepaymentAccountWithCompletion {
    [MNFNetworkProtocolForTesting setObjectType:MNFOfferObject];
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    [MNFOffer deleteRepaymentAccountWithId:@"id" completion:^(MNFResponse *  _Nullable result) {
        XCTAssertNotNil(result);
        XCTAssertNil(result.error);
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}
-(void)testDeleteRepaymentAccountWithJob {
    [MNFNetworkProtocolForTesting setObjectType:MNFOfferObject];
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    [[MNFOffer deleteRepaymentAccountWithId:@"id"].task continueWithBlock:^id(MNF_BFTask *task) {
        XCTAssertNotNil(task.result);
        XCTAssertNil(task.error);
        [expectation fulfill];
        return nil;
    }];
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}
-(void)testUpdateRepaymentAccountWithCompletion {
    [MNFNetworkProtocolForTesting setObjectType:MNFOfferObject];
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    [MNFOffer updateRepaymentAccountWithId:@"id" displayName:@"name" accountInfo:@"info" completion:^(MNFResponse *  _Nullable result) {
        XCTAssertNotNil(result);
        XCTAssertNil(result.error);
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}
-(void)testUpdateRepaymentAccountWithJob {
    [MNFNetworkProtocolForTesting setObjectType:MNFOfferObject];
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    [[MNFOffer updateRepaymentAccountWithId:@"id" displayName:@"name" accountInfo:@"info"].task continueWithBlock:^id(MNF_BFTask *task) {
        XCTAssertNotNil(task.result);
        XCTAssertNil(task.error);
        [expectation fulfill];
        return nil;
    }];
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}
-(void)testGetTermsAndConditionsWithCompletion {
    [MNFNetworkProtocolForTesting setObjectType:MNFOfferObject];
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    [MNFOffer getTermsAndConditionsWithCompletion:^(MNFResponse *  _Nullable result) {
        XCTAssertNotNil(result);
        XCTAssertNil(result.error);
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}
-(void)testGetTermsAndConditionsWithJob {
    [MNFNetworkProtocolForTesting setObjectType:MNFOfferObject];
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    [[MNFOffer getTermsAndConditions].task continueWithBlock:^id(MNF_BFTask *task) {
        XCTAssertNotNil(task.result);
        XCTAssertNil(task.error);
        [expectation fulfill];
        return nil;
    }];
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}
-(void)testAcceptTermsAndConditionsWithCompletion {
    [MNFNetworkProtocolForTesting setResponseData:[NSKeyedArchiver archivedDataWithRootObject:@[]]];
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    [MNFOffer acceptTermsAndConditionsWithCompletion:^(MNFResponse *  _Nullable result) {
        XCTAssertNil(result.error);
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}
-(void)testAcceptTermsAndConditionsWithJob {
    [MNFNetworkProtocolForTesting setResponseData:[NSKeyedArchiver archivedDataWithRootObject:@[]]];
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    [[MNFOffer acceptTermsAndConditions].task continueWithBlock:^id(MNF_BFTask *task) {
        XCTAssertNil(task.error);
        [expectation fulfill];
        return nil;
    }];
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}
-(void)testAcceptOfferWithCompletion {
    [MNFNetworkProtocolForTesting setObjectType:MNFOfferObject];
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    [MNFOffer fetchWithId:@10 completion:^(MNFOffer * _Nullable offer, NSError * _Nullable error) {
        [offer acceptOfferWithCompletion:^(MNFResponse *  _Nullable result) {
            XCTAssertNil(result.error);
            [expectation fulfill];
        }];
    }];
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}
-(void)testAcceptOfferWithJob {
    [MNFNetworkProtocolForTesting setObjectType:MNFOfferObject];
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    [[MNFOffer fetchWithId:@10].task continueWithBlock:^id(MNF_BFTask *task) {
        MNFOffer *offer = task.result;
        [[offer acceptOffer].task continueWithBlock:^id(MNF_BFTask *task) {
            XCTAssertNil(task.error);
            [expectation fulfill];
            return nil;
        }];
        return nil;
    }];
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}
-(void)testDeclineOfferWithCompletion {
    [MNFNetworkProtocolForTesting setObjectType:MNFOfferObject];
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    [MNFOffer fetchWithId:@10 completion:^(MNFOffer * _Nullable offer, NSError * _Nullable error) {
        [offer declineOfferWithCompletion:^(MNFResponse *  _Nullable result) {
            XCTAssertNil(result.error);
            [expectation fulfill];
        }];
    }];
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}
-(void)testDeclineOfferWithJob {
    [MNFNetworkProtocolForTesting setObjectType:MNFOfferObject];
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    [[MNFOffer fetchWithId:@10].task continueWithBlock:^id(MNF_BFTask *task) {
        MNFOffer *offer = task.result;
        [[offer declineOffer].task continueWithBlock:^id(MNF_BFTask *task) {
            XCTAssertNil(task.error);
            [expectation fulfill];
            return nil;
        }];
        return nil;
    }];
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}
-(void)testRefreshWithCompletion {
    [MNFNetworkProtocolForTesting setObjectType:MNFOfferObject];
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    [MNFOffer fetchWithId:@10 completion:^(MNFOffer * _Nullable offer, NSError * _Nullable error) {
        [offer refreshWithCompletion:^(NSError * _Nullable error) {
            XCTAssertNil(error);
            XCTAssertNotNil(offer.offerId);
            XCTAssertNotNil(offer.offerCategory);
            XCTAssertNotNil(offer.offerCategoryId);
            XCTAssertNotNil(offer.offerDescription);
            XCTAssertNotNil(offer.offerGoal);
            XCTAssertNotNil(offer.offerReason);
            XCTAssertNotNil(offer.title);
            XCTAssertNotNil(offer.validationToken);
            XCTAssertNotNil(offer.validFrom);
            XCTAssertNotNil(offer.validTo);
            XCTAssertNotNil(offer.merchant);
            XCTAssertNotNil(offer.categoryDisplay);
            XCTAssertNotNil(offer.transactionContainer);
            XCTAssertNotNil(offer.displayState);
            XCTAssertNotNil(offer.lastPayment);
            XCTAssertNotNil(offer.lastPaymentDate);
            XCTAssertNotNil(offer.nextPaymentDate);
            XCTAssertNotNil(offer.nextPaymentScheduledAmount);
            XCTAssertNotNil(offer.partnerImageFilename);
            XCTAssertNotNil(offer.merchantId);
            XCTAssertNotNil(offer.merchantDeclined);
            XCTAssertNotNil(offer.merchantWebsite);
            XCTAssertNotNil(offer.reward);
            XCTAssertNotNil(offer.rewardType);
            XCTAssertNotNil(offer.repaymentRecords);
            XCTAssertNotNil(offer.maximumCashbackPerOffer);
            XCTAssertNotNil(offer.maximumCashbackPerPurchase);
            XCTAssertNotNil(offer.maximumPurchaseEvents);
            XCTAssertNotNil(offer.minimumAccumulatedAmount);
            XCTAssertNotNil(offer.minimumPurchaseAmount);
            XCTAssertNotNil(offer.totalRedeemedAmount);
            XCTAssertNotNil(offer.totalRepayedAmount);
            XCTAssertNotNil(offer.daysleft);
            XCTAssertNotNil(offer.acceptanceDate);
            XCTAssertNotNil(offer.availableFrom);
            XCTAssertNotNil(offer.cashbackPrediction);
            XCTAssertNotNil(offer.declineDate);
            [expectation fulfill];
        }];
    }];
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}
-(void)testRefreshWithJob {
    [MNFNetworkProtocolForTesting setObjectType:MNFOfferObject];
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    [[MNFOffer fetchWithId:@10].task continueWithBlock:^id(MNF_BFTask *task) {
        MNFOffer *offer = task.result;
        [[offer refresh].task continueWithBlock:^id(MNF_BFTask *task) {
            XCTAssertNil(task.error);
            XCTAssertNotNil(offer.offerId);
            XCTAssertNotNil(offer.offerCategory);
            XCTAssertNotNil(offer.offerCategoryId);
            XCTAssertNotNil(offer.offerDescription);
            XCTAssertNotNil(offer.offerGoal);
            XCTAssertNotNil(offer.offerReason);
            XCTAssertNotNil(offer.title);
            XCTAssertNotNil(offer.validationToken);
            XCTAssertNotNil(offer.validFrom);
            XCTAssertNotNil(offer.validTo);
            XCTAssertNotNil(offer.merchant);
            XCTAssertNotNil(offer.categoryDisplay);
            XCTAssertNotNil(offer.transactionContainer);
            XCTAssertNotNil(offer.displayState);
            XCTAssertNotNil(offer.lastPayment);
            XCTAssertNotNil(offer.lastPaymentDate);
            XCTAssertNotNil(offer.nextPaymentDate);
            XCTAssertNotNil(offer.nextPaymentScheduledAmount);
            XCTAssertNotNil(offer.partnerImageFilename);
            XCTAssertNotNil(offer.merchantId);
            XCTAssertNotNil(offer.merchantDeclined);
            XCTAssertNotNil(offer.merchantWebsite);
            XCTAssertNotNil(offer.reward);
            XCTAssertNotNil(offer.rewardType);
            XCTAssertNotNil(offer.repaymentRecords);
            XCTAssertNotNil(offer.maximumCashbackPerOffer);
            XCTAssertNotNil(offer.maximumCashbackPerPurchase);
            XCTAssertNotNil(offer.maximumPurchaseEvents);
            XCTAssertNotNil(offer.minimumAccumulatedAmount);
            XCTAssertNotNil(offer.minimumPurchaseAmount);
            XCTAssertNotNil(offer.totalRedeemedAmount);
            XCTAssertNotNil(offer.totalRepayedAmount);
            XCTAssertNotNil(offer.daysleft);
            XCTAssertNotNil(offer.acceptanceDate);
            XCTAssertNotNil(offer.availableFrom);
            XCTAssertNotNil(offer.cashbackPrediction);
            XCTAssertNotNil(offer.declineDate);
            [expectation fulfill];
            return nil;
        }];
        return nil;
    }];
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

@end
