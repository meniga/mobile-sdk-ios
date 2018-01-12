//
//  MenigaObjectTest.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 30/09/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNFObject.h"
#import "MNFObject_private.h"
#import "MNFURLRequestConstants.h"
#import "MNFNetwork.h"
#import "MNFNetworkProtocolForTesting.h"
#import "MNFResponse.h"
#import "MNFHTTPMethods.h"
#import "MNFTransaction.h"
#import "MNFObjectState.h"

@interface MNFObjectTest : XCTestCase

@end

@implementation MNFObjectTest {
    MNFTransaction *_sut;
}

-(void)setUp {
    [super setUp];
    [MNFNetwork initializeForTesting];
    NSDictionary *transactionData = [NSJSONSerialization JSONObjectWithData:[self transactionResponse] options:0 error:nil];
    NSDictionary *unwrap = [transactionData objectForKey:@"data"];
    _sut = [MNFJsonAdapter objectOfClass:[MNFTransaction class] jsonDict:unwrap option:kMNFAdapterOptionNoOption error:nil];
}
-(void)tearDown {
    _sut = nil;
    [MNFNetwork flushForTesting];
    [super tearDown];
}

-(void)testInit {
    XCTAssertNotNil([[MNFObject alloc] init]);
    XCTAssertTrue([[MNFObject alloc] init].isNew == YES);
    XCTAssertTrue([[MNFObject alloc] initNeutral].isNew == NO);
}

- (void)testStateUpdatesOnChange {
    
    _sut.text = @"lalala";
    
    XCTAssertEqualObjects([[_sut objectState] stateValueForKey:@"text"], @"Gate Cinema");
    
}

- (void)testStateUpdatesOnChangeButPersistsValueOfFirstChange {
    
    _sut.text = @"lalala";
    _sut.text = @"lalala2";
    
    XCTAssertEqualObjects([[_sut objectState] stateValueForKey:@"text"], @"Gate Cinema");
    
}


- (void)testStateUpdatesClearOnRevert {
    
    _sut.text = @"lalala";
    [_sut revert];
    
    XCTAssertTrue([[_sut objectState] serverData].count == 0);
    
}


- (void)testObjectResetsOnRevert {
    
    _sut.text = @"lalala";
    [_sut revert];
    
    XCTAssertEqualObjects(_sut.text, @"Gate Cinema");
    
}

-(void)testDirtynessIsTrueWhenAlteringObject{

    _sut.text = @"lalala";
    
    XCTAssertTrue(_sut.isDirty);
}

- (void)testDirtynessIsFalseWhenResettingObject {
    
    _sut.text = @"lalala";
    [_sut revert];
    
    XCTAssertFalse(_sut.isDirty);
    
}

#pragma mark - helpers

-(NSData*)transactionResponse{
    return [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"transactionResponse" ofType:@"json"]];
}

@end
