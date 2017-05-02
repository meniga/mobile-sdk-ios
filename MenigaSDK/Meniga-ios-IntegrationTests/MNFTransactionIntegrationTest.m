//
//  MNFTransactionIntegrationTest.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 20/04/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNFIntegrationTestSetup.h"
#import "MNFTransaction.h"
#import "MNFTransactionFilter.h"
#import "MNFTransactionPage.h"
#import "MNFSynchronization.h"
#import "MNFComment.h"
#import "MNFDemoUser.h"

@interface MNFTransactionIntegrationTest : MNFIntegrationTestSetup

@end

@implementation MNFTransactionIntegrationTest

- (void)setUp {
    [super setUp];
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    // MARK: Do not dispatch the semaphore, as fetch with transaction filter takes a heavy load on the test server this will overload it and it will simply send an empty response for some odd reason???
    [MNFDemoUser startSynchronizationWithWaitTime:@1000 completion:^(MNFSynchronization * _Nullable synchronization, NSError * _Nullable error) {
        //dispatch_semaphore_signal(semaphore);

    }];
    
    dispatch_semaphore_wait(semaphore, dispatch_time(DISPATCH_TIME_NOW, kMNFIntegrationTestWaitTime*NSEC_PER_SEC));
}

- (void)tearDown {
    [super tearDown];
}

-(void)testFetchTransactions {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFTransactionFilter *filter = [[MNFTransactionFilter alloc] init];

    [MNFTransactionPage fetchWithTransactionFilter:filter page:nil transactionsPerPage:@10 completion:^( MNFTransactionPage * _Nullable page, NSError * _Nullable error) {
        
        XCTAssertNil(error);
        XCTAssertNotNil(page);
        XCTAssertNotNil(page.transactions);
        XCTAssertTrue(page.transactions.count != 0);
        
        MNFJob *job = [MNFTransaction fetchWithId:[page.transactions firstObject].identifier completion:^(MNFTransaction * _Nullable transaction, NSError * _Nullable error) {
            
            XCTAssertNil(error);
            XCTAssertNotNil(transaction);
            
            [expectation fulfill];
        }];
        
        [job handleCompletion:^(MNFTransaction * _Nullable transaction, id  _Nullable metaData, NSError * _Nullable error) {
            
            XCTAssertNotNil(transaction);
            XCTAssertNil(metaData);
            XCTAssertNil(error);
        
        }];
        
    }];
    
    [self waitForExpectationsWithTimeout:kMNFIntegrationTestWaitTime handler:nil];
}

-(void)testFetchSplit {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFTransactionFilter *filter = [[MNFTransactionFilter alloc] init];
    [MNFTransactionPage fetchWithTransactionFilter:filter page:nil transactionsPerPage:@10 completion:^( MNFTransactionPage * _Nullable page, NSError * _Nullable error) {
        
        XCTAssertNil(error);
        XCTAssertNotNil(page);
        XCTAssertNotNil(page.transactions);
        XCTAssertTrue(page.transactions.count != 0);
        
        MNFJob *job = [[page.transactions firstObject] fetchSplitWithCompletion:^(NSArray<MNFTransaction *> * _Nullable transactions, NSError * _Nullable error) {
            
            XCTAssertNil(error);
            XCTAssertNotNil(transactions);
            XCTAssertTrue(transactions.count == 1);
        
            [expectation fulfill];
        
        }];
        
        [job handleCompletion:^(NSArray<MNFTransaction *> * _Nullable transactions, id  _Nullable metaData, NSError * _Nullable error) {
            
            XCTAssertNotNil(transactions);
            XCTAssertTrue(transactions.count == 1);
            XCTAssertNil(metaData);
            XCTAssertNil(error);
        
        }];
    }];
    
    [self waitForExpectationsWithTimeout:kMNFIntegrationTestWaitTime handler:nil];
}

-(void)testCreateAndDeleteTransaction {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    NSDate *date = [NSDate date];
    
    MNFJob *job = [MNFTransaction createTransactionWithDate:date text:@"text" amount:@10 categoryId:@10 setAsRead:@YES completion:^(MNFTransaction * _Nullable transaction, NSError * _Nullable error) {
        
        XCTAssertNil(error);
        XCTAssertNotNil(transaction);
        XCTAssertTrue([transaction.text isEqualToString:@"text"]);
        XCTAssertTrue([transaction.amount isEqualToNumber:@10]);
        XCTAssertTrue([transaction.categoryId isEqualToNumber:@10]);
        XCTAssertTrue([transaction.isRead boolValue]);
        
        MNFJob *secondJob = [transaction deleteTransactionWithCompletion:^(NSError * _Nullable error) {
        
            XCTAssertNil(error);
            XCTAssertTrue(transaction.isDeleted);
            
            [expectation fulfill];
        
        }];
        
        [secondJob handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
            
            XCTAssertNil(result);
            XCTAssertTrue(transaction.isDeleted);
            XCTAssertNil(metaData);
            XCTAssertNil(error);
            
        }];
    
    }];
    
    [job handleCompletion:^(MNFTransaction * _Nullable transaction, id _Nullable metadata, NSError * _Nullable error) {
        
        XCTAssertNil(error);
        XCTAssertNil(metadata);
        XCTAssertNotNil(transaction);
        XCTAssertTrue([transaction.text isEqualToString:@"text"]);
        XCTAssertTrue([transaction.amount isEqualToNumber:@10]);
        XCTAssertTrue([transaction.categoryId isEqualToNumber:@10]);
        XCTAssertTrue([transaction.isRead boolValue]);
        
    }];
    
    [self waitForExpectationsWithTimeout:kMNFIntegrationTestWaitTime handler:nil];
}

-(void)testDeleteMultipleTransactions {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    

    [MNFTransaction createTransactionWithDate:[NSDate date] text:@"new trans" amount:@10 categoryId:@81 setAsRead:@0 completion:^(MNFTransaction *transaction, NSError *error) {
       
        XCTAssertNil(error);
        
        MNFJob *job = [MNFTransaction deleteTransactions:@[transaction] withCompletion:^(NSError * _Nullable secondError) {
            
            XCTAssertNil(secondError);
            XCTAssertTrue(transaction.isDeleted);
            
            [expectation fulfill];
            
        }];
        
        [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
            XCTAssertNil(result);
            XCTAssertNil(metaData);
            XCTAssertNil(error);
        }];
    }];
    
    [self waitForExpectationsWithTimeout:kMNFIntegrationTestWaitTime handler:nil];
}

-(void)testUpdateTransaction {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFTransactionFilter *filter = [[MNFTransactionFilter alloc] init];
    [MNFTransactionPage fetchWithTransactionFilter:filter page:nil transactionsPerPage:@10 completion:^( MNFTransactionPage * _Nullable page, NSError * _Nullable error) {
        
        [page.transactions firstObject].text = @"changed text";
        
        MNFJob *job = [[page.transactions firstObject] saveWithCompletion:^(NSError * _Nullable error) {
        
            XCTAssertNil(error);
            XCTAssertTrue([[page.transactions firstObject].text isEqualToString:@"changed text"]);
            
            [expectation fulfill];
        
        }];
        
        [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
            
            XCTAssertEqualObjects([page.transactions firstObject].text, @"changed text");
            XCTAssertNotNil(result);
            XCTAssertNil(metaData);
            XCTAssertNil(error);
        
        }];
    }];
    
    [self waitForExpectationsWithTimeout:kMNFIntegrationTestWaitTime handler:nil];
}

-(void)testRefreshTransaction {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFTransactionFilter *filter = [[MNFTransactionFilter alloc] init];
    [MNFTransactionPage fetchWithTransactionFilter:filter page:nil transactionsPerPage:@10 completion:^( MNFTransactionPage * _Nullable page, NSError * _Nullable error) {
        
        NSString *textBeforeChanged = [page.transactions firstObject].text;
        [page.transactions firstObject].text = @"changed text";
        
        MNFJob *job = [[page.transactions firstObject] refreshWithCompletion:^(NSError * _Nullable error) {
            
            XCTAssertNil(error);
            XCTAssertTrue([[page.transactions firstObject].text isEqualToString:textBeforeChanged]);
            XCTAssertTrue([[page.transactions firstObject].text isEqualToString:@"changed text"] == NO);
            
            [expectation fulfill];
            
        }];
        
        [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
            
            XCTAssertTrue([[page.transactions firstObject].text isEqualToString:textBeforeChanged]);
            XCTAssertTrue([[page.transactions firstObject].text isEqualToString:@"changed text"] == NO);
            
            XCTAssertNotNil(result);
            XCTAssertNil(metaData);
            XCTAssertNil(error);
        }];
    }];
    
    [self waitForExpectationsWithTimeout:kMNFIntegrationTestWaitTime handler:nil];
}

-(void)testSplitTransaction {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFTransactionFilter *filter = [[MNFTransactionFilter alloc] init];
    [MNFTransactionPage fetchWithTransactionFilter:filter page:nil transactionsPerPage:@10 completion:^( MNFTransactionPage * _Nullable page, NSError * _Nullable error) {
        
        NSNumber *splitAmount = @([[page.transactions firstObject].amount floatValue]/2);
        
        MNFJob *job = [[page.transactions firstObject] splitTransactionWithAmount:splitAmount categoryId:[page.transactions firstObject].categoryId text:@"split" isFlagged:NO completion:^(MNFTransaction * _Nullable transaction, NSError * _Nullable error) {
            
            XCTAssertNil(error);
            XCTAssertNotNil(transaction);
            XCTAssertEqualObjects([page.transactions firstObject].amount,transaction.amount);
            XCTAssertEqualObjects(transaction.text, @"split");
            XCTAssertFalse([transaction.isFlagged boolValue]);
            
            [expectation fulfill];
        }];
        
        [job handleCompletion:^(MNFTransaction * _Nullable transaction, id  _Nullable metaData, NSError * _Nullable error) {
            
            XCTAssertNotNil(transaction);
            XCTAssertEqualObjects([page.transactions firstObject].amount,transaction.amount);
            XCTAssertEqualObjects(transaction.text, @"split");
            XCTAssertFalse([transaction.isFlagged boolValue]);
            
            XCTAssertNil(metaData);
            XCTAssertNil(error);
        }];
    }];
    
    [self waitForExpectationsWithTimeout:kMNFIntegrationTestWaitTime handler:nil];
}

-(void)testPostComment {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFTransactionFilter *filter = [[MNFTransactionFilter alloc] init];
    [MNFTransactionPage fetchWithTransactionFilter:filter page:nil transactionsPerPage:@10 completion:^( MNFTransactionPage * _Nullable page, NSError * _Nullable error) {
        
        MNFJob *job = [[page.transactions firstObject] postComment:@"testing" withCompletion:^(NSError * _Nullable error) {
        
            XCTAssertNil(error);
            
            MNFComment *comment = [[page.transactions firstObject].comments firstObject];
            XCTAssertEqualObjects(comment.comment, @"testing");
            
            [expectation fulfill];
        }];
        
        [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
            
            MNFComment *comment = [[page.transactions firstObject].comments firstObject];
            XCTAssertEqualObjects(comment.comment, @"testing");
            
            XCTAssertNotNil(result);
            XCTAssertNil(metaData);
            XCTAssertNil(error);
        }];
    }];
    
    [self waitForExpectationsWithTimeout:kMNFIntegrationTestWaitTime handler:nil];
}

-(void)testRecategorizeTransactions {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFJob *job = [MNFTransaction recategorizeWithTexts:@[@"T-Mobile UK"] unreadOnly:NO useSubText:NO markAsRead:NO categoryId:@81 completion:^(NSError * _Nullable error) {
        
        XCTAssertNil(error);
        
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        
        XCTAssertNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    
    }];
    
    [self waitForExpectationsWithTimeout:kMNFIntegrationTestWaitTime handler:nil];
}

@end
