//
//  MNFRealmUserIntegrationTest.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 20/04/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNFIntegrationTestSetup.h"
#import "MNFRealmUser.h"

@interface MNFRealmUserIntegrationTest : MNFIntegrationTestSetup

@end

@implementation MNFRealmUserIntegrationTest

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testFetchAndDeleteRealmUsers {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];

    MNFJob *job = [MNFRealmUser
        fetchRealmUsersWithCompletion:^(NSArray<MNFRealmUser *> *_Nullable users, NSError *_Nullable error) {
            XCTAssertNil(error);
            XCTAssertNotNil(users);

            MNFJob *secondJob = [[users firstObject] deleteRealmUserWithCompletion:^(NSError *_Nullable error) {
                XCTAssertTrue(users.firstObject.isDeleted == YES);
                XCTAssertNil(error);

                [expectation fulfill];
            }];

            [secondJob handleCompletion:^(id _Nullable result, id _Nullable metadata, NSError *_Nullable error) {
                XCTAssertTrue(users.firstObject.isDeleted == YES);

                XCTAssertNil(metadata);
                XCTAssertNil(error);
            }];
        }];

    [job handleCompletion:^(NSArray<MNFUser *> *users, id _Nullable metaData, NSError *_Nullable error) {
        XCTAssertNotNil(users);

        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];

    [self waitForExpectationsWithTimeout:kMNFIntegrationTestWaitTime handler:nil];
}

@end
