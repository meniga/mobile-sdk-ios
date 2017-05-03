//
//  MNFMerchantTest.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 07/04/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNFNetwork.h"
#import "MNFNetworkProtocolForTesting.h"
#import "MNFMerchant.h"
#import "MNFMerchantAddress.h"

@interface MNFMerchantTest : XCTestCase

@end

@implementation MNFMerchantTest

- (void)setUp {
    [super setUp];
    [MNFNetwork initializeForTesting];
}

- (void)tearDown {
    [MNFNetwork flushForTesting];
    [super tearDown];
}

-(void)testMerchantCreation {
    
    MNFMerchant *merchant = [[MNFMerchant alloc] init];
    XCTAssertTrue(merchant.isNew == YES);
    
}

-(void)testFetchingMerchantReturnsPartiallyPopulatedObject {
    [MNFNetworkProtocolForTesting setResponseData:[self merchantResponse]];
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFJob *job = [MNFMerchant fetchWithId:@40801 completion:^(MNFMerchant * _Nullable merchant, NSError * _Nullable error) {
        
        XCTAssertNil(error);
        
        XCTAssertNotNil(merchant.address);
        XCTAssertNil(merchant.categoryScores);
        XCTAssertNil(merchant.childMerchants);
        XCTAssertNil(merchant.detectedCategory);
        XCTAssertNil(merchant.directoryLink);
        XCTAssertNil(merchant.email);
        XCTAssertNotNil(merchant.identifier);
        XCTAssertNil(merchant.merchantIdentifier);
        XCTAssertNotNil(merchant.masterIdentifier);
        XCTAssertNotNil(merchant.merchantCategoryIdentifier);
        XCTAssertNotNil(merchant.name);
        XCTAssertNil(merchant.offersLink);
        XCTAssertNotNil(merchant.parentId);
        XCTAssertNotNil(merchant.parentMerchant);
        XCTAssertNotNil(merchant.parentName);
        XCTAssertNil(merchant.publicIdentifier);
        XCTAssertNotNil(merchant.telephone);
        XCTAssertNotNil(merchant.webpage);
        XCTAssertTrue(merchant.isNew == NO);
        
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

-(void)testFetchingMerchantPopulatesMerchantAddress {
    [MNFNetworkProtocolForTesting setResponseData:[self merchantResponse]];
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFJob *job = [MNFMerchant fetchWithId:@40801 completion:^(MNFMerchant * _Nullable merchant, NSError * _Nullable error) {
        
        XCTAssertNil(error);
        
        MNFMerchantAddress *address = merchant.address;
        
        XCTAssertNil(address.city);
        XCTAssertNotNil(address.country);
        XCTAssertNotNil(address.countryCode);
        XCTAssertNotNil(address.latitude);
        XCTAssertNotNil(address.longitude);
        XCTAssertNil(address.postalCode);
        XCTAssertNotNil(address.streetLine1);
        XCTAssertNotNil(address.streetLine2);
        XCTAssertTrue(address.isNew == NO);
        
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

-(void)testFetchingMerchantPopulatesParentMerchant {
    [MNFNetworkProtocolForTesting setResponseData:[self merchantResponse]];
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFJob *job = [MNFMerchant fetchWithId:@40801 completion:^(MNFMerchant * _Nullable merchant, NSError * _Nullable error) {
        
        XCTAssertNil(error);
        
        MNFMerchant *parent = merchant.parentMerchant;
        
        XCTAssertNil(parent.address);
        XCTAssertNil(parent.categoryScores);
        XCTAssertNil(parent.childMerchants);
        XCTAssertNil(parent.detectedCategory);
        XCTAssertNil(parent.directoryLink);
        XCTAssertNil(parent.email);
        XCTAssertNotNil(parent.identifier);
        XCTAssertNil(parent.merchantIdentifier);
        XCTAssertNotNil(parent.masterIdentifier);
        XCTAssertNil(parent.merchantCategoryIdentifier);
        XCTAssertNotNil(parent.name);
        XCTAssertNil(parent.offersLink);
        XCTAssertNotNil(parent.parentId);
        XCTAssertNil(parent.parentMerchant);
        XCTAssertNil(parent.parentName);
        XCTAssertNil(parent.publicIdentifier);
        XCTAssertNil(parent.telephone);
        XCTAssertNil(parent.webpage);
        XCTAssertTrue(parent.isNew == NO);
        

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
-(NSData*)merchantResponse {
    return [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"merchantResponse" ofType:@"json"]];
}
@end
