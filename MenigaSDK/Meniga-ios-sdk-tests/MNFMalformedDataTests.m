//
//  MNFMalformedDataTests.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 4/18/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "MNFNetworkProtocolForTesting.h"
#import "MNFObjectTypes.h"
#import "MNFNetwork.h"
#import "MNFAccount.h"
#import "MNFCategory.h"
#import "MNFTransaction.h"
#import "MNFObject_Private.h"
#import "MNFMerchant.h"
#import "MNFNetworthAccount.h"
#import "MNFSynchronization.h"
#import "MNFTag.h"
#import "MNFUser.h"
#import "MNFRealmUser.h"
#import "MNFUserProfile.h"
#import "MNFTransactionPage.h"
#import "MNFTransactionFilter.h"
#import "MNFTransactionRule.h"
#import "MNFTransactionSeries.h"
#import "MNFTransactionSeriesFilter.h"

@interface MNFMalformedDataTests : XCTestCase

@end

@implementation MNFMalformedDataTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    [MNFNetwork initializeForTesting];
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [MNFNetwork flushForTesting];
    
    [super tearDown];
}

#pragma mark - MNFResponseData handled errors

//- (void)testFetchTransactionWithoutDataParameterInJsonFormat {
//    
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithoutDataParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    [MNFTransaction fetchWithId:@1 completion:^(MNFTransaction *transaction, NSError *error) {
//        
//        XCTAssertNil(transaction);
//        XCTAssertNotNil(error);
//        
//        [expectation fulfill];
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//    
//}
//
//-(void)testFetchTransactionWithNullDataParameterInJsonFormat {
//    
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithNilDataParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    [MNFTransaction fetchWithId:@1 completion:^(MNFTransaction *transaction, NSError *error) {
//        
//        XCTAssertNil(transaction);
//        XCTAssertNotNil(error);
//        
//        [expectation fulfill];
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//    
//}

#pragma mark - Empty response tests

#pragma mark - Transactions

//-(void)testFetchtransactionWithCompletionEmptyDataParamterInJsonFormat {
//    
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithEmptyDataDictionaryParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    [MNFTransaction fetchWithId:@1 completion:^(MNFTransaction *transaction, NSError *error) {
//        
//        XCTAssertNil(transaction);
//        XCTAssertNil(error);
//        
//        [expectation fulfill];
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//    
//}
//
//-(void)testFetchtransactionWithJobEmptyDataParamterInJsonFormat {
//    
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithEmptyDataDictionaryParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    [[MNFTransaction fetchWithId:@1].task continueWithBlock:^id(MNF_BFTask *task) {
//        
//        MNFTransaction *transaction = task.result;
//        
//        XCTAssertNil(transaction);
//        XCTAssertNil(task.error);
//        
//        [expectation fulfill];
//        
//        return nil;
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//    
//}
//
//-(void)testCreateTransactionWithCompletionEmptyDataParameterInJsonFormat {
//    
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithEmptyDataDictionaryParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    [MNFTransaction createTransactionWithDate:[NSDate date] text:@"some text" amount:@3000 categoryId:@2 setAsRead:@1 completion:^(MNFTransaction *transaction, NSError *error) {
//        
//        XCTAssertNil(transaction);
//        XCTAssertNil(error);
//        
//        [expectation fulfill];
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//    
//}
//
//-(void)testCreateTransactionWithJobEmptyDataParameterInJsonFormat {
//    
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithEmptyDataDictionaryParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    [[MNFTransaction createTransactionWithDate:[NSDate date] text:@"some text" amount:@3000 categoryId:@2 setAsRead:@1].task continueWithBlock:^id(MNF_BFTask *task)  {
//        
//        MNFTransaction *transaction = task.result;
//        
//        XCTAssertNil(transaction);
//        XCTAssertNil(task.error);
//        
//        [expectation fulfill];
//        
//        return nil;
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//    
//}
//
//
//-(void)testFetchTransactionsWithTransactionFilterWithCompletionEmptyDataParameterInJsonFormat {
//    
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithEmptyDataDictionaryParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    [MNFTransactionPage fetchWithTransactionFilter: [[MNFTransactionFilter alloc] init] page:nil transactionsPerPage:@1000 completion:^( MNFTransactionPage * _Nullable page, NSError * _Nullable error) {
//        
//        XCTAssertNil(page);
//        XCTAssertNotNil(error);
//        
//        [expectation fulfill];
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//    
//}
//
//-(void)testFetchTransactionsWithTransactionFilterWithJobEmptyDataParameterInJsonFormat {
//    
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithEmptyDataDictionaryParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    [[MNFTransactionPage fetchWithTransactionFilter: [[MNFTransactionFilter alloc] init] page:nil transactionsPerPage:@1000].task continueWithBlock:^id(MNF_BFTask *task) {
//        
//        XCTAssertNil(task.result);
//        XCTAssertNotNil(task.error);
//        
//        [expectation fulfill];
//        
//        return nil;
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//    
//}
//
//-(void)testFetchTransactionSplitChildrenWithCompletionEmptyDataParameterInJsonFormat {
//    
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithEmptyDataDictionaryParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    MNFTransaction *trans = [[MNFTransaction alloc] initNeutral];
//    
//    [trans fetchSplitWithCompletion:^(NSArray *transactions, NSError *error) {
//       
//        XCTAssertNil(transactions);
//        XCTAssertNotNil(error);
//        
//        [expectation fulfill];
//        
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//}
//
//-(void)testFetchTransactionSplitChildrenWithJobEmptyDataParameterInJsonFormat {
//
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithEmptyDataDictionaryParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    MNFTransaction *trans = [[MNFTransaction alloc] initNeutral];
//    
//    [[trans fetchSplit].task continueWithBlock:^id(MNF_BFTask *task) {
//        
//        XCTAssertNil(task.result);
//        XCTAssertNotNil(task.error);
//        
//        [expectation fulfill];
//        
//        return nil;
//        
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//
//}
//
//#pragma mark - Transaction Page
//
//-(void)testFetchWithTransactionFilterWithCompletionEmptyDictionaryInJsonFormat {
//    
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithEmptyDataDictionaryParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    [MNFTransactionPage fetchWithTransactionFilter:[[MNFTransactionFilter alloc] init] page:@1 transactionsPerPage:@100 completion:^(MNFTransactionPage *page, NSError *error) {
//        
//        XCTAssertNil(page);
//        XCTAssertNotNil(error);
//        
//        [expectation fulfill];
//        
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//    
//}
//
//-(void)testFetchWithTransactionFilterWithJobEmptyDictionaryInJsonFormat {
//    
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithEmptyDataDictionaryParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    [[MNFTransactionPage fetchWithTransactionFilter:[[MNFTransactionFilter alloc] init] page:@1 transactionsPerPage:@100].task continueWithBlock:^id(MNF_BFTask *task) {
//        
//        XCTAssertNil(task.result);
//        XCTAssertNotNil(task.error);
//        
//        [expectation fulfill];
//        
//        return nil;
//        
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//    
//}
//
//
//#pragma mark - Transaction Rule
//
//-(void)testFetchRuleWithIdWithCompletionEmptyDiciotnaryInJsonFormat {
//    
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithEmptyDataDictionaryParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    [MNFTransactionRule fetchRuleWithId:@1 completion:^(MNFTransactionRule * _Nullable rule, NSError * _Nullable error) {
//        
//        XCTAssertNil(rule);
//        XCTAssertNil(error);
//        
//        [expectation fulfill];
//        
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//    
//}
//
//-(void)testFetchRuleWithIdWithJobEmptyDiciotnaryInJsonFormat {
//    
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithEmptyDataDictionaryParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    [[MNFTransactionRule fetchRuleWithId:@1].task continueWithBlock:^id(MNF_BFTask *task) {
//        
//        XCTAssertNil(task.result);
//        XCTAssertNil(task.error);
//        
//        [expectation fulfill];
//        
//        return nil;
//        
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//    
//}
//
//-(void)testFetchRulesWithCompletionEmptyDictionaryInJsonFormat {
//    
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithEmptyDataDictionaryParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    [MNFTransactionRule fetchRulesWithCompletion:^(NSArray *transactionRules, NSError *error) {
//        
//        XCTAssertNil(transactionRules);
//        XCTAssertNotNil(error);
//        
//        [expectation fulfill];
//        
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//    
//}
//
//-(void)testFetchRulesWithJobEmptyDictionaryInJsonFormat {
//    
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithEmptyDataDictionaryParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    [[MNFTransactionRule fetchRules].task continueWithBlock:^id(MNF_BFTask *task) {
//        
//        XCTAssertNil(task.result);
//        XCTAssertNotNil(task.error);
//        
//        [expectation fulfill];
//        
//        return nil;
//        
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//    
//}
//
//#pragma mark - Transaction Series
//
//-(void)testTransactionSeriesWithFilterWithCompletionEmptyDictionaryInJsonFormat {
//    
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithEmptyDataDictionaryParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    [MNFTransactionSeries fetchTransactionSeriesWithTransactionSeriesFilter:[[MNFTransactionSeriesFilter alloc] init] withCompletion:^(NSArray *series, NSError *error) {
//        
//        XCTAssertNil(series);
//        XCTAssertNotNil(error);
//        
//        [expectation fulfill];
//        
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//    
//}
//
//-(void)testTransactionSeriesWithFilterWithJobEmptyDictionaryInJsonFormat {
//
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithEmptyDataDictionaryParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    [[MNFTransactionSeries fetchTransactionSeriesWithTransactionSeriesFilter:[[MNFTransactionSeriesFilter alloc] init]].task continueWithBlock:^id(MNF_BFTask *task) {
//        
//        XCTAssertNil(task.result);
//        XCTAssertNotNil(task.error);
//        
//        [expectation fulfill];
//        
//        return nil;
//        
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//    
//}
//
//
//#pragma mark - Accounts
//
//-(void)testFetchAccountWithIdWithCompletionEmptyDataParameterInJsonFormat {
//    
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithEmptyDataDictionaryParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    [MNFAccount fetchWithId:@1 completion:^(MNFAccount *account, NSError *error) {
//        
//        XCTAssertNil(account);
//        XCTAssertNil(error);
//        
//        [expectation fulfill];
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//
//}
//
//-(void)testFetchAccountWithIdWithJobEmptyDataParameterInJsonFormat {
//    
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithEmptyDataDictionaryParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    [[MNFAccount fetchWithId:@1].task continueWithBlock:^id(MNF_BFTask *task) {
//        
//        XCTAssertNil(task.result);
//        XCTAssertNil(task.error);
//        
//        [expectation fulfill];
//        
//        return nil;
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//    
//}
//
//-(void)testFetchAccountsWithCompletionEmptyDataParameterInJsonFormat {
//    
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithEmptyDataDictionaryParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    [MNFAccount fetchAccountsWithCompletion:^(NSArray *accounts, NSError *error) {
//        
//        XCTAssertNil(accounts);
//        XCTAssertNotNil(error);
//        
//        [expectation fulfill];
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//    
//}
//
//-(void)testFetchAccountsWithJobEmptyDataParameterInJsonFormat {
//    
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithEmptyDataDictionaryParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    [[MNFAccount fetchAccounts].task continueWithBlock:^id(MNF_BFTask *task) {
//        
//        XCTAssertNil(task.result);
//        XCTAssertNotNil(task.error);
//        
//        [expectation fulfill];
//        
//        return nil;
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//    
//}
//
//-(void)testFetchAccountTypesWithCompletionEmptyDataPArameterInJsonFormat {
//    
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithEmptyDataDictionaryParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    [MNFAccount fetchAccountTypesWithCompletion:^(NSArray *accountTypes, NSError *error) {
//        
//        XCTAssertNil(accountTypes);
//        XCTAssertNotNil(error);
//        
//        [expectation fulfill];
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//}
//
//-(void)testFetchAccountTypesWithJobEmptyDataParameterInJsonFormat {
//    
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithEmptyDataDictionaryParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    [[MNFAccount fetchAccountTypes].task continueWithBlock:^id(MNF_BFTask *task) {
//        
//        XCTAssertNil(task.result);
//        XCTAssertNotNil(task.error);
//        
//        [expectation fulfill];
//        
//        return nil;
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//    
//}
//
//-(void)testFetchAccountAuthorizationTypesWithCompletionEmptyDataParameterInJsonFormat {
//    
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithEmptyDataDictionaryParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    [MNFAccount fetchAccountAuthorizationTypesWithCompletion:^(NSArray *accountAuthTypes, NSError *error) {
//        
//        XCTAssertNil(accountAuthTypes);
//        XCTAssertNotNil(error);
//        
//        [expectation fulfill];
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//    
//}
//
//-(void)testFetchAccountAuthorizationTypesWithJobEmptyDataParameterInJsonFormat {
//    
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithEmptyDataDictionaryParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    [[MNFAccount fetchAccountTypes].task continueWithBlock:^id(MNF_BFTask *task) {
//        
//        XCTAssertNil(task.result);
//        XCTAssertNotNil(task.error);
//        
//        [expectation fulfill];
//        
//        return nil;
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//    
//}
//
//-(void)testFetchRealmAccountTypesWithCompletionEmptyDataParameterInJsonFormat {
//    
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithEmptyDataDictionaryParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    [MNFAccount fetchAccountTypesWithCompletion:^(NSArray *realmAccounts, NSError *error) {
//        
//        XCTAssertNil(realmAccounts);
//        XCTAssertNotNil(error);
//        
//        [expectation fulfill];
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//    
//}
//
//-(void)testFetchRealmAccountTypesWithJobEmptyDataParameterInJsonFormat {
//    
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithEmptyDataDictionaryParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    [[MNFAccount fetchAccountTypes].task continueWithBlock:^id(MNF_BFTask *task) {
//        
//        XCTAssertNil(task.result);
//        XCTAssertNotNil(task.error);
//        
//        [expectation fulfill];
//        
//        return nil;
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//
//}
//
//-(void)testFetchAccountHistoryWithCompletionEmptyDataParameterInJsonFormat {
//    
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithEmptyDataDictionaryParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    MNFAccount *account = [[MNFAccount alloc] initNeutral];
//    
//    [account fetchHistoryFromDate:[NSDate date] toDate:[NSDate date] sortBy:@"something" ascending:YES completion:^(NSArray *accountHistory, NSError *error) {
//        
//        XCTAssertNil(accountHistory);
//        XCTAssertNotNil(error);
//        
//        [expectation fulfill];
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//    
//}
//
//-(void)testFetchAccountHistoryWithJobEmptyDataParameterInJsonFormat {
//
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithEmptyDataDictionaryParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    MNFAccount *account = [[MNFAccount alloc] initNeutral];
//    
//    [[account fetchHistoryFromDate:[NSDate date] toDate:[NSDate date] sortBy:@"something" ascending:YES].task continueWithBlock:^id(MNF_BFTask *task) {
//        
//        XCTAssertNil(task.result);
//        XCTAssertNotNil(task.error);
//        
//        [expectation fulfill];
//        
//        return nil;
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//    
//}
//
//#pragma mark - Categories
//
//-(void)testFetchCategoryWithIdWithCompletionEmptyDictionaryInJsonFormat {
//    
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithEmptyDataDictionaryParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    [MNFCategory fetchWithId:@1 culture:@"some culture" completion:^(MNFCategory *category, NSError *error) {
//        
//        XCTAssertNil(category);
//        XCTAssertNil(error);
//        
//        [expectation fulfill];
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//    
//}
//
//-(void)testFetchCategoryWithIdWithJobEmptyDictionaryInJsonFormat {
//    
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithEmptyDataDictionaryParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    [[MNFCategory fetchWithId:@1 culture:@"some culture"].task continueWithBlock:^id(MNF_BFTask *task) {
//        
//        XCTAssertNil(task.result);
//        XCTAssertNil(task.error);
//        
//        [expectation fulfill];
//        
//        return nil;
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//    
//}
//
//-(void)testFetchUserCreatedCategoriesWithCompletionEmptyDictionaryInJsonFormat {
//    
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithEmptyDataDictionaryParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    [MNFCategory fetchUserCreatedCategoriesWithCulture:nil completion:^(NSArray *categories, NSError *error) {
//        
//        XCTAssertNil(categories);
//        XCTAssertNotNil(error);
//        
//        [expectation fulfill];
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//    
//}
//
//-(void)testFetchUserCreatedCategoriesWithJobEmptyDictionaryInJsonFormat {
//    
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithEmptyDataDictionaryParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    [[MNFCategory fetchUserCreatedCategoriesWithCulture:nil].task continueWithBlock:^id(MNF_BFTask *task) {
//        
//        XCTAssertNil(task.result);
//        XCTAssertNotNil(task.error);
//        
//        [expectation fulfill];
//        
//        return nil;
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//    
//}
//
//-(void)testFetchSystemCategoriesWithCompletionEmptyDictionaryInJsonFormat {
//    
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithEmptyDataDictionaryParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    [MNFCategory fetchSystemCategoriesWithCulture:nil completion:^(NSArray *categories, NSError *error) {
//        
//        XCTAssertNil(categories);
//        XCTAssertNotNil(error);
//        
//        [expectation fulfill];
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//    
//}
//
//-(void)testFetchSystemCategoriesWithJobEmptyDictionaryInJsonFormat {
//    
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithEmptyDataDictionaryParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    [[MNFCategory fetchSystemCategoriesWithCulture:nil].task continueWithBlock:^id(MNF_BFTask *task) {
//        
//        XCTAssertNil(task.result);
//        XCTAssertNotNil(task.error);
//        
//        [expectation fulfill];
//        
//        return nil;
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//    
//}
//
//-(void)testFetchCatgoriesWithCompletionEmptyDictionaryInJsonFormat {
//    
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithEmptyDataDictionaryParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    [MNFCategory fetchCategoriesWithCulture:nil completion:^(NSArray *categories, NSError *error) {
//        
//        XCTAssertNil(categories);
//        XCTAssertNotNil(error);
//        
//        [expectation fulfill];
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//    
//}
//
//-(void)testFetchCatgoriesWithJobEmptyDictionaryInJsonFormat {
//
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithEmptyDataDictionaryParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    [[MNFCategory fetchCategoriesWithCulture:nil].task continueWithBlock:^id(MNF_BFTask *task) {
//        
//        XCTAssertNil(task.result);
//        XCTAssertNotNil(task.error);
//        
//        [expectation fulfill];
//        
//        return nil;
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//    
//}
//
//-(void)testFetchCategoryTreeWithCompletionEmptyDicionaryInJsonFormat {
//    
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithEmptyDataDictionaryParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    [MNFCategory fetchCategoryTreeWithCulture:nil completion:^(NSArray *categories, NSError *error) {
//        
//        XCTAssertNil(categories);
//        XCTAssertNotNil(error);
//        
//        [expectation fulfill];
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//    
//}
//
//-(void)testFetchCategoryTreeWithJobEmptyDicionaryInJsonFormat {
//
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithEmptyDataDictionaryParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    [[MNFCategory fetchCategoryTreeWithCulture:nil].task continueWithBlock:^id(MNF_BFTask *task) {
//        
//        XCTAssertNil(task.result);
//        XCTAssertNotNil(task.error);
//        
//        [expectation fulfill];
//        
//        return nil;
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//    
//}
//
//-(void)testFetchCategoryTypesWithCompletionEmptyDictionaryInJsonFormat {
//    
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithEmptyDataDictionaryParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    [MNFCategory fetchCategoryTypesWithCompletion:^(NSArray *categoryTypes, NSError *error) {
//        
//        XCTAssertNil(categoryTypes);
//        XCTAssertNotNil(error);
//        
//        [expectation fulfill];
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//    
//}
//
//-(void)testFetchCategoryTypesWithJobEmptyDictionaryInJsonFormat {
//
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithEmptyDataDictionaryParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    [[MNFCategory fetchCategoryTypes].task continueWithBlock:^id(MNF_BFTask *task) {
//        
//        XCTAssertNil(task.result);
//        XCTAssertNotNil(task.error);
//        
//        [expectation fulfill];
//        
//        return nil;
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//    
//}
//
//-(void)testCreateCategoryWithCompletionEmptyDictionaryInJsonFormat {
//    
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithEmptyDataDictionaryParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    [MNFCategory createUserParentCategoryWithName:@"ome name" isFixedExpense:nil categoryType:1 completion:^(MNFCategory *category, NSError *error) {
//        
//        XCTAssertNil(category);
//        XCTAssertNil(error);
//        
//        [expectation fulfill];
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//    
//}
//
//-(void)testCreateCategoryWithJobEmptyDictionaryInJsonFormat {
//    
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithEmptyDataDictionaryParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    [[MNFCategory createUserParentCategoryWithName:@"user cat" isFixedExpense:nil categoryType:1].task continueWithBlock:^id(MNF_BFTask *task) {
//        
//        XCTAssertNil(task.result);
//        XCTAssertNil(task.error);
//        
//        [expectation fulfill];
//        
//        return nil;
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//    
//}
//
//#pragma mark - Merchant
//
//-(void)testFetchMerchantWithIdWithCompletionEmptyDictionaryInJsonFormat {
//    
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithEmptyDataDictionaryParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    [MNFMerchant fetchWithId:@1 completion:^(MNFMerchant *merchant, NSError *error) {
//        
//        XCTAssertNil(merchant);
//        XCTAssertNil(error);
//        
//        [expectation fulfill];
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//    
//}
//
//-(void)testFetchMerchantWithIdWithJobEmptyDictionaryInJsonFormat {
//    
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithEmptyDataDictionaryParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    [[MNFMerchant fetchWithId:@1].task continueWithBlock:^id(MNF_BFTask *task) {
//        
//        XCTAssertNil(task.result);
//        XCTAssertNil(task.error);
//        
//        [expectation fulfill];
//        
//        return nil;
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//    
//}
//
//
//#pragma mark - Networth
//
//-(void)testFetchNetworthAccountWithStartDateWithCompletionEmptyDictionaryInJsonFormat {
//    
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithEmptyDataDictionaryParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    [MNFNetworthAccount fetchWithStartDate:[NSDate date] endDate:[NSDate date] completion:^(NSArray *networthAccounts, NSError *error) {
//        
//        XCTAssertNil(networthAccounts);
//        XCTAssertNotNil(error);
//        
//        [expectation fulfill];
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//}
//
//-(void)testFetchNetworthAccountWithStartDateWithJobEmptyDictionaryInJsonFormat {
//
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithEmptyDataDictionaryParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    [[MNFNetworthAccount fetchWithStartDate:[NSDate date] endDate:[NSDate date]].task continueWithBlock:^id(MNF_BFTask *task) {
//        
//        XCTAssertNil(task.result);
//        XCTAssertNotNil(task.error);
//        
//        [expectation fulfill];
//        
//        return nil;
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//    
//}
//
//-(void)testNetworthSummaryWithCompletionEmptyDictionaryInJsonFormat {
//    
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithEmptyDataDictionaryParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    [MNFNetworthAccount fetchSummaryWithStartDate:[NSDate date] endDate:[NSDate date] completion:^(NSArray *networthAccounts, NSError *error) {
//        
//        XCTAssertNil(networthAccounts);
//        XCTAssertNotNil(error);
//        
//        [expectation fulfill];
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//    
//}
//
//-(void)testNetworthSummaryWithJobEmptyDictionaryInJsonFormat {
//    
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithEmptyDataDictionaryParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    [[MNFNetworthAccount fetchSummaryWithStartDate:[NSDate date] endDate:[NSDate date]].task continueWithBlock:^id(MNF_BFTask *task) {
//        
//        XCTAssertNil(task.result);
//        XCTAssertNotNil(task.error);
//        
//        [expectation fulfill];
//        
//        return nil;
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//
//}
//
//-(void)testFetchNetworthAccountTypesWithCompletionEmptyDictionaryInJsonFormat {
//    
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithEmptyDataDictionaryParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    [MNFNetworthAccount fetchNetworthTypesWithCompletion:^(NSArray *networthAccountTypes, NSError *error) {
//        
//        XCTAssertNil(networthAccountTypes);
//        XCTAssertNotNil(error);
//        
//        [expectation fulfill];
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//    
//}
//
//-(void)testFetchNetworthAccountTypesWithJobEmptyDictionaryInJsonFormat {
//    
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithEmptyDataDictionaryParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    [[MNFNetworthAccount fetchNetworthTypes].task continueWithBlock:^id(MNF_BFTask *task) {
//        
//        XCTAssertNil(task.result);
//        XCTAssertNotNil(task.error);
//        
//        [expectation fulfill];
//        
//        return nil;
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//    
//}
//
//#pragma mark - Synchronization
//
//-(void)testStartSynchronizationWithCompletionEmptyDictionaryInJsonFormat {
//    
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithEmptyDataDictionaryParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    [MNFSynchronization startSynchronizationWithWaitTime:@0 completion:^(MNFSynchronization *sync, NSError *error) {
//        
//        XCTAssertNil(sync);
//        XCTAssertNil(error);
//        
//        [expectation fulfill];
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//    
//}
//
//-(void)testStartSynchronizationWithJobEmptyDictionaryInJsonFormat {
//
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithEmptyDataDictionaryParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    [[MNFSynchronization startSynchronizationWithWaitTime:@0].task continueWithBlock:^id(MNF_BFTask *task) {
//        
//        XCTAssertNil(task.result);
//        XCTAssertNil(task.error);
//        
//        [expectation fulfill];
//        
//        return nil;
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//    
//}
//
//-(void)testFetchCurrentSynchronizationStatusWithCompletionEmptyDictionaryInJsonFormat {
//    
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithEmptyDataDictionaryParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    [MNFSynchronization fetchCurrentSynchronizationStatusWithCompletion:^(MNFSynchronization *sync, NSError *error) {
//        
//        XCTAssertNil(sync);
//        XCTAssertNil(error);
//        
//        [expectation fulfill];
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//    
//}
//
//-(void)testFetchCurrentSynchronizationStatusWithJobEmptyDictionaryInJsonFormat {
//
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithEmptyDataDictionaryParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    [[MNFSynchronization fetchCurrentSynchronizationStatus].task continueWithBlock:^id(MNF_BFTask *task) {
//        
//        XCTAssertNil(task.result);
//        XCTAssertNil(task.error);
//        
//        [expectation fulfill];
//        
//        return nil;
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//    
//}
//
//
//#pragma mark - Tags
//
//-(void)testFetchTagWithIdWithCompletionEmptyDictionaryInJsonFormat {
//    
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithEmptyDataDictionaryParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    [MNFTag fetchWithId:@1 completion:^(MNFTag *tag, NSError *error) {
//        
//        XCTAssertNil(tag);
//        XCTAssertNil(error);
//        
//        [expectation fulfill];
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//    
//}
//
//-(void)testFetchTagWithIdWithJobEmptyDictionaryInJsonFormat {
//
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithEmptyDataDictionaryParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    [[MNFTag fetchWithId:@1].task continueWithBlock:^id(MNF_BFTask *task) {
//        
//        XCTAssertNil(task.result);
//        XCTAssertNil(task.error);
//        
//        [expectation fulfill];
//        
//        return nil;
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//    
//}
//
//-(void)testFetchTagsWithCompletionEmptyDictionaryInJsonFormat {
//    
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithEmptyDataDictionaryParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    [MNFTag fetchTagsWithCompletion:^(NSArray *array, NSError *error) {
//        
//        XCTAssertNil(array);
//        XCTAssertNotNil(error);
//        
//        [expectation fulfill];
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//    
//}
//
//-(void)testFetchTagsWithJobEmptyDictionaryInJsonFormat {
//    
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithEmptyDataDictionaryParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    [[MNFTag fetchTags].task continueWithBlock:^id(MNF_BFTask *task) {
//        
//        XCTAssertNil(task.result);
//        XCTAssertNotNil(task.error);
//        
//        [expectation fulfill];
//        
//        return nil;
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
// 
//}
//
//-(void)testFetchPopularTagsWithCompletionEmptyDictionaryInJsonFormat {
//    
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithEmptyDataDictionaryParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    [MNFTag fetchPopularTagsWithCount:@10 completion:^(NSArray *array, NSError *error) {
//        
//        XCTAssertNil(array);
//        XCTAssertNotNil(error);
//        
//        [expectation fulfill];
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//    
//}
//
//-(void)testFetchPopularTagsWithJobEmptyDictionaryInJsonFormat {
//
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithEmptyDataDictionaryParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    [[MNFTag fetchPopularTagsWithCount:@10].task continueWithBlock:^id(MNF_BFTask *task) {
//        
//        XCTAssertNil(task.result);
//        XCTAssertNotNil(task.error);
//        
//        [expectation fulfill];
//        
//        return nil;
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//    
//}
//
//
//#pragma mark - Realm User
//
//-(void)testFetchRealmUserWithCompletionEmptyDictionaryInJsonFormat {
//    
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithEmptyDataDictionaryParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    [MNFRealmUser fetchRealmUsersWithCompletion:^(NSArray *realmsUsers, NSError *error) {
//        
//        XCTAssertNil(realmsUsers);
//        XCTAssertNotNil(error);
//        
//        [expectation fulfill];
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//    
//}
//
//
//-(void)testFetchRealmUsersWithJobDictionaryInJsonFormat {
//    
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithEmptyDataDictionaryParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    [[MNFRealmUser fetchRealmUsers].task continueWithBlock:^id(MNF_BFTask *task) {
//        
//        XCTAssertNil(task.result);
//        XCTAssertNotNil(task.error);
//        
//        [expectation fulfill];
//        
//        return nil;
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//    
//}
//
//#pragma mark - Users
//
//-(void)testFetchUsersWithCompletionDictionaryInJsonFormat {
//    
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithEmptyDataDictionaryParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    [MNFUser fetchUsersWithCompletion:^(NSArray *users, NSError *error) {
//        
//        XCTAssertNil(users);
//        XCTAssertNotNil(error);
//        
//        [expectation fulfill];
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//    
//}
//
//-(void)testFetchUsersWithJobDictionaryInJsonFormat {
//    
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithEmptyDataDictionaryParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    [[MNFUser fetchUsers].task continueWithBlock:^id(MNF_BFTask *task) {
//        
//        XCTAssertNil(task.result);
//        XCTAssertNotNil(task.error);
//        
//        [expectation fulfill];
//        
//        return nil;
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//    
//}
//
//#pragma mark - User Profile
//
//-(void)testFetchUsersProfilesWithCompletionDictionaryInJsonFormat {
//    
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithEmptyDataDictionaryParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    [MNFUserProfile fetchWithCompletion:^(MNFUserProfile *profile, NSError *error) {
//        
//        XCTAssertNil(profile);
//        XCTAssertNil(error);
//        
//        [expectation fulfill];
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//    
//    
//}
//
//-(void)testFetchUsersProfilesWithJobDictionaryInJsonFormat {
//    
//    [MNFNetworkProtocolForTesting setResponseData:[self jsonWithEmptyDataDictionaryParameter]];
//    
//    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    [[MNFUserProfile fetch].task continueWithBlock:^id(MNF_BFTask *task) {
//        
//        XCTAssertNil(task.result);
//        XCTAssertNil(task.error);
//        
//        [expectation fulfill];
//        
//        return nil;
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//    
//}
//
//#pragma mark - Json file helpers
//
//-(NSData*)jsonWithoutDataParameter {
//    return [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"testJsonWithoutDataParameter" ofType:@"json"]];
//}
//
//-(NSData *)jsonWithNilDataParameter {
//    return [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"testJsonDataParameterNil" ofType:@"json"]];
//}
//
//-(NSData *)jsonWithEmptyDataDictionaryParameter {
//    return [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"testJsonEmptyDataParameter" ofType:@"json"]];
//}



@end
