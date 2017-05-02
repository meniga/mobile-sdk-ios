//
//  MNFTransactionGroupTest.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 16/12/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNFTransactionGroup.h"
#import "MNFNetworkProtocolForTesting.h"
#import "MNFNetwork.h"
#import "MNFJsonAdapter.h"
#import "MNFTransaction.h"

@interface MNFTransactionGroupTest : XCTestCase

@end

@implementation MNFTransactionGroupTest

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


-(void)testGroupByCategory {
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"transactionsResponse" ofType:@"json"]];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSArray *jsonArray = [json objectForKey:@"data"];
    NSArray *transactions = [MNFJsonAdapter objectsOfClass:[MNFTransaction class] jsonArray:jsonArray option:kMNFAdapterOptionNoOption error:nil];
    MNFTransactionGroup *group = [MNFTransactionGroup groupBy:MNFGroupedByCategory WithTransactions:transactions];
    XCTAssertNotNil(group);
    XCTAssertTrue(group.groupedBy == MNFGroupedByCategory);
    XCTAssertNotNil(group.groupId);
    XCTAssertNotNil(group.sum);
}
-(void)testGroupByDate {
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"transactionsResponse" ofType:@"json"]];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSArray *jsonArray = [json objectForKey:@"data"];
    NSArray *transactions = [MNFJsonAdapter objectsOfClass:[MNFTransaction class] jsonArray:jsonArray option:kMNFAdapterOptionNoOption error:nil];
    MNFTransactionGroup *group = [MNFTransactionGroup groupBy:MNFGroupedByDate WithTransactions:transactions];
    XCTAssertNotNil(group);
    XCTAssertTrue(group.groupedBy == MNFGroupedByDate);
    XCTAssertNotNil(group.groupId);
    XCTAssertNotNil(group.sum);
}


@end
