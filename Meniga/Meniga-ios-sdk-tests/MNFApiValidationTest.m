//
//  MNFApiValidationTest.m
//  Meniga-ios-sdk-tests
//
//  Created by Haukur Ísfeld on 21/03/2018.
//  Copyright © 2018 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNFTestFactory.h"
#import "MNFTestUtils.h"
#import "Meniga.h"

@interface MNFApiValidationTest : XCTestCase

@end

@implementation MNFApiValidationTest

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testValidateAccountsApi {
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Core.Api.Models.AccountModel"] withModelObject:[MNFAccount new]]);
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Core.Api.Models.AccountTypeModel"] withModelObject:[MNFAccountType new]]);
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Core.Api.Models.AccountTypeCategory"] withModelObject:[MNFAccountCategory new]]);
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Core.Api.Models.NameId"] withModelObject:[MNFAccountAuthorizationType new]]);
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Core.Api.Models.AccountBalanceHistory"] withModelObject:[MNFAccountHistoryEntry new]]);
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Core.Api.Models.ImportAccountConfigurationModel"] withModelObject:[MNFImportAccountConfiguration new]]);
    XCTAssertTrue([MNFTestUtils validateFilterParameters:[MNFTestFactory filterParametersWithPath:@"/accounts"] withModelObject:[MNFAccountFilter new]]);
}

- (void)testValidateAuthenicationApi {
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Core.Authentication.Api.Models.AuthenticationResponse"] withModelObject:[MNFAuthentication new]]);
}

- (void)testValidateBudgetsApi {
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Component.Budgets.Api.Models.Responses.BudgetHeaderMessage"] withModelObject:[MNFBudget new]]);
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Component.Budgets.Api.Models.Responses.BudgetEntryMessage"] withModelObject:[MNFBudgetEntry new]]);
    XCTAssertTrue([MNFTestUtils validateFilterParameters:[MNFTestFactory filterParametersWithPath:@"/budgets/{id}"] withModelObject:[MNFBudgetFilter new]]);
    XCTAssertTrue([MNFTestUtils validateFilterParameters:[MNFTestFactory filterParametersWithPath:@"/budgets/{id}/entries"] withModelObject:[MNFBudgetFilter new]]);
}

- (void)testValidateCategoriesApi {
//    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Core.Api.Models.CategoryModel"] withModelObject:[MNFCategory new]]);
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Core.Api.Models.NameId"] withModelObject:[MNFCategoryType new]]);
}

- (void)testValidateChallengesApi {
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Challenges.Api.Models.UserChallengeModel"] withModelObject:[MNFChallenge new]]);
}

- (void)testValidateFeedApi {
    XCTAssert([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Core.Api.Models.Feed.FeedItemModel"] withModelObject:[MNFFeedItem new]]);
}

- (void)testValidateLifeGoalsApi {
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Component.LifeGoals.Api.Models.LifeGoalModel"] withModelObject:[MNFLifeGoal new]]);
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Component.LifeGoals.Api.Models.LifeGoalHistoryRecordModel"] withModelObject:[MNFLifeGoalHistory new]]);
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Component.LifeGoals.Api.Models.LifeGoalAccountModel"] withModelObject:[MNFLifeGoalAccountInfo new]]);
}

- (void)testValidateMerchantsApi {
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Core.Api.Models.Merchant"] withModelObject:[MNFMerchant new]]);
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Core.Api.Models.Address"] withModelObject:[MNFMerchantAddress new]]);
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Core.Api.Models.CategoryScore"] withModelObject:[MNFCategoryScore new]]);
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Core.Api.Models.TopMerchantsOptions"] withModelObject:[MNFMerchantSeriesOptions new]]);
}

- (void)testValidateNetworthApi {
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Core.DataContract.AccountBalanceHistoryWrapper"] withModelObject:[MNFNetworthAccount new]]);
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Core.DataContract.AccountBalanceHistory"] withModelObject:[MNFNetworthBalanceHistory new]]);
}

- (void)testValidateOrganizationsApi {
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Core.Api.Models.OrganizationModel"] withModelObject:[MNFOrganization new]]);
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Core.Api.Models.OrganizationRealm"] withModelObject:[MNFOrganizationRealm new]]);
}

- (void)testValidatePeerComparisonApi {
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Core.Api.Models.PeerComparison.PeerComparison"] withModelObject:[MNFPeerComparison new]]);
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Core.Api.Models.PeerComparison.TopMerchantComparison"] withModelObject:[MNFPeerComparison new]]);
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Core.Api.Models.PeerComparison.ComparisonItem"] withModelObject:[MNFPeerComparisonStats new]]);
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Core.Api.Models.PeerComparison.MerchantComparisonItem"] withModelObject:[MNFPeerComparisonMerchants new]]);
}

- (void)testValidatePublicApi {
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Core.Api.Models.PublicSettings"] withModelObject:[MNFPublic new]]);
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Core.Api.Models.Currency"] withModelObject:[MNFCurrency new]]);
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Core.Api.Models.PostalCodesModel"] withModelObject:[MNFPostalCode new]]);
}

- (void)testValidateSyncApi {
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Core.Api.Models.SynchronizationStatus"] withModelObject:[MNFSynchronization new]]);
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Core.Api.Models.RealmSyncStatus"] withModelObject:[MNFRealmSyncResponse new]]);
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Core.Api.Models.AccountSyncStatus"] withModelObject:[MNFAccountSyncStatus new]]);
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Core.Api.Models.AuthenticationChallenge"] withModelObject:[MNFSyncAuthenticationChallenge new]]);
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Core.Api.Models.ParameterDescription"] withModelObject:[MNFSyncAuthRequiredParameter new]]);
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Core.Api.Models.AggregationAccountInfo"] withModelObject:[MNFRealmAccount new]]);
}

- (void)testValidateTagsApi {
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Core.Api.Models.Tag"] withModelObject:[MNFTag new]]);
}

- (void)testValidateTermsApi {
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Core.Api.Models.Terms.TermsAndConditions"] withModelObject:[MNFTermsAndConditions new]]);
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Core.Api.Models.Terms.TermsAndConditionsType"] withModelObject:[MNFTermsAndConditionType new]]);
}

- (void)testValidateTransactionsApi {
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Core.Api.Models.TransactionModel"] withModelObject:[MNFTransaction new]]);
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Core.Api.Models.TransactionCommentModel"] withModelObject:[MNFComment new]]);
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Core.Api.Models.TransactionFilter"] withModelObject:[MNFTransactionFilter new]]);
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Core.Api.Models.TransactionRule"] withModelObject:[MNFTransactionRule new]]);
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Core.Api.Models.TransactionRuleSplitAction"] withModelObject:[MNFTransactionSplitAction new]]);
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Core.Api.Models.TransactionSeries"] withModelObject:[MNFTransactionSeries new]]);
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Core.Api.Models.TimeSerieStatistics"] withModelObject:[MNFTransactionSeriesStatistics new]]);
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Core.Api.Models.TransactionSeriesData"] withModelObject:[MNFTransactionSeriesValue new]]);
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Core.Api.Models.TransactionSeriesOptions"] withModelObject:[MNFTransactionSeriesFilter new]]);
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Core.Api.Models.SearchSuggestion"] withModelObject:[MNFTransactionSuggestion new]]);
}

- (void)testValidateUpcomingApi {
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Upcoming.Api.Models.UpcomingModel"] withModelObject:[MNFUpcoming new]]);
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Upcoming.Api.Models.RecurringPatternModel"] withModelObject:[MNFUpcomingRecurringPattern new]]);
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Upcoming.Api.Models.CronExpressionModel"] withModelObject:[MNFUpcomingPattern new]]);
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Upcoming.Api.Models.CommentModel"] withModelObject:[MNFUpcomingComment new]]);
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Upcoming.Api.Models.UpcomingReconcileScore"] withModelObject:[MNFUpcomingReconcileScore new]]);
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Upcoming.Api.Models.DetailsModel"] withModelObject:[MNFUpcomingDetails new]]);
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Upcoming.Api.Models.InvoiceModel"] withModelObject:[MNFUpcomingInvoice new]]);
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Upcoming.Api.Models.ScheduledPaymentModel"] withModelObject:[MNFUpcomingScheduledPayment new]]);
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Upcoming.Api.Models.ThresholdSetModel"] withModelObject:[MNFUpcomingThreshold new]]);
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Upcoming.Api.Models.BalanceModel"] withModelObject:[MNFUpcomingBalance new]]);
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Upcoming.Api.Models.BalanceDateModel"] withModelObject:[MNFUpcomingBalanceDate new]]);
}

- (void)testValidateUserEventsApi {
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Core.Api.Models.UserEvents.UserEventsModel"] withModelObject:[MNFUserEvent new]]);
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Core.Api.Models.UserEvents.UserEventTypeSubscriptionDetailModel"] withModelObject:[MNFUserEventSubscription new]]);
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Core.Api.Models.UserEvents.UserEventTypeSubscriptionModel"] withModelObject:[MNFUserEventSubscriptionDetail new]]);
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Core.Api.Models.UserEvents.UserEventTypeSubscriptionSettingModel"] withModelObject:[MNFUserEventSubscriptionSetting new]]);
}

- (void)testValidateUsersApi {
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Core.Api.Models.PersonInfo"] withModelObject:[MNFUser new]]);
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Core.Api.Models.UserProfile"] withModelObject:[MNFUserProfile new]]);
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory apiModelWithDefinition:@"Meniga.Core.Api.Models.RealmUser"] withModelObject:[MNFRealmUser new]]);
}

@end
