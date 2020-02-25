//
//  MNFTestModelObjects.m
//  Meniga-ios-sdk-tests
//
//  Created by Haukur Ísfeld on 27/03/2018.
//  Copyright © 2018 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNFInternalImports.h"
#import "MNFNetwork.h"
#import "MNFNetworkProtocolForTesting.h"
#import "MNFTestFactory.h"
#import "MNFTestUtils.h"
#import "Meniga.h"

#define kMNFTestWaitTime 10.0

@interface MNFTestModelObjects : XCTestCase

@end

@implementation MNFTestModelObjects

- (void)setUp {
    [super setUp];
    [[MNFNetwork sharedNetwork] initializeForTesting];
}

- (void)tearDown {
    [[MNFNetwork sharedNetwork] flushForTesting];
    [super tearDown];
}

#pragma mark - accounts
- (void)testAccountSerialization {
    [self performSerializationTestWithModelDefinition:@"Meniga.Core.Api.Models.AccountModel"
                               expectationDescription:NSStringFromSelector(_cmd)
                                              asArray:NO
                                                block:^(NSDictionary *model, XCTestExpectation *expectation) {
                                                    [MNFAccount fetchWithId:@1
                                                                 completion:^(MNFAccount *_Nullable account,
                                                                              NSError *_Nullable error) {
                                                                     XCTAssertTrue([MNFTestUtils
                                                                         validateApiSerialization:model
                                                                                  withModelObject:account]);
                                                                     [expectation fulfill];
                                                                 }];
                                                }];
}

- (void)testAccountTypeSerialization {
    [self performSerializationTestWithModelDefinition:@"Meniga.Core.Api.Models.AccountTypeModel"
                               expectationDescription:NSStringFromSelector(_cmd)
                                              asArray:YES
                                                block:^(NSDictionary *model, XCTestExpectation *expectation) {
                                                    [MNFAccount fetchAccountTypesWithCompletion:^(
                                                                    NSArray<MNFAccountType *>
                                                                        *_Nullable realmAccountTypes,
                                                                    NSError *_Nullable error) {
                                                        XCTAssertTrue([MNFTestUtils
                                                            validateApiSerialization:model
                                                                     withModelObject:[realmAccountTypes firstObject]]);
                                                        [expectation fulfill];
                                                    }];
                                                }];
}

- (void)testAccountCategorySerialization {
    [self
        performSerializationTestWithModelDefinition:@"Meniga.Core.Api.Models.AccountTypeCategory"
                             expectationDescription:NSStringFromSelector(_cmd)
                                            asArray:YES
                                              block:^(NSDictionary *model, XCTestExpectation *expectation) {
                                                  [MNFAccount fetchAccountCategoriesWithCompletion:^(
                                                                  NSArray<MNFAccountCategory *> *_Nullable accountTypes,
                                                                  NSError *_Nullable error) {
                                                      XCTAssertTrue([MNFTestUtils
                                                          validateApiSerialization:model
                                                                   withModelObject:[accountTypes firstObject]]);
                                                      [expectation fulfill];
                                                  }];
                                              }];
}

- (void)testAccountAuthorizationTypeSerialization {
    [self performSerializationTestWithModelDefinition:@"Meniga.Core.Api.Models.NameId"
                               expectationDescription:NSStringFromSelector(_cmd)
                                              asArray:YES
                                                block:^(NSDictionary *model, XCTestExpectation *expectation) {
                                                    [MNFAccount fetchAccountAuthorizationTypesWithCompletion:^(
                                                                    NSArray<MNFAccountAuthorizationType *>
                                                                        *_Nullable accountAuthorizationTypes,
                                                                    NSError *_Nullable error) {
                                                        XCTAssertTrue([MNFTestUtils
                                                            validateApiSerialization:model
                                                                     withModelObject:[accountAuthorizationTypes
                                                                                         firstObject]]);
                                                        [expectation fulfill];
                                                    }];
                                                }];
}

- (void)testAccountHistoryEntrySerialization {
    [self
        performSerializationTestWithModelDefinition:@"Meniga.Core.Api.Models.AccountBalanceHistory"
                             expectationDescription:NSStringFromSelector(_cmd)
                                            asArray:YES
                                              block:^(NSDictionary *model, XCTestExpectation *expectation) {
                                                  [[MNFAccount new]
                                                      fetchHistoryFromDate:[NSDate date]
                                                                    toDate:[NSDate date]
                                                                    sortBy:nil
                                                                 ascending:NO
                                                                completion:^(NSArray<MNFAccountHistoryEntry *>
                                                                                 *_Nullable accountHistoryEntries,
                                                                             NSError *_Nullable error) {
                                                                    XCTAssertTrue([MNFTestUtils
                                                                        validateApiSerialization:model
                                                                                 withModelObject:[accountHistoryEntries
                                                                                                     firstObject]]);
                                                                    [expectation fulfill];
                                                                }];
                                              }];
}

#pragma mark - authentication
- (void)testAuthenticationSerialization {
    [self performSerializationTestWithModelDefinition:@"Meniga.Core.Authentication.Api.Models.AuthenticationResponse"
                               expectationDescription:NSStringFromSelector(_cmd)
                                              asArray:NO
                                                block:^(NSDictionary *model, XCTestExpectation *expectation) {
                                                    [MNFAuthentication
                                                        authenticateWithEmail:@""
                                                                     password:@""
                                                                   completion:^(
                                                                       MNFAuthentication *_Nullable authentication,
                                                                       NSError *_Nullable error) {
                                                                       XCTAssertTrue([MNFTestUtils
                                                                           validateApiSerialization:model
                                                                                    withModelObject:authentication]);
                                                                       [expectation fulfill];
                                                                   }];
                                                }];
}

#pragma mark - budget
- (void)testBudgetSerialization {
    [self
        performSerializationTestWithModelDefinition:@"Meniga.Component.Budgets.Api.Models.Responses.BudgetHeaderMessage"
                             expectationDescription:NSStringFromSelector(_cmd)
                                            asArray:NO
                                              block:^(NSDictionary *model, XCTestExpectation *expectation) {
                                                  [MNFBudget fetchBudgetWithId:@1
                                                                        filter:nil
                                                                    completion:^(MNFBudget *_Nullable budget,
                                                                                 NSError *_Nullable error) {
                                                                        XCTAssertTrue([MNFTestUtils
                                                                            validateApiSerialization:model
                                                                                     withModelObject:budget]);
                                                                        [expectation fulfill];
                                                                    }];
                                              }];
}

#pragma mark - categories
- (void)testCategoryTypeSerialization {
    [self
        performSerializationTestWithModelDefinition:@"Meniga.Core.Api.Models.NameId"
                             expectationDescription:NSStringFromSelector(_cmd)
                                            asArray:YES
                                              block:^(NSDictionary *model, XCTestExpectation *expectation) {
                                                  [MNFCategory fetchCategoryTypesWithCompletion:^(
                                                                   NSArray<MNFCategoryType *> *_Nullable categoryTypes,
                                                                   NSError *_Nullable error) {
                                                      XCTAssertTrue([MNFTestUtils
                                                          validateApiSerialization:model
                                                                   withModelObject:[categoryTypes firstObject]]);
                                                      [expectation fulfill];
                                                  }];
                                              }];
}

#pragma mark - challenges
- (void)testChallengeSerialization {
    [self performSerializationTestWithModelDefinition:@"Meniga.Challenges.Api.Models.UserChallengeModel"
                               expectationDescription:NSStringFromSelector(_cmd)
                                              asArray:NO
                                                block:^(NSDictionary *model, XCTestExpectation *expectation) {
                                                    [MNFChallenge
                                                        fetchChallengeWithId:@1
                                                                  completion:^(MNFChallenge *_Nullable challenge,
                                                                               NSError *_Nullable error) {
                                                                      XCTAssertTrue([MNFTestUtils
                                                                          validateApiSerialization:model
                                                                                   withModelObject:challenge]);
                                                                      [expectation fulfill];
                                                                  }];
                                                }];
}

#pragma mark - feed
- (void)testFeedSerialization {
    [self performSerializationTestWithModelDefinition:@"Meniga.Core.Api.Models.Feed.FeedItemModel"
                               expectationDescription:NSStringFromSelector(_cmd)
                                              asArray:YES
                                                block:^(NSDictionary *model, XCTestExpectation *expectation) {
                                                    [MNFFeed
                                                         fetchFromDate:[NSDate date]
                                                                toDate:[NSDate date]
                                                                  skip:nil
                                                                  take:nil
                                                        withCompletion:^(MNFFeed *_Nullable feed,
                                                                         NSError *_Nullable error) {
                                                            XCTAssertTrue([MNFTestUtils
                                                                validateApiSerialization:model
                                                                         withModelObject:[feed.feedItems firstObject]]);
                                                            [expectation fulfill];
                                                        }];
                                                }];
}

#pragma mark - life goals
- (void)testLifeGoalSerialization {
    [self performSerializationTestWithModelDefinition:@"Meniga.Component.LifeGoals.Api.Models.LifeGoalModel"
                               expectationDescription:NSStringFromSelector(_cmd)
                                              asArray:NO
                                                block:^(NSDictionary *model, XCTestExpectation *expectation) {
                                                    [MNFLifeGoal fetchWithId:@1
                                                                  completion:^(MNFLifeGoal *_Nullable lifeGoal,
                                                                               NSError *_Nullable error) {
                                                                      XCTAssertTrue([MNFTestUtils
                                                                          validateApiSerialization:model
                                                                                   withModelObject:lifeGoal]);
                                                                      [expectation fulfill];
                                                                  }];
                                                }];
}

- (void)testLifeGoalHistorySerialization {
    [self
        performSerializationTestWithModelDefinition:@"Meniga.Component.LifeGoals.Api.Models.LifeGoalHistoryRecordModel"
                             expectationDescription:NSStringFromSelector(_cmd)
                                            asArray:YES
                                              block:^(NSDictionary *model, XCTestExpectation *expectation) {
                                                  [[MNFLifeGoal new]
                                                      fetchHistoryWithCompletion:^(
                                                          NSArray<MNFLifeGoalHistory *> *_Nullable lifeGoalHistory,
                                                          NSError *_Nullable error) {
                                                          XCTAssertTrue([MNFTestUtils
                                                              validateApiSerialization:model
                                                                       withModelObject:[lifeGoalHistory firstObject]]);
                                                          [expectation fulfill];
                                                      }];
                                              }];
}

- (void)testLifeGoalAccountInfoSerialization {
    [self
        performSerializationTestWithModelDefinition:@"Meniga.Component.LifeGoals.Api.Models.LifeGoalAccountModel"
                             expectationDescription:NSStringFromSelector(_cmd)
                                            asArray:YES
                                              block:^(NSDictionary *model, XCTestExpectation *expectation) {
                                                  [MNFLifeGoal
                                                      fetchLifeGoalsAccountInfoWithAccountIds:nil
                                                                                   completion:^(
                                                                                       NSArray<MNFLifeGoalAccountInfo *>
                                                                                           *_Nullable lifeGoalAccountInfo,
                                                                                       NSError *_Nullable error) {
                                                                                       XCTAssertTrue([MNFTestUtils
                                                                                           validateApiSerialization:
                                                                                               model
                                                                                                    withModelObject:
                                                                                                        [lifeGoalAccountInfo
                                                                                                            firstObject]]);
                                                                                       [expectation fulfill];
                                                                                   }];
                                              }];
}

#pragma mark - merchants
- (void)testMerchantSerialization {
    [self performSerializationTestWithModelDefinition:@"Meniga.Core.Api.Models.Merchant"
                               expectationDescription:NSStringFromSelector(_cmd)
                                              asArray:NO
                                                block:^(NSDictionary *model, XCTestExpectation *expectation) {
                                                    [MNFMerchant fetchWithId:@1
                                                                  completion:^(MNFMerchant *_Nullable merchant,
                                                                               NSError *_Nullable error) {
                                                                      XCTAssertTrue([MNFTestUtils
                                                                          validateApiSerialization:model
                                                                                   withModelObject:merchant]);
                                                                      [expectation fulfill];
                                                                  }];
                                                }];
}

#pragma mark - networth
- (void)testNetworthSerialization {
    [self performSerializationTestWithModelDefinition:@"Meniga.Core.DataContract.AccountBalanceHistoryWrapper"
                               expectationDescription:NSStringFromSelector(_cmd)
                                              asArray:NO
                                                block:^(NSDictionary *model, XCTestExpectation *expectation) {
                                                    [MNFNetworthAccount
                                                        fetchWithId:@1
                                                         completion:^(MNFNetworthAccount *_Nullable networthAccount,
                                                                      NSError *_Nullable error) {
                                                             XCTAssertTrue([MNFTestUtils
                                                                 validateApiSerialization:model
                                                                          withModelObject:networthAccount]);
                                                             [expectation fulfill];
                                                         }];
                                                }];
}

- (void)testNetworthBalanceHistorySerialization {
    [self
        performSerializationTestWithModelDefinition:@"Meniga.Core.DataContract.AccountBalanceHistory"
                             expectationDescription:NSStringFromSelector(_cmd)
                                            asArray:NO
                                              block:^(NSDictionary *model, XCTestExpectation *expectation) {
                                                  [MNFNetworthAccount
                                                      firstEntrydateWithExcludedAccounts:NO
                                                                              completion:^(
                                                                                  MNFNetworthBalanceHistory
                                                                                      *_Nullable networthBalanceHistory,
                                                                                  NSError *_Nullable error) {
                                                                                  XCTAssertTrue([MNFTestUtils
                                                                                      validateApiSerialization:model
                                                                                               withModelObject:
                                                                                                   networthBalanceHistory]);
                                                                                  [expectation fulfill];
                                                                              }];
                                              }];
}

#pragma mark - organizations
- (void)testOrganizationsSerialization {
    [self performSerializationTestWithModelDefinition:@"Meniga.Core.Api.Models.OrganizationModel"
                               expectationDescription:NSStringFromSelector(_cmd)
                                              asArray:YES
                                                block:^(NSDictionary *model, XCTestExpectation *expectation) {
                                                    [MNFOrganization
                                                        fetchOrganizationsWithNameSearch:nil
                                                                              completion:^(NSArray<MNFOrganization *>
                                                                                               *_Nullable organizations,
                                                                                           NSError *_Nullable error) {
                                                                                  XCTAssertTrue([MNFTestUtils
                                                                                      validateApiSerialization:model
                                                                                               withModelObject:
                                                                                                   [organizations
                                                                                                       firstObject]]);
                                                                                  [expectation fulfill];
                                                                              }];
                                                }];
}

#pragma mark - peer comparison
- (void)testPeerComparisonSerialization {
    [self performSerializationTestWithModelDefinition:@"Meniga.Core.Api.Models.PeerComparison.PeerComparison"
                               expectationDescription:NSStringFromSelector(_cmd)
                                              asArray:YES
                                                block:^(NSDictionary *model, XCTestExpectation *expectation) {
                                                    [MNFPeerComparison
                                                        fetchPeerComparisonWithCategoryIds:nil
                                                                               excludeUser:nil
                                                                            previousMonths:nil
                                                                           groupCategories:nil
                                                                                 segmentBy:nil
                                                                                completion:^(
                                                                                    NSArray<MNFPeerComparison *>
                                                                                        *_Nullable peerComparison,
                                                                                    NSError *_Nullable error) {
                                                                                    XCTAssertTrue([MNFTestUtils
                                                                                        validateApiSerialization:model
                                                                                                 withModelObject:
                                                                                                     [peerComparison
                                                                                                         firstObject]]);
                                                                                    [expectation fulfill];
                                                                                }];
                                                }];
}

#pragma mark - public
- (void)testPublicSerialization {
    [self performSerializationTestWithModelDefinition:@"Meniga.Core.Api.Models.PublicSettings"
                               expectationDescription:NSStringFromSelector(_cmd)
                                              asArray:NO
                                                block:^(NSDictionary *model, XCTestExpectation *expectation) {
                                                    [MNFPublic fetchPublicSettingsWithCompletion:^(
                                                                   MNFPublic *_Nullable publicSettings,
                                                                   NSError *_Nullable error) {
                                                        XCTAssertTrue([MNFTestUtils
                                                            validateApiSerialization:model
                                                                     withModelObject:publicSettings]);
                                                        [expectation fulfill];
                                                    }];
                                                }];
}

- (void)testPostalCodeSerialization {
    [self performSerializationTestWithModelDefinition:@"Meniga.Core.Api.Models.PostalCodesModel"
                               expectationDescription:NSStringFromSelector(_cmd)
                                              asArray:YES
                                                block:^(NSDictionary *model, XCTestExpectation *expectation) {
                                                    [MNFPostalCode fetchPostalCodesWithCompletion:^(
                                                                       NSArray<MNFPostalCode *> *_Nullable postalCodes,
                                                                       NSError *_Nullable error) {
                                                        XCTAssertTrue([MNFTestUtils
                                                            validateApiSerialization:model
                                                                     withModelObject:[postalCodes firstObject]]);
                                                        [expectation fulfill];
                                                    }];
                                                }];
}

#pragma mark - sync
- (void)testSyncSerialization {
    [self
        performSerializationTestWithModelDefinition:@"Meniga.Core.Api.Models.SynchronizationStatus"
                             expectationDescription:NSStringFromSelector(_cmd)
                                            asArray:NO
                                              block:^(NSDictionary *model, XCTestExpectation *expectation) {
                                                  [MNFSynchronization
                                                      startSynchronizationWithWaitTime:@10
                                                                            completion:^(MNFSynchronization
                                                                                             *_Nullable synchronization,
                                                                                         NSError *_Nullable error) {
                                                                                XCTAssertTrue([MNFTestUtils
                                                                                    validateApiSerialization:model
                                                                                             withModelObject:
                                                                                                 synchronization]);
                                                                                [expectation fulfill];
                                                                            }];
                                              }];
}

- (void)testSyncAuthenticationChallengeSerialization {
    [self
        performSerializationTestWithModelDefinition:@"Meniga.Core.Api.Models.AuthenticationChallenge"
                             expectationDescription:NSStringFromSelector(_cmd)
                                            asArray:NO
                                              block:^(NSDictionary *model, XCTestExpectation *expectation) {
                                                  [MNFSynchronization
                                                      fetchRealmAuthenticationChallengeWithRealmId:@1
                                                                                        completion:^(
                                                                                            MNFSyncAuthenticationChallenge
                                                                                                *_Nullable authChallenge,
                                                                                            NSError *_Nullable error) {
                                                                                            XCTAssertTrue([MNFTestUtils
                                                                                                validateApiSerialization:
                                                                                                    model
                                                                                                         withModelObject:
                                                                                                             authChallenge]);
                                                                                            [expectation fulfill];
                                                                                        }];
                                              }];
}

- (void)testSyncRealmAccountSerialization {
    [self
        performSerializationTestWithModelDefinition:@"Meniga.Core.Api.Models.AggregationAccountInfo"
                             expectationDescription:NSStringFromSelector(_cmd)
                                            asArray:YES
                                              block:^(NSDictionary *model, XCTestExpectation *expectation) {
                                                  [MNFSynchronization
                                                      fetchAvailableRealmAccountsWithRealmUserId:@1
                                                                                    sessionToken:nil
                                                                                      completion:^(
                                                                                          NSArray<MNFRealmAccount *>
                                                                                              *_Nullable realmAccounts,
                                                                                          NSError *_Nullable error) {
                                                                                          XCTAssertTrue([MNFTestUtils
                                                                                              validateApiSerialization:
                                                                                                  model
                                                                                                       withModelObject:
                                                                                                           [realmAccounts
                                                                                                               firstObject]]);
                                                                                          [expectation fulfill];
                                                                                      }];
                                              }];
}

#pragma mark - tags
- (void)testTagsSerialization {
    [self performSerializationTestWithModelDefinition:@"Meniga.Core.Api.Models.Tag"
                               expectationDescription:NSStringFromSelector(_cmd)
                                              asArray:NO
                                                block:^(NSDictionary *model, XCTestExpectation *expectation) {
                                                    [MNFTag
                                                        fetchWithId:@1
                                                         completion:^(MNFTag *_Nullable tag, NSError *_Nullable error) {
                                                             XCTAssertTrue([MNFTestUtils validateApiSerialization:model
                                                                                                  withModelObject:tag]);
                                                             [expectation fulfill];
                                                         }];
                                                }];
}

#pragma mark - terms
- (void)testTermsSerialization {
    [self
        performSerializationTestWithModelDefinition:@"Meniga.Core.Api.Models.Terms.TermsAndConditions"
                             expectationDescription:NSStringFromSelector(_cmd)
                                            asArray:NO
                                              block:^(NSDictionary *model, XCTestExpectation *expectation) {
                                                  [MNFTermsAndConditions
                                                      fetchTermsAndConditionsWithId:@1
                                                                         completion:^(MNFTermsAndConditions
                                                                                          *_Nullable termsAndConditions,
                                                                                      NSError *_Nullable error) {
                                                                             XCTAssertTrue([MNFTestUtils
                                                                                 validateApiSerialization:model
                                                                                          withModelObject:
                                                                                              termsAndConditions]);
                                                                             [expectation fulfill];
                                                                         }];
                                              }];
}

#pragma mark - transactions
- (void)testTransactionSerialization {
    [self performSerializationTestWithModelDefinition:@"Meniga.Core.Api.Models.TransactionModel"
                               expectationDescription:NSStringFromSelector(_cmd)
                                              asArray:NO
                                                block:^(NSDictionary *model, XCTestExpectation *expectation) {
                                                    [MNFTransaction fetchWithId:@1
                                                                     completion:^(MNFTransaction *_Nullable transaction,
                                                                                  NSError *_Nullable error) {
                                                                         XCTAssertTrue([MNFTestUtils
                                                                             validateApiSerialization:model
                                                                                      withModelObject:transaction]);
                                                                         [expectation fulfill];
                                                                     }];
                                                }];
}

- (void)testTransactionRuleSerialization {
    [self performSerializationTestWithModelDefinition:@"Meniga.Core.Api.Models.TransactionRule"
                               expectationDescription:NSStringFromSelector(_cmd)
                                              asArray:NO
                                                block:^(NSDictionary *model, XCTestExpectation *expectation) {
                                                    [MNFTransactionRule
                                                        fetchRuleWithId:@1
                                                             completion:^(MNFTransactionRule *_Nullable rule,
                                                                          NSError *_Nullable error) {
                                                                 XCTAssertTrue([MNFTestUtils
                                                                     validateApiSerialization:model
                                                                              withModelObject:rule]);
                                                                 [expectation fulfill];
                                                             }];
                                                }];
}

- (void)testTransactionSeriesSerialization {
    [self
        performSerializationTestWithModelDefinition:@"Meniga.Core.Api.Models.TransactionSeries"
                             expectationDescription:NSStringFromSelector(_cmd)
                                            asArray:YES
                                              block:^(NSDictionary *model, XCTestExpectation *expectation) {
                                                  [MNFTransactionSeries
                                                      fetchTransactionSeriesWithTransactionSeriesFilter:
                                                          [MNFTransactionSeriesFilter new]
                                                                                         withCompletion:^(
                                                                                             NSArray<
                                                                                                 MNFTransactionSeries *>
                                                                                                 *_Nullable result,
                                                                                             NSError *_Nullable error) {
                                                                                             XCTAssertTrue([MNFTestUtils
                                                                                                 validateApiSerialization:
                                                                                                     model
                                                                                                          withModelObject:
                                                                                                              [result
                                                                                                                  firstObject]]);
                                                                                             [expectation fulfill];
                                                                                         }];
                                              }];
}

- (void)testTransactionSuggestionSerialization {
    [self
        performSerializationTestWithModelDefinition:@"Meniga.Core.Api.Models.SearchSuggestion"
                             expectationDescription:NSStringFromSelector(_cmd)
                                            asArray:YES
                                              block:^(NSDictionary *model, XCTestExpectation *expectation) {
                                                  [MNFTransactionSuggestion
                                                      fetchTransactionSuggestionsWithText:@""
                                                                          suggestionTypes:nil
                                                          onlyShowResultsWithTransactions:nil
                                                                                     take:nil
                                                                                     sort:nil
                                                                                   filter:nil
                                                                               completion:^(
                                                                                   NSArray<MNFTransactionSuggestion *>
                                                                                       *_Nullable suggestions,
                                                                                   NSError *_Nullable error) {
                                                                                   XCTAssertTrue([MNFTestUtils
                                                                                       validateApiSerialization:model
                                                                                                withModelObject:
                                                                                                    [suggestions
                                                                                                        firstObject]]);
                                                                                   [expectation fulfill];
                                                                               }];
                                              }];
}

#pragma mark - upcoming
- (void)testUpcomingSerialization {
    [self performSerializationTestWithModelDefinition:@"Meniga.Upcoming.Api.Models.UpcomingModel"
                               expectationDescription:NSStringFromSelector(_cmd)
                                              asArray:NO
                                                block:^(NSDictionary *model, XCTestExpectation *expectation) {
                                                    [MNFUpcoming fetchUpcomingWithId:@1
                                                                          completion:^(MNFUpcoming *_Nullable upcoming,
                                                                                       NSError *_Nullable error) {
                                                                              XCTAssertTrue([MNFTestUtils
                                                                                  validateApiSerialization:model
                                                                                           withModelObject:upcoming]);
                                                                              [expectation fulfill];
                                                                          }];
                                                }];
}

- (void)testUpcomingBalanceSerialization {
    [self performSerializationTestWithModelDefinition:@"Meniga.Upcoming.Api.Models.BalanceModel"
                               expectationDescription:NSStringFromSelector(_cmd)
                                              asArray:NO
                                                block:^(NSDictionary *model, XCTestExpectation *expectation) {
                                                    [MNFUpcomingBalance
                                                        fetchBalancesWithDateTo:[NSDate date]
                                                         includeOverdueFromDate:nil
                                                                     accountIds:nil
                                                                includeUnlinked:NO
                                                             useAvailableAmount:NO
                                                                     completion:^(MNFUpcomingBalance *_Nullable balance,
                                                                                  NSError *_Nullable error) {
                                                                         XCTAssertTrue([MNFTestUtils
                                                                             validateApiSerialization:model
                                                                                      withModelObject:balance]);
                                                                         [expectation fulfill];
                                                                     }];
                                                }];
}

- (void)testUpcomingRecurringPatternSerialization {
    [self performSerializationTestWithModelDefinition:@"Meniga.Upcoming.Api.Models.RecurringPatternModel"
                               expectationDescription:NSStringFromSelector(_cmd)
                                              asArray:NO
                                                block:^(NSDictionary *model, XCTestExpectation *expectation) {
                                                    [MNFUpcomingRecurringPattern
                                                        fetchWithId:@1
                                                         completion:^(
                                                             MNFUpcomingRecurringPattern *_Nullable recurringPattern,
                                                             NSError *_Nullable error) {
                                                             XCTAssertTrue([MNFTestUtils
                                                                 validateApiSerialization:model
                                                                          withModelObject:recurringPattern]);
                                                             [expectation fulfill];
                                                         }];
                                                }];
}

- (void)testUpcomingThresholdSerialization {
    [self performSerializationTestWithModelDefinition:@"Meniga.Upcoming.Api.Models.ThresholdSetModel"
                               expectationDescription:NSStringFromSelector(_cmd)
                                              asArray:YES
                                                block:^(NSDictionary *model, XCTestExpectation *expectation) {
                                                    [MNFUpcomingThreshold
                                                        fetchThresholdsWithAccountIds:nil
                                                                           completion:^(NSArray<MNFUpcomingThreshold *>
                                                                                            *_Nullable thresholds,
                                                                                        NSError *_Nullable error) {
                                                                               XCTAssertTrue([MNFTestUtils
                                                                                   validateApiSerialization:model
                                                                                            withModelObject:
                                                                                                [thresholds
                                                                                                    firstObject]]);
                                                                               [expectation fulfill];
                                                                           }];
                                                }];
}

#pragma mark - user events
- (void)testUserEventSerialization {
    [self performSerializationTestWithModelDefinition:@"Meniga.Core.Api.Models.UserEvents.UserEventsModel"
                               expectationDescription:NSStringFromSelector(_cmd)
                                              asArray:NO
                                                block:^(NSDictionary *model, XCTestExpectation *expectation) {
                                                    [MNFUserEvent fetchWithId:@1
                                                                   completion:^(MNFUserEvent *_Nullable userEvent,
                                                                                NSError *_Nullable error) {
                                                                       XCTAssertTrue([MNFTestUtils
                                                                           validateApiSerialization:model
                                                                                    withModelObject:userEvent]);
                                                                       [expectation fulfill];
                                                                   }];
                                                }];
}

- (void)testUserEventDetailSerialization {
    [self
        performSerializationTestWithModelDefinition:@"Meniga.Core.Api.Models.UserEvents.UserEventTypeSubscriptionModel"
                             expectationDescription:NSStringFromSelector(_cmd)
                                            asArray:YES
                                              block:^(NSDictionary *model, XCTestExpectation *expectation) {
                                                  [MNFUserEventSubscriptionDetail
                                                      fetchSubscriptionDetailsWithCompletion:^(
                                                          NSArray<MNFUserEventSubscriptionDetail *>
                                                              *_Nullable subscriptionDetails,
                                                          NSError *_Nullable error) {
                                                          XCTAssertTrue([MNFTestUtils
                                                              validateApiSerialization:model
                                                                       withModelObject:[subscriptionDetails
                                                                                           firstObject]]);
                                                          [expectation fulfill];
                                                      }];
                                              }];
}

#pragma mark - user
- (void)testUserSerialization {
    [self performSerializationTestWithModelDefinition:@"Meniga.Core.Api.Models.PersonInfo"
                               expectationDescription:NSStringFromSelector(_cmd)
                                              asArray:YES
                                                block:^(NSDictionary *model, XCTestExpectation *expectation) {
                                                    [MNFUser
                                                        fetchUsersWithCompletion:^(NSArray<MNFUser *> *_Nullable users,
                                                                                   NSError *_Nullable error) {
                                                            XCTAssertTrue([MNFTestUtils
                                                                validateApiSerialization:model
                                                                         withModelObject:[users firstObject]]);
                                                            [expectation fulfill];
                                                        }];
                                                }];
}

- (void)testUserProfileSerialization {
    [self performSerializationTestWithModelDefinition:@"Meniga.Core.Api.Models.UserProfile"
                               expectationDescription:NSStringFromSelector(_cmd)
                                              asArray:NO
                                                block:^(NSDictionary *model, XCTestExpectation *expectation) {
                                                    [MNFUserProfile
                                                        fetchWithCompletion:^(MNFUserProfile *_Nullable userProfile,
                                                                              NSError *_Nullable error) {
                                                            XCTAssertTrue([MNFTestUtils
                                                                validateApiSerialization:model
                                                                         withModelObject:userProfile]);
                                                            [expectation fulfill];
                                                        }];
                                                }];
}

- (void)testRealmUserSerialization {
    [self performSerializationTestWithModelDefinition:@"Meniga.Core.Api.Models.RealmUser"
                               expectationDescription:NSStringFromSelector(_cmd)
                                              asArray:YES
                                                block:^(NSDictionary *model, XCTestExpectation *expectation) {
                                                    [MNFRealmUser fetchRealmUsersWithCompletion:^(
                                                                      NSArray<MNFRealmUser *> *_Nullable users,
                                                                      NSError *_Nullable error) {
                                                        XCTAssertTrue([MNFTestUtils
                                                            validateApiSerialization:model
                                                                     withModelObject:[users firstObject]]);
                                                        [expectation fulfill];
                                                    }];
                                                }];
}

#pragma mark - perform test
- (void)performSerializationTestWithModelDefinition:(NSString *)definition
                             expectationDescription:(NSString *)description
                                            asArray:(BOOL)asArray
                                              block:
                                                  (void (^)(NSDictionary *model, XCTestExpectation *expectation))block {
    NSDictionary *model = [MNFTestFactory jsonModelWithDefinition:definition];
    if (asArray)
        [MNFNetworkProtocolForTesting setResponseData:[NSJSONSerialization dataWithJSONObject:@{ @"data": @[model] }
                                                                                      options:0
                                                                                        error:nil]];
    else
        [MNFNetworkProtocolForTesting setResponseData:[NSJSONSerialization dataWithJSONObject:@{ @"data": model }
                                                                                      options:0
                                                                                        error:nil]];

    XCTestExpectation *expectation = [self expectationWithDescription:description];

    block(model, expectation);

    [self waitForExpectationsWithTimeout:kMNFTestWaitTime handler:nil];
}

@end
