//
//  MNFOfferIntegrationTests.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 5/17/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNFOffer.h"
#import "MNFIntegrationTestSetup.h"
#import "MENIGAAuthentication.h"
#import "Meniga.h"
#import "MNFDemoUser.h"
#import "MNFIntegrationAuthProvider.h"
#import "MNFRedemptions.h"
#import "MNFOfferTransaction.h"

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


-(void)testFetchOffersWithFilterEmpty {
    
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFOfferFilter *filter = [[MNFOfferFilter alloc] init];
    filter.expiredWithCashbackOnly = @1;
    filter.offerIds = nil;
    filter.offerStates = nil;
    
    [MNFOffer fetchOffersWithFilter: filter take:@100 skip:@0 completion:^(NSArray <MNFOffer *> *offers, NSDictionary *metadata, NSError *error){
       
        XCTAssertNotNil(offers);
        XCTAssertTrue(offers.count == 0);
        XCTAssertNil(error);
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:30.0 handler:nil];
}

-(void)testFetchOffersWithNilFilter {
    
    XCTestExpectation *expectation = [self expectationWithDescription: NSStringFromSelector(_cmd)];
    
    [MNFOffer fetchOffersWithFilter: nil take:@100 skip:@0 completion:^(NSArray  <MNFOffer *> *offers, NSDictionary *metadata, NSError *error) {
        
        XCTAssertNotNil( offers );
        XCTAssertTrue( offers.count == 0 );
        XCTAssertNil( error );
        
        [expectation fulfill];
        
    }];
    
    [self waitForExpectationsWithTimeout: 30 handler: nil];
    
}

//  No offers for test users
//-(void)testFetchOfferWithId {
//
//    XCTestExpectation *expectation = [self expectationWithDescription: NSStringFromSelector(_cmd)];
//
//    [MNFOffer fetchOffersWithFilter: nil take:@100 skip:@0 completion:^(NSArray  <MNFOffer *> *offers, NSDictionary *metadata, NSError *error) {
//
//        MNFOffer *firstOffer = [offers firstObject];
//
//        [MNFOffer fetchWithId: firstOffer.identifier completion:^(MNFOffer *fetchedOffer, NSError *error) {
//
//            XCTAssertEqualObjects(firstOffer.identifier, fetchedOffer.identifier);
//            XCTAssertEqualObjects(firstOffer.title, fetchedOffer.title);
//            XCTAssertEqualObjects(firstOffer.offerDescription, fetchedOffer.offerDescription);
//            XCTAssertEqualObjects(firstOffer.brandId, fetchedOffer.brandId);
//            XCTAssertEqualObjects(firstOffer.brandName, fetchedOffer.brandName);
//            XCTAssertEqualObjects(firstOffer.validationToken, fetchedOffer.validationToken);
//            XCTAssertEqualObjects(firstOffer.state, fetchedOffer.state);
//            XCTAssertEqualObjects(firstOffer.rewardType, fetchedOffer.rewardType);
//            XCTAssertEqualObjects(firstOffer.reward, fetchedOffer.reward);
//            XCTAssertEqualObjects(firstOffer.totalRedeemedAmount, fetchedOffer.totalRedeemedAmount);
//            XCTAssertEqualObjects(firstOffer.minimumPurchaseAmount, fetchedOffer.minimumPurchaseAmount);
//            XCTAssertEqualObjects(firstOffer.maximumRedemptionPerOffer, fetchedOffer.maximumRedemptionPerOffer);
//            XCTAssertEqualObjects(firstOffer.maximumRedemptionPerPurchase, fetchedOffer.maximumRedemptionPerPurchase);
//            XCTAssertEqualObjects(firstOffer.minimumAccumulatedAmount, fetchedOffer.minimumAccumulatedAmount);
//            XCTAssertEqualObjects(firstOffer.maximumPurchase, fetchedOffer.maximumPurchase);
//            XCTAssertEqualObjects(firstOffer.lastReimbursementAmount, fetchedOffer.lastReimbursementAmount);
//            XCTAssertEqualObjects(firstOffer.lastReimbursementDate, fetchedOffer.lastReimbursementDate);
//            XCTAssertEqualObjects(firstOffer.scheduledReimbursementAmount, fetchedOffer.scheduledReimbursementAmount);
//            XCTAssertEqualObjects(firstOffer.scheduledReimbursementDate, fetchedOffer.scheduledReimbursementDate);
//            XCTAssertEqualObjects(firstOffer.daysLeft, fetchedOffer.daysLeft);
//            XCTAssertEqualObjects(firstOffer.validFrom, fetchedOffer.validFrom);
//            XCTAssertEqualObjects(firstOffer.validTo, fetchedOffer.validTo);
//            XCTAssertEqualObjects(firstOffer.activatedDate, fetchedOffer.activatedDate);
//            XCTAssertEqualObjects(firstOffer.declineDate, fetchedOffer.declineDate);
//            XCTAssertEqualObjects(firstOffer.merchantId, fetchedOffer.merchantId);
//            XCTAssertEqualObjects(firstOffer.merchantName, fetchedOffer.merchantName);
//            XCTAssertEqualObjects(firstOffer.merchantDeclined, fetchedOffer.merchantDeclined);
//            XCTAssertEqualObjects(firstOffer.activateOfferOnFirstPurchase, fetchedOffer.activateOfferOnFirstPurchase);
//            XCTAssertEqualObjects(firstOffer.totalSpendingAtSimilarBrands, fetchedOffer.totalSpendingAtSimilarBrands);
//            XCTAssertEqualObjects(firstOffer.totalSpendingOnOffer, fetchedOffer.totalSpendingOnOffer);
//            XCTAssertEqualObjects(firstOffer.offerSimilarBrandsSpendingRatio, fetchedOffer.offerSimilarBrandsSpendingRatio);
//
//            // relevance hook item.
//            XCTAssertEqualObjects(firstOffer.relevanceHook.identifier, fetchedOffer.relevanceHook.identifier);
//            XCTAssertEqualObjects(firstOffer.relevanceHook.text, fetchedOffer.relevanceHook.text);
//
//            [expectation fulfill];
//        }];
//
//    }];
//
//    [self waitForExpectationsWithTimeout: 30 handler: nil];
//
//}

//  No offers for test users
//-(void)testFetchOfferWithToken {
//
//    XCTestExpectation *expectation = [self expectationWithDescription: NSStringFromSelector(_cmd)];
//
//    [MNFOffer fetchOffersWithFilter: nil take:@100 skip:@0 completion:^(NSArray  <MNFOffer *> *offers, NSDictionary *metadata, NSError *error) {
//
//        MNFOffer *firstOffer = [offers firstObject];
//        XCTAssertTrue(firstOffer != nil);
//
//        [MNFOffer fetchWithToken: firstOffer.validationToken completion:^(MNFOffer *fetchedOffer, NSError *error) {
//
//            XCTAssertEqualObjects(firstOffer.identifier, fetchedOffer.identifier);
//            XCTAssertEqualObjects(firstOffer.title, fetchedOffer.title);
//            XCTAssertEqualObjects(firstOffer.offerDescription, fetchedOffer.offerDescription);
//            XCTAssertEqualObjects(firstOffer.brandId, fetchedOffer.brandId);
//            XCTAssertEqualObjects(firstOffer.brandName, fetchedOffer.brandName);
//            XCTAssertEqualObjects(firstOffer.validationToken, fetchedOffer.validationToken);
//            XCTAssertEqualObjects(firstOffer.state, fetchedOffer.state);
//            XCTAssertEqualObjects(firstOffer.rewardType, fetchedOffer.rewardType);
//            XCTAssertEqualObjects(firstOffer.reward, fetchedOffer.reward);
//            XCTAssertEqualObjects(firstOffer.totalRedeemedAmount, fetchedOffer.totalRedeemedAmount);
//            XCTAssertEqualObjects(firstOffer.minimumPurchaseAmount, fetchedOffer.minimumPurchaseAmount);
//            XCTAssertEqualObjects(firstOffer.maximumRedemptionPerOffer, fetchedOffer.maximumRedemptionPerOffer);
//            XCTAssertEqualObjects(firstOffer.maximumRedemptionPerPurchase, fetchedOffer.maximumRedemptionPerPurchase);
//            XCTAssertEqualObjects(firstOffer.minimumAccumulatedAmount, fetchedOffer.minimumAccumulatedAmount);
//            XCTAssertEqualObjects(firstOffer.maximumPurchase, fetchedOffer.maximumPurchase);
//            XCTAssertEqualObjects(firstOffer.lastReimbursementAmount, fetchedOffer.lastReimbursementAmount);
//            XCTAssertEqualObjects(firstOffer.lastReimbursementDate, fetchedOffer.lastReimbursementDate);
//            XCTAssertEqualObjects(firstOffer.scheduledReimbursementAmount, fetchedOffer.scheduledReimbursementAmount);
//            XCTAssertEqualObjects(firstOffer.scheduledReimbursementDate, fetchedOffer.scheduledReimbursementDate);
//            XCTAssertEqualObjects(firstOffer.daysLeft, fetchedOffer.daysLeft);
//            XCTAssertEqualObjects(firstOffer.validFrom, fetchedOffer.validFrom);
//            XCTAssertEqualObjects(firstOffer.validTo, fetchedOffer.validTo);
//            XCTAssertEqualObjects(firstOffer.activatedDate, fetchedOffer.activatedDate);
//            XCTAssertEqualObjects(firstOffer.declineDate, fetchedOffer.declineDate);
//            XCTAssertEqualObjects(firstOffer.merchantId, fetchedOffer.merchantId);
//            XCTAssertEqualObjects(firstOffer.merchantName, fetchedOffer.merchantName);
//            XCTAssertEqualObjects(firstOffer.merchantDeclined, fetchedOffer.merchantDeclined);
//            XCTAssertEqualObjects(firstOffer.activateOfferOnFirstPurchase, fetchedOffer.activateOfferOnFirstPurchase);
//            XCTAssertEqualObjects(firstOffer.totalSpendingAtSimilarBrands, fetchedOffer.totalSpendingAtSimilarBrands);
//            XCTAssertEqualObjects(firstOffer.totalSpendingOnOffer, fetchedOffer.totalSpendingOnOffer);
//            XCTAssertEqualObjects(firstOffer.offerSimilarBrandsSpendingRatio, fetchedOffer.offerSimilarBrandsSpendingRatio);
//
//            // relevance hook item.
//            XCTAssertEqualObjects(firstOffer.relevanceHook.identifier, fetchedOffer.relevanceHook.identifier);
//            XCTAssertEqualObjects(firstOffer.relevanceHook.text, fetchedOffer.relevanceHook.text);
//
//            [expectation fulfill];
//        }];
//
//    }];
//
//    [self waitForExpectationsWithTimeout: 30 handler: nil];
//
//}

-(void)testEnableOffers {
    
    XCTestExpectation *expectation = [self expectationWithDescription: NSStringFromSelector(_cmd)];
    
    [MNFOffer enableOffers: NO completion: ^(NSError *error) {
       
        XCTAssertNil( error );
        
        [MNFOffer enableOffers: YES completion:^(NSError *error) {
            
            XCTAssertNil( error );
            
            [expectation fulfill];
            
        }];
        
    }];
    
    [self waitForExpectationsWithTimeout: 50.0 handler: nil];
}

-(void)testAcceptOffersTermsAndConditions {
    
    XCTestExpectation *expectation = [self expectationWithDescription: NSStringFromSelector(_cmd)];
    
    [MNFOffer acceptOffersTermsAndConditionsWithCompletion:^(NSError *error) {
        
        XCTAssertNil( error );
        
        [expectation fulfill];
        
    }];
    
    [self waitForExpectationsWithTimeout: 30.0 handler: nil];
}


//  No offers on test users
//-(void)testFetchSimilarBrandSpendingWithOfferId {
//
//    XCTestExpectation *expectation = [self expectationWithDescription: NSStringFromSelector(_cmd)];
//
//    [MNFOffer fetchOffersWithFilter: nil take:@100 skip:@0 completion:^(NSArray  <MNFOffer *> *offers, NSDictionary *metadata, NSError *error) {
//
//        MNFOffer *firstOffer = [offers firstObject];
//
//        [firstOffer fetchSimilarBrandSpendingWithCompletion:^(NSArray <MNFSimilarBrand *> *similarBrandSpendings, MNFSimilarBrandMetaData *metadata, NSError *error) {
//
//            XCTAssertNotNil( similarBrandSpendings );
//            XCTAssertNotNil( metadata );
//            XCTAssertNil( error );
//
//            [expectation fulfill];
//        }];
//
//    }];
//
//    [self waitForExpectationsWithTimeout: 30 handler: nil];
//
//}

//  No offers on test users
//-(void)testFetchRedeemedTransactions {
//
//    XCTestExpectation *expectation = [self expectationWithDescription: NSStringFromSelector(_cmd)];
//
//    [MNFOffer fetchOffersWithFilter: nil take:@100 skip:@0 completion:^(NSArray  <MNFOffer *> *offers, NSDictionary *metadata, NSError *error) {
//
//        MNFOffer *firstOffer = [offers firstObject];
//
//        [firstOffer fetchRedeemedTransactionsWithCompletion:^(NSArray <MNFOfferTransaction *> *offerTransactions, NSError *error) {
//
//            XCTAssertNotNil( offerTransactions );
//            XCTAssertNil( error );
//
//            [expectation fulfill];
//        }];
//
//    }];
//
//    [self waitForExpectationsWithTimeout: 60 handler: nil];
//
//
//}

//  No offers on test users
//-(void)testActivateAndDeactivate {
//
//    XCTestExpectation *expectation = [self expectationWithDescription: NSStringFromSelector(_cmd)];
//
//    [MNFOffer fetchOffersWithFilter:nil take: nil skip: nil completion: ^(NSArray <MNFOffer *> *offers, NSDictionary *metadata, NSError *error) {
//
//        MNFOffer *firstOffer = [offers firstObject];
//
//        [firstOffer activateOffer: YES completion: ^(NSError *error) {
//
//            XCTAssertNil( error );
//
//            [firstOffer activateOffer: NO completion: ^(NSError *error) {
//
//                XCTAssertNil( error );
//
//                [expectation fulfill];
//
//            }];
//
//        }];
//
//    }];
//
//    [self waitForExpectationsWithTimeout: 30.0 handler: nil];
//}

-(void)testFetchSomeData {
    
    XCTestExpectation *expectation = [self expectationWithDescription: NSStringFromSelector(_cmd)];
    
    [MNFRedemptions fetchRedemptionsFromDate: [NSDate dateWithTimeIntervalSince1970:0] toDate: [NSDate date] skip: @0 take: @1000 completion:^(NSArray <MNFOfferTransaction *> *offerTransactions, MNFRedemptionsMetaData *metadata, NSError *error) {
        
        XCTAssertNil( error );
        XCTAssertNotNil( metadata );
        XCTAssertNotNil( offerTransactions );
        
        [expectation fulfill];
        
        
    }];
    
    
    [self waitForExpectationsWithTimeout: 100 handler: nil];
}

@end
