//
//  MNFChallengesTest.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 27/11/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Meniga.h"
#import "MNFChallenge.h"
#import "MNFNetwork.h"
#import "MNFNetworkProtocolForTesting.h"
#import "MNFJsonAdapter.h"

@interface MNFChallengesTest : XCTestCase

@end

@implementation MNFChallengesTest {
    MNFChallenge *_sut;
}

- (void)setUp {
    [super setUp];
    [MNFNetwork initializeForTesting];
    
    NSDictionary *challengeResponse = [NSJSONSerialization JSONObjectWithData:[self challengeResponse] options:0 error:nil];
    NSDictionary *challengeData = [challengeResponse objectForKey:@"data"];
    
    _sut = [MNFJsonAdapter objectOfClass:[MNFChallenge class] jsonDict:challengeData option:0 error:nil];
}

- (void)tearDown {
    [MNFNetwork flushForTesting];
    _sut = nil;
    [super tearDown];
}

- (void)testFetchChallenges {
    [MNFNetworkProtocolForTesting setResponseData:[self challengesResponse]];
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [MNFChallenge fetchChallengesWithIncludeExpired:nil excludeSuggested:nil excludeAccepted:nil completion:^(NSArray<MNFChallenge *> * _Nullable challenges, NSError * _Nullable error) {
        XCTAssertNil(error);
        XCTAssertNotNil(challenges);
        
        MNFChallenge *challenge = [challenges firstObject];
        XCTAssertNotNil(challenge.challengeId);
        XCTAssertNotNil(challenge.accepted);
        XCTAssertNil(challenge.acceptedDate);
        XCTAssertNotNil(challenge.topicId);
        XCTAssertNil(challenge.title);
        XCTAssertNil(challenge.challengeDescription);
        XCTAssertNotNil(challenge.type);
        XCTAssertNotNil(challenge.startDate);
        XCTAssertNotNil(challenge.endDate);
        XCTAssertNil(challenge.iconUrl);
        MNFSpendingChallenge *spending = (MNFSpendingChallenge*)challenge.challengeModel;
        XCTAssertNotNil(spending.categoryIds);
        XCTAssertNotNil(spending.targetPercentage);
        XCTAssertNotNil(spending.targetAmount);
        XCTAssertNil(spending.spentAmount);
        XCTAssertNotNil(spending.numberOfParticipants);
        XCTAssertNotNil(spending.recurringInterval);
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

- (void)testAcceptChallenge {
    [MNFNetworkProtocolForTesting setResponseData:[self challengeResponse]];
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [_sut acceptChallengeWithTargetAmount:nil waitTime:nil completion:^(NSError * _Nullable error) {
        XCTAssertNil(error);
        XCTAssertNotNil(_sut.challengeId);
        XCTAssertNotNil(_sut.accepted);
        XCTAssertNil(_sut.acceptedDate);
        XCTAssertNotNil(_sut.topicId);
        XCTAssertNil(_sut.title);
        XCTAssertNil(_sut.challengeDescription);
        XCTAssertNotNil(_sut.type);
        XCTAssertNotNil(_sut.startDate);
        XCTAssertNotNil(_sut.endDate);
        XCTAssertNil(_sut.iconUrl);
        MNFSpendingChallenge *spending = (MNFSpendingChallenge*)_sut.challengeModel;
        XCTAssertNotNil(spending.categoryIds);
        XCTAssertNotNil(spending.targetPercentage);
        XCTAssertNotNil(spending.targetAmount);
        XCTAssertNil(spending.spentAmount);
        XCTAssertNotNil(spending.numberOfParticipants);
        XCTAssertNotNil(spending.recurringInterval);
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

- (void)testCreateChallenge {
    [MNFNetworkProtocolForTesting setResponseData:[self challengeResponse]];
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [MNFChallenge challengeWithTitle:@"title" description:@"description" startDate:[NSDate date] endDate:[NSDate date] iconUrl:@"iconUrl" typeData:@{} completion:^(MNFChallenge * _Nullable challenge, NSError * _Nullable error) {
        XCTAssertNil(error);
        XCTAssertNotNil(challenge.challengeId);
        XCTAssertNotNil(challenge.accepted);
        XCTAssertNil(challenge.acceptedDate);
        XCTAssertNotNil(challenge.topicId);
        XCTAssertNil(challenge.title);
        XCTAssertNil(challenge.challengeDescription);
        XCTAssertNotNil(challenge.type);
        XCTAssertNotNil(challenge.startDate);
        XCTAssertNotNil(challenge.endDate);
        XCTAssertNil(challenge.iconUrl);
        MNFSpendingChallenge *spending = (MNFSpendingChallenge*)challenge.challengeModel;
        XCTAssertNotNil(spending.categoryIds);
        XCTAssertNotNil(spending.targetPercentage);
        XCTAssertNotNil(spending.targetAmount);
        XCTAssertNil(spending.spentAmount);
        XCTAssertNotNil(spending.numberOfParticipants);
        XCTAssertNotNil(spending.recurringInterval);
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

- (void)testSaveChallenge {
    [MNFNetworkProtocolForTesting setResponseData:[self challengeResponse]];
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    _sut.title = @"NewTitle";
    [_sut saveWithCompletion:^(NSError * _Nullable error) {
        XCTAssertNil(error);
        XCTAssertNotEqual(_sut.title, @"NewTitle"); //Can't change a 'SuggestedSpending' challenge.
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

- (void)testDeleteChallenge {
    [MNFNetworkProtocolForTesting setResponseData:[self emptyResponse]];
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [_sut deleteWithCompletion:^(NSError * _Nullable error) {
        XCTAssertNil(error);
        XCTAssertTrue(_sut.isDeleted);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

-(NSData*)challengesResponse {
    return [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"challengesResponse" ofType:@"json"]];
}
-(NSData*)challengeResponse {
    return [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"challengeResponse" ofType:@"json"]];
}
-(NSData*)emptyResponse {
    return [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"emptyResponse" ofType:@"json"]];
}

@end
