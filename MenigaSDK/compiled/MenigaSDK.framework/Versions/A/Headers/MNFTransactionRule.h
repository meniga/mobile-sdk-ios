//
//  MNFTransactionRule.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 31/03/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFObject.h"

NS_ASSUME_NONNULL_BEGIN

@class MNFTransactionSplitAction;

/**
 The MNFTransactionRule class encapsulates transaction rule json data from the server in an object.
 
 A transaction rule can be initialized directly or fetched from the server. When creating a new transaction rule populate properties accordingly before calling save.
 This will create the rule on the server and assign it a userId and the requisite dates. Use the applyOnExisting property to indicate whether this rule should apply to existing transactions.
 */
@interface MNFTransactionRule : MNFObject

///************************************
/// @name Immutable properties
///************************************

/**
 @abstract The user identifier for the transaction rule.
 */
@property (nonatomic,strong,readonly) NSNumber *userId;

/**
 @abstract The date the transaction rule was created.
 */
@property (nonatomic,strong,readonly) NSDate *createdDate;

/**
 @abstract The date the transaction rule was last modified.
 */
@property (nonatomic,strong,readonly) NSDate *modifiedDate;

///************************************
/// @name Mutable properties
///************************************

/**
 @abstract The name of the transaction rule.
 */
@property (nonatomic,copy) NSString * _Nullable name;

/**
 @abstract A text criteria to match by this rule, or null if this rule has no text criteria.
 */
@property (nonatomic,copy) NSString * _Nullable textCriteria;

/**
 @abstract The type of operater to use when evaluating text criteria.
 */
@property (nonatomic,strong) NSNumber * _Nullable textCriteriaOperatorType;

/**
 @abstract A date match criteria for the rule. (0 = first, 1 = last).
 */
@property (nonatomic,strong) NSNumber * _Nullable dateMatchTypeCriteria;

/**
 @abstract The number of days to use when using dateMatchTypeCriteria for the rule.
 */
@property (nonatomic,strong) NSNumber * _Nullable daysLimitCriteria;

/**
 @abstract Amount criteria for the rule. (0 = amount under, 1 = amount over, 2 = amount equals).
 */
@property (nonatomic,strong) NSNumber * _Nullable amountLimitTypeCriteria;

/**
 @abstract Amount limit sign criteria for the rule. (0 = income or expense, 1 = expense, 2 = income).
 */
@property (nonatomic,strong) NSNumber * _Nullable amountLimitSignCriteria;

/**
 @abstract Amount criteria for the rule.
 */
@property (nonatomic,strong) NSNumber * _Nullable amountCriteria;

/**
 @abstract A comma seperated list of account category integers that should be matched before applying actions. (1 = Current, 2 = Credit, 3 = Savings).
 */
@property (nonatomic,copy) NSString * _Nullable accountCategoryCriteria;

/**
 @abstract Accept action for the rule.
 */
@property (nonatomic,strong) NSNumber * _Nullable acceptAction;

/**
 @abstract Month shift action for the rule.
 */
@property (nonatomic,strong) NSNumber * _Nullable monthShiftAction;

/**
 @abstract Remove action for the rule.
 */
@property (nonatomic,strong) NSNumber * _Nullable removeAction;

/**
 @abstract Text action for the rule.
 */
@property (nonatomic,copy) NSString * _Nullable textAction;

/**
 @abstract Comment action for the rule.
 */
@property (nonatomic,copy) NSString * _Nullable commentAction;

/**
 @abstract Tag action for the rule.
 */
@property (nonatomic,copy) NSString * _Nullable tagAction;

/**
 @abstract Categorization to apply by this rule.
 */
@property (nonatomic,strong) NSNumber * _Nullable categoryIdAction;

/**
 @abstract Split actions to perform by this rule.
 */
@property (nonatomic,copy) NSArray <MNFTransactionSplitAction *> * _Nullable splitActions;

/**
 @abstract Whether to flag transactions mathicng this rule.
 */
@property (nonatomic,strong) NSNumber * _Nullable flagAction;

/**
 @abstract Fetches a transaction rule with a given identifier.
 
 @param identifier The identefier of the rule to be fetched.
 @param completion A completion block returning a transaction rule and an error.
 
 @return An MNFJob containing a transaction rule and an error.
 */
+(MNFJob*)fetchRuleWithId:(NSNumber*)identifier completion:(MNFTransactionRuleCompletionHandler)completion;

/**
 @abstract Fetches a list of transaction rules.
 
 @param completion A completion block returning a list of transaction rules and an error.
 
 @return An MNFJob containing a list of transaction rules and an error.
 */
+(MNFJob*)fetchRulesWithCompletion:(MNFMultipleTransactionRulesCompleitonHandler)completion;

/**
 @abstract Creates a transaction rule.
 
 @return An MNFJob containing a transaction rule and an error
 
 */
+(MNFJob *)createRuleWithName:(nullable NSString *)theRuleName textCriteria:(nullable NSString *)textCriteria textCriteriaOperatorType:(nullable NSNumber *)operatorType dateMatchTypeCriteria:(nullable NSNumber *)dateMatchTypeCriteria daysLimitCriteria:(nullable NSNumber *)daysLimitCriteria amountLimitTypeCriteria:(nullable NSNumber *)amountLimitTypeCriteria amountLimitSignCriteria:(nullable NSNumber *)amountLimitSignCriteria amountCriteria:(nullable NSNumber *)amountCritera accountCategoryCriteria:(nullable NSString *)accountCategoryCriteria acceptAction:(nullable NSNumber *)acceptAction monthShiftAction:(nullable NSNumber *)monthShiftAction removeAction:(nullable NSNumber *)removeAction textAction:(nullable NSString *)textAction commentAction:(nullable NSString *)commentAction categoryIdAction:(nullable NSNumber *)categoryIdAction splitActions:(nullable NSArray *)splitActions flagAction:(nullable NSNumber *)flagAction applyOnExisting:(NSNumber *)applyOnExisting completion:(MNFTransactionRuleCompletionHandler)completion;


/**
 @abstract Deletes a rule from the server.
 
 @param completion A completino block returning an error.
 
 @return An MNFJob containing an error.
 
 @warning Remember to deallocate objects that have been deleted from the server.
 */
-(MNFJob*)deleteRuleWithCompletion:(nullable MNFErrorOnlyCompletionHandler)completion;

/**
 @abstract Saves a transaction rule to the server.
 
 @param completion A completion block returning an error.
 
 @return An MNFJob containing an error.
 
 @discussion Used to save changes made to a rule.
 */
-(MNFJob*)saveAndApplyOnExisting:(NSNumber *)applyOnExisting completion:(nullable MNFErrorOnlyCompletionHandler)completion;

/**
 @abstract Refreshes a rule with data from the server.
 
 @param completion A completion block returning an error.
 
 @return An MNFJob containing an error.
 */
-(MNFJob*)refreshWithCompletion:(nullable MNFErrorOnlyCompletionHandler)completion;

@end

NS_ASSUME_NONNULL_END
