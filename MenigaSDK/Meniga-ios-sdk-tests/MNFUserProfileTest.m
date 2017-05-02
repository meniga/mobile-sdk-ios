//
//  MNFUserProfileTest.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 08/04/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNFUserProfile.h"
#import "MNFNetwork.h"
#import "MNFNetworkProtocolForTesting.h"
#import "MNFJsonAdapter.h"
#import "GCDUtils.h"

@interface MNFUserProfileTest : XCTestCase

@end

@implementation MNFUserProfileTest {
    MNFUserProfile *_sut;
}

- (void)setUp {
    [super setUp];
    [MNFNetwork initializeForTesting];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[self userProfileResponse] options:0 error:nil];
    NSDictionary *unwrap = [dict objectForKey:@"data"];
    _sut = [MNFJsonAdapter objectOfClass:[MNFUserProfile class] jsonDict:unwrap option:kMNFAdapterOptionNoOption error:nil];
}

- (void)tearDown {
    _sut = nil;
    [MNFNetwork flushForTesting];
    [super tearDown];
}

-(void)testUserProfileCreation {
    
    MNFUserProfile *profile = [[MNFUserProfile alloc] init];
    XCTAssertTrue(profile.isNew == YES);
    
}

-(void)testFetchProfilePopulatesObject {
    [MNFNetworkProtocolForTesting setResponseData:[self userProfileResponse]];
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFJob *job = [MNFUserProfile fetchWithCompletion:^(MNFUserProfile * _Nullable userProfile, NSError * _Nullable error) {
        
        XCTAssertNil(error);
        
        XCTAssertNotNil(userProfile.personId);
        XCTAssertNotNil(userProfile.gender);
        XCTAssertNotNil(userProfile.birthYear);
        XCTAssertNotNil(userProfile.postalCode);
        XCTAssertNotNil(userProfile.numberInFamily);
        XCTAssertNotNil(userProfile.numberOfKids);
        XCTAssertNotNil(userProfile.numberOfCars);
        XCTAssertNotNil(userProfile.incomeId);
        XCTAssertNotNil(userProfile.apartmentType);
        XCTAssertNotNil(userProfile.apartmentRooms);
        XCTAssertNotNil(userProfile.apartmentSize);
        XCTAssertNotNil(userProfile.apartmentSizeKey);
        XCTAssertNotNil(userProfile.hasSavedProfile);
        XCTAssertNotNil(userProfile.created);
        XCTAssertTrue(userProfile.isNew == NO);
        
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

-(void)testUpdateProfile {
    [MNFNetworkProtocolForTesting setResponseData:[self userProfileResponse]];
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    _sut.numberOfCars = @2;
    MNFJob *job = [_sut saveWithCompletion:^(NSError * _Nullable error) {
        XCTAssertNil(error);
        XCTAssertEqualObjects(_sut.numberOfCars, @2);
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

-(void)testUpdateProfileWithNilCompletion {
    
    [MNFNetworkProtocolForTesting setResponseData:[self userProfileResponse]];
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    _sut.numberOfCars = @2;
    [_sut saveWithCompletion:nil];
    
    [GCDUtils dispatchAfterTime:0.1 completion:^{
        
        XCTAssertEqualObjects(_sut.numberOfCars, @2);
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
    
}

#pragma mark - helpers
-(NSData*)userProfileResponse {
    return [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"userProfileResponse" ofType:@"json"]];
}

@end
