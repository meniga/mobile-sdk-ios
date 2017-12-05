//
//  MNFFeedTest.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 12/11/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNFFeed.h"
#import "MNFFeedItem.h"
#import "MNFFeedItemGroup.h"
#import "MNFTransaction.h"
//#import "MNFUserEvent.h"
#import "MNFNetwork.h"
#import "MNFNetworkProtocolForTesting.h"

@interface MNFFeedTest : XCTestCase

@end

@implementation MNFFeedTest

- (void)setUp {
    [super setUp];
    [MNFNetwork initializeForTesting];
}

- (void)tearDown {
    [MNFNetwork flushForTesting];
    [super tearDown];
}

-(void)testFetchFeed {
    
    [MNFNetworkProtocolForTesting setResponseData:[self feedResponse]];
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFJob *job = [MNFFeed fetchFromDate:[NSDate date] toDate:[NSDate date] skip:nil take:nil withCompletion:^(MNFFeed * _Nullable feed, NSError * _Nullable error) {
        XCTAssertNil(error);
        XCTAssertNotNil(feed);
        XCTAssertNotNil(feed.from);
        XCTAssertNotNil(feed.to);
        XCTAssertNotNil(feed.feedItems);
        XCTAssertNil(feed.actualEndDate);
        XCTAssertFalse(feed.hasMorePages);
        XCTAssertTrue(feed.hasMoreData);
        MNFFeedItem *feedItem = [feed.feedItems firstObject];
        XCTAssertNotNil(feedItem.topicId);
        XCTAssertNotNil(feedItem.topicName);
        XCTAssertNotNil(feedItem.typeName);
        XCTAssertNotNil(feedItem.title);
        XCTAssertNotNil(feedItem.body);
        XCTAssertNotNil(feedItem.model);
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNotNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

-(void)testAppendDays {
    [MNFNetworkProtocolForTesting setResponseData:[self feedResponse]];
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFJob *job = [MNFFeed fetchFromDate:[NSDate date] toDate:[NSDate date] skip:nil take:nil withCompletion:^(MNFFeed * _Nullable feed, NSError * _Nullable error) {
        [MNFNetworkProtocolForTesting setResponseData:[self feedResponse]];
        NSUInteger feedItemCount = feed.feedItems.count;
        [feed appendDays:@2 withCompletion:^(NSArray <MNFFeedItem *> *newItems, NSError * _Nullable error) {
            XCTAssertNil(error);
            XCTAssertEqual(feed.feedItems.count, feedItemCount*2);
            [expectation fulfill];
        }];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNotNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

-(void)testAppendPage{

    [MNFNetworkProtocolForTesting setResponseData:[self feedResponse]];
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [MNFFeed fetchFromDate:[NSDate date] toDate:[NSDate date] skip:@(0) take:@(10) withCompletion:^(MNFFeed * _Nullable feed, NSError * _Nullable error) {
        [MNFNetworkProtocolForTesting setResponseData:[self feedResponse]];
        NSUInteger feedItemCount = feed.feedItems.count;
        
        [feed setValue:@(YES) forKey:@"_hasMorePages"]; //data does not return more pages, so injected the value
        
        MNFJob * job = [feed appendPageWithCompletion:^(NSArray <MNFFeedItem *> *newItems, NSError * _Nullable error) {
            
            XCTAssertNil(error);
            XCTAssertEqual(feed.feedItems.count, feedItemCount*2);
            
            [expectation fulfill];
            
        }];
        
        [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
            XCTAssertNil(error);
        }];
        
    }];
    
    
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];

}


-(void)testNextPage{

    [MNFNetworkProtocolForTesting setResponseData:[self feedResponse]];
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [MNFFeed fetchFromDate:[NSDate date] toDate:[NSDate date] skip:@(0) take:@(10) withCompletion:^(MNFFeed * _Nullable feed, NSError * _Nullable error) {
        [MNFNetworkProtocolForTesting setResponseData:[self feedResponse]];
        NSUInteger feedItemCount = feed.feedItems.count;
        
        [feed setValue:@(YES) forKey:@"_hasMorePages"]; //data does not return more pages, so injected the value
        
        MNFJob *job = [feed nextPageWithCompletion:^(NSError * _Nullable error) {
            
            XCTAssertNil(error);
            XCTAssertEqual(feed.feedItems.count, feedItemCount);
            
            [expectation fulfill];
            
        }];
        
        [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
            XCTAssertNil(error);
        }];
        
        
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}


-(void)testPrevPage{

    [MNFNetworkProtocolForTesting setResponseData:[self feedResponse]];
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [MNFFeed fetchFromDate:[NSDate date] toDate:[NSDate date] skip:@(0) take:@(10) withCompletion:^(MNFFeed * _Nullable feed, NSError * _Nullable error) {
        [MNFNetworkProtocolForTesting setResponseData:[self feedResponse]];
        
        NSUInteger feedItemCount = feed.feedItems.count;
        [feed setValue:@(YES) forKey:@"_hasMorePages"]; //data does not return more pages, so injected the value
        
        [feed nextPageWithCompletion:^(NSError * _Nullable error) {
            [MNFNetworkProtocolForTesting setResponseData:[self feedResponse]];
            
            XCTAssertNil(error);
            
            MNFJob *job = [feed prevPageWithCompletion:^(NSError * _Nullable error) {
               
                XCTAssertNil(error);
                XCTAssertEqual(feed.feedItems.count, feedItemCount);
                
                [expectation fulfill];
                
                
            }];
            
            [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
                XCTAssertNil(error);
            }];
            
            
            
        }];

    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}



-(void)testRefreshFeed {
    
    [MNFNetworkProtocolForTesting setResponseData:[self feedResponse]];
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFJob *job = [MNFFeed fetchFromDate:[NSDate date] toDate:[NSDate date] skip:nil take:nil withCompletion:^(MNFFeed * _Nullable feed, NSError * _Nullable error) {
        [MNFNetworkProtocolForTesting setResponseData:[self feedResponse]];
        MNFFeedItem *feedItem = [feed.feedItems firstObject];
        MNFTransaction *transaction = (MNFTransaction*)feedItem.model;
        transaction.text = @"changed text";
        MNFJob *newJob = [feed refreshFromServerFromDate:[NSDate distantPast] toDate:[NSDate date] withCompletion:^(NSArray <MNFFeedItem *> *newItems, NSArray <MNFFeedItem *> *replaceObjects, NSError * _Nullable error) {
            XCTAssertNil(error);
            MNFFeedItem *feedItem = [feed.feedItems firstObject];
            MNFTransaction *trans = (MNFTransaction*)feedItem.model;
            XCTAssertNotEqualObjects(trans.text, @"changed text");
            [expectation fulfill];
        }];
        
        [newJob handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
            XCTAssertNotNil(result);
            XCTAssertNil(metaData);
            XCTAssertNil(error);
        }];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNotNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

-(void)testFetchFeedTypes {
    
    [MNFNetworkProtocolForTesting setResponseData:[self feedTypesResponse]];
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFJob *job = [MNFFeed fetchFeedTypesWithCompletion:^(NSArray<NSString *> * _Nullable feedTypes, NSError * _Nullable error) {
        XCTAssertNil(error);
        XCTAssertNotNil(feedTypes);
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

-(void)testGroupByDateAndUngroup {
    
    [MNFNetworkProtocolForTesting setResponseData:[self feedResponse]];
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [MNFFeed fetchFromDate:[NSDate date] toDate:[NSDate date] skip:nil take:nil withCompletion:^(MNFFeed * _Nullable feed, NSError * _Nullable error) {
        [feed groupByDate];
//        NSLog(@"Feed items %@",feed.feedItems);
        XCTAssertNotNil(feed.feedItems);
        XCTAssertEqual(feed.feedItems.count, 9);
        for (int i=0;i<feed.feedItems.count;i++) {
            XCTAssertEqual([[feed.feedItems objectAtIndex:i] class], [MNFFeedItemGroup class]);
        }
        [feed ungroup];
//        NSLog(@"Feed items %@",feed.feedItems);
        XCTAssertEqual(feed.feedItems.count, 10);
        for (int i=0;i<feed.feedItems.count;i++) {
            XCTAssertEqual([[feed.feedItems objectAtIndex:i] class], [MNFFeedItem class]);
        }
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

#pragma mark - helpers
-(NSData*)feedResponse{
    return [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"feedResponse" ofType:@"json"]];
}
-(NSData*)feedTypesResponse{
    return [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"feedTypesResponse" ofType:@"json"]];
}

@end
