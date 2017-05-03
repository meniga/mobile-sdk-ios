//
//  MNFUserTest.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 29/10/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNFUser.h"
#import "MNFNetwork.h"
#import "MNFNetworkProtocolForTesting.h"
#import "Meniga.h"
#import "MNFJsonAdapter.h"
#import "GCDUtils.h"

@interface MNFUserTest : XCTestCase

@end

@implementation MNFUserTest {
    MNFUser *_sut;
}

- (void)setUp {
    [super setUp];
    [MNFNetwork initializeForTesting];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[self userResponse] options:0 error:nil];
    NSArray *unwrap = [dict objectForKey:@"data"];
    NSDictionary *json = [unwrap firstObject];
    _sut = [MNFJsonAdapter objectOfClass:[MNFUser class] jsonDict:json option:kMNFAdapterOptionNoOption error:nil];
}

- (void)tearDown {
    [MNFNetwork flushForTesting];
    _sut = nil;
    [super tearDown];
}

-(void)testUserCreation {
    
    MNFUser *user = [[MNFUser alloc] init];
    XCTAssertTrue(user.isNew == YES);
    
}

-(void)testFetchUserProfileWithCompletionPartiallyPopulatesObject {
    [MNFNetworkProtocolForTesting setResponseData:[self userResponse]];
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    MNFJob *job = [MNFUser fetchUsersWithCompletion:^(NSArray<MNFUser *> * _Nullable users, NSError * _Nullable error) {
        
        XCTAssertNil(error);
        XCTAssertNotNil(users);
        XCTAssertTrue(users.count == 1);
        
        MNFUser *user = [users firstObject];
        XCTAssertNotNil(user.identifier);
        XCTAssertNotNil(user.personId);
        XCTAssertNil(user.firstName);
        XCTAssertNil(user.lastName);
        XCTAssertNotNil(user.lastLoginDate);
        XCTAssertNotNil(user.isInitialSetupDone);
        XCTAssertNotNil(user.email);
        XCTAssertNotNil(user.culture);
        XCTAssertNotNil(user.lastLoginRemoteHost);
        XCTAssertNotNil(user.createDate);
        XCTAssertNil(user.termsAndConditionsId);
        XCTAssertNil(user.termsAndConditionsAcceptDate);
        XCTAssertNil(user.optOutDate);
        XCTAssertNotNil(user.profile);
        XCTAssertNil(user.phoneNumber);
        XCTAssertNil(user.passwordExpiryDate);
        XCTAssertNotNil(user.hide);
        XCTAssertTrue(user.isNew == NO);
        
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}
 
-(void)testChangeCultureWithCompletion {
    [MNFNetworkProtocolForTesting setResponseData:[self cultureResponse]];
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFJob *job = [_sut changeCulture:@"is-IS" withCompletion:^(NSError * _Nullable error) {
        XCTAssertNil(error);
        XCTAssertEqual(_sut.culture, @"is-IS");
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

-(void)testSaveWithCompletion {
    [MNFNetworkProtocolForTesting setResponseData:[self userResponse]];
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    _sut.firstName = @"Ahhnuld";
    MNFJob *job = [_sut saveWithCompletion:^(NSError * _Nullable error) {
        XCTAssertNil(error);
        XCTAssertEqual(_sut.firstName, @"Ahhnuld");
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

-(void)testSaveWithNilCompletion {
    
    [MNFNetworkProtocolForTesting setResponseData:[self userResponse]];
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    _sut.firstName = @"Ahhnuld";
    [_sut saveWithCompletion:nil];
    
    [GCDUtils dispatchAfterTime:0.1 completion:^{
       
        XCTAssertEqual(_sut.firstName, @"Ahhnuld");
        [expectation fulfill];
        
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
    
}

-(void)testRefreshWithCompletion {
    [MNFNetworkProtocolForTesting setResponseData:[self userResponse]];
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    _sut.firstName = @"Ahhnuld";
    MNFJob *job = [_sut refreshWithCompletion:^(NSError * _Nullable error) {
        
        XCTAssertNil(error);
        XCTAssertNotNil(_sut.identifier);
        XCTAssertNotNil(_sut.personId);
        XCTAssertNotNil(_sut.firstName);
        XCTAssertNil(_sut.lastName);
        XCTAssertNotNil(_sut.lastLoginDate);
        XCTAssertNotNil(_sut.isInitialSetupDone);
        XCTAssertNotNil(_sut.email);
        XCTAssertNotNil(_sut.culture);
        XCTAssertNotNil(_sut.lastLoginRemoteHost);
        XCTAssertNotNil(_sut.createDate);
        XCTAssertNil(_sut.termsAndConditionsId);
        XCTAssertNil(_sut.termsAndConditionsAcceptDate);
        XCTAssertNil(_sut.optOutDate);
        XCTAssertNotNil(_sut.profile);
        XCTAssertNil(_sut.phoneNumber);
        XCTAssertNil(_sut.passwordExpiryDate);
        XCTAssertNotNil(_sut.hide);
        XCTAssertTrue(_sut.isNew == NO);
        
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

-(void)testRefreshWithNilCompletion {
    
    [MNFNetworkProtocolForTesting setResponseData:[self userResponse]];
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    _sut.firstName = @"Ahhnuld";
    [_sut refreshWithCompletion:nil];
    
    [GCDUtils dispatchAfterTime:0.1 completion:^{
       
        XCTAssertNotNil(_sut.identifier);
        XCTAssertNotNil(_sut.personId);
        XCTAssertNotNil(_sut.firstName);
        XCTAssertNil(_sut.lastName);
        XCTAssertNotNil(_sut.lastLoginDate);
        XCTAssertNotNil(_sut.isInitialSetupDone);
        XCTAssertNotNil(_sut.email);
        XCTAssertNotNil(_sut.culture);
        XCTAssertNotNil(_sut.lastLoginRemoteHost);
        XCTAssertNotNil(_sut.createDate);
        XCTAssertNil(_sut.termsAndConditionsId);
        XCTAssertNil(_sut.termsAndConditionsAcceptDate);
        XCTAssertNil(_sut.optOutDate);
        XCTAssertNotNil(_sut.profile);
        XCTAssertNil(_sut.phoneNumber);
        XCTAssertNil(_sut.passwordExpiryDate);
        XCTAssertNotNil(_sut.hide);
        XCTAssertTrue(_sut.isNew == NO);
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
    
}

-(void)testDeleteUserSetsObjectDeleted {
    [MNFNetworkProtocolForTesting setResponseData:[self userResponse]];
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFJob *job = [_sut deleteUserWithCompletion:^(NSError * _Nullable error) {
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

-(void)testFetchMetadata {
    [MNFNetworkProtocolForTesting setResponseData:[self metadataResponse]];
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFJob *job = [_sut fetchMetaDataForKeys:@"meta" completion:^(id  _Nullable result, NSError * _Nullable error) {
        XCTAssertNil(error);
        XCTAssertNotNil(result);
        NSArray *array = result;
        XCTAssertTrue(array.count == 1);
        NSDictionary *dict = [array firstObject];
        XCTAssertEqualObjects([dict objectForKey:@"key"], @"meta");
        XCTAssertEqualObjects([dict objectForKey:@"value"], @"data");
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

-(void)testUpdateMetadata {
    [MNFNetworkProtocolForTesting setResponseData:[self metadataResponse]];
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFJob *job = [_sut updateMetaDataForKey:@"meta" value:@"data" completion:^(NSError * _Nullable error) {
        XCTAssertNil(error);
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

//-(void)testReset {
//    [MNFNetworkProtocolForTesting setResponseData:[self userResponse]];
//    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    MNFJob *job = [_sut resetWithCompletion:^(NSError * _Nullable error) {
//        XCTAssertNil(error);
//        [expectation fulfill];
//    }];
//    
//    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
//        XCTAssertNotNil(result);
//        XCTAssertNil(metaData);
//        XCTAssertNil(error);
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//}

-(void)testOptIn {
    [MNFNetworkProtocolForTesting setResponseData:[self userResponse]];
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFJob *job = [_sut optInWithCompletion:^(NSError * _Nullable error) {
        XCTAssertNil(error);
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

-(void)testOptOut {
    [MNFNetworkProtocolForTesting setResponseData:[self userResponse]];
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFJob *job = [_sut optOutWithCompletion:^(NSError * _Nullable error) {
        XCTAssertNil(error);
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

#pragma mark - helpers 

-(NSData*)userResponse {
    return [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"userResponse" ofType:@"json"]];
}
-(NSData*)cultureResponse {
    return [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"cultureResponse" ofType:@"json"]];
}
-(NSData*)emptyResponse {
    return [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"emptyResponse" ofType:@"json"]];
}
-(NSData*)metadataResponse {
    return [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"userMetadataResponse" ofType:@"json"]];
}

@end
