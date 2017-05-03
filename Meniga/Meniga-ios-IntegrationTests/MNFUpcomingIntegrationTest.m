//
//  MNFUpcomingIntegrationTest.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 03/10/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNFIntegrationTestSetup.h"
#import "MNFUpcoming.h"
#import "Meniga.h"
#import "MNFUpcomingComment.h"
#import "MNFUpcomingPattern.h"
#import "MNFUpcomingRecurringPattern.h"

@interface MNFUpcomingIntegrationTest : MNFIntegrationTestSetup

@end

@implementation MNFUpcomingIntegrationTest

- (void)setUp {
    [super setUp];
    [Meniga setLogLevel:kMNFLogLevelDebug];
}

- (void)tearDown {
    [super tearDown];
}

-(void)testFetchMultipleUpcoming {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFJob *job = [MNFUpcoming createUpcomingWithText:@"Upcoming test" amountInCurrency:@100 currencyCode:@"GBP" date:[NSDate date] accountId:nil categoryId:nil isFlagged:nil isWatched:nil recurringPattern:nil completion:^(NSArray<MNFUpcoming *> * _Nullable upcomings, NSError * _Nullable error) {
        
        XCTAssertNotNil(upcomings);
        XCTAssertNil(error);
        
        MNFJob *secondJob = [MNFUpcoming fetchUpcomingFromDate:[NSDate date] toDate:[NSDate dateWithTimeIntervalSinceNow:10*24*60*60] completion:^(NSArray<MNFUpcoming *> * _Nullable upcomings, NSError * _Nullable error) {
            XCTAssertNil(error);
            XCTAssertNotNil(upcomings);
            [expectation fulfill];
        }];
        
        [secondJob handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
            XCTAssertNil(error);
        }];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:kMNFIntegrationTestWaitTime handler:nil];
}

-(void)testFetchSingleUpcoming {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFJob *job = [MNFUpcoming createUpcomingWithText:@"Upcoming test" amountInCurrency:@100 currencyCode:@"GBP" date:[NSDate date] accountId:nil categoryId:nil isFlagged:nil isWatched:nil recurringPattern:nil completion:^(NSArray<MNFUpcoming *> * _Nullable upcomings, NSError * _Nullable error) {
        
        XCTAssertNotNil(upcomings);
        XCTAssertNil(error);
        
        MNFJob *secondJob = [MNFUpcoming fetchUpcomingWithId:[upcomings firstObject].identifier completion:^(MNFUpcoming * _Nullable upcoming, NSError * _Nullable error) {
            XCTAssertNil(error);
            XCTAssertNotNil(upcoming);
            [expectation fulfill];
        }];
        
        [secondJob handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
            XCTAssertNil(error);
        }];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:kMNFIntegrationTestWaitTime handler:nil];
}

-(void)testDeleteUpcoming {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFJob *job = [MNFUpcoming createUpcomingWithText:@"Upcoming test" amountInCurrency:@100 currencyCode:@"GBP" date:[NSDate date] accountId:nil categoryId:nil isFlagged:nil isWatched:nil recurringPattern:nil completion:^(NSArray<MNFUpcoming *> * _Nullable upcomings, NSError * _Nullable error) {
        
        XCTAssertNotNil(upcomings);
        XCTAssertNil(error);
        
        MNFJob *secondJob = [[upcomings firstObject] deleteUpcomingWithCompletion:^(NSError * _Nullable error) {
            XCTAssertNil(error);
            XCTAssertTrue([upcomings firstObject].isDeleted);
            [expectation fulfill];
        }];
        
        [secondJob handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
            XCTAssertNil(error);
        }];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:kMNFIntegrationTestWaitTime handler:nil];
}

-(void)testSaveUpcoming {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFJob *job = [MNFUpcoming createUpcomingWithText:@"Upcoming test" amountInCurrency:@100 currencyCode:@"GBP" date:[NSDate date] accountId:nil categoryId:nil isFlagged:nil isWatched:nil recurringPattern:nil completion:^(NSArray<MNFUpcoming *> * _Nullable upcomings, NSError * _Nullable error) {
        
        XCTAssertNotNil(upcomings);
        XCTAssertNil(error);
        
        MNFUpcoming *upcoming = [upcomings firstObject];
        upcoming.text = @"New text";
        XCTAssertTrue(upcoming.isDirty);
        
        MNFJob *secondJob = [upcoming saveAllInSeries:NO withCompletion:^(NSError * _Nullable error) {
            XCTAssertNil(error);
            XCTAssertTrue(!upcoming.isDirty);
            XCTAssertEqualObjects(upcoming.text, @"New text");
            [expectation fulfill];
        }];
        
        [secondJob handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
            XCTAssertNil(error);
        }];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:kMNFIntegrationTestWaitTime handler:nil];
}

-(void)testPostComment {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFJob *job = [MNFUpcoming createUpcomingWithText:@"Upcoming test" amountInCurrency:@100 currencyCode:@"GBP" date:[NSDate date] accountId:nil categoryId:nil isFlagged:nil isWatched:nil recurringPattern:nil completion:^(NSArray<MNFUpcoming *> * _Nullable upcomings, NSError * _Nullable error) {
        
        XCTAssertNotNil(upcomings);
        XCTAssertNil(error);
        
        MNFUpcoming *upcoming = [upcomings firstObject];
        upcoming.text = @"New text";
        XCTAssertTrue(upcoming.isDirty);
        
        MNFJob *secondJob = [upcoming postComment:@"Upcoming comment" withCompletion:^(NSError * _Nullable error) {
            XCTAssertNil(error);
            XCTAssertTrue(upcoming.comments.count > 0);
            MNFUpcomingComment *comment = [upcoming.comments firstObject];
            XCTAssertEqualObjects(comment.comment, @"Upcoming comment");
            [expectation fulfill];
        }];
        
        [secondJob handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
            XCTAssertNil(error);
        }];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:kMNFIntegrationTestWaitTime handler:nil];
}

-(void)testDefaultAccountIds {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [MNFAccount fetchAccountsWithCompletion:^(NSArray<MNFAccount *> * _Nullable accounts, NSError * _Nullable error) {
        MNFJob *job = [MNFUpcoming setDefaultAccountId:[accounts firstObject].identifier withCompletion:^(NSError * _Nullable error) {
            XCTAssertNil(error);
            MNFJob *secondJob = [MNFUpcoming fetchDefaultAccountIdWithCompletion:^(NSNumber * _Nullable accountId, NSError * _Nullable error) {
                XCTAssertNil(error);
                XCTAssertEqualObjects([accounts firstObject].identifier, accountId);
                [expectation fulfill];
            }];
            
            [secondJob handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
                XCTAssertNil(error);
            }];
        }];
        
        [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
            XCTAssertNil(error);
        }];
    }];
    
    [self waitForExpectationsWithTimeout:kMNFIntegrationTestWaitTime handler:nil];
}

-(void)testIncludedAccountIds {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [MNFAccount fetchAccountsWithCompletion:^(NSArray<MNFAccount *> * _Nullable accounts, NSError * _Nullable error) {
        MNFJob *job = [MNFUpcoming setIncludedAccountIds:[NSString stringWithFormat:@"%@",[accounts firstObject].identifier] withCompletion:^(NSError * _Nullable error) {
            XCTAssertNil(error);
            MNFJob *secondJob = [MNFUpcoming fetchIncludedAccountIdsWithCompletion:^(NSArray<NSNumber *> * _Nullable accountIds, NSError * _Nullable error) {
                XCTAssertNil(error);
                XCTAssertNotNil(accountIds);
                XCTAssertTrue(accountIds.count > 0);
                XCTAssertEqualObjects([accounts firstObject].identifier, [accountIds firstObject]);
                [expectation fulfill];
            }];
            
            [secondJob handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
                XCTAssertNil(error);
            }];
        }];
        
        [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
            XCTAssertNil(error);
        }];
    }];
    
    [self waitForExpectationsWithTimeout:kMNFIntegrationTestWaitTime handler:nil];
}

//Server bug, create does not return an object.
//-(void)testRecurringPatterns {
//    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    
//    MNFUpcomingPattern *pattern = [[MNFUpcomingPattern alloc] init];
//    pattern.dayOfMonth = @"1";
//    pattern.month = @"1";
//    pattern.dayOfWeek = @"Sunday";
//    
//    MNFUpcomingRecurringPattern *recurrPattern = [[MNFUpcomingRecurringPattern alloc] init];
//    recurrPattern.repeatUntil = [NSDate dateWithTimeIntervalSinceNow:60*24*60*60];
//    recurrPattern.pattern = pattern;
//    
//    [MNFUpcoming createUpcomingWithText:@"Upcoming text" amountInCurrency:@100 currencyCode:@"GBP" date:[NSDate date] accountId:nil categoryId:nil isFlagged:nil isWatched:nil recurringPattern:recurrPattern completion:^(NSArray<MNFUpcoming *> * _Nullable upcomings, NSError * _Nullable error) {
//        MNFJob *job = [MNFUpcomingRecurringPattern fetchWithId:[upcomings firstObject].recurringPattern.identifier completion:^(MNFUpcomingRecurringPattern * _Nullable recurringPattern, NSError * _Nullable error) {
//            XCTAssertNil(error);
//            XCTAssertNotNil(recurringPattern);
//            MNFJob *secondJob = [recurringPattern deleteRecurringPatternWithCompletion:^(NSError * _Nullable error) {
//                XCTAssertNil(error);
//                [expectation fulfill];
//            }];
//            
//            [secondJob handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
//                XCTAssertNil(error);
//            }];
//        }];
//        
//        [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
//            XCTAssertNil(error);
//        }];
//    }];
//    
//    [self waitForExpectationsWithTimeout:kMNFIntegrationTestWaitTime handler:nil];
//}

@end