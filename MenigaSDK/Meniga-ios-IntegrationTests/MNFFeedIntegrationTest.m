//
//  MNFFeedIntegrationTest.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 02/05/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNFIntegrationTestSetup.h"
#import "MNFFeed.h"
#import "MNFFeedItem.h"
#import "MNFTransaction.h"
#import "MNFDemoUser.h"

@interface MNFFeedIntegrationTest : MNFIntegrationTestSetup

@end

@implementation MNFFeedIntegrationTest

- (void)setUp {
    [super setUp];
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    [MNFDemoUser startSynchronizationWithWaitTime:@1000 completion:^(MNFSynchronization * _Nullable synchronization, NSError * _Nullable error) {
        //dispatch_semaphore_signal(semaphore);
    }];
    
    dispatch_semaphore_wait(semaphore, dispatch_time(DISPATCH_TIME_NOW, kMNFIntegrationTestWaitTime*NSEC_PER_SEC));
}

- (void)tearDown {
    [super tearDown];
}

-(void)testFetchFeed {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    NSDate *fromDate = [NSDate dateWithTimeIntervalSinceNow:-120*24*60*60];
    NSDate *toDate = [NSDate date];

    MNFJob *job = [MNFFeed fetchFromDate:fromDate toDate:toDate skip:nil take:nil withCompletion:^(MNFFeed * _Nullable feed, NSError * _Nullable error) {
        
        XCTAssertNil(error);
        XCTAssertNotNil(feed);
        
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        
        XCTAssertNotNil(result);
        
        XCTAssertNotNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:kMNFIntegrationTestWaitTime handler:nil];
}

-(void)testAppendDays {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    NSDate *fromDate = [NSDate dateWithTimeIntervalSinceNow:-120*24*60*60];
    NSDate *toDate = [NSDate date];
    
    MNFJob *job = [MNFFeed fetchFromDate:fromDate toDate:toDate skip:nil take:nil withCompletion:^(MNFFeed * _Nullable feed, NSError * _Nullable error) {
        
        XCTAssertNotNil(feed);
        
        NSDate *currentFromDate = feed.from;
        
        MNFJob *secondJob = [feed appendDays:@30 withCompletion:^(NSArray <MNFFeedItem *> *newItems, NSError * _Nullable error) {
        
            XCTAssertNil(error);
            XCTAssertNotEqualObjects(currentFromDate, feed.to);
            
            [expectation fulfill];
        }];
        
        [secondJob handleCompletion:^(id _Nullable result, id _Nullable metadata, NSError * _Nullable error) {
           
            XCTAssertNotNil(result);
            XCTAssertNotEqualObjects(currentFromDate, feed.to);
            
            XCTAssertNotNil(metadata);
            XCTAssertNil(error);
            
        }];
        
    }];
    
    [job handleCompletion:^(MNFFeed * _Nullable feed, id  _Nullable metaData, NSError * _Nullable error) {
        
        XCTAssertNotNil(feed);
        
        XCTAssertNotNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:kMNFIntegrationTestWaitTime handler:nil];
}

//CHECK: Timed out
-(void)testRefreshFeed {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    NSDate *fromDate = [NSDate dateWithTimeIntervalSinceNow:-30*24*60*60];
    NSDate *toDate = [NSDate date];
    
    [MNFFeed fetchFromDate:fromDate toDate:toDate skip:nil take:nil withCompletion:^(MNFFeed * _Nullable feed, NSError * _Nullable error) {
        
        XCTAssertNotNil(feed);
        XCTAssertNil(error);
        
        MNFTransaction *transaction = nil;
        
        for (MNFFeedItem *item in feed.feedItems) {
            
            if ([item.model isKindOfClass:[MNFTransaction class]] == YES) {
                transaction = (MNFTransaction *)item.model;
                transaction.text = @"changed text";
                break;
            }
            
        }
        
        MNFJob *job = [feed refreshFromServerFromDate:feed.from toDate:feed.to withCompletion:^(NSArray <MNFFeedItem *> *newItems, NSArray <MNFFeedItem *> *itemsToReplace, NSError * _Nullable error) {
        
            MNFTransaction *trans = nil;
            
            for (MNFFeedItem *item in feed.feedItems) {
                
                if ([item.model isKindOfClass:[MNFTransaction class]] == YES) {
                    trans = (MNFTransaction *)item.model;
                    break ;
                }
                
            }

            XCTAssertNotEqualObjects(trans.text, @"changed text");
            
            XCTAssertNil(error);
            
            [expectation fulfill];
        }];
        
        [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
            
            
            MNFTransaction *trans = nil;
            
            for (MNFFeedItem *item in feed.feedItems) {
                
                if ([item.model isKindOfClass:[MNFTransaction class]] == YES) {
                    trans = (MNFTransaction *)item.model;
                    break;
                }
                
            }
            
            XCTAssertNotEqualObjects(trans.text, @"changed text");
            
            // MARK: We need to add metadata as a parameter to all endpoints as it can be anywhere and the sdk should handle that.
            XCTAssertNil(metaData);
            
            XCTAssertNil(error);
        }];
    }];
    
    [self waitForExpectationsWithTimeout:kMNFIntegrationTestWaitTime handler:nil];
}

-(void)testFetchFeedTypes {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFJob *job = [MNFFeed fetchFeedTypesWithCompletion:^(NSArray<NSString *> * _Nullable feedTypes, NSError * _Nullable error) {
        
        XCTAssertNil(error);
        XCTAssertNotNil(feedTypes);
        XCTAssertTrue(feedTypes.count != 0);
        XCTAssertTrue(feedTypes.count == 4);
        
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(NSArray<NSString *> * _Nullable feedTypes, id  _Nullable metaData, NSError * _Nullable error) {
        
        XCTAssertNotNil(feedTypes);
        XCTAssertTrue(feedTypes.count != 0);
        XCTAssertTrue(feedTypes.count == 4);
        
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:kMNFIntegrationTestWaitTime handler:nil];
}

-(void)testFeedErrorData {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [MNFFeed fetchFromDate:[NSDate date] toDate:[NSDate date] skip: @"jækladfajsæ" take:nil withCompletion:^(MNFFeed *feed, NSError *error) {
       
        XCTAssertNotNil( error );
        
        [expectation fulfill];
        
    }];
    
    [self waitForExpectationsWithTimeout:kMNFIntegrationTestWaitTime handler:nil];

}

@end
