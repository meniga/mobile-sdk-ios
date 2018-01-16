//
//  MNFConstants.h
//  Meniga-ios-sdk
//
//  Created by Aske Bendtsen on 12/11/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

@class MNFTransaction;
@class MNFOffer;
@class MNFOfferTransaction;
@class MNFRedemptionsMetaData;
@class MNFReimbursementAccount;
@class MNFReimbursementAccountType;
@class MNFSimilarBrand;
@class MNFSimilarBrandMetaData;
@class MNFCategory;
@class MNFFeed;
@class MNFFeedItem;
@class MNFTag;
@class MNFUser;
@class MNFUserProfile;
@class MNFTransactionPage;
@class MNFRepaymentAccount;
@class MNFSynchronization;
@class MNFResponse;
@class MNFTransactionSeries;
@class MNFRealmUser;
@class MNFMerchant;
@class MNFTransactionRule;
@class MNFCategoryType;
@class MNFUserEvent;
@class MNFNetworthAccount;
@class MNFNetworthBalanceHistory;
@class MNFUpcoming;
@class MNFUpcomingRecurringPattern;
@class MNFUpcomingBalance;
@class MNFUpcomingThreshold;
@class MNFChallenge;
@class MNFBudget;
@class MNFBudgetEntry;
@class MNFScheduledEvent;
@class MNFMerchantSeries;
@class MNFPublic;
@class MNFPostalCode;
@class MNFOrganization;
@class MNFAuthentication;
@class MNFTranslation;
@class MNFLanguage;
@class MNFTermsAndConditionType;
@class MNFTermsAndConditions;
@class MNFSyncAuthenticationChallenge;
@class MNFRealmAccount;
@class MNFUserEventSubscriptionDetail;

// MNFAccount
@class MNFAccount;
@class MNFAccountCategory;
@class MNFAccountHistoryEntry;
@class MNFAccountAuthorizationType;
@class MNFAccountType;

@class MNFJob;

// internal completion handler
typedef void (^MNFCompletionHandler)(MNFResponse * _Nullable response);

// metadata completion handler
typedef void (^MNFMetadataValueCompletionHandler)(NSString *_Nullable metadataValue, NSError *_Nullable error);
typedef void (^MNFMetadataCompletionHandler)(NSDictionary *_Nullable metadata, NSError *_Nullable error);
typedef void (^MNFMultipleMetadataCompletionHandlers)(NSArray <NSDictionary *> *_Nullable metadatas, NSError *_Nullable error);

typedef void (^MNFFetchMultipleCompletionHandler)(NSArray *_Nullable result, NSError  * _Nullable error);

//Completion for built in types
typedef void (^MNFDateCompletionHandler)(NSDate *_Nullable result, NSError  * _Nullable error);


//generic for misc calls that only need to return an error
typedef void (^MNFErrorOnlyCompletionHandler)(NSError *_Nullable error);

// Array result type
typedef void (^MNFFetchObjectsCompletionHandler)(NSArray *_Nullable objects, NSError *_Nullable error);

//Transaction
typedef void (^MNFTransactionCompletionHandler)(MNFTransaction *_Nullable transaction, NSError * _Nullable error);
typedef void (^MNFMultipleTransactionsCompletionHandler)(NSArray <MNFTransaction *> *_Nullable transactions, NSError * _Nullable error);
typedef void (^MNFTransactionRuleCompletionHandler)(MNFTransactionRule *_Nullable rule, NSError *_Nullable error);
typedef void (^MNFMultipleTransactionRulesCompleitonHandler)(NSArray <MNFTransactionRule *> *_Nullable transactionRules, NSError *_Nullable error);
//TransactionPage
typedef void (^MNFTransactionPageCompletionHandler)(MNFTransactionPage *_Nullable result, NSError  * _Nullable error);
//TransactionSeries
typedef void (^MNFTransactionSeriesCompletionHandler)(NSArray <MNFTransactionSeries *> *_Nullable result, NSError *_Nullable error);

// Categories
typedef void (^MNFCategoryCompletionHandler)(MNFCategory *_Nullable category, NSError *_Nullable error);
typedef void (^MNFMultipleCategoriesCompletionHandler)(NSArray <MNFCategory *> *_Nullable categories, NSError * _Nullable error);
typedef void (^MNFMultipleCategoryTypesCompletionHandler)(NSArray <MNFCategoryType *> * _Nullable categoryTypes, NSError * _Nullable error);

// Accounts
typedef void (^MNFAccountCompletionHandler)(MNFAccount *_Nullable account, NSError *_Nullable error);
typedef void (^MNFMultipleAccountsCompletionHandler)(NSArray <MNFAccount *> * _Nullable accounts, NSError *_Nullable error);
typedef void (^MNFMultipleAccountHistoryCompletionHandler)(NSArray <MNFAccountHistoryEntry*> *_Nullable accountHistoryEntries, NSError *_Nullable error);
typedef void (^MNFMultipleAccountCategoriesCompletionHandler)(NSArray <MNFAccountCategory *> *_Nullable accountTypes, NSError *_Nullable error);
typedef void (^MNFMultipleAccountAuthorizationTypesCompletionHandler)(NSArray <MNFAccountAuthorizationType *> *_Nullable accountAuthorizationTypes, NSError *_Nullable error);
typedef void (^MNFMultipleAccountTypesCompletionHandler)(NSArray <MNFAccountType *> *_Nullable realmAccountTypes, NSError *_Nullable error);

// Networth Account
typedef void (^MNFMultipleNetworthAccountsCompletionHandler)(NSArray <MNFNetworthAccount *> * _Nullable networthAccounts, NSError *_Nullable error);
typedef void (^MNFSingleNetworthAccountsCompletionHandler)(MNFNetworthAccount* _Nullable networthAccount, NSError *_Nullable error);
typedef void (^MNFMultipleNetworthBalanceHistoryCompletionHandler)(NSArray <MNFNetworthBalanceHistory *> * _Nullable networthBalanceHistory, NSError *_Nullable error);
typedef void (^MNFSingleNetworthBalanceHistoryCompletionHandler)(MNFNetworthBalanceHistory* _Nullable networthBalanceHistory, NSError *_Nullable error);

// Tag
typedef void (^MNFTagCompletionHandler)(MNFTag *_Nullable tag, NSError *_Nullable error);
typedef void (^MNFMultipleTagsCompletionHandler) (NSArray <MNFTag *> *_Nullable tags, NSError *_Nullable error);

// User
typedef void (^MNFUserCompletionHandler)(MNFUser *_Nullable user, NSError *_Nullable error);
typedef void (^MNFMultipleUsersCompletionHandler)(NSArray <MNFUser*> *_Nullable users, NSError *_Nullable error);
typedef void (^MNFUserProfileCompletionHandler)(MNFUserProfile *_Nullable userProfile, NSError *_Nullable error);
typedef void (^MNFMultipleRealmUsersComletionHandler)(NSArray <MNFRealmUser*> *_Nullable users, NSError *_Nullable error);


//Synchronization
typedef void (^MNFSynchronizationCompletionHandler)(MNFSynchronization *_Nullable synchronization, NSError *_Nullable error);
typedef void (^MNFIsSyncNeededCompletionHandler)(NSNumber *_Nullable isSyncNeeded, NSError *_Nullable error);
typedef void (^MNFSyncAuthenticationCompletionHandler)(MNFSyncAuthenticationChallenge *_Nullable authChallenge, NSError *_Nullable error);
typedef void (^MNFMultipleRealmAccountCompletionHandler)(NSArray <MNFRealmAccount *> *_Nullable realmAccounts, NSError *_Nullable error);

//Merchant
typedef void (^MNFMerchantCompletionHandler)(MNFMerchant *_Nullable merchant,NSError *_Nullable error);
typedef void (^MNFMultipleMerchantsCompletionHandler)(NSArray <MNFMerchant*> *_Nullable merchants,NSError *_Nullable error);
//MerchantSeries
typedef void (^MNFMerchantSeriesCompletionHandler)(NSArray <MNFMerchantSeries *> *_Nullable result, NSError *_Nullable error);


// Offers
typedef void (^MNFOfferCompletionHandler)(MNFOffer *_Nullable offer, NSError * _Nullable error);
typedef void (^MNFMultipleOffersCompletionHandler)(NSArray <MNFOffer *> * _Nullable offers, NSDictionary * _Nullable metadata, NSError * _Nullable error);
typedef void (^MNFMultipleOfferTransactionsCompletionHandler)(NSArray <MNFOfferTransaction *> * _Nullable offerTransactions, NSError * _Nullable error);
typedef void (^MNFOfferSimilarBrandSpendingCompletionHandler)(NSArray <MNFSimilarBrand *> * _Nullable similarBrands, MNFSimilarBrandMetaData * _Nullable metaData, NSError * _Nullable error);
typedef void (^MNFRedemptionsCompletionHandler)(NSArray <MNFOfferTransaction *> * _Nullable offerRedemptionTransactions, MNFRedemptionsMetaData * _Nullable metaData, NSError *_Nullable error);
typedef void (^MNFMultipleReimbursementAccountsCompletionHandler)(NSArray <MNFReimbursementAccount *> * _Nullable reimbursementAccounts, NSError * _Nullable error);
typedef void (^MNFRemibursementAccountCompletionHandler)(MNFReimbursementAccount * _Nullable account, NSError * _Nullable error);
typedef void (^MNFMultipleReimbursementAccountTypesCompletionHandler)(NSArray <MNFReimbursementAccountType *> * _Nullable accountType, NSError * _Nullable error);


//Feed
typedef void (^MNFFeedCompletionHandler)(MNFFeed *_Nullable feed, NSError *_Nullable error);
typedef void (^MNFFeedItemsCompletionHandler)(NSArray <MNFFeedItem *> * _Nullable feedItems, NSError * _Nullable error);
typedef void (^MNFFeedTypesCompletionHandler)(NSArray <NSString *> *_Nullable feedTypes, NSError *_Nullable error);
typedef void (^MNFScheduledEventCompletionHandler)(MNFScheduledEvent *_Nullable scheduledEvent, NSError *_Nullable error);
typedef void (^MNFSingleFeedItemCompletionHandler)(MNFFeedItem *_Nullable feedItem, NSError * _Nullable error);

//Upcoming
typedef void (^MNFUpcomingCompletionHandler)(MNFUpcoming *_Nullable upcoming, NSError *_Nullable error);
typedef void (^MNFMultipleUpcomingCompletionHandler)(NSArray <MNFUpcoming *> *_Nullable upcomings, NSError *_Nullable error);
typedef void (^MNFRecurringPatternCompletionHandler)(MNFUpcomingRecurringPattern *_Nullable recurringPattern, NSError *_Nullable error);
typedef void (^MNFMultipleRecurringPatternsCompletionHandler)(NSArray <MNFUpcomingRecurringPattern *> *_Nullable recurringPatterns, NSError *_Nullable error);
typedef void (^MNFDefaultAccountIdCompletionHandler)(NSNumber *_Nullable accountId, NSError *_Nullable error);
typedef void (^MNFMultipleAccountIdsCompletionHandler)(NSArray <NSNumber *> *_Nullable accountIds, NSError *_Nullable error);
typedef void (^MNFBalancesCompletionHandler)(MNFUpcomingBalance *_Nullable balance, NSError *_Nullable error);
typedef void (^MNFThresholdCompletionHandler)(MNFUpcomingThreshold *_Nullable threshold, NSError *_Nullable error);
typedef void (^MNFMultipleThresholdsCompletionHandler)(NSArray <MNFUpcomingThreshold *> *_Nullable thresholds, NSError *_Nullable error);

//Challenges
typedef void (^MNFChallengesCompletionHandler)(MNFChallenge *_Nullable challenge, NSError *_Nullable error);
typedef void (^MNFMultipleChallengesCompletionHandler)(NSArray <MNFChallenge *> *_Nullable challenges, NSError *_Nullable error);
typedef void (^MNFChallengeIconIdentifiersCompletionHandler)(NSArray <NSString *> *_Nullable iconIdentifiers, NSError *_Nullable error);
typedef void (^MNFChallengeIconImageDataCompletionHandler)(NSData *_Nullable imageData, NSError *_Nullable error);

//Budget
typedef void (^MNFBudgetCompletionHandler)(MNFBudget *_Nullable budget, NSError *_Nullable error);
typedef void (^MNFMultipleBudgetCompletionHandler)(NSArray <MNFBudget *> *_Nullable budgets, NSError *_Nullable error);
typedef void (^MNFMultipleBudgetEntriesCompletionHandler)(NSArray <MNFBudgetEntry *> *_Nullable budgetEntries, NSError *_Nullable error);
typedef void (^MNFBudgetEntryCompletionHandler)(MNFBudgetEntry *_Nullable budgetEntry, NSError *_Nullable error);

// Terms and Conditions
typedef void (^MNFTermsAndConditionsCompletionHandler)(MNFTermsAndConditions * _Nullable termsAndConditions, NSError * _Nullable error);
typedef void (^MNFMultipleTermsAndConditionsCompletionHandler)(NSArray <MNFTermsAndConditions *> * _Nullable termsAndConditions, NSError * _Nullable error);

typedef void (^MNFMultipleTermsAndConditionTypesCompletionHandler)(NSArray <MNFTermsAndConditionType *> * _Nullable termsAndConditions, NSError * _Nullable error);
typedef void (^MNFTermsAndConditionTypeCompletionHandler)(MNFTermsAndConditionType * _Nullable termsAndConditionType, NSError * _Nullable error);

//Public
typedef void (^MNFPublicCompletionHandler)(MNFPublic *_Nullable publicSettings, NSError *_Nullable error);
typedef void (^MNFPostalCodeCompletionHandler)(MNFPostalCode *_Nullable postalCode, NSError *_Nullable error);
typedef void (^MNFMultiplePostalCodesCompletionHandler)(NSArray <MNFPostalCode*> *_Nullable postalCodes, NSError *_Nullable error);

//Organizations
typedef void (^MNFOrganizationsCompletionHandler)(NSArray <MNFOrganization *> *_Nullable organizations, NSError *_Nullable error);

//Authentication
typedef void (^MNFAuthenticationCompletionHandler)(MNFAuthentication *_Nullable authentication, NSError *_Nullable error);

//User events
typedef void (^MNFUserEventSubscriptionDetailCompletionHandler)(NSArray <MNFUserEventSubscriptionDetail *> *_Nullable subscriptionDetails, NSError *_Nullable error);

//Repayment Account info keys
extern NSString *const _Nonnull kMNFRepaymentAccountInfoBankAccountNumberKey;// bankAccountNumber
extern NSString *const _Nonnull kMNFRepaymentAccountInfoLedgerKey;// ledger
extern NSString *const _Nonnull kMNFRepaymentAccountInfoSocialSecurityNumberKey;// socialSecurityNumber
extern NSString *const _Nonnull kMNFRepaymentAccountInfoBankNumberKey;//bankNumber

//Error message json key
extern NSString *const _Nonnull kMNFErrorMessageJSONKey;


//Error domains
extern NSString *const _Nonnull MNFMenigaErrorDomain;

typedef NS_ENUM(NSInteger, MNFErrorCode){
    
    /**
     @abstract Invalid response from server.
     */
    kMNFErrorInvalidResponse = 1,
    /**
     @abstract Incorrect data format.
     */
    kMNFErrorIncorrectDataFormat = 150,
    /**
     @abstract Invalid operation, attempting to perform operation not allowed.
     */
    kMNFErrorInvalidOperation = 151,
    /**
     @abstract Invalid parameter, attempting to pass parameter not allowed.
     */
    kMNFErrorInvalidParameter = 152,
    /**
     @abstract Server not responding because device has no internet connection.
     */
    kMNFErrorNoInternetConnection = 153,
    /**
     @abstract Server not responding due to an internal server error.
     */
    kMNFErrorServerNotResponding = 154,
    /**
     @abstract Method execution is cancelled, most likely because of a deleted object.
     */
    kMNFErrorMethodExecution = 155,
    /**
     @abstract Server authentication failed. Check authentication provider.
     */
    kMNFErrorAuthenticationFailed = 156
};

//Log levels
typedef NS_ENUM(NSInteger, MNFLogLevel) {
    
    /**
     @abstract No information logged from the sdk.
     */
    kMNFLogLevelNone = 0,
    /**
     @abstract All error messages logged from the sdk.
     */
    kMNFLogLevelError,
    /**
     @abstract Information on unexpected behaviour that might cause errors.
     */
    kMNFLogLevelWarning,
    /**
     @abstract Only info on sdk actions logged.
     */
    kMNFLogLevelInfo,
    /**
     @abstract Detailed info on sdk actions.
     */
    kMNFLogLevelDebug,
    /**
     @abstract Complete information log including raw json data and serialization actions.
     */
    kMNFLogLevelVerbose
};

typedef NS_ENUM(NSInteger,MNFGroupedBy){
    /**
     @abstract Ungrouped transaction group.
     */
    MNFGroupedByUngrouped = 0,
    /**
     @abstract Transactions grouped by date.
     */
    MNFGroupedByDate,
    /**
     @abstract Transaction grouped by category
     */
    MNFGroupedByCategory,
};

typedef NS_ENUM(NSInteger,MNFServiceName) {
    /**
     @abstract Account service includes MNFAccount, MNFAccountAuthorizationType, MNFAccountCategory, MNFAccountHistoryEntry, MNFAccountType
     */
    MNFServiceNameAccounts = 0,
    /**
     @abstract Authentication service
     */
    MNFServiceNameAuthentication,
    /**
     @abstract Budget service
     */
    MNFServiceNameBudget,
    /**
     @abstract Categories service includes MNFCategory, MNFCategoryType, MNFCategoryScore
     */
    MNFServiceNameCategories,
    /**
     @abstract Challenges service includes MNFChallenge
     */
    MNFServiceNameChallenges,
    /**
     @abstract Event tracking service
     */
    MNFServiceNameEventTracking,
    /**
     @abstract Feed service includes MNFFeed, MNFFeedItem, MNFFeedItemGroup
     */
    MNFServiceNameFeed,
    /**
     @abstract Merchants service MNFMerchant, MNFMerchantAddress
     */
    MNFServiceNameMerchants,
    /**
     @abstract MNFNetworthAccount, MNFNetworthBalanceHistory
     */
    MNFServiceNameNetWorth,
    /**
     @abstract Organizations service
     */
    MNFServiceNameOrganizations,
    /**
     @abstract Offers service includes MNFOffer, MNFOfferFilter, MNFOfferTransaction, MNFSimilarBrand, MNFRedemptions, MNFReimbursementAccount
     */
    MNFServiceNameOffers,
    /**
     @abstract Public service
     */
    MNFServiceNamePublic,
    /**
     @abstract Sync service includes MNFSynchronization, MNFAccountSyncStatus, MNFRealmSyncResponse, MNFSyncAuthRequiredParameter, MNFSyncAuthenticationChallenge
     */
    MNFServiceNameSync,
    /**
     @abstract Tags service includes MNFTags
     */
    MNFServiceNameTags,
    /**
     @abstract Transactions service includes MNFTransaction, MNFTransactionFilter, MNFTransactionGroup, MNFTransactionPage, MNFTransactionRule, MNFTransactionSeries, MNFTransactionSeriesFilter, MNFTransactionSplitAction, MNFComment
     */
    MNFServiceNameTransactions,
    /**
     @abstract Translations service
     */
    MNFServiceNameTranslations,
    /**
     @abstract Upcoming service
     */
    MNFServiceNameUpcoming,
    /**
     @abstract User events service
     */
    MNFServiceNameUserEvents,
    /**
     @abstract Users service includes MNFUser, MNFUserProfile, MNFRealmUser
     */
    MNFServiceNameUsers,
    /**
     @abstract Terms and condition service includes MNFTermsAndConditionType and MNFTermsAndConditions
     */
    MNFServiceNameTerms,
    
    /**
     @abstract Not related to any service, should not be used.
     */
    MNFServiceNameNone
};

#pragma mark - preprocessor macros

///******************************
/// @name Deprecated macros
///******************************

#ifndef MNF_DEPRECATED
#  ifdef __deprecated_msg
#    define MNF_DEPRECATED(_MSG) __deprecated_msg(_MSG)
#  else
#    ifdef __deprecated
#      define MNF_DEPRECATED(_MSG) __attribute__((deprecated))
#    else
#      define MNF_DEPRECATED(_MSG)
#    endif
#  endif
#endif

#define MNF_CLASS_UNAVAILABLE 0
