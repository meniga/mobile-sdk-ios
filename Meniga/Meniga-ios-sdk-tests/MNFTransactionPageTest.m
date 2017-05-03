//
//  MNFTransactionPageTest.m
//  Meniga-ios-sdk
//
//  Created by Aske Bendtsen on 24/11/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNFTransactionPage.h"
#import "MNFTransaction.h"
#import "MNFTransactionFilter.h"
#import "MNFNetworkProtocolForTesting.h"
#import "MNFNetwork.h"
#import "MNFJsonAdapter.h"
#import "MNFTransactionGroup.h"
#import "GCDUtils.h"

@interface MNFTransactionPageTest : XCTestCase

@end

@implementation MNFTransactionPageTest{

    MNFTransactionPage *_sut;
}

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    [MNFNetwork initializeForTesting];
    [MNFNetworkProtocolForTesting removeDelay];
    
    
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:[self transactionsResponse] options:0 error:nil];
    NSArray *unwrap = [jsonDict objectForKey:@"data"];
    NSArray *transactions = [MNFJsonAdapter objectsOfClass:[MNFTransaction class] jsonArray:unwrap option:kMNFAdapterOptionNoOption error:nil];
    NSDictionary *pageDict = @{@"pageNumber":@1,@"numberOfPages":@2,@"transactions":transactions,@"numberOfTransactions":@20,@"transactionsPerPage":@10};
    _sut = [MNFJsonAdapter objectOfClass:[MNFTransactionPage class] jsonDict:pageDict option:kMNFAdapterOptionNoOption error:nil];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    [MNFNetwork flushForTesting];
    _sut = nil;
}

-(void)testTransactionPageCreation {
    MNFTransactionPage *page = [[MNFTransactionPage alloc] init];
    XCTAssertTrue(page.isNew == YES);
}

- (void)testFetchWithFilterPopulatesTransactionPage{
    
    // MARK:  Causing NSTaggedPointerString countByEnumeratingWithState: objects: count:] unrecognized selector sent to instance from MNFJsonAdapter
    [MNFNetworkProtocolForTesting setResponseData:[self transactionsResponse]];
    
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFTransactionFilter *filter = [[MNFTransactionFilter alloc]init];
    filter.searchText = @"Vodafone";
    
    MNFJob *job = [MNFTransactionPage fetchWithTransactionFilter:filter page:@0 transactionsPerPage:@10 completion:^(MNFTransactionPage * _Nullable result, NSError * _Nullable error) {
        
        XCTAssertNotNil(result.transactions);
        XCTAssertNotNil(result.numberOfPages);
        XCTAssertNotNil(result.numberOfTransactions);
        XCTAssertNotNil(result.pageNumber);
        XCTAssertNotNil(result.sumOfTransactions);
        XCTAssertNotNil(result.transactionsPerPage);
        XCTAssertTrue(result.isNew == NO);
        
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

-(void)testAppendingPageResultsInIncreasedTransactionsArrayCount{
    
    [MNFNetworkProtocolForTesting setResponseData:[self transactionsResponse]];

    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    NSInteger transactionCount = _sut.transactions.count;
    
    MNFJob *job = [_sut appendNextPageWithCompletion:^(NSError * _Nullable error) {

        XCTAssertEqual(transactionCount*2, _sut.transactions.count);
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

-(void)testAppendingPageResultsInIncreasedTransactionsArrayCountWithNilCompletion {
    
    [MNFNetworkProtocolForTesting setResponseData:[self transactionsResponse]];
    
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    NSInteger transactionCount = _sut.transactions.count;
    
    [_sut appendNextPageWithCompletion:nil];
    
    [GCDUtils dispatchAfterTime:2.0 completion:^{
        
        XCTAssertEqual(transactionCount*2, _sut.transactions.count);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
    
}

-(void)testNextPageReplacesCurrentTransactions{
    
    [MNFNetworkProtocolForTesting setResponseData:[self transactionsResponse]];

    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFTransaction *trans = [_sut.transactions objectAtIndex:0];
    NSDate *newDate = [trans.date dateByAddingTimeInterval:1000];
    trans.date = newDate;
    
    MNFJob *job = [_sut nextPageWithCompletion:^(NSError * _Nullable error) {
        XCTAssertNotEqualObjects(((MNFTransaction*)[_sut.transactions objectAtIndex:0]).date, newDate);
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

-(void)testRefreshPopulatesPage {
    [MNFNetworkProtocolForTesting setResponseData:[self transactionsResponse]];
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFJob *job = [_sut refreshWithCompletion:^(NSError * _Nullable error) {
        
        XCTAssertNil(error);
        XCTAssertNotNil(_sut.transactions);
        XCTAssertNotNil(_sut.numberOfPages);
        XCTAssertNotNil(_sut.numberOfTransactions);
        XCTAssertNotNil(_sut.pageNumber);
        XCTAssertNotNil(_sut.sumOfTransactions);
        XCTAssertNotNil(_sut.transactionsPerPage);
        XCTAssertTrue(_sut.isNew == NO);
        
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

-(void)testRefreshWithNilCompletionPopulatesPage {
    
    [MNFNetworkProtocolForTesting setResponseData:[self transactionsResponse]];
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [_sut refreshWithCompletion:nil];
    
    [GCDUtils dispatchAfterTime:0.1 completion:^{
       
        XCTAssertNotNil(_sut.transactions);
        XCTAssertNotNil(_sut.numberOfPages);
        XCTAssertNotNil(_sut.numberOfTransactions);
        XCTAssertNotNil(_sut.pageNumber);
        XCTAssertNotNil(_sut.sumOfTransactions);
        XCTAssertNotNil(_sut.transactionsPerPage);
        XCTAssertTrue(_sut.isNew == NO);
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
    
}

-(void)testGroupByDate {
    
    [_sut groupByDate];
    XCTAssertTrue(_sut.transactionsGroupedByDate.count == 5);
    XCTAssertEqual([[_sut.transactionsGroupedByDate firstObject] class], [MNFTransactionGroup class]);
    MNFTransactionGroup *group = [_sut.transactionsGroupedByDate firstObject];
    XCTAssertEqual(group.groupedBy, MNFGroupedByDate);
}
-(void)testGroupByCategory {
    
    [_sut groupByCategory];
    XCTAssertTrue(_sut.transactionsGroupedByCategory.count == 8);
    XCTAssertEqual([[_sut.transactionsGroupedByCategory firstObject] class], [MNFTransactionGroup class]);
    MNFTransactionGroup *group = [_sut.transactionsGroupedByCategory firstObject];
    XCTAssertEqual(group.groupedBy, MNFGroupedByCategory);
}
-(void)testUngroup {
    
    [_sut groupByDate];
    XCTAssertTrue(_sut.transactions.count == 10);
    XCTAssertEqual([[_sut.transactions firstObject] class], [MNFTransaction class]);
}

#pragma mark - helpers

-(NSData*)transactionsResponse{
    return [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"transactionsResponse" ofType:@"json"]];
}

@end
