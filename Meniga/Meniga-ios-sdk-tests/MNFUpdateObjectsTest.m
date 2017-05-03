//
//  MNFUpdateObjectsTest.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 10/12/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNFObjectUpdater.h"
#import "MNFTransaction.h"
#import "MNFJsonAdapter.h"
#import "Meniga.h"
#import "NSObject+MNFObjectCreation.h"

@interface MNFUpdateObjectsTest : XCTestCase

@end

@implementation MNFUpdateObjectsTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testUpdateTransaction {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NSDictionary *originaTransactionDict = @{ @"parentIdentifier" : @"NiceIdentifier", @"id" : @10, @"amount" : @10, @"tags" : @[], @"comments" : @[], @"categoryId" : @200, @"text" : @"string", @"originalDate" : @"2016-09-06T10:50:53.3717884", @"data" : @"NoData", @"originalText" : @"Phone", @"originalAmount" : @4, @"isRead" : @0, @"isFlagged" : @0, @"hasUncertainCategorization" : @0, @"accountId" : @10, @"mcc" : @50, @"detectedCategories" : @[], @"currency" : @"EUNE", @"amountInCurrency" : [NSNull null], @"dataFormat" : @7, @"merchantId" : @2, @"parsedData" : @[], @"accuracy" : @1, @"bankId" : @"10", @"insertTime" : @"2016-10-11T12:58:28.693", @"hasUserClearedCategoryUncertainty" : @0, @"isMerchant" : @0, @"isOwnAccountTransfer" : @0, @"isUncleared" : @0, @"isSplitChild" : @0, @"balance" : [NSNull null], @"categoryChangedTime" : @"2016-10-11T12:58:28.5606128", @"changedByRuleTime" : @"2016-10-11T12:58:28.5606128", @"couterpartyAccountIDentifier" : [NSNull null], @"dueDate" : @"2016-10-11T12:58:28.5606128", @"lastModifiedTime" : @"2016-10-11T12:58:28.5606128", @"timestamp" : @"2016-10-11T12:58:28.5606128", @"metadata" : @[], @"userData" : [NSNull null], @"date" : @"2016-10-01T00:00:00" };
    NSDictionary *updateTransactionDict = @{ @"parentIdentifier" : @"NewIdentifier", @"id" : @15, @"amount" : @20, @"tags" : @[], @"comments" : @[], @"categoryId" : @100, @"text" : @"newString", @"originalDate" : [NSNull null], @"data" : @"NewData", @"originalText" : @"Blazam", @"originalAmount" : @100, @"isRead" : @1, @"isFlagged" : @1, @"hasUncertainCategorization" : @1, @"accountId" : @20, @"mcc" : @100, @"detectedCategories" : @[], @"currency" : @"EUWest", @"amountInCurrency" : @25, @"dataFormat" : @10, @"merchantId" : @5, @"parsedData" : @[], @"accuracy" : @10, @"bankId" : @"100", @"insertTime" : [NSNull null], @"hasUserClearedCategoryUncertainty" : @1, @"isMerchant" : @1, @"isOwnAccountTransfer" : @1, @"isUncleared" : @1, @"isSplitChild" : @1, @"balance" : @34, @"categoryChangedTime" : [NSNull null], @"changedByRuleTime" : [NSNull null], @"counterpartyAccountIdentifier" : @10, @"dueDate" : [NSNull null], @"lastModifiedTime" : [NSNull null], @"timestamp" : [NSNull null], @"metadata" : @[], @"userData" : @"moreUserData", @"date" : [NSNull null] };
    
    MNFTransaction *transaction = [MNFTransaction initWithServerResult: originaTransactionDict];
    MNFTransaction *updateTransaction = [MNFTransaction initWithServerResult: updateTransactionDict];
    
    XCTAssertEqualObjects( transaction.parentIdentifier, @"NiceIdentifier");
    XCTAssertEqualObjects( transaction.identifier,  @10);
    XCTAssertEqualObjects( transaction.amount, @10);
    XCTAssertEqualObjects( transaction.tags,  @[]);
    XCTAssertEqualObjects( transaction.comments,  @[]);
    XCTAssertEqualObjects( transaction.categoryId,  @200);
    XCTAssertEqualObjects( transaction.text,  @"string");
    XCTAssertNotNil( transaction.originalDate);
    XCTAssertEqualObjects( transaction.data, @"NoData");
    XCTAssertEqualObjects( transaction.originalText, @"Phone");
    XCTAssertEqualObjects( transaction.originalAmount, @4);
    XCTAssertEqualObjects( transaction.isRead, @0);
    XCTAssertEqualObjects( transaction.isFlagged, @0);
    XCTAssertEqualObjects( transaction.hasUncertainCategorization, @0);
    XCTAssertEqualObjects( transaction.accountId, @10);
    XCTAssertEqualObjects( transaction.mcc, @50);
    XCTAssertEqualObjects( transaction.detectedCategories, @[]);
    XCTAssertEqualObjects( transaction.currency, @"EUNE");
    XCTAssertEqualObjects( transaction.amountInCurrency, nil);
    XCTAssertEqualObjects( transaction.dataFormat, @7);
    XCTAssertEqualObjects( transaction.merchantId, @2);
    XCTAssertEqualObjects( transaction.parsedData, @[]);
    XCTAssertEqualObjects( transaction.bankId, @"10");
    XCTAssertNotNil( transaction.insertTime);
    XCTAssertEqualObjects( transaction.hasUserClearedCategoryUncertainty, @0);
    XCTAssertEqualObjects( transaction.isMerchant, @0);
    XCTAssertEqualObjects( transaction.isOwnAccountTransfer, @0);
    XCTAssertEqualObjects( transaction.isUncleared, @0);
    XCTAssertEqualObjects( transaction.isSplitChild, @0);
    XCTAssertEqualObjects( transaction.balance, nil);
    XCTAssertNotNil( transaction.categoryChangedTime);
    XCTAssertNotNil( transaction.changedByRuleTime);
    XCTAssertNil( transaction.counterpartyAccountIdentifier);
    XCTAssertNotNil( transaction.dueDate);
    XCTAssertNotNil( transaction.date);
    XCTAssertNotNil( transaction.lastModifiedTime);
    XCTAssertNotNil( transaction.timestamp);
    XCTAssertNil( transaction.userData);
    
    
    XCTAssertEqualObjects( updateTransaction.parentIdentifier, @"NewIdentifier");
    XCTAssertEqualObjects( updateTransaction.identifier, @15);
    XCTAssertEqualObjects( updateTransaction.amount, @20);
    XCTAssertEqualObjects( updateTransaction.tags, @[]);
    XCTAssertEqualObjects( updateTransaction.comments, @[]);
    XCTAssertEqualObjects( updateTransaction.categoryId, @100);
    XCTAssertEqualObjects( updateTransaction.text, @"newString");
    XCTAssertEqualObjects( updateTransaction.originalDate, nil);
    XCTAssertEqualObjects( updateTransaction.data, @"NewData");
    XCTAssertEqualObjects( updateTransaction.originalText, @"Blazam");
    XCTAssertEqualObjects( updateTransaction.originalAmount, @100);
    XCTAssertEqualObjects( updateTransaction.isRead, @1);
    XCTAssertEqualObjects( updateTransaction.isFlagged, @1);
    XCTAssertEqualObjects( updateTransaction.hasUncertainCategorization, @1);
    XCTAssertEqualObjects( updateTransaction.accountId, @20);
    XCTAssertEqualObjects( updateTransaction.mcc, @100);
    XCTAssertEqualObjects( updateTransaction.detectedCategories, @[]);
    XCTAssertEqualObjects( updateTransaction.currency, @"EUWest");
    XCTAssertEqualObjects( updateTransaction.amountInCurrency, @25);
    XCTAssertEqualObjects( updateTransaction.dataFormat, @10);
    XCTAssertEqualObjects( updateTransaction.merchantId, @5);
    XCTAssertEqualObjects( updateTransaction.parsedData, @[]);
    XCTAssertEqualObjects( updateTransaction.bankId, @"100");
    XCTAssertEqualObjects( updateTransaction.insertTime, nil);
    XCTAssertEqualObjects( updateTransaction.hasUserClearedCategoryUncertainty, @1);
    XCTAssertEqualObjects( updateTransaction.isMerchant, @1);
    XCTAssertEqualObjects( updateTransaction.isOwnAccountTransfer, @1);
    XCTAssertEqualObjects( updateTransaction.isUncleared, @1);
    XCTAssertEqualObjects( updateTransaction.isSplitChild, @1);
    XCTAssertEqualObjects( updateTransaction.balance, @34);
    XCTAssertEqualObjects( updateTransaction.categoryChangedTime, nil);
    XCTAssertEqualObjects( updateTransaction.changedByRuleTime, nil);
    XCTAssertEqualObjects( updateTransaction.counterpartyAccountIdentifier, @10);
    XCTAssertEqualObjects( updateTransaction.dueDate, nil);
    XCTAssertEqualObjects( updateTransaction.lastModifiedTime, nil);
    XCTAssertEqualObjects( updateTransaction.timestamp, nil);
    XCTAssertEqualObjects( updateTransaction.userData, @"moreUserData");
    XCTAssertEqualObjects( updateTransaction.date, nil);
    
    
    [MNFObjectUpdater updateMNFObject: transaction withMNFObject: updateTransaction];
    
    XCTAssertEqualObjects( transaction.parentIdentifier, @"NewIdentifier");
    XCTAssertEqualObjects( transaction.identifier, @15);
    XCTAssertEqualObjects( transaction.amount, @20);
    XCTAssertEqualObjects( transaction.tags, @[]);
    XCTAssertEqualObjects( transaction.comments, nil);
    XCTAssertEqualObjects( transaction.categoryId, @100);
    XCTAssertEqualObjects( transaction.text, @"newString");
    XCTAssertEqualObjects( transaction.originalDate, nil);
    XCTAssertEqualObjects( transaction.data, @"NewData");
    XCTAssertEqualObjects( transaction.originalText, @"Blazam");
    XCTAssertEqualObjects( transaction.originalAmount, @100);
    XCTAssertEqualObjects( transaction.isRead, @1);
    XCTAssertEqualObjects( transaction.isFlagged, @1);
    XCTAssertEqualObjects( transaction.hasUncertainCategorization, @1);
    XCTAssertEqualObjects( transaction.accountId, @20);
    XCTAssertEqualObjects( transaction.mcc, @100);
    XCTAssertEqualObjects( transaction.detectedCategories, @[]);
    XCTAssertEqualObjects( transaction.currency, @"EUWest");
    XCTAssertEqualObjects( transaction.amountInCurrency, @25);
    XCTAssertEqualObjects( transaction.dataFormat, @10);
    XCTAssertEqualObjects( transaction.merchantId, @5);
    XCTAssertEqualObjects( transaction.parsedData, @[]);
    XCTAssertEqualObjects( transaction.bankId, @"100");
    XCTAssertEqualObjects( transaction.insertTime, nil);
    XCTAssertEqualObjects( transaction.hasUserClearedCategoryUncertainty, @1);
    XCTAssertEqualObjects( transaction.isMerchant, @1);
    XCTAssertEqualObjects( transaction.isOwnAccountTransfer, @1);
    XCTAssertEqualObjects( transaction.isUncleared, @1);
    XCTAssertEqualObjects( transaction.isSplitChild, @1);
    XCTAssertEqualObjects( transaction.balance, @34);
    XCTAssertEqualObjects( transaction.categoryChangedTime, nil);
    XCTAssertEqualObjects( transaction.changedByRuleTime, nil);
    XCTAssertEqualObjects( transaction.counterpartyAccountIdentifier, @10);
    XCTAssertEqualObjects( transaction.dueDate, nil);
    XCTAssertEqualObjects( transaction.lastModifiedTime, nil);
    XCTAssertEqualObjects( transaction.timestamp, nil);
    XCTAssertEqualObjects( transaction.userData, @"moreUserData");
    XCTAssertEqualObjects( transaction.date, nil);
    
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
