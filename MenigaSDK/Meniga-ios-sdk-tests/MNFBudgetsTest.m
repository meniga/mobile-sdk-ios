//
//  MNFBudgetsTest.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 27/11/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Meniga.h"
#import "MNFBudget.h"
#import "MNFNetwork.h"
#import "MNFNetworkProtocolForTesting.h"
#import "MNFJsonAdapter.h"

@interface MNFBudgetsTest : XCTestCase

@end

@implementation MNFBudgetsTest {
    MNFBudget *_sut;
}

- (void)setUp {
    [super setUp];
    [MNFNetwork initializeForTesting];
    
    NSDictionary *budgetResponse = [NSJSONSerialization JSONObjectWithData:[self budgetResponse] options:0 error:nil];
    NSDictionary *budgetData = [budgetResponse objectForKey:@"data"];
    
    _sut = [MNFJsonAdapter objectOfClass:[MNFBudget class] jsonDict:budgetData option:0 error:nil];
}

- (void)tearDown {
    [MNFNetwork flushForTesting];
    _sut = nil;
    [super tearDown];
}

- (void)testFetchBudgets {
    [MNFNetworkProtocolForTesting setResponseData:[self budgetsResponse]];
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [MNFBudget fetchBudgetsWithFilter:nil completion:^(NSArray<MNFBudget *> * _Nullable budgets, NSError * _Nullable error) {
        
        XCTAssertNil(error);
        XCTAssertNotNil(budgets);
        
        MNFBudget *budget = [budgets firstObject];
        XCTAssertNotNil(budget.identifier);
        XCTAssertNotNil(budget.name);
        XCTAssertNotNil(budget.targetAmount);
        XCTAssertNotNil(budget.spentAmount);
        XCTAssertNotNil(budget.validFrom);
        XCTAssertNotNil(budget.validTo);
        XCTAssertNotNil(budget.updatedAt);
        XCTAssertNil(budget.budgetDescription);
        XCTAssertNotNil(budget.categoryIds);
        XCTAssertNotNil(budget.accountIds);
        XCTAssertNil(budget.parentId);
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

- (void)testFetchBudgetsWithId {
    [MNFNetworkProtocolForTesting setResponseData:[self budgetResponse]];
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [MNFBudget fetchBudgetWithId:@(10) completion:^(MNFBudget * _Nullable budget, NSError * _Nullable error) {
        
        XCTAssertNil(error);
        XCTAssertNotNil(budget.identifier);
        XCTAssertNotNil(budget.name);
        XCTAssertNotNil(budget.targetAmount);
        XCTAssertNotNil(budget.spentAmount);
        XCTAssertNotNil(budget.validFrom);
        XCTAssertNotNil(budget.validTo);
        XCTAssertNotNil(budget.updatedAt);
        XCTAssertNil(budget.budgetDescription);
        XCTAssertNotNil(budget.categoryIds);
        XCTAssertNotNil(budget.accountIds);
        XCTAssertNil(budget.parentId);
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

- (void)testCreateBudget {
    [MNFNetworkProtocolForTesting setResponseData:[self budgetResponse]];
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [MNFBudget budgetWithName:@"name" targetAmount:@(1000) validFrom:[NSDate date] validTo:[NSDate date] description:@"description" allCategoriesOfType:@"Expenses" categoryIds:nil accountIds:nil completion:^(MNFBudget * _Nullable budget, NSError * _Nullable error) {
        
        XCTAssertNil(error);
        XCTAssertNotNil(budget.identifier);
        XCTAssertNotNil(budget.name);
        XCTAssertNotNil(budget.targetAmount);
        XCTAssertNotNil(budget.spentAmount);
        XCTAssertNotNil(budget.validFrom);
        XCTAssertNotNil(budget.validTo);
        XCTAssertNotNil(budget.updatedAt);
        XCTAssertNil(budget.budgetDescription);
        XCTAssertNotNil(budget.categoryIds);
        XCTAssertNotNil(budget.accountIds);
        XCTAssertNil(budget.parentId);
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

- (void)testRecalculateBudget {
    [MNFNetworkProtocolForTesting setResponseData:[self budgetsResponse]];
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [MNFBudget recalculateWithFilter:nil completion:^(NSArray<MNFBudget *> * _Nullable budgets, NSError * _Nullable error) {
        
        XCTAssertNil(error);
        XCTAssertNotNil(budgets);
        
        MNFBudget *budget = [budgets firstObject];
        XCTAssertNotNil(budget.identifier);
        XCTAssertNotNil(budget.name);
        XCTAssertNotNil(budget.targetAmount);
        XCTAssertNotNil(budget.spentAmount);
        XCTAssertNotNil(budget.validFrom);
        XCTAssertNotNil(budget.validTo);
        XCTAssertNotNil(budget.updatedAt);
        XCTAssertNil(budget.budgetDescription);
        XCTAssertNotNil(budget.categoryIds);
        XCTAssertNotNil(budget.accountIds);
        XCTAssertNil(budget.parentId);
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

- (void)testDeleteBudgetsWithList {
    [MNFNetworkProtocolForTesting setResponseData:[self emptyResponse]];
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [MNFBudget deleteBudgets:@[_sut] withCompletion:^(NSError * _Nullable error) {
        XCTAssertNil(error);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

- (void)testDeleteBudgetsWithParentId {
    [MNFNetworkProtocolForTesting setResponseData:[self emptyResponse]];
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [MNFBudget deleteWithParentId:@(10) completion:^(NSError * _Nullable error) {
        XCTAssertNil(error);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

- (void)createRecurringBudgets {
    [MNFNetworkProtocolForTesting setResponseData:[self budgetsResponse]];
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [MNFBudget recurringBudgetWithName:@"name" targetAmount:@(1000) validFrom:[NSDate date] validTo:[NSDate date] description:@"description" allCategoriesOfType:@"Expenses" categoryIds:nil accountIds:nil numberOfRecurrences:@(2) interval:@(1) intervalType:@"Month" completion:^(NSArray<MNFBudget *> * _Nullable budgets, NSError * _Nullable error) {
        XCTAssertNil(error);
        XCTAssertNotNil(budgets);
        
        MNFBudget *budget = [budgets firstObject];
        XCTAssertNotNil(budget.identifier);
        XCTAssertNotNil(budget.name);
        XCTAssertNotNil(budget.targetAmount);
        XCTAssertNotNil(budget.spentAmount);
        XCTAssertNotNil(budget.validFrom);
        XCTAssertNotNil(budget.validTo);
        XCTAssertNotNil(budget.updatedAt);
        XCTAssertNil(budget.budgetDescription);
        XCTAssertNotNil(budget.categoryIds);
        XCTAssertNotNil(budget.accountIds);
        XCTAssertNil(budget.parentId);
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

- (void)testSaveBudget {
    [MNFNetworkProtocolForTesting setResponseData:[self emptyResponse]];
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    _sut.name = @"changed name";
    [_sut saveWithCompletion:^(NSError * _Nullable error) {
        
        XCTAssertNil(error);
        XCTAssertEqual(_sut.name, @"changed name");
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

- (void)testDeleteBudget {
    [MNFNetworkProtocolForTesting setResponseData:[self emptyResponse]];
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [_sut deleteWithCompletion:^(NSError * _Nullable error) {
        
        XCTAssertNil(error);
        XCTAssertTrue(_sut.isDeleted);
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

- (void)testRefreshBudget {
    [MNFNetworkProtocolForTesting setResponseData:[self budgetResponse]];
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    _sut.name = @"changed name";
    [_sut refreshWithCompletion:^(NSError * _Nullable error) {
        
        XCTAssertNil(error);
        XCTAssertNotEqual(_sut.name, @"change name");
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

- (void)testGetBudgetTransactions {
    [MNFNetworkProtocolForTesting setResponseData:[self transactionsResponse]];
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [_sut fetchTransactionsWithCompletion:^(NSArray<MNFTransaction *> * _Nullable transactions, NSError * _Nullable error) {
        
        XCTAssertNil(error);
        XCTAssertNotNil(transactions);
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

-(NSData*)budgetsResponse {
    return [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"budgetsResponse" ofType:@"json"]];
}
-(NSData*)budgetResponse {
    return [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"budgetResponse" ofType:@"json"]];
}
-(NSData*)emptyResponse {
    return [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"emptyResponse" ofType:@"json"]];
}
-(NSData*)transactionsResponse {
    return [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"transactionsResponse" ofType:@"json"]];
}

@end
