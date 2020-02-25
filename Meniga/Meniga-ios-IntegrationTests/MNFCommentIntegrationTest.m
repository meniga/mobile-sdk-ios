//
//  MNFCommentIntegrationTest.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 22/04/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNFComment.h"
#import "MNFDemoUser.h"
#import "MNFIntegrationTestSetup.h"
#import "MNFSynchronization.h"
#import "MNFTransaction.h"
#import "MNFTransactionFilter.h"
#import "MNFTransactionPage.h"

@interface MNFCommentIntegrationTest : MNFIntegrationTestSetup

@end

@implementation MNFCommentIntegrationTest

- (void)setUp {
    [super setUp];
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    [MNFDemoUser
        startSynchronizationWithWaitTime:@1000
                              completion:^(MNFSynchronization *_Nullable synchronization, NSError *_Nullable error) {
                                  dispatch_semaphore_signal(semaphore);
                              }];

    dispatch_semaphore_wait(semaphore, dispatch_time(DISPATCH_TIME_NOW, kMNFIntegrationTestWaitTime * NSEC_PER_SEC));
}

- (void)tearDown {
    [super tearDown];
}

- (void)testSaveComment {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];

    MNFTransactionFilter *filter = [[MNFTransactionFilter alloc] init];
    [MNFTransactionPage
        fetchWithTransactionFilter:filter
                              page:nil
               transactionsPerPage:@10
                        completion:^(MNFTransactionPage *_Nullable page, NSError *_Nullable error) {
                            MNFJob *job = [[page.transactions firstObject]
                                   postComment:@"testComment"
                                withCompletion:^(NSError *_Nullable error) {
                                    MNFComment *comment = [[page.transactions firstObject].comments firstObject];
                                    XCTAssertEqualObjects(comment.comment, @"testComment");
                                    comment.comment = @"changed comment";

                                    MNFJob *secondJob = [comment saveWithCompletion:^(NSError *_Nullable error) {
                                        XCTAssertNil(error);
                                        XCTAssertEqualObjects(comment.comment, @"changed comment");

                                        [expectation fulfill];
                                    }];

                                    [secondJob
                                        handleCompletion:^(
                                            id _Nullable result, id _Nullable metadata, NSError *_Nullable error) {
                                            XCTAssertNil(error);
                                            XCTAssertNil(metadata);
                                            XCTAssertEqualObjects(comment.comment, @"changed comment");
                                        }];
                                }];

                            [job handleCompletion:^(
                                     id _Nullable result, id _Nullable metaData, NSError *_Nullable error) {
                                MNFComment *comment = [[page.transactions firstObject].comments firstObject];
                                XCTAssertEqualObjects(comment.comment, @"testComment");

                                XCTAssertNotNil(result);
                                XCTAssertNil(metaData);
                                XCTAssertNil(error);
                            }];
                        }];

    [self waitForExpectationsWithTimeout:kMNFIntegrationTestWaitTime handler:nil];
}

- (void)testDeleteComment {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];

    MNFTransactionFilter *filter = [[MNFTransactionFilter alloc] init];

    [MNFTransactionPage
        fetchWithTransactionFilter:filter
                              page:nil
               transactionsPerPage:@10
                        completion:^(MNFTransactionPage *_Nullable page, NSError *_Nullable error) {
                            [[page.transactions firstObject]
                                   postComment:@"testComment"
                                withCompletion:^(NSError *_Nullable error) {
                                    MNFComment *comment = [[page.transactions firstObject].comments firstObject];
                                    XCTAssertEqualObjects(comment.comment, @"testComment");
                                    XCTAssertNotNil(comment);

                                    MNFJob *job = [comment deleteCommentWithCompletion:^(NSError *_Nullable error) {
                                        XCTAssertNil(error);
                                        XCTAssertTrue(comment.isDeleted);

                                        [expectation fulfill];
                                    }];

                                    [job handleCompletion:^(
                                             id _Nullable result, id _Nullable metaData, NSError *_Nullable error) {
                                        XCTAssertTrue(comment.isDeleted);
                                        XCTAssertNil(result);
                                        XCTAssertNil(metaData);
                                        XCTAssertNil(error);
                                    }];
                                }];
                        }];

    [self waitForExpectationsWithTimeout:60 handler:nil];
}

@end
