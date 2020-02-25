//
//  MNFUserIntegrationTest.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 20/04/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNFIntegrationTestSetup.h"
#import "MNFUser.h"

@interface MNFUserIntegrationTest : MNFIntegrationTestSetup

@end

@implementation MNFUserIntegrationTest

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testFetchUsers {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];

    MNFJob *job = [MNFUser fetchUsersWithCompletion:^(NSArray<MNFUser *> *_Nullable users, NSError *_Nullable error) {
        XCTAssertNil(error);
        XCTAssertNotNil(users);
        XCTAssertTrue(users.count != 0);

        [expectation fulfill];
    }];

    [job handleCompletion:^(NSArray<MNFUser *> *_Nullable users, id _Nullable metaData, NSError *_Nullable error) {
        XCTAssertNotNil(users);
        XCTAssertTrue(users.count != 0);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];

    [self waitForExpectationsWithTimeout:kMNFIntegrationTestWaitTime handler:nil];
}

- (void)testSaveUser {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];

    [MNFUser fetchUsersWithCompletion:^(NSArray<MNFUser *> *_Nullable users, NSError *_Nullable error) {
        [users firstObject].firstName = @"changed first name";
        [users firstObject].lastName = @"changed last name";

        MNFJob *job = [[users firstObject] saveWithCompletion:^(NSError *_Nullable error) {
            XCTAssertNil(error);
            XCTAssertEqualObjects([users firstObject].firstName, @"changed first name");
            XCTAssertEqualObjects([users firstObject].lastName, @"changed last name");

            [expectation fulfill];
        }];

        [job handleCompletion:^(id _Nullable result, id _Nullable metaData, NSError *_Nullable error) {
            XCTAssertEqualObjects([users firstObject].firstName, @"changed first name");
            XCTAssertEqualObjects([users firstObject].lastName, @"changed last name");

            XCTAssertNotNil(result);
            XCTAssertNil(metaData);
            XCTAssertNil(error);
        }];
    }];

    [self waitForExpectationsWithTimeout:kMNFIntegrationTestWaitTime handler:nil];
}

- (void)testRefreshUser {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];

    [MNFUser fetchUsersWithCompletion:^(NSArray<MNFUser *> *_Nullable users, NSError *_Nullable error) {
        [users firstObject].firstName = @"changed first name";

        MNFJob *job = [[users firstObject] refreshWithCompletion:^(NSError *_Nullable error) {
            XCTAssertNil(error);

            XCTAssertNotEqualObjects([users firstObject].firstName, @"changed first name");

            [expectation fulfill];
        }];

        [job handleCompletion:^(id _Nullable result, id _Nullable metaData, NSError *_Nullable error) {
            XCTAssertNotEqualObjects([users firstObject].firstName, @"changed first name");

            XCTAssertNotNil(result);
            XCTAssertNil(metaData);
            XCTAssertNil(error);
        }];
    }];

    [self waitForExpectationsWithTimeout:kMNFIntegrationTestWaitTime handler:nil];
}

- (void)testChangeCulture {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];

    [MNFUser fetchUsersWithCompletion:^(NSArray<MNFUser *> *_Nullable users, NSError *_Nullable error) {
        MNFJob *job = [[users firstObject] changeCulture:@"is-IS"
                                          withCompletion:^(NSError *_Nullable error) {
                                              XCTAssertNil(error);
                                              XCTAssertEqualObjects([users firstObject].culture, @"is-IS");

                                              [expectation fulfill];
                                          }];

        [job handleCompletion:^(id _Nullable result, id _Nullable metaData, NSError *_Nullable error) {
            XCTAssertEqualObjects([users firstObject].culture, @"is-IS");

            XCTAssertNil(metaData);
            XCTAssertNil(error);
        }];
    }];

    [self waitForExpectationsWithTimeout:kMNFIntegrationTestWaitTime handler:nil];
}

- (void)testOptIn {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];

    [MNFUser fetchUsersWithCompletion:^(NSArray<MNFUser *> *_Nullable users, NSError *_Nullable error) {
        MNFJob *job = [[users firstObject] optInWithCompletion:^(NSError *_Nullable error) {
            XCTAssertNil(error);

            [expectation fulfill];
        }];

        [job handleCompletion:^(id _Nullable result, id _Nullable metaData, NSError *_Nullable error) {
            XCTAssertNil(result);
            XCTAssertNil(metaData);

            XCTAssertNil(error);
        }];
    }];

    [self waitForExpectationsWithTimeout:kMNFIntegrationTestWaitTime handler:nil];
}

- (void)testOptOut {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];

    [MNFUser fetchUsersWithCompletion:^(NSArray<MNFUser *> *_Nullable users, NSError *_Nullable error) {
        MNFJob *job = [[users firstObject] optOutWithCompletion:^(NSError *_Nullable error) {
            XCTAssertNil(error);

            [expectation fulfill];
        }];

        [job handleCompletion:^(id _Nullable result, id _Nullable metaData, NSError *_Nullable error) {
            XCTAssertNil(result);
            XCTAssertNil(metaData);
            XCTAssertNil(error);
        }];
    }];

    [self waitForExpectationsWithTimeout:kMNFIntegrationTestWaitTime handler:nil];
}

- (void)testUserMetadata {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];

    [MNFUser fetchUsersWithCompletion:^(NSArray<MNFUser *> *_Nullable users, NSError *_Nullable error) {
        [[users firstObject]
            updateMetaDataForKey:@"metadataKey"
                           value:@"metadataValue"
                      completion:^(NSError *_Nullable error) {
                          XCTAssertNil(error);

                          MNFJob *job = [[users firstObject]
                              fetchMetaDataForKeys:@"metadataKey"
                                        completion:^(NSArray<NSDictionary *> *_Nullable metadatas,
                                                     NSError *_Nullable error) {
                                            NSDictionary *metadata = [metadatas firstObject];

                                            XCTAssertEqualObjects([metadata objectForKey:@"key"], @"metadataKey");
                                            XCTAssertEqualObjects([metadata objectForKey:@"value"], @"metadataValue");

                                            XCTAssertNil(error);
                                            XCTAssertNotNil(metadatas);

                                            [expectation fulfill];
                                        }];

                          [job handleCompletion:^(NSArray<NSDictionary *> *_Nullable metadatas,
                                                  id _Nullable meta,
                                                  NSError *_Nullable error) {
                              NSDictionary *metadata = [metadatas firstObject];

                              XCTAssertEqualObjects([metadata objectForKey:@"key"], @"metadataKey");
                              XCTAssertEqualObjects([metadata objectForKey:@"value"], @"metadataValue");

                              XCTAssertNotNil(metadatas);
                              XCTAssertNil(meta);
                              XCTAssertNil(error);
                          }];
                      }];
    }];

    [self waitForExpectationsWithTimeout:kMNFIntegrationTestWaitTime handler:nil];
}

@end
