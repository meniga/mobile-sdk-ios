//
//  MNFMerchantIntegrationTest.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 20/04/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNFIntegrationTestSetup.h"
#import "MNFMerchant.h"

@interface MNFMerchantIntegrationTest : MNFIntegrationTestSetup

@end

@implementation MNFMerchantIntegrationTest

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

-(void)testFetchMerchants {
    
    // Mark: Currently cannot test as there is no reliable merchant existant with test data.
    
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFJob *job = [MNFMerchant fetchWithId:@5 completion:^(MNFMerchant * _Nullable merchant, NSError * _Nullable error) {
        
        XCTAssertNil(error);
        XCTAssertNotNil(merchant);
        XCTAssertEqualObjects(merchant.identifier, @5);
        
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:kMNFIntegrationTestWaitTime handler:nil];
    
}

@end
