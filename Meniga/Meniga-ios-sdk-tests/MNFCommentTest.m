//
//  MNFCommentTest.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 13/04/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNFComment.h"
#import "MNFNetworkProtocolForTesting.h"
#import "MNFNetwork.h"
#import "MNFJsonAdapter.h"

@interface MNFCommentTest : XCTestCase

@end

@implementation MNFCommentTest {
    MNFComment *_sut;
}

- (void)setUp {
    [super setUp];
    [MNFNetwork initializeForTesting];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[self commentResponse] options:0 error:nil];
    NSDictionary *unwrap = [dict objectForKey:@"data"];
    _sut = [MNFJsonAdapter objectOfClass:[MNFComment class] jsonDict:unwrap option:kMNFAdapterOptionNoOption error:nil];
}

- (void)tearDown {
    _sut = nil;
    [MNFNetwork flushForTesting];
    [super tearDown];
}

-(void)testSaveUpdatesObject {
    [MNFNetworkProtocolForTesting setResponseData:[self commentResponse]];
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    _sut.comment = @"change";
    MNFJob *job = [_sut saveWithCompletion:^(NSError * _Nullable error) {
        XCTAssertNil(error);
        XCTAssertEqualObjects(_sut.comment, @"change");
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

-(void)testDeleteSetsObjectDeleted {
    [MNFNetworkProtocolForTesting setResponseData:[self emptyResponse]];
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFJob *job = [_sut deleteCommentWithCompletion:^(NSError * _Nullable error) {
        XCTAssertNil(error);
        XCTAssertTrue(_sut.isDeleted);
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

-(NSData*)commentResponse {
    return [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"commentResponse" ofType:@"json"]];
}
-(NSData*)emptyResponse {
    return [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"emptyResponse" ofType:@"json"]];
}

@end
