//
//  MNFRealmUserTest.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 08/04/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNFRealmUser.h"
#import "MNFNetworkProtocolForTesting.h"
#import "MNFNetwork.h"
#import "MNFJsonAdapter.h"
#import "GCDUtils.h"

@interface MNFRealmUserTest : XCTestCase

@end

@implementation MNFRealmUserTest {
    MNFRealmUser *_sut;
}

- (void)setUp {
    [super setUp];
    [MNFNetwork initializeForTesting];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[self realmUserResponse] options:0 error:nil];
    NSArray *unwrap = [dict objectForKey:@"data"];
    NSDictionary *json = [unwrap firstObject];
    _sut = [MNFJsonAdapter objectOfClass:[MNFRealmUser class] jsonDict:json option:kMNFAdapterOptionNoOption error:nil];
}

- (void)tearDown {
    _sut = nil;
    [MNFNetwork flushForTesting];
    [super tearDown];
}

-(void)testFetchingRealmUser {
    [MNFNetworkProtocolForTesting setResponseData:[self realmUserResponse]];
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFJob *job = [MNFRealmUser fetchRealmUsersWithCompletion:^(NSArray<MNFRealmUser *> * _Nullable users, NSError * _Nullable error) {
        XCTAssertNil(error);
        XCTAssertNotNil(users);
        XCTAssertTrue(users.count == 1);
        MNFRealmUser *realmUser = [users firstObject];
        XCTAssertNotNil(realmUser.identifier);
        XCTAssertNotNil(realmUser.userIdentifier);
        XCTAssertNotNil(realmUser.userId);
        XCTAssertNotNil(realmUser.realmId);
        XCTAssertNotNil(realmUser.personId);
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

-(void)testDeleteRealmUserSetsObjectDeleted {
    [MNFNetworkProtocolForTesting setResponseData:[self realmUserResponse]];
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFJob *job = [_sut deleteRealmUserWithCompletion:^(NSError * _Nullable error) {
        XCTAssertNil(error);
        XCTAssertTrue(_sut.isDeleted);
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

-(void)testDeleteRealmUserWithNilCompletion {
    
    [MNFNetworkProtocolForTesting setResponseData:[self realmUserResponse]];
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [_sut deleteRealmUserWithCompletion:nil];
    
    [GCDUtils dispatchAfterTime:3.0 completion:^{
        
        XCTAssertTrue(_sut.isDeleted);
        
        [expectation fulfill];
        
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
    
}

#pragma mark - helpers
-(NSData*)realmUserResponse {
    return [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"realmUserResponse" ofType:@"json"]];
}

@end
