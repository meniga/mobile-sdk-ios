//
//  MNFTagIntegrationTest.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 22/04/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNFIntegrationTestSetup.h"
#import "MNFTransactionPage.h"
#import "MNFSynchronization.h"
#import "MNFTransaction.h"
#import "MNFTransactionFilter.h"
#import "MNFTag.h"
#import "MNFDemoUser.h"

@interface MNFTagIntegrationTest : MNFIntegrationTestSetup

@end

@implementation MNFTagIntegrationTest

- (void)setUp {
    [super setUp];
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    [MNFDemoUser startSynchronizationWithWaitTime:@1000 completion:^(MNFSynchronization * _Nullable synchronization, NSError * _Nullable error) {
        //dispatch_semaphore_signal(semaphore);
    }];
    
    dispatch_semaphore_wait(semaphore, dispatch_time(DISPATCH_TIME_NOW, 5.0 * NSEC_PER_SEC));
}

- (void)tearDown {
    [super tearDown];
}

-(void)testFetchTags {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFTransactionFilter *filter = [[MNFTransactionFilter alloc] init];
    
    [MNFTransactionPage fetchWithTransactionFilter:filter page:nil transactionsPerPage:@1000 completion:^( MNFTransactionPage * _Nullable page, NSError * _Nullable error) {
        
        [[page.transactions firstObject] postComment:@"testComment with #hashtag" withCompletion:^(NSError * _Nullable error) {
            
            XCTAssertNil(error);
            
            MNFJob *job = [MNFTag fetchTagsWithCompletion:^(NSArray<MNFTag *> * _Nullable tags, NSError * _Nullable error) {
            
                XCTAssertNil(error);
                
                XCTAssertNotNil(tags);
                XCTAssertEqualObjects([tags firstObject].name, @"hashtag");
                
                [MNFTag fetchWithId:[tags firstObject].identifier completion:^(MNFTag * _Nullable tag, NSError * _Nullable error) {
                
                    XCTAssertNil(error);
                    XCTAssertNotNil(tag);
                    XCTAssertEqualObjects(tag.name, @"hashtag");
                    
                    [expectation fulfill];
                
                }];
            }];
            
            [job handleCompletion:^(NSArray<MNFTag *> * _Nullable tags, id  _Nullable metaData, NSError * _Nullable error) {
                
                XCTAssertNotNil(tags);
                XCTAssertEqualObjects([tags firstObject].name, @"hashtag");
                XCTAssertNil(metaData);
                XCTAssertNil(error);
                
            }];
        }];
    }];
    
    [self waitForExpectationsWithTimeout:kMNFIntegrationTestWaitTime handler:nil];
}

-(void)testFetchPopularTags {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFTransactionFilter *filter = [[MNFTransactionFilter alloc] init];
    [MNFTransactionPage fetchWithTransactionFilter:filter page:nil transactionsPerPage:@1000 completion:^( MNFTransactionPage * _Nullable page, NSError * _Nullable error) {
        
        [[page.transactions firstObject] postComment:@"testComment with #hashtag" withCompletion:^(NSError * _Nullable error) {
            
            MNFJob *job = [MNFTag fetchPopularTagsWithCount:@10 completion:^(NSArray<MNFTag *> * _Nullable tags, NSError * _Nullable error) {
                
                XCTAssertNil(error);
                XCTAssertNotNil(tags);
                XCTAssertTrue(tags.count != 0);
                XCTAssertEqualObjects(tags.firstObject.name, @"hashtag");
                
                [expectation fulfill];
                
            }];
            
            [job handleCompletion:^(NSArray<MNFTag *> * _Nullable tags, id  _Nullable metaData, NSError * _Nullable error) {
                
                XCTAssertNotNil(tags);
                XCTAssertTrue(tags.count != 0);
                XCTAssertEqualObjects(tags.firstObject.name, @"hashtag");
                
                XCTAssertNil(metaData);
                XCTAssertNil(error);
                
            }];
        }];
    }];
    
    [self waitForExpectationsWithTimeout:kMNFIntegrationTestWaitTime handler:nil];
}

@end
