//
//  MNFCashbackApiValidationTest.m
//  Api-validation-tests
//
//  Created by Haukur Ísfeld on 26/03/2018.
//  Copyright © 2018 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNFTestFactory.h"
#import "MNFTestUtils.h"
#import "Meniga.h"

@interface MNFCashbackApiValidationTest : XCTestCase

@end

@implementation MNFCashbackApiValidationTest

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testValidateOffersApi {
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory cashbackapiModelWithDefinition:@"Offer"]
                                 withModelObject:[MNFOffer new]]);
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory cashbackapiModelWithDefinition:@"OfferRelevanceHook"]
                                 withModelObject:[MNFOfferRelevanceHook new]]);
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory cashbackapiModelWithDefinition:@"MerchantLocation"]
                                 withModelObject:[MNFMerchantLocation new]]);
    XCTAssertTrue([MNFTestUtils
        validateApiModel:[MNFTestFactory cashbackapiModelWithDefinition:@"RedemptionTransaction"]
         withModelObject:[MNFOfferTransaction new]]);
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory cashbackapiModelWithDefinition:@"BrandSpending"]
                                 withModelObject:[MNFSimilarBrand new]]);
}

@end
