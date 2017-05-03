//
//  MNFTransactionRuleTest.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 13/04/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNFTransactionRule.h"
#import "MNFNetworkProtocolForTesting.h"
#import "MNFNetwork.h"
#import "MNFJsonAdapter.h"

@interface MNFTransactionRuleTest : XCTestCase

@end

@implementation MNFTransactionRuleTest {
    MNFTransactionRule *_sut;
}

- (void)setUp {
    [super setUp];
    [MNFNetwork initializeForTesting];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[self transactionRuleResponse] options:0 error:nil];
    NSDictionary *unwrap = [dict objectForKey:@"data"];
    _sut = [MNFJsonAdapter objectOfClass:[MNFTransactionRule class] jsonDict:unwrap option:kMNFAdapterOptionNoOption error:nil];
}

- (void)tearDown {
    _sut = nil;
    [MNFNetwork flushForTesting];
    [super tearDown];
}

-(void)testFetchWithIdPopulatesObject {
    [MNFNetworkProtocolForTesting setResponseData:[self transactionRuleResponse]];
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFJob *job = [MNFTransactionRule fetchRuleWithId:@10 completion:^(MNFTransactionRule * _Nullable rule, NSError * _Nullable error) {
        XCTAssertNil(error);
        XCTAssertNotNil(rule.identifier);
        XCTAssertNotNil(rule.userId);
        XCTAssertNotNil(rule.name);
        XCTAssertNotNil(rule.createdDate);
        XCTAssertNil(rule.modifiedDate);
        XCTAssertNotNil(rule.textCriteria);
        XCTAssertNotNil(rule.textCriteriaOperatorType);
        XCTAssertNil(rule.dateMatchTypeCriteria);
        XCTAssertNil(rule.daysLimitCriteria);
        XCTAssertNil(rule.amountLimitTypeCriteria);
        XCTAssertNil(rule.amountLimitSignCriteria);
        XCTAssertNil(rule.amountCriteria);
        XCTAssertNil(rule.accountCategoryCriteria);
        XCTAssertNil(rule.acceptAction);
        XCTAssertNil(rule.monthShiftAction);
        XCTAssertNil(rule.removeAction);
        XCTAssertNil(rule.textAction);
        XCTAssertNil(rule.commentAction);
        XCTAssertNil(rule.tagAction);
        XCTAssertNotNil(rule.categoryIdAction);
        XCTAssertNotNil(rule.splitActions);
        XCTAssertNotNil(rule.flagAction);
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

-(void)testFetchRules {
    [MNFNetworkProtocolForTesting setResponseData:[self transactionsRuleResponse]];
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFJob *job = [MNFTransactionRule fetchRulesWithCompletion:^(NSArray * _Nullable result, NSError * _Nullable error) {
        XCTAssertNil(error);
        XCTAssertNotNil(result);
        XCTAssertTrue(result.count == 1);
        MNFTransactionRule *rule = [result firstObject];
        XCTAssertNotNil(rule.identifier);
        XCTAssertNotNil(rule.userId);
        XCTAssertNotNil(rule.name);
        XCTAssertNotNil(rule.createdDate);
        XCTAssertNil(rule.modifiedDate);
        XCTAssertNotNil(rule.textCriteria);
        XCTAssertNotNil(rule.textCriteriaOperatorType);
        XCTAssertNil(rule.dateMatchTypeCriteria);
        XCTAssertNil(rule.daysLimitCriteria);
        XCTAssertNil(rule.amountLimitTypeCriteria);
        XCTAssertNil(rule.amountLimitSignCriteria);
        XCTAssertNil(rule.amountCriteria);
        XCTAssertNil(rule.accountCategoryCriteria);
        XCTAssertNil(rule.acceptAction);
        XCTAssertNil(rule.monthShiftAction);
        XCTAssertNil(rule.removeAction);
        XCTAssertNil(rule.textAction);
        XCTAssertNil(rule.commentAction);
        XCTAssertNil(rule.tagAction);
        XCTAssertNotNil(rule.categoryIdAction);
        XCTAssertNotNil(rule.splitActions);
        XCTAssertNotNil(rule.flagAction);
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
    
    MNFJob *job = [_sut deleteRuleWithCompletion:^(NSError * _Nullable error) {
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

-(void)testSaveUpdatesObject {
    [MNFNetworkProtocolForTesting setResponseData:[self transactionRuleResponse]];
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    _sut.name = @"change";
    MNFJob *job = [_sut saveAndApplyOnExisting:@YES completion:^(NSError * _Nullable error) {
        XCTAssertNil(error);
        XCTAssertEqualObjects(_sut.name, @"change");
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

-(void)testRefreshUpdatesObject {
    [MNFNetworkProtocolForTesting setResponseData:[self transactionRuleResponse]];
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    _sut.name = @"change";
    MNFJob *job = [_sut refreshWithCompletion:^(NSError * _Nullable error) {
        XCTAssertNil(error);
        XCTAssertEqualObjects(_sut.name, @"Test Rule 1460104956427");
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

-(NSData*)transactionRuleResponse {
    return [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"transactionRuleResponse" ofType:@"json"]];
}
-(NSData*)transactionsRuleResponse {
    return [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"transactionsRuleResponse" ofType:@"json"]];
}
-(NSData*)emptyResponse {
    return [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"emptyResponse" ofType:@"json"]];
}

@end
