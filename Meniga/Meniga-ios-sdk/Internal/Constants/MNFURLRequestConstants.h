//
//  MNFURLRequestConstants.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 29/09/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#ifndef MNFURLRequestConstants_h
#define MNFURLRequestConstants_h

//********************************
//Meniga 3.0 API
//********************************

//New accounts end points
#pragma mark - Accounts

#define kMNFAPIPathAccounts @"/accounts"
#define kMNFAccountCategories kMNFAPIPathAccounts @"/accountcategories"
#define kMNFAccountAuthorizationTypes kMNFAPIPathAccounts @"/authorizationtypes"
#define kMNFAccountTypes kMNFAPIPathAccounts @"/accounttypes"
#define kMNFAccountMetadata @"metadata"
#define kMNFAccountHistory @"history"

#pragma mark - Transactions

#define kMNFApiPathTransactions @"/transactions"
#define kMNFTransactionsSplit @"/split"
#define kMNFTransactionsComments @"/comments"
#define KMNFTransactionsRecategorize kMNFApiPathTransactions @"/recategorize"
#define kMNFTransactionsRule kMNFApiPathTransactions @"/rules"

#pragma mark - Categories

#define kMNFApiPathCategories @"/categories"
#define kMNFCategorieTypes kMNFApiPathCategories @"/types"

#pragma mark - Tags

#define kMNFApiPathTags @"/tags"

#pragma mark - Synchronization

#define kMNFApiPathSynchronization @"/sync"
#define kMNFSynchronizationSkip kMNFApiPathSynchronization @"/skip"
#define kMNFSynchronizationRealm kMNFApiPathSynchronization @"/realm"
#define kMNFSynchronizationAccounts kMNFApiPathSynchronization @"/accounts"

#pragma mark - User
#define kMNFApiPathUser @"/me"
#define kMNFUserCulture kMNFApiPathUser @"/culture"
#define kMNFUserOptin kMNFApiPathUser @"/optin"
#define kMNFUserOptout kMNFApiPathUser @"/optout"
#define kMNFUserMetaData kMNFApiPathUser @"/metadata"
#define kMNFUserProfile kMNFApiPathUser @"/profile"
#define kMNFRealmUsers kMNFApiPathUser @"/realmusers"
#define kMNFUserRegister kMNFApiPathUser @"/register"

#pragma mark - Merchant

#define kMNFApiPathMerchants @"/merchants"
#define kMNFApiPathMerchantSeries @"/top"

#pragma mark - Networth
#define kMNFAPIPathNetworth @"/networth"
#define kMNFNetworthSummary kMNFAPIPathNetworth @"/summary"
#define kMNFNetworthFirstEntryDate kMNFAPIPathNetworth @"/first"
#define kMNFNetworthAccountTypes kMNFAPIPathNetworth @"/types"
#define kMNFNetworthAccounts kMNFAPIPathNetworth @"/accounts"
#define kMNFNetworthBalanceHistoryExtension @"/balancehistory"

#pragma mark - Offers
#define kMNFApiPathOffers @"/offers"
#define kMNFApiPathRedemptions @"/redemptions"
#define kMNFApiPathReimbursementAccounts @"/reimbursementAccounts"

#pragma mark - Feed
#define kMNFApiPathFeed @"/feed"
#define kMNFFeedTypes kMNFApiPathFeed @"/types"
#define kMNFFeedUserEvents kMNFApiPathFeed @"/userevents"

#pragma mark - Upcoming
#define kMNFApiPathUpcoming @"/upcoming"
#define kMNFUpcomingRecurring kMNFApiPathUpcoming @"/recurring"
#define KMNFUpcomingBalances kMNFApiPathUpcoming @"/balances"
#define kMNFUpcomingThresholds kMNFApiPathUpcoming @"/thresholds"
#define kMNFUpcomingAccountsDefault kMNFApiPathUpcoming @"/accounts/default"
#define kMNFUpcomingAccountsIncluded kMNFApiPathUpcoming @"/accounts/included"

#pragma mark - Challenges
#define kMNFApiPathChallenges @"/challenges"
#define kMNFChallengesAcceptWithId kMNFApiPathChallenges @"/%@/accept"
#define kMNFChallengesCustom kMNFApiPathChallenges @"/custom"
#define kMNFChallengesIcons kMNFApiPathChallenges @"/icons"
#define kMNFChallengesEnable kMNFApiPathChallenges @"/%@/enable"
#define kMNFChallengesDisable kMNFApiPathChallenges @"/%@/disable"

#pragma mark - Budget
#define kMNFApiPathBudget @"/budgets"
#define kMNFBudgetTransactions kMNFApiPathBudget @"/%@/transactions"
#define kMNFBudgetRecurring kMNFApiPathBudget @"/recurring"
#define kMNFBudgetRecalculate kMNFApiPathBudget @"/recalculate"

#pragma mark - Terms
#define kMNFApiPathTerms @"/terms"
#define kMNFTermTypes kMNFApiPathTerms @"/types"
#define kMNFAcceptTerms kMNFApiPathTerms @"/%@/accept"
#define kMNFDeclineTerms kMNFApiPathTerms @"/%@/decline"

#pragma mark - Public
#define kMNFApiPathPublic @"/public"
#define kMNFPublicSettings kMNFApiPathPublic @"/settings"
#define kMNFPublicPostalCodes kMNFApiPathPublic @"/postalcodes"

#pragma mark - Organizations
#define kMNFApiPathOrganizations @"/organizations"

#pragma mark - Authentication
#define kMNFApiPathAuthentication @"/authentication"
#define kMNFAuthenticationRefresh kMNFApiPathAuthentication @"/refresh"
#define kMNFAuthenticationSSO kMNFApiPathAuthentication @"/sso/%@"
#define kMNFAuthenticationAfter kMNFApiPathAuthentication @"/after"

#pragma mark - User Events
#define kMNFApiPathUserEvents @"/userevents"
#define kMNFUserEventsSubscription kMNFApiPathUserEvents @"/subscription"
#define kMNFUserEventsSubscriptionDetails kMNFUserEventsSubscription @"/details"
#define kMNFUserEventTypes @"/eventtypes"


//*********************************
//Meniga 2.0 API
//*********************************


#pragma mark Cashback


#pragma mark Cashback
#pragma mark -

#define kMNFGetOfferInventory @"%@/Api/Cashback/GetOfferInventory"
#define kMNFGetOffers @"%@/Api/Cashback/GetOffers"
#define kMNFGetOffer @"%@/Api/Cashback/GetOffer"
#define kMNFAcceptOffer @"%@/Api/Cashback/AcceptOffer"
#define kMNFDeclineOffer @"%@/Api/Cashback/DeclineOffer"
#define kMNFCreateRepaymentAccount @"%@/Api/Cashback/CreateRepaymentAccount"
#define kMNFDeleteRepaymentAccount @"%@/Api/Cashback/DeleteRepaymentAccount"
#define kMNFUpdateRepaymentAccount @"%@/Api/Cashback/UpdateRepaymentAccount"
#define kMNFGetCashBackReport @"%@/Api/Cashback/GetCashbackReport"
#define kMNFAcceptCashbackTermsAndConditions @"%@/Api/Cashback/AcceptCashbackTermsAndConditions"
#define kMNFSetCampaginModuleStatus @"%@/Api/Cashback/SetCampaignModuleStatus"
#define kMNFGetOfferSettingsPage @"%@/Api/Cashback/GetOfferSettingsPage"
#define kMNFGetRepaymentAccounts @"%@/Api/Cashback/GetRepaymentAccounts"
#define kMNFRemoveMerchantDeclines @"%@/Api/Cashback/RemoveMerchantDeclines"
#define kMNFSetOfferSeen @"%@/Api/Cashback/SetOfferSeen"
#define kMNFSetEmailOfferStatus @"%@/Api/Cashback/SetEmailOfferStatus"
#define kMNFGetCashbackTermsAndConditions @"%@/Api/Cashback/GetCashbackTermsAndConditions"

#pragma mark Extended
#pragma mark -

#define kMNFAuthenticateToBank @"%@/Api/Extended/AuthenticateToBank"
#define kMNFRegisterUserAndAccounts @"%@/Api/Extended/RegisterUserAndAccounts"

#pragma mark User
#pragma mark -

#define kMNFSetLoginPreference @"%@/Api/User/SetMobileLoginPreference"
#define kMNFSetNewEmail @"%@/Api/User/ChangeEmail"
#define kMNFSetNewPassword @"%@/Api/User/ChangePassword"
#define kMNFConfirmNewPassword @"%@/Api/User/ConfirmPassword"
#define kMNFUpdateUserProfile @"%@/Api/User/UpdateUserProfile"
#define kMNFGetUserProfile @"%@/Api/User/GetUserProfile"
#define kMNFGetUserCategoryTree @"%@/Api/User/GetUserCategoryTree"
#define kMNFGetUserCategories @"%@/Api/User/GetUserCategories"
#define kMNFGetTopCategoryIds @"%@/Api/User/GetTopCategoryIds"
#define kMNFGetCategoryById @"%@/Api/User/GetCategoryById"
#define kMNFCreateUserCategory @"%@/Api/User/CreateUserCategory"
#define kMNFUpdateUserCategory @"%@/Api/User/UpdateUserCategory"
#define kMNFDeleteUserCategory @"%@/Api/User/DeleteUserCategory"
#define kMNFGetPublicCategoryTree @"%@/Api/User/GetPublicCategoryTree"

#pragma mark Authorization
#pragma mark -

#define kMNFLogin @"%@/Mobile/LogOn"
#define kMNFSandboxAuth @"/authentication"
#define kMNFSandboxRefresh @"/authentication/refresh"
#define kMNFAuthentication @"/authentication"

#define kMNFResetPasswordWithEmail @"%@/auth/ForgotPassword"

#pragma mark Home
#pragma mark -

#define kMNFSetCulture @"%@/Home/SetCulture/%@"

/*
//New accounts end points
#pragma mark Accounts
#pragma mark -

#define kMNFAPIPathAccounts @"%@/accounts"
#define kMNFAccountsSingleParameter kMNFAPIPathAccounts @"/%@"
#define kMNFAccountCategoryTypes kMNFAPIPathAccounts @"/categorytypes"
#define kMNFAccountAuthorizationTypes kMNFAPIPathAccounts @"/authorizationtypes"
#define kMNFAccountsByDisabled kMNFAPIPathAccounts @"@/disabled"
#define kMNFAccountsParameters kMNFAPIPathAccounts @"@%@/parameters"
#define kMNFAccountsParameter kMNFAPIPathAccounts @"@%@/parameters/%@"
#define kMNFAccountsGroupedByOrganization kMNFAPIPathAccounts @"@/groupedbyorganization"
*/

#pragma mark Transactions
#pragma mark -

#define kMNFGetTransactionCount @"%@/Api/Transactions/GetTransactionCount"
#define kMNFStartSynchronization @"%@/Api/Transactions/StartSynchronization"
#define kMNFGetSynchronizationStatus @"%@/Api/Transactions/GetSynchronizationStatus"
#define KMNFIsSynchronizationNeeded @"%@/Api/Transactions/IsSynchronizationNeeded"
#define kMNFGetTransactionPage @"%@/Api/Transactions/GetTransactionsPage"
#define kMNFGetTransactions @"%@/Api/Transactions/GetTransactions"
#define kMNFGetTransaction @"%@/Api/Transactions/GetTransaction"
#define kMNFGetTransactionsByIds @"%@/Api/Transactions/GetTransactionsByIds"
#define kMNFGetTransactionsByParentIdentifier @"%@/Api/Transactions/GetTransactionsByParentIdentifier"
#define kMNFUpdateTransaction @"%@/Api/Transactions/UpdateTransaction"
#define kMNFClearTransactionCategoryUncertainty @"%@/Api/Transactions/ClearTransactionCategoryUncertainty"
#define kMNFSplitTransaction @"%@/Api/Transactions/SplitTransaction"
#define kMNFExcludeTransaction @"%@/Api/Transactions/ExcludeTransaction"
#define kMNFDeleteTransaction @"%@/Api/Tansactions/DeleteTransaction"
#define kMNFDeleteTransactions @"%@/Api/Transactions/DeleteTransactions"
#define kMNFSetTransactionFlagState @"%@/Api/Transactions/SetTransactionFlagState"
#define kMNFSetTransactionReadState @"%@/Api/Transactions/SetTransactionReadState"
#define kMNFCreateTransaction @"%@/Api/Transactions/CreateTransaction"
#define kMNFGetTag @"%@/Api/Transactions/GetTag"
#define kMNFGetTags @"%@/Api/Transactions/GetTags"
#define kMNFCreateTag @"%@/Api/Transactions/CreateTag"
#define kMNFDeleteTag @"%@/Api/Transactions/DeleteTag"
#define kMNFUpdateTag @"%@/Api/Transactions/UpdateTag"
#define kMNFUpdateTags @"%@/Api/Transactions/UpdateTags"



#pragma mark Lifegoals
#pragma mark -

#define kMNFGetLifeGoalsPage @"%@/Api/%@/GetLifeGoalsPage"
#define kMNFCreateLifeGoal @"%@/Api/%@/CreateLifeGoal"
#define kMNFUpdateLifeGoal @"%@/Api/%@/UpdateLifeGoal"
#define kMNFFeedGoal @"%@/Api/%@/FeedGoal"
#define kMNFMarkLifeGoalAsReached @"%@/Api/%@/MarkLifeGoalAsReached"
#define kMNFDeleteLifeGoal @"%@/Api/%@/DeleteLifeGoal"
#define kMNFGetLifeGoalHistory @"%@/Api/%@/GetLifeGoalHistory"

#pragma mark Public
#pragma mark -

#define kMNFGetBasicTermsAndConditions @"%@/Api/Public/GetBasicTermsAndConditions"

#pragma mark User Events
#pragma mark -

#define kMNFGetUserFeed @"%@/Api/UserEvents/GetUserFeed"
#define kMNFGetTrendsReport @"%@/Api/UserEvents/GetTrendsReport"
#define kMNFGetUserEvent @"%@/Api/UserEvents/GetUserEvent"

#pragma mark Planning

#define kMNFGetTransactionsByMerchants @"%@/Api/Planning/GetTransactionsByMerchants"
#define kMNFGetBudgetTable @"%@/Api/Planning/GetBudgetTable"
#define kMNFGetWatchedCategories @"%@/Api/Planning/GetWatchedCategories"
#define kMNFSetWatchedCategories @"%@/Api/Planning/SetWatchedCategories"
#define kMNFGetBudgetDetails @"%@/Api/Planning/GetBudgetDetails"
#define kMNFUpdateBudgetData @"%@/Api/Planning/UpdateBudgetData"

#endif
