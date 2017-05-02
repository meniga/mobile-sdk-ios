//
//  MNFTransactionTest.m
//  Meniga-ios-sdk
//
//  Created by Aske Bendtsen on 27/10/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNFTransaction.h"
#import "MNFNetwork.h"
#import "MNFNetworkProtocolForTesting.h"
#import "MNFObjectTypes.h"
#import "Meniga.h"
#import "MNFSettings.h"
#import "MNFJsonAdapter.h"
#import "GCDUtils.h"

@interface MNFTransactionTest : XCTestCase

@end

@implementation MNFTransactionTest {
    MNFTransaction *_sut;
}

- (void)setUp {
    [super setUp];
    
    [MNFNetwork initializeForTesting];
    [MNFNetworkProtocolForTesting removeDelay];
    [Meniga setLogLevel:kMNFLogLevelError];
    
    NSDictionary *transactionData = [NSJSONSerialization JSONObjectWithData:[self transactionResponse] options:0 error:nil];
    NSDictionary *transaction = [transactionData objectForKey:@"data"];
    
    _sut = [MNFJsonAdapter objectOfClass:[MNFTransaction class] jsonDict:transaction option:kMNFAdapterOptionNoOption error:nil];
}

- (void)tearDown {
    
    [MNFNetwork flushForTesting];
    
    _sut = nil;
    
    [super tearDown];
}

-(void)testTransactionCreation {
    
    MNFTransaction *transaction = [[MNFTransaction alloc] init];
    XCTAssertTrue(transaction.isNew == YES);
    
}

- (void)testFetchWithIdPartialPopulatingObjectProperties {
    [MNFNetworkProtocolForTesting setResponseData:[self transactionResponse]];
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
     
    MNFJob *job = [MNFTransaction fetchWithId:@1 completion:^(MNFTransaction * _Nullable result, NSError *error) {
        
        XCTAssertNotNil(result.identifier);
        XCTAssertNotNil(result.accountId);
        XCTAssertNotNil(result.amount);
        XCTAssertNil(result.amountInCurrency);
        XCTAssertNil(result.balance);
        XCTAssertNotNil(result.bankId);
        XCTAssertNil(result.categoryChangedTime);
        XCTAssertNil(result.changedByRule);
        XCTAssertNil(result.changedByRuleTime);
        XCTAssertNil(result.counterpartyAccountIdentifier);
        XCTAssertNil(result.currency);
        XCTAssertNotNil(result.data);
        XCTAssertNotNil(result.dataFormat);
        XCTAssertNotNil(result.detectedCategories);
        XCTAssertNil(result.dueDate);
        XCTAssertNotNil(result.hasUncertainCategorization);
        XCTAssertNil(result.hasUserClearedCategoryUncertainty);
        XCTAssertNotNil(result.insertTime);
        XCTAssertNil(result.isFlagged);
        XCTAssertNotNil(result.isMerchant);
        XCTAssertNil(result.isOwnAccountTransfer);
        XCTAssertNil(result.isSplitChild);
        XCTAssertNotNil(result.isUncleared);
        XCTAssertNil(result.lastModifiedTime);
        XCTAssertNotNil(result.mcc);
        XCTAssertNil(result.merchantId);
        XCTAssertNotNil(result.metaData);
        XCTAssertNotNil(result.originalAmount);
        XCTAssertNotNil(result.originalDate);
        XCTAssertNotNil(result.originalText);
        XCTAssertNotNil(result.parentIdentifier);
        XCTAssertNotNil(result.parsedData);
        XCTAssertNil(result.timestamp);
        XCTAssertNil(result.userData);
        XCTAssertTrue(result.isNew == NO);
        
        //Mutable state
        XCTAssertNotNil(result.categoryId);
        XCTAssertNotNil(result.comments);
        XCTAssertNotNil(result.date);
        XCTAssertNotNil(result.tags);
        XCTAssertNotNil(result.text);
        XCTAssertNotNil(result.isRead);
        
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

//-(void)testFetchTransactionsWithFilter {
//    
//    [MNFNetworkProtocolForTesting setResponseData:[self transactionsResponse]];
//    
//    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    MNFTransactionFilter *filter = [[MNFTransactionFilter alloc] init];
//    
//    MNFJob *job = [MNFTransactionPage fetchWithTransactionFilter:filter page:nil transactionsPerPage:@1000 completion:^( MNFTransactionPage * _Nullable page, NSError * _Nullable error) {
//        
//        XCTAssertNotNil(page);
//        XCTAssertFalse(page.transactions.count == 0);
//        XCTAssertNil(error);
//        
//        for (MNFTransaction *transaction in page.transactions) {
//            XCTAssertTrue(transaction.isNew == NO);
//        }
//        
//        [expectation fulfill];
//    }];
//    
//    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
//        XCTAssertNotNil(result);
//        XCTAssertNil(metaData);
//        XCTAssertNil(error);
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:nil];
//}


-(void)testDeleteTransactions {
    
    [MNFNetworkProtocolForTesting setResponseData:[self transactionEmptyResponse]];
     
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    NSDictionary *transactionDict = [NSJSONSerialization JSONObjectWithData:[self transactionsResponse] options:0 error:nil];
    NSArray *trans = [transactionDict objectForKey:@"data"];
    NSArray *transactions = [MNFJsonAdapter objectsOfClass:[MNFTransaction class] jsonArray:trans option:kMNFAdapterOptionNoOption error:nil];
    
    MNFJob *job = [MNFTransaction deleteTransactions:transactions withCompletion:^(NSError * _Nullable error) {
        
        XCTAssertNil(error);

        for (MNFTransaction *transaction in transactions) {
            XCTAssertTrue(transaction.isDeleted == YES);
        }
        
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

-(void)testDeleteTransactionsNilCompletion {
    
    [MNFNetworkProtocolForTesting setResponseData:[self transactionEmptyResponse]];
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    NSDictionary *transactionDict = [NSJSONSerialization JSONObjectWithData:[self transactionsResponse] options:0 error:nil];
    NSArray *trans = [transactionDict objectForKey:@"data"];
    NSArray *transactions = [MNFJsonAdapter objectsOfClass:[MNFTransaction class] jsonArray:trans option:kMNFAdapterOptionNoOption error:nil];
    
    [MNFTransaction deleteTransactions:transactions withCompletion:nil];
    
    [GCDUtils dispatchAfterTime:0.1 completion:^{
        
        for (MNFTransaction *transaction in transactions) {
            XCTAssertTrue(transaction.isDeleted == YES);
        }
        
        [expectation fulfill];
        
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
    
}

-(void)testSavingTransactionPersistsChanges{
    
    NSData *response = [self transactionEmptyResponse];
    
    [MNFNetworkProtocolForTesting setResponseData:response];
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    _sut.text = @"newTestText";
    XCTAssertTrue(_sut.isDirty == YES);
    
    MNFJob *job = [_sut saveWithCompletion:^(NSError * _Nullable error)  {
        XCTAssertEqualObjects(_sut.text, @"newTestText");
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:nil];
}

-(void)testSplitTransactionAltersAmountOfParent{
    NSData *response = [self transactionSplitResponse];
    
    [MNFNetworkProtocolForTesting setResponseData:response];
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFJob *job = [_sut splitTransactionWithAmount:@(2) categoryId:@12 text:@"additional purchase" isFlagged:NO completion:^(MNFTransaction * _Nullable result, NSError * _Nullable error) {
        
        XCTAssertEqualObjects(_sut.amount, @(-6));
        
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

-(void)testSplitTransactionAltersAmountOfParentNilCompletion {
    
    NSData *response = [self transactionSplitResponse];
    
    [MNFNetworkProtocolForTesting setResponseData:response];
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [_sut splitTransactionWithAmount:@(2) categoryId:@12 text:@"additional purchase" isFlagged:NO completion:nil];
    
    [GCDUtils dispatchAfterTime:0.1 completion:^{
        
        XCTAssertEqualObjects(_sut.amount, @(-6));
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
    
}

-(void)testFetchSplitsReturnsChildWithSameParentIdentifier{

    [MNFNetworkProtocolForTesting setResponseData:[self transactionSplitResponse]];
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFJob *job = [_sut fetchSplitWithCompletion:^(NSArray * _Nullable result, NSError * _Nullable error) {
        MNFTransaction *child = [result lastObject];
        
        XCTAssertEqualObjects(child.parentIdentifier, _sut.parentIdentifier);
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:nil];
}

-(void)testSplittingASplitChildReturnsError{
    
    NSDictionary *transactionData = [NSJSONSerialization JSONObjectWithData:[self transactionSplitResponse] options:0 error:nil];
    NSArray *transactions = [transactionData objectForKey:@"data"];
    _sut = [MNFJsonAdapter objectOfClass:[MNFTransaction class] jsonDict:[transactions lastObject] option:kMNFAdapterOptionNoOption error:nil];

    [MNFNetworkProtocolForTesting setResponseData:[self transactionSplitResponse]];
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFJob *job = [_sut splitTransactionWithAmount:@1 categoryId:@12 text:@"additional purchase" isFlagged:NO completion:^(MNFTransaction * _Nullable result, NSError * _Nullable error) {
        
        XCTAssertNotNil(error);
        
        XCTAssertTrue(result.isNew == NO);
        
        [expectation fulfill];
        
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNil(result);
        XCTAssertNil(metaData);
        XCTAssertNotNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:nil];

}

-(void)testRefreshOnObject {
    [MNFNetworkProtocolForTesting setResponseData:[self transactionResponse]];
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFJob *job = [_sut refreshWithCompletion:^(NSError * _Nullable error) {
        
        XCTAssertNotNil(_sut.identifier);
        XCTAssertNotNil(_sut.accountId);
        XCTAssertNotNil(_sut.amount);
        XCTAssertNil(_sut.amountInCurrency);
        XCTAssertNil(_sut.balance);
        XCTAssertNotNil(_sut.bankId);
        XCTAssertNil(_sut.categoryChangedTime);
        XCTAssertNil(_sut.changedByRule);
        XCTAssertNil(_sut.changedByRuleTime);
        XCTAssertNil(_sut.counterpartyAccountIdentifier);
        XCTAssertNil(_sut.currency);
        XCTAssertNotNil(_sut.data);
        XCTAssertNotNil(_sut.dataFormat);
        XCTAssertNotNil(_sut.detectedCategories);
        XCTAssertNil(_sut.dueDate);
        XCTAssertNotNil(_sut.hasUncertainCategorization);
        XCTAssertNil(_sut.hasUserClearedCategoryUncertainty);
        XCTAssertNotNil(_sut.insertTime);
        XCTAssertNil(_sut.isFlagged);
        XCTAssertNotNil(_sut.isMerchant);
        XCTAssertNil(_sut.isOwnAccountTransfer);
        XCTAssertNil(_sut.isSplitChild);
        XCTAssertNotNil(_sut.isUncleared);
        XCTAssertNil(_sut.lastModifiedTime);
        XCTAssertNotNil(_sut.mcc);
        XCTAssertNil(_sut.merchantId);
        XCTAssertNotNil(_sut.metaData);
        XCTAssertNotNil(_sut.originalAmount);
        XCTAssertNotNil(_sut.originalDate);
        XCTAssertNotNil(_sut.originalText);
        XCTAssertNotNil(_sut.parentIdentifier);
        XCTAssertNotNil(_sut.parsedData);
        XCTAssertNil(_sut.timestamp);
        XCTAssertNil(_sut.userData);
        XCTAssertTrue(_sut.isNew == NO);
        
        //Mutable state
        XCTAssertNotNil(_sut.comments);
        XCTAssertNotNil(_sut.categoryId);
        XCTAssertNotNil(_sut.date);
        XCTAssertNotNil(_sut.tags);
        XCTAssertNotNil(_sut.text);
        XCTAssertNotNil(_sut.isRead);
        
        
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

-(void)testRefreshOnObjectWithNilCompletion {
    
    [MNFNetworkProtocolForTesting setResponseData:[self transactionResponse]];
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [_sut refreshWithCompletion:nil];
    
    [GCDUtils dispatchAfterTime:0.1 completion:^{
        
        XCTAssertNotNil(_sut.identifier);
        XCTAssertNotNil(_sut.accountId);
        XCTAssertNotNil(_sut.amount);
        XCTAssertNil(_sut.amountInCurrency);
        XCTAssertNil(_sut.balance);
        XCTAssertNotNil(_sut.bankId);
        XCTAssertNil(_sut.categoryChangedTime);
        XCTAssertNil(_sut.changedByRule);
        XCTAssertNil(_sut.changedByRuleTime);
        XCTAssertNil(_sut.counterpartyAccountIdentifier);
        XCTAssertNil(_sut.currency);
        XCTAssertNotNil(_sut.data);
        XCTAssertNotNil(_sut.dataFormat);
        XCTAssertNotNil(_sut.detectedCategories);
        XCTAssertNil(_sut.dueDate);
        XCTAssertNotNil(_sut.hasUncertainCategorization);
        XCTAssertNil(_sut.hasUserClearedCategoryUncertainty);
        XCTAssertNotNil(_sut.insertTime);
        XCTAssertNil(_sut.isFlagged);
        XCTAssertNotNil(_sut.isMerchant);
        XCTAssertNil(_sut.isOwnAccountTransfer);
        XCTAssertNil(_sut.isSplitChild);
        XCTAssertNotNil(_sut.isUncleared);
        XCTAssertNil(_sut.lastModifiedTime);
        XCTAssertNotNil(_sut.mcc);
        XCTAssertNil(_sut.merchantId);
        XCTAssertNotNil(_sut.metaData);
        XCTAssertNotNil(_sut.originalAmount);
        XCTAssertNotNil(_sut.originalDate);
        XCTAssertNotNil(_sut.originalText);
        XCTAssertNotNil(_sut.parentIdentifier);
        XCTAssertNotNil(_sut.parsedData);
        XCTAssertNil(_sut.timestamp);
        XCTAssertNil(_sut.userData);
        XCTAssertTrue(_sut.isNew == NO);
        
        //Mutable state
        XCTAssertNotNil(_sut.comments);
        XCTAssertNotNil(_sut.categoryId);
        XCTAssertNotNil(_sut.date);
        XCTAssertNotNil(_sut.tags);
        XCTAssertNotNil(_sut.text);
        XCTAssertNotNil(_sut.isRead);
        
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
    
}

-(void)testDeleteOnObjectWithNilCompletion {
    
    [MNFNetworkProtocolForTesting setResponseData:[self transactionEmptyResponse]];
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [_sut deleteTransactionWithCompletion:nil];
    
    [GCDUtils dispatchAfterTime:0.1 completion:^{
        XCTAssertTrue(_sut.isDeleted == YES);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
    
}

-(void)testSaveAPICallReturnsErrorOnDeletedObject {

    [MNFNetworkProtocolForTesting setResponseData:[self transactionResponse]];
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
        
    MNFJob *job = [_sut deleteTransactionWithCompletion:^(NSError * _Nullable error) {
        if (error == nil) {
            [_sut saveWithCompletion:^(NSError * _Nullable error) {
                XCTAssertNotNil(error);
                [expectation fulfill];
            }];
        }
        else {
            XCTFail();
            [expectation fulfill];
        }
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];

    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

-(void)testRefreshAPICallReturnsErrorOnDeletedObject{
    
    [MNFNetworkProtocolForTesting setResponseData:[self transactionEmptyResponse]];
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [_sut deleteTransactionWithCompletion:^(NSError * _Nullable error) {
        if (error == nil) {
            [_sut refreshWithCompletion:^(NSError * _Nullable error) {
                XCTAssertNotNil(error);
                [expectation fulfill];
            }];
        }
    }];
    
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

-(void)testCreateTransactionReturnsObject {
    
    [MNFNetworkProtocolForTesting setResponseData:[self transactionResponse]];
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFJob *job = [MNFTransaction createTransactionWithDate:[NSDate date] text:@"text" amount:@10 categoryId:@10 setAsRead:@YES completion:^(MNFTransaction * _Nullable result, NSError * _Nullable error) {
        
        XCTAssertNotNil(result.identifier);
        XCTAssertNotNil(result.accountId);
        XCTAssertNotNil(result.amount);
        XCTAssertNil(result.amountInCurrency);
        XCTAssertNil(result.balance);
        XCTAssertNotNil(result.bankId);
        XCTAssertNil(result.categoryChangedTime);
        XCTAssertNil(result.changedByRule);
        XCTAssertNil(result.changedByRuleTime);
        XCTAssertNil(result.counterpartyAccountIdentifier);
        XCTAssertNil(result.currency);
        XCTAssertNotNil(result.data);
        XCTAssertNotNil(result.dataFormat);
        XCTAssertNotNil(result.detectedCategories);
        XCTAssertNil(result.dueDate);
        XCTAssertNotNil(result.hasUncertainCategorization);
        XCTAssertNil(result.hasUserClearedCategoryUncertainty);
        XCTAssertNotNil(result.insertTime);
        XCTAssertNil(result.isFlagged);
        XCTAssertNotNil(result.isMerchant);
        XCTAssertNil(result.isOwnAccountTransfer);
        XCTAssertNil(result.isSplitChild);
        XCTAssertNotNil(result.isUncleared);
        XCTAssertNil(result.lastModifiedTime);
        XCTAssertNotNil(result.mcc);
        XCTAssertNil(result.merchantId);
        XCTAssertNotNil(result.metaData);
        XCTAssertNotNil(result.originalAmount);
        XCTAssertNotNil(result.originalDate);
        XCTAssertNotNil(result.originalText);
        XCTAssertNotNil(result.parentIdentifier);
        XCTAssertNotNil(result.parsedData);
        XCTAssertNil(result.timestamp);
        XCTAssertNil(result.userData);
        XCTAssertTrue(result.isNew == NO);
        
        //Mutable state
        XCTAssertNotNil(result.categoryId);
        XCTAssertNotNil(result.comments);
        XCTAssertNotNil(result.date);
        XCTAssertNotNil(result.tags);
        XCTAssertNotNil(result.text);
        XCTAssertNotNil(result.isRead);
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

-(void)testRecategorization {
    
    [MNFNetworkProtocolForTesting setResponseData:[self transactionEmptyResponse]];
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFJob *job = [MNFTransaction recategorizeWithTexts:@[@"test",@"test2"] unreadOnly:YES useSubText:YES markAsRead:YES categoryId:@10 completion:^(NSError * _Nullable error) {
        XCTAssertNil(error);
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

-(void)testPostComment {
    [MNFNetworkProtocolForTesting setResponseData:[self transactionCommentResponse]];
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFJob *job = [_sut postComment:@"testing" withCompletion:^(NSError * _Nullable error) {
        
        XCTAssertNil(error);
        XCTAssertNotNil(_sut.comments);
        XCTAssertFalse(_sut.comments.count == 0);
        
        MNFComment *comment = [_sut.comments firstObject];
        XCTAssertNotNil(comment.identifier);
        XCTAssertNotNil(comment.personId);
        XCTAssertNotNil(comment.comment);
        XCTAssertNotNil(comment.createdDate);
        XCTAssertNil(comment.modifiedDate);
        XCTAssertEqualObjects(comment.comment, @"testing");
        XCTAssertTrue(comment.isNew == NO);
        
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

-(void)testPostCommentNilCompletionHandler {
    
    [MNFNetworkProtocolForTesting setResponseData:[self transactionCommentResponse]];
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [_sut postComment:@"testing" withCompletion:nil];
    
    [GCDUtils dispatchAfterTime:0.1 completion:^{
        
        XCTAssertNotNil(_sut.comments);
        XCTAssertFalse(_sut.comments.count == 0);
        
        MNFComment *comment = [_sut.comments firstObject];
        XCTAssertNotNil(comment.identifier);
        XCTAssertNotNil(comment.personId);
        XCTAssertNotNil(comment.comment);
        XCTAssertNotNil(comment.createdDate);
        XCTAssertNil(comment.modifiedDate);
        XCTAssertEqualObjects(comment.comment, @"testing");
        XCTAssertTrue(comment.isNew == NO);
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
    
}

#pragma mark - helpers

-(NSData*)transactionResponse{
    return [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"transactionResponse" ofType:@"json"]];
}

-(NSData*)transactionsResponse {
    return [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"transactionsResponse" ofType:@"json"]];
}

-(NSData*)transactionSplitResponse {
    return [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"transactionSplitResponse" ofType:@"json"]];
}

-(NSData*)transactionEmptyResponse {
    return [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"emptyResponse" ofType:@"json"]];
}

-(NSData*)transactionCommentResponse {
    return [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"commentResponse" ofType:@"json"]];
}


@end
