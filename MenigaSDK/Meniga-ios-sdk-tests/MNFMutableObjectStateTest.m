//
//  MNFMutableObjectStateTest.m
//  Meniga-ios-sdk
//
//  Created by Aske Bendtsen on 13/11/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNFTransaction.h"
#import "MNFMutableObject_Private.h"

#import "MNFObjectState.h"
#import "MNFJsonAdapter.h"

@interface MNFMutableObjectStateTest : XCTestCase

@end

@implementation MNFMutableObjectStateTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testStateUpdatesOnChange {
    
    NSDictionary *transactionDict = [NSJSONSerialization JSONObjectWithData:[self transactionResponse] options:0 error:nil];
    NSDictionary *transactionData = [transactionDict objectForKey:@"data"];
    MNFTransaction *testTrans = [MNFJsonAdapter objectOfClass:[MNFTransaction class] jsonDict:transactionData option:kMNFAdapterOptionNoOption error:nil];
    
    testTrans.text = @"lalala";
    
    XCTAssertEqualObjects([[testTrans objectState] stateValueForKey:@"text"], @"Gate Cinema");

}

- (void)testStateUpdatesOnChangeButPersistsValueOfFirstChange {
    
    NSDictionary *transactionDict = [NSJSONSerialization JSONObjectWithData:[self transactionResponse] options:0 error:nil];
    NSDictionary *transactionData = [transactionDict objectForKey:@"data"];
    MNFTransaction *testTrans = [MNFJsonAdapter objectOfClass:[MNFTransaction class] jsonDict:transactionData option:kMNFAdapterOptionNoOption error:nil];
    
    NSLog(@"test trans is: %@", testTrans);
    
    testTrans.text = @"lalala";
    testTrans.text = @"lalala2";
    
    XCTAssertEqualObjects([[testTrans objectState] stateValueForKey:@"text"], @"Gate Cinema");

}


- (void)testStateUpdatesClearOnRevert {
    
    NSDictionary *transactionData = [NSJSONSerialization JSONObjectWithData:[self transactionResponse] options:0 error:nil];
    MNFTransaction *testTrans = [MNFJsonAdapter objectOfClass:[MNFTransaction class] jsonDict:transactionData option:kMNFAdapterOptionFirstLetterUppercase error:nil];
    
    testTrans.text = @"lalala";
    [testTrans revert];
    
    XCTAssertTrue([[testTrans objectState] serverData].count == 0);

}


- (void)testObjectResetsOnRevert {
    
    NSDictionary *transactionDict = [NSJSONSerialization JSONObjectWithData:[self transactionResponse] options:0 error:nil];
    NSDictionary *transactionData = [transactionDict objectForKey:@"data"];
    MNFTransaction *testTrans = [MNFJsonAdapter objectOfClass:[MNFTransaction class] jsonDict:transactionData option:kMNFAdapterOptionNoOption error:nil];
    
    testTrans.text = @"lalala";
    [testTrans revert];
    
    XCTAssertEqualObjects(testTrans.text, @"Gate Cinema");
    
}

-(void)testDirtynessIsTrueWhenAlteringObject{
    
    NSDictionary *transactionData = [NSJSONSerialization JSONObjectWithData:[self transactionResponse] options:0 error:nil];
    MNFTransaction *testTrans = [MNFJsonAdapter objectOfClass:[MNFTransaction class] jsonDict:transactionData option:kMNFAdapterOptionFirstLetterUppercase error:nil];
    
    testTrans.text = @"lalala";
    
    XCTAssertTrue(testTrans.isDirty);
}

- (void)testDirtynessIsFalseWhenResettingObject {
    
    NSDictionary *transactionData = [NSJSONSerialization JSONObjectWithData:[self transactionResponse] options:0 error:nil];
    MNFTransaction *testTrans = [MNFJsonAdapter objectOfClass:[MNFTransaction class] jsonDict:transactionData option:kMNFAdapterOptionFirstLetterUppercase error:nil];
    
    testTrans.text = @"lalala";
    [testTrans revert];
    
    XCTAssertFalse(testTrans.isDirty);
    
}




#pragma mark - helpers

-(NSData*)transactionResponse{
    return [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"transactionResponse" ofType:@"json"]];
}

@end
