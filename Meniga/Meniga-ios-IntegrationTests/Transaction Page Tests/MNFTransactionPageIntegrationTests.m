//
//  MNFTransactionPageIntegrationTests.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 4/20/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNFIntegrationTestSetup.h"
#import "MNFInternalImports.h"
#import "MNFTransactionPage.h"
#import "MNFTransactionFilter.h"
#import "MNFSynchronization.h"
#import "MNFDemoUser.h"

@interface MNFTransactionPageIntegrationTests : MNFIntegrationTestSetup

@end

@implementation MNFTransactionPageIntegrationTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    // has to be one thousand or it will fail
    [MNFDemoUser startSynchronizationWithWaitTime:@1000 completion:^(MNFSynchronization *sync, NSError *error) {
        
        // need to wait a bit for the transactions to sync
        //dispatch_semaphore_signal(semaphore);
        
    }];
    
    dispatch_semaphore_wait(semaphore, dispatch_time(DISPATCH_TIME_NOW, kMNFIntegrationTestWaitTime * NSEC_PER_SEC));
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testTransactionPageWithEmptyFilterAndTenTransactionsPerPage {
    
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFJob *job = [MNFTransactionPage fetchWithTransactionFilter:[[MNFTransactionFilter alloc] init] page:nil transactionsPerPage:[NSNumber numberWithInt:10] completion:^(MNFTransactionPage *transPage, NSError *error) {
        
        XCTAssertNotNil(transPage);
        
        XCTAssertTrue(transPage.transactions.count == 10);
        XCTAssertEqualObjects(transPage.pageNumber, @1);
        XCTAssertEqualObjects(transPage.transactionsPerPage, @10);
        
        
        XCTAssertNil(error);
        
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(MNFTransactionPage *transPage, id  _Nullable metaData, NSError * _Nullable error) {
        
        XCTAssertNotNil(transPage);
        
        XCTAssertTrue(transPage.transactions.count == 10);
        XCTAssertEqualObjects(transPage.pageNumber, @1);
        XCTAssertEqualObjects(transPage.transactionsPerPage, @10);
        
        XCTAssertNotNil(metaData);
        XCTAssertTrue([metaData objectForKey:@"totalCount"]);
        
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:kMNFIntegrationTestWaitTime handler:nil];
}

-(void)testTransactionPageWithEmptyFilterAndTwentyTransactionsPerPage {
    
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFJob *job = [MNFTransactionPage fetchWithTransactionFilter:[[MNFTransactionFilter alloc] init] page:@2 transactionsPerPage:@20 completion:^(MNFTransactionPage *page, NSError *error) {
       
        XCTAssertTrue(page.transactions.count == 20);
        XCTAssertEqualObjects(page.pageNumber, @2);
        XCTAssertEqualObjects(page.transactionsPerPage, @20);
        
        XCTAssertNil(error);
        
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(MNFTransactionPage *page, id  _Nullable metaData, NSError * _Nullable error) {

        XCTAssertTrue(page.transactions.count == 20);
        XCTAssertEqualObjects(page.pageNumber, @2);
        XCTAssertEqualObjects(page.transactionsPerPage, @20);
        
        XCTAssertNotNil(metaData);
        XCTAssertTrue([metaData objectForKey:@"totalCount"]);
        
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:kMNFIntegrationTestWaitTime handler:nil];
}

-(void)testTransactionPageAppendNextPage {
    
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFJob *job = [MNFTransactionPage fetchWithTransactionFilter:[[MNFTransactionFilter alloc] init] page:@1 transactionsPerPage:@10 completion:^(MNFTransactionPage *page, NSError *error) {
        
        XCTAssertTrue(page.transactions.count == 10);
        XCTAssertEqualObjects(page.pageNumber, @1);
        XCTAssertEqualObjects(page.transactionsPerPage, @10);
        
        XCTAssertNil(error);
        
        MNFJob *secondJob = [page appendNextPageWithCompletion:^(NSError *secondError) {
            
            XCTAssertTrue(page.transactions.count == 20);
            XCTAssertEqualObjects(page.pageNumber, @2);
            XCTAssertEqualObjects(page.transactionsPerPage, @10);
            
            XCTAssertNil(secondError);
            
            [expectation fulfill];

            
        }];
        
        [secondJob handleCompletion:^(id _Nullable result, id _Nullable metadata, NSError * _Nullable error) {
           
            XCTAssertTrue(page.transactions.count == 20);
            XCTAssertEqualObjects(page.pageNumber, @2);
            XCTAssertEqualObjects(page.transactionsPerPage, @10);
            
            XCTAssertNotNil(metadata);
            XCTAssertTrue([metadata objectForKey:@"totalCount"]);
            
            XCTAssertNil(error);
            
        }];
        
        
    }];
    
    [job handleCompletion:^(MNFTransactionPage *page, id  _Nullable metaData, NSError * _Nullable error) {

        XCTAssertTrue(page.transactions.count == 10);
        XCTAssertEqualObjects(page.pageNumber, @1);
        XCTAssertEqualObjects(page.transactionsPerPage, @10);
        
        XCTAssertNotNil(metaData);
        XCTAssertTrue([metaData objectForKey:@"totalCount"]);
        
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:kMNFIntegrationTestWaitTime handler:nil];
}

-(void)testNextTransactionPage {
    
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFJob *job = [MNFTransactionPage fetchWithTransactionFilter:[[MNFTransactionFilter alloc] init] page:@1 transactionsPerPage:@10 completion:^(MNFTransactionPage *page, NSError *error) {
       
        XCTAssertTrue(page.transactions.count == 10);
        XCTAssertEqualObjects(page.pageNumber, @1);
        XCTAssertEqualObjects(page.transactionsPerPage, @10);
        
        XCTAssertNil(error);
        
        MNFJob *secondJob = [page nextPageWithCompletion:^(NSError *secondError) {
           
            XCTAssertTrue(page.transactions.count == 10);
            XCTAssertEqualObjects(page.pageNumber, @2);
            XCTAssertEqualObjects(page.transactionsPerPage, @10);
            
            XCTAssertNil(secondError);
            
            [expectation fulfill];
        }];
        
        [secondJob handleCompletion:^(id _Nullable result, id _Nullable metadata, NSError * _Nullable error) {
           
            XCTAssertTrue(page.transactions.count == 10);
            XCTAssertEqualObjects(page.pageNumber, @2);
            XCTAssertEqualObjects(page.transactionsPerPage, @10);
            
            XCTAssertNotNil(metadata);
            XCTAssertTrue([metadata objectForKey:@"totalCount"]);

            XCTAssertNil(error);
            
        }];
        
    }];
    
    [job handleCompletion:^(MNFTransactionPage *page, id  _Nullable metaData, NSError * _Nullable error) {
        
        XCTAssertTrue(page.transactions.count == 10);
        XCTAssertEqualObjects(page.pageNumber, @1);
        XCTAssertEqualObjects(page.transactionsPerPage, @10);
        
        XCTAssertNotNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:kMNFIntegrationTestWaitTime handler:nil];
    
}

-(void)testRefresh {
    
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFJob *job = [MNFTransactionPage fetchWithTransactionFilter:[[MNFTransactionFilter alloc] init] page:@1 transactionsPerPage:@30 completion:^(MNFTransactionPage *page, NSError *error) {
        
        XCTAssertTrue(page.transactions.count == 30);
        XCTAssertEqualObjects(page.pageNumber, @1);
        XCTAssertEqualObjects(page.transactionsPerPage, @30);
        
        XCTAssertNil(error);
        
        MNFJob *secondJob = [page refreshWithCompletion:^(NSError *secondError) {
           
            XCTAssertTrue(page.transactions.count == 30);
            XCTAssertEqualObjects(page.pageNumber, @1);
            XCTAssertEqualObjects(page.transactionsPerPage, @30);
            
            XCTAssertNil(secondError);
            
            [expectation fulfill];
        }];
        
        [secondJob handleCompletion:^(id _Nullable result, id _Nullable metadata, NSError * _Nullable error) {
           
            XCTAssertTrue(page.transactions.count == 30);
            XCTAssertEqualObjects(page.pageNumber, @1);
            XCTAssertEqualObjects(page.transactionsPerPage, @30);
            
            XCTAssertNotNil(metadata);
            XCTAssertTrue([metadata objectForKey:@"totalCount"]);

            XCTAssertNil(error);
            
        }];
        
    }];
    
    [job handleCompletion:^(MNFTransactionPage *page, id  _Nullable metaData, NSError * _Nullable error) {
        
        XCTAssertTrue(page.transactions.count == 30);
        XCTAssertEqualObjects(page.pageNumber, @1);
        XCTAssertEqualObjects(page.transactionsPerPage, @30);
        
        XCTAssertNotNil(metaData);
        XCTAssertTrue([metaData objectForKey:@"totalCount"]);
        
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:kMNFIntegrationTestWaitTime handler:nil];
}

@end
