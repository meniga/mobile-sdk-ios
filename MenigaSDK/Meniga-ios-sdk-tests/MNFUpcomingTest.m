//
//  MNFUpcomingTest.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 03/10/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Meniga.h"
#import "MNFUpcoming.h"
#import "MNFNetwork.h"
#import "MNFNetworkProtocolForTesting.h"
#import "MNFUpcomingRecurringPattern.h"
#import "MNFUpcomingPattern.h"
#import "MNFUpcomingComment.h"
#import "MNFUpcomingBalance.h"
#import "MNFUpcomingBalanceDate.h"
#import "MNFUpcomingThreshold.h"
#import "MNFJsonAdapter.h"

@interface MNFUpcomingTest : XCTestCase

@end

@implementation MNFUpcomingTest {
    MNFUpcoming *_sut;
}

- (void)setUp {
    [super setUp];
    [MNFNetwork initializeForTesting];
    [Meniga setLogLevel:kMNFLogLevelDebug];
    
    NSDictionary *accountResponse = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"upcomingResponse" ofType:@"json"]] options:0 error:nil];
    NSDictionary *accountData = [accountResponse objectForKey:@"data"];
    
    _sut = [MNFJsonAdapter objectOfClass:[MNFUpcoming class] jsonDict:accountData option:kMNFAdapterOptionNoOption error:nil];
}

- (void)tearDown {
    [MNFNetwork flushForTesting];
    [super tearDown];
}

-(void)testFetchMultipleUpcoming {
    [MNFNetworkProtocolForTesting setResponseData:[self multipleUpcomingResponse]];
    
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [MNFUpcoming fetchUpcomingFromDate:[NSDate date] toDate:[NSDate dateWithTimeIntervalSinceNow:10*24*60*60] completion:^(NSArray<MNFUpcoming *> * _Nullable upcomings, NSError * _Nullable error) {
        
        XCTAssertNil(error);
        XCTAssertNotNil(upcomings);
        XCTAssertTrue(upcomings.count > 0);
        MNFUpcoming *upcoming = [upcomings firstObject];
        XCTAssertNotNil(upcoming.identifier);
        XCTAssertNil(upcoming.bankReference);
        XCTAssertNotNil(upcoming.text);
        XCTAssertNotNil(upcoming.amount);
        XCTAssertNotNil(upcoming.amountInCurrency);
        XCTAssertNotNil(upcoming.currencyCode);
        XCTAssertNotNil(upcoming.date);
        XCTAssertNotNil(upcoming.paymentStatus);
        XCTAssertNotNil(upcoming.isFlagged);
        XCTAssertNotNil(upcoming.isWatched);
        XCTAssertNotNil(upcoming.accountId);
        XCTAssertNil(upcoming.transactionId);
        XCTAssertNil(upcoming.invoiceId);
        XCTAssertNil(upcoming.scheduledPaymentId);
        XCTAssertNotNil(upcoming.categoryId);
        XCTAssertNotNil(upcoming.recurringPattern);
        XCTAssertNotNil(upcoming.comments);
        XCTAssertNotNil(upcoming.reconcileScores);
        XCTAssertNil(upcoming.details);
        
        MNFUpcomingRecurringPattern *recurringPattern = upcoming.recurringPattern;
        XCTAssertNotNil(recurringPattern.identifier);
        XCTAssertNotNil(recurringPattern.text);
        XCTAssertNotNil(recurringPattern.amountInCurrency);
        XCTAssertNotNil(recurringPattern.currencyCode);
        XCTAssertNotNil(recurringPattern.categoryId);
        XCTAssertNotNil(recurringPattern.accountId);
        XCTAssertNotNil(recurringPattern.pattern);
        XCTAssertNotNil(recurringPattern.repeatUntil);
        XCTAssertNotNil(recurringPattern.isWatched);
        XCTAssertNotNil(recurringPattern.isFlagged);
        XCTAssertNotNil(recurringPattern.type);
        XCTAssertNotNil(recurringPattern.status);
        
        MNFUpcomingPattern *pattern = recurringPattern.pattern;
        XCTAssertNil(pattern.dayOfMonth);
        XCTAssertNil(pattern.dayOfMonthInterval);
        XCTAssertNil(pattern.month);
        XCTAssertNil(pattern.monthInterval);
        XCTAssertNil(pattern.dayOfWeek);
        XCTAssertNil(pattern.dayOfWeekInterval);
        XCTAssertNil(pattern.weekOfYear);
        XCTAssertNil(pattern.weekInterval);
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

-(void)testFetchUpcomingWithId {
    [MNFNetworkProtocolForTesting setResponseData:[self singleUpcomingResponse]];
    
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [MNFUpcoming fetchUpcomingWithId:@1594 completion:^(MNFUpcoming * _Nullable upcoming, NSError * _Nullable error) {
        
        XCTAssertNil(error);
        XCTAssertNotNil(upcoming);
        XCTAssertNotNil(upcoming.identifier);
        XCTAssertNil(upcoming.bankReference);
        XCTAssertNotNil(upcoming.text);
        XCTAssertNotNil(upcoming.amount);
        XCTAssertNotNil(upcoming.amountInCurrency);
        XCTAssertNotNil(upcoming.currencyCode);
        XCTAssertNotNil(upcoming.date);
        XCTAssertNotNil(upcoming.paymentStatus);
        XCTAssertNotNil(upcoming.isFlagged);
        XCTAssertNotNil(upcoming.isWatched);
        XCTAssertNotNil(upcoming.accountId);
        XCTAssertNil(upcoming.transactionId);
        XCTAssertNil(upcoming.invoiceId);
        XCTAssertNil(upcoming.scheduledPaymentId);
        XCTAssertNotNil(upcoming.categoryId);
        XCTAssertNotNil(upcoming.recurringPattern);
        XCTAssertNotNil(upcoming.comments);
        XCTAssertNotNil(upcoming.reconcileScores);
        XCTAssertNil(upcoming.details);
        
        MNFUpcomingRecurringPattern *recurringPattern = upcoming.recurringPattern;
        XCTAssertNotNil(recurringPattern.identifier);
        XCTAssertNotNil(recurringPattern.text);
        XCTAssertNotNil(recurringPattern.amountInCurrency);
        XCTAssertNotNil(recurringPattern.currencyCode);
        XCTAssertNotNil(recurringPattern.categoryId);
        XCTAssertNotNil(recurringPattern.accountId);
        XCTAssertNotNil(recurringPattern.pattern);
        XCTAssertNotNil(recurringPattern.repeatUntil);
        XCTAssertNotNil(recurringPattern.isWatched);
        XCTAssertNotNil(recurringPattern.isFlagged);
        XCTAssertNotNil(recurringPattern.type);
        XCTAssertNotNil(recurringPattern.status);
        
        MNFUpcomingPattern *pattern = recurringPattern.pattern;
        XCTAssertNil(pattern.dayOfMonth);
        XCTAssertNil(pattern.dayOfMonthInterval);
        XCTAssertNil(pattern.month);
        XCTAssertNil(pattern.monthInterval);
        XCTAssertNil(pattern.dayOfWeek);
        XCTAssertNil(pattern.dayOfWeekInterval);
        XCTAssertNil(pattern.weekOfYear);
        XCTAssertNil(pattern.weekInterval);
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

-(void)testCreateUpcoming {
    [MNFNetworkProtocolForTesting setResponseData:[self multipleUpcomingResponse]];
    
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [MNFUpcoming createUpcomingWithText:@"Upcoming 1" amountInCurrency:@100 currencyCode:@"ISK" date:[NSDate date] accountId:@1355 categoryId:@81 isFlagged:@NO isWatched:@NO recurringPattern:nil completion:^(NSArray<MNFUpcoming *> * _Nullable upcomings, NSError * _Nullable error) {
        
        XCTAssertNil(error);
        XCTAssertNotNil(upcomings);
        XCTAssertTrue(upcomings.count > 0);
        MNFUpcoming *upcoming = [upcomings firstObject];
        XCTAssertNotNil(upcoming.identifier);
        XCTAssertNil(upcoming.bankReference);
        XCTAssertNotNil(upcoming.text);
        XCTAssertNotNil(upcoming.amount);
        XCTAssertNotNil(upcoming.amountInCurrency);
        XCTAssertNotNil(upcoming.currencyCode);
        XCTAssertNotNil(upcoming.date);
        XCTAssertNotNil(upcoming.paymentStatus);
        XCTAssertNotNil(upcoming.isFlagged);
        XCTAssertNotNil(upcoming.isWatched);
        XCTAssertNotNil(upcoming.accountId);
        XCTAssertNil(upcoming.transactionId);
        XCTAssertNil(upcoming.invoiceId);
        XCTAssertNil(upcoming.scheduledPaymentId);
        XCTAssertNotNil(upcoming.categoryId);
        XCTAssertNotNil(upcoming.recurringPattern);
        XCTAssertNotNil(upcoming.comments);
        XCTAssertNotNil(upcoming.reconcileScores);
        XCTAssertNil(upcoming.details);
        
        MNFUpcomingRecurringPattern *recurringPattern = upcoming.recurringPattern;
        XCTAssertNotNil(recurringPattern.identifier);
        XCTAssertNotNil(recurringPattern.text);
        XCTAssertNotNil(recurringPattern.amountInCurrency);
        XCTAssertNotNil(recurringPattern.currencyCode);
        XCTAssertNotNil(recurringPattern.categoryId);
        XCTAssertNotNil(recurringPattern.accountId);
        XCTAssertNotNil(recurringPattern.pattern);
        XCTAssertNotNil(recurringPattern.repeatUntil);
        XCTAssertNotNil(recurringPattern.isWatched);
        XCTAssertNotNil(recurringPattern.isFlagged);
        XCTAssertNotNil(recurringPattern.type);
        XCTAssertNotNil(recurringPattern.status);
        
        MNFUpcomingPattern *pattern = recurringPattern.pattern;
        XCTAssertNil(pattern.dayOfMonth);
        XCTAssertNil(pattern.dayOfMonthInterval);
        XCTAssertNil(pattern.month);
        XCTAssertNil(pattern.monthInterval);
        XCTAssertNil(pattern.dayOfWeek);
        XCTAssertNil(pattern.dayOfWeekInterval);
        XCTAssertNil(pattern.weekOfYear);
        XCTAssertNil(pattern.weekInterval);
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

-(void)testDeleteUpcoming {
    [MNFNetworkProtocolForTesting setResponseData:[self singleUpcomingResponse]];
    
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [MNFUpcoming fetchUpcomingWithId:@1594 completion:^(MNFUpcoming * _Nullable upcoming, NSError * _Nullable error) {
        
        [upcoming deleteUpcomingWithCompletion:^(NSError * _Nullable error) {
            XCTAssertNil(error);
            XCTAssertTrue(upcoming.isDeleted);
            [expectation fulfill];
        }];
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

-(void)testSaveUpcoming {
    [MNFNetworkProtocolForTesting setResponseData:[self singleUpcomingResponse]];
    
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [MNFUpcoming fetchUpcomingWithId:@1594 completion:^(MNFUpcoming * _Nullable upcoming, NSError * _Nullable error) {
        
        upcoming.text = @"New text";
        XCTAssertTrue(upcoming.isDirty);
        [upcoming saveAllInSeries:NO withCompletion:^(NSError * _Nullable error) {
            XCTAssertNil(error);
            XCTAssertTrue([upcoming.text isEqualToString:@"New text"]);
            XCTAssertTrue(!upcoming.isDirty);
            [expectation fulfill];
        }];
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

-(void)testPostUpcomingComment {
    [MNFNetworkProtocolForTesting setResponseData:[self upcomingCommentResponse]];
    
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    XCTAssertTrue(_sut.comments.count == 0);
    [_sut postComment:@"Upcoming comment" withCompletion:^(NSError * _Nullable error) {
        
        XCTAssertNil(error);
        XCTAssertTrue(_sut.comments.count > 0);
        MNFUpcomingComment *comment = [_sut.comments firstObject];
        XCTAssertNotNil(comment.identifier);
        XCTAssertNotNil(comment.created);
        XCTAssertNil(comment.modified);
        XCTAssertNotNil(comment.comment);
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

-(void)testFetchDefaultAccountId {
    [MNFNetworkProtocolForTesting setResponseData:[self upcomingDefaultAccountResponse]];
    
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [MNFUpcoming fetchDefaultAccountIdWithCompletion:^(NSNumber * _Nullable accountId, NSError * _Nullable error) {
        XCTAssertNil(error);
        XCTAssertNotNil(accountId);
        XCTAssertEqualObjects(accountId, @1355);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

-(void)testSetDefaultAccountId {
    [MNFNetworkProtocolForTesting setResponseData:[self emptyResponse]];
    
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [MNFUpcoming setDefaultAccountId:@1355 withCompletion:^(NSError * _Nullable error) {
        XCTAssertNil(error);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

-(void)testFetchIncludedAccountIds {
    [MNFNetworkProtocolForTesting setResponseData:[self upcomingIncludedAccountsResponse]];
    
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [MNFUpcoming fetchIncludedAccountIdsWithCompletion:^(NSArray<NSNumber *> * _Nullable accountIds, NSError * _Nullable error) {
        XCTAssertNil(error);
        XCTAssertNotNil(accountIds);
        XCTAssertTrue(accountIds.count > 0);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

-(void)testSetIncludedAccountIds {
    [MNFNetworkProtocolForTesting setResponseData:[self upcomingSetIncludedAccountsResponse]];
    
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [MNFUpcoming setIncludedAccountIds:@"1355" withCompletion:^(NSError * _Nullable error) {
        XCTAssertNil(error);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

-(void)testFetchRecurringPatterns {
    [MNFNetworkProtocolForTesting setResponseData:[self upcomingRecurringPatternsResponse]];
    
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [MNFUpcomingRecurringPattern fetchRecurringPatternsWithStatuses:nil types:nil completion:^(NSArray<MNFUpcomingRecurringPattern *> * _Nullable recurringPatterns, NSError * _Nullable error) {
        
        XCTAssertNil(error);
        XCTAssertNotNil(recurringPatterns);
        XCTAssertTrue(recurringPatterns.count > 0);
        MNFUpcomingRecurringPattern *recurringPattern = [recurringPatterns firstObject];
        XCTAssertNotNil(recurringPattern.identifier);
        XCTAssertNotNil(recurringPattern.text);
        XCTAssertNotNil(recurringPattern.amountInCurrency);
        XCTAssertNotNil(recurringPattern.currencyCode);
        XCTAssertNotNil(recurringPattern.categoryId);
        XCTAssertNotNil(recurringPattern.accountId);
        XCTAssertNotNil(recurringPattern.pattern);
        XCTAssertNotNil(recurringPattern.repeatUntil);
        XCTAssertNotNil(recurringPattern.isWatched);
        XCTAssertNotNil(recurringPattern.isFlagged);
        XCTAssertNotNil(recurringPattern.type);
        XCTAssertNotNil(recurringPattern.status);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

-(void)testFetchRecurringPatternWithId {
    [MNFNetworkProtocolForTesting setResponseData:[self upcomingRecurringPatternResponse]];
    
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [MNFUpcomingRecurringPattern fetchWithId:@46 completion:^(MNFUpcomingRecurringPattern * _Nullable recurringPattern, NSError * _Nullable error) {
        XCTAssertNil(error);
        XCTAssertNotNil(recurringPattern);
        XCTAssertNotNil(recurringPattern.identifier);
        XCTAssertNotNil(recurringPattern.text);
        XCTAssertNotNil(recurringPattern.amountInCurrency);
        XCTAssertNotNil(recurringPattern.currencyCode);
        XCTAssertNotNil(recurringPattern.categoryId);
        XCTAssertNotNil(recurringPattern.accountId);
        XCTAssertNotNil(recurringPattern.pattern);
        XCTAssertNotNil(recurringPattern.repeatUntil);
        XCTAssertNotNil(recurringPattern.isWatched);
        XCTAssertNotNil(recurringPattern.isFlagged);
        XCTAssertNotNil(recurringPattern.type);
        XCTAssertNotNil(recurringPattern.status);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

-(void)testDeleteRecurringPattern {
    
    [MNFNetworkProtocolForTesting setResponseData:[self upcomingRecurringPatternResponse]];
    
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [MNFUpcomingRecurringPattern fetchWithId:@46 completion:^(MNFUpcomingRecurringPattern * _Nullable recurringPattern, NSError * _Nullable error) {
        
        [recurringPattern deleteRecurringPatternWithCompletion:^(NSError * _Nullable error) {
            
            XCTAssertNil(error);
            XCTAssertTrue(recurringPattern.isDeleted);
            [expectation fulfill];
        }];
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

-(void)testFetchUpcomingBalance {
    [MNFNetworkProtocolForTesting setResponseData:[self upcomingBalanceResponse]];
    
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [MNFUpcomingBalance fetchBalancesWithDateTo:[NSDate dateWithTimeIntervalSinceNow:30*24*60*60] includeOverdueFromDate:nil accountIds:@"1355" includeUnlinked:NO useAvailableAmount:NO completion:^(MNFUpcomingBalance * _Nullable balance, NSError * _Nullable error) {
        
        XCTAssertNil(error);
        XCTAssertNotNil(balance);
        XCTAssertNotNil(balance.startBalance);
        XCTAssertNotNil(balance.endBalance);
        XCTAssertNotNil(balance.todaysTransactionsAmount);
        XCTAssertNotNil(balance.currency);
        XCTAssertNotNil(balance.balanceDates);
        XCTAssertTrue(balance.balanceDates.count > 0);
        
        MNFUpcomingBalanceDate *balanceDate = [balance.balanceDates firstObject];
        XCTAssertNotNil(balanceDate.date);
        XCTAssertNotNil(balanceDate.endOfDayBalance);
        XCTAssertNotNil(balanceDate.income);
        XCTAssertNotNil(balanceDate.expenses);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

-(void)testFetchUpcomingThresholds {
    [MNFNetworkProtocolForTesting setResponseData:[self upcomingThresholdsResponse]];
    
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [MNFUpcomingThreshold fetchThresholdsWithAccountIds:nil completion:^(NSArray<MNFUpcomingThreshold *> * _Nullable thresholds, NSError * _Nullable error) {
        
        XCTAssertNil(error);
        XCTAssertNotNil(thresholds);
        XCTAssertTrue(thresholds.count > 0);
        MNFUpcomingThreshold *threshold = [thresholds firstObject];
        XCTAssertNotNil(threshold.identifier);
        XCTAssertNotNil(threshold.value);
        XCTAssertNotNil(threshold.isUpperLimit);
        XCTAssertNotNil(threshold.accountSetId);
        XCTAssertNotNil(threshold.accountIds);
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

-(void)testFetchUpcomingThresholdWithId {
    [MNFNetworkProtocolForTesting setResponseData:[self upcomingThresholdResponse]];
    
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [MNFUpcomingThreshold fetchWithId:@13 completion:^(MNFUpcomingThreshold * _Nullable threshold, NSError * _Nullable error) {
        
        XCTAssertNotNil(threshold.identifier);
        XCTAssertNotNil(threshold.value);
        XCTAssertNotNil(threshold.isUpperLimit);
        XCTAssertNotNil(threshold.accountSetId);
        XCTAssertNotNil(threshold.accountIds);
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

-(void)testCreateUpcomingThreshold {
    [MNFNetworkProtocolForTesting setResponseData:[self upcomingThresholdResponse]];
    
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [MNFUpcomingThreshold createThresholdWithValue:@100 isUpperLimit:@YES accountIds:@[@1355] completion:^(MNFUpcomingThreshold * _Nullable threshold, NSError * _Nullable error) {
        
        XCTAssertNotNil(threshold.identifier);
        XCTAssertNotNil(threshold.value);
        XCTAssertNotNil(threshold.isUpperLimit);
        XCTAssertNotNil(threshold.accountSetId);
        XCTAssertNotNil(threshold.accountIds);
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

-(void)testSaveUpcomingThreshold {
    [MNFNetworkProtocolForTesting setResponseData:[self upcomingThresholdResponse]];
    
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [MNFUpcomingThreshold fetchWithId:@13 completion:^(MNFUpcomingThreshold * _Nullable threshold, NSError * _Nullable error) {
        
        threshold.value = @90;
        XCTAssertTrue(threshold.isDirty);
        [threshold saveWithCompletion:^(NSError * _Nullable error) {
            XCTAssertNil(error);
            XCTAssertTrue(!threshold.isDirty);
            [expectation fulfill];
        }];
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

-(void)testDeleteUpcomingThreshold {
    [MNFNetworkProtocolForTesting setResponseData:[self upcomingThresholdResponse]];
    
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [MNFUpcomingThreshold fetchWithId:@13 completion:^(MNFUpcomingThreshold * _Nullable threshold, NSError * _Nullable error) {
        
        [threshold deleteThresholdWithCompletion:^(NSError * _Nullable error) {
            XCTAssertNil(error);
            XCTAssertTrue(threshold.isDeleted);
            [expectation fulfill];
        }];
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

#pragma mark - data helpers
-(NSData*)multipleUpcomingResponse {
    return [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"upcomingsResponse" ofType:@"json"]];
}
-(NSData*)singleUpcomingResponse {
    return [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"upcomingResponse" ofType:@"json"]];
}
-(NSData*)upcomingCommentResponse {
    return [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"upcomingCommentResponse" ofType:@"json"]];
}
-(NSData*)upcomingDefaultAccountResponse {
    return [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"upcomingDefaultAccountResponse" ofType:@"json"]];
}
-(NSData*)upcomingIncludedAccountsResponse {
    return [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"upcomingIncludedAccountsResponse" ofType:@"json"]];
}
-(NSData*)upcomingSetIncludedAccountsResponse {
    return [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"upcomingSetIncludedAccountsResponse" ofType:@"json"]];
}
-(NSData*)emptyResponse {
    return [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"emptyResponse" ofType:@"json"]];
}
-(NSData*)upcomingRecurringPatternsResponse {
    return [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"upcomingRecurringPatternsResponse" ofType:@"json"]];
}
-(NSData*)upcomingRecurringPatternResponse {
    return [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"upcomingRecurringPatternResponse" ofType:@"json"]];
}
-(NSData*)upcomingBalanceResponse {
    return [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"upcomingBalanceResponse" ofType:@"json"]];
}
-(NSData*)upcomingThresholdResponse {
    return [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"upcomingThresholdResponse" ofType:@"json"]];
}
-(NSData*)upcomingThresholdsResponse {
    return [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"upcomingThresholdsResponse" ofType:@"json"]];
}

@end
