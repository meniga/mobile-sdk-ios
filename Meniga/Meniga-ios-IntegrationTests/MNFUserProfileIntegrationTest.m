//
//  MNFUserProfileIntegrationTest.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 20/04/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNFIntegrationTestSetup.h"
#import "MNFUserProfile.h"

@interface MNFUserProfileIntegrationTest : MNFIntegrationTestSetup

@end

@implementation MNFUserProfileIntegrationTest

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testFetchUserProfile {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    // MARK: NOTE User profile sends back empty dictionary
    MNFJob *job =
        [MNFUserProfile fetchWithCompletion:^(MNFUserProfile *_Nullable userProfile, NSError *_Nullable error) {
            //        NSLog(@"user profile is: %@", userProfile);

            XCTAssertNotNil(userProfile);
            XCTAssertNotNil(userProfile.personId);
            XCTAssertNotNil(userProfile.created);

            XCTAssertNil(error);

            [expectation fulfill];
        }];

    [job handleCompletion:^(MNFUserProfile *_Nullable userProfile, id _Nullable metaData, NSError *_Nullable error) {
        XCTAssertNotNil(userProfile);
        XCTAssertNotNil(userProfile.personId);
        XCTAssertNotNil(userProfile.created);

        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];

    [self waitForExpectationsWithTimeout:kMNFIntegrationTestWaitTime handler:nil];
}

@end
