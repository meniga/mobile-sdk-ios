//
//  MNFTagTest.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 11/6/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNFTag.h"
#import "MNFNetwork.h"
#import "MNFNetworkProtocolForTesting.h"
#import "MNFJsonAdapter.h"

@interface MNFTagTest : XCTestCase

@end

@implementation MNFTagTest {
    MNFTag *_sut;
    NSArray *_ssut;
}

- (void)setUp {
    [super setUp];
    [MNFNetwork initializeForTesting];

}

- (void)tearDown {
    [MNFNetwork flushForTesting];

    [super tearDown];
}

-(void)testTagCreation {
    MNFTag *tag = [[MNFTag alloc] init];
    XCTAssertTrue(tag.isNew == YES);
}

-(void)testFetchWithIdWithCompletion {
    [MNFNetworkProtocolForTesting setObjectType:MNFTagObject];
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    MNFJob *job = [MNFTag fetchWithId:@1 completion:^(MNFTag * _Nullable tag, NSError * _Nullable error) {
        
        XCTAssertNotNil(tag);
        XCTAssertNil(error);
        XCTAssertNotNil(tag.identifier);
        XCTAssertNotNil(tag.name);
        XCTAssertTrue(tag.isNew == NO);
        
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

-(void)testFetchTagsWithCompletion {
    [MNFNetworkProtocolForTesting setResponseData:[NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"tagsResponse" ofType:@"json"] options:0 error:nil]];
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    MNFJob *job = [MNFTag fetchTagsWithCompletion:^(NSArray *tags, NSError *error) {
       
        XCTAssertNotNil(tags);
        XCTAssertNil(error);
        XCTAssertTrue(tags.count == 5);
        
        for (MNFTag *tag in tags) {
            XCTAssertNotNil(tag.identifier);
            XCTAssertNotNil(tag.name);
            XCTAssertTrue(tag.isNew == NO);
        }
        
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

-(void)testFetchPopularTags {
    [MNFNetworkProtocolForTesting setResponseData:[NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"tagsResponse" ofType:@"json"] options:0 error:nil]];
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    MNFJob *job = [MNFTag fetchPopularTagsWithCount:@5 completion:^(NSArray *tags, NSError *error) {
        
        XCTAssertNotNil(tags);
        XCTAssertNil(error);
        XCTAssertTrue(tags.count == 5);
        
        for (MNFTag *tag in tags) {
            XCTAssertNotNil(tag.identifier);
            XCTAssertNotNil(tag.name);
            XCTAssertTrue(tag.isNew == NO);
        }
        
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}
@end
