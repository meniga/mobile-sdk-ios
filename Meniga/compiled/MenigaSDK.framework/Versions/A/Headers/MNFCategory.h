//
//  MNFCategory.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 23/10/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFObject.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, MNFCategoryTypeId) {
    kMNFCategoryTypeExpenses = 0,
    kMNFCategoryTypeIncome = 1,
    kMNFCategoryTypeSavings = 2,
    kMNFCategoryTypeExcluded = 3
};

/**
 An MNFCategory encapsulates category json data from the server in an object.
 
 A category should not be directly initialized but instead should be constructed with data from the server.
 The response from the server will be automatically converted to an MNFCategory object.
 
 */
@interface MNFCategory : MNFObject {
@protected
    NSArray *_children;
}

/**
 @abstract The default name of a parent category when presented as 'other' category
 */
@property (nonatomic,strong,readonly) NSString *otherCategoryName;

/**
 @abstract Whether the category is a public category or a user created category.
 */
@property (nonatomic,strong,readonly) NSNumber *isSystemCategory;


/**
 @abstract The category rank.
 */
@property (nonatomic,strong,readonly) NSString *categoryRank;

/**
 @abstract The budget generation type.
 */
@property (nonatomic,strong,readonly) NSNumber *budgetGenerationType;

/**
 @abstract A list of the category's children.
 */
@property (nonatomic,strong,readonly) NSArray *children;

/**
 @abstract The category context identifier.
 
 @discussion Indicates what context the category belongs to; normal or small business user.
 */
@property (nonatomic,strong,readonly) NSNumber *categoryContextId;

/**
 @abstract The ascending order of the category.
 */
@property (nonatomic,strong,readonly) NSNumber *orderId;

/**
 @abstract Additional data for displaying the category.
 */
@property (nonatomic,strong,readonly) NSString *displayData;


// Mutable state

/**
 @abstract The name of the category.
 */
@property (nonatomic, strong, readwrite) NSString *name;

/**
 @abstract The server identifier of a parent category.
 
 @discussion If the category is not a child category this value is nil.
 */
@property (nonatomic, strong, readwrite) NSNumber *parentCategoryId;

/**
 @abstract Whether the category is a fixed expenses category.
 */
@property (nonatomic, strong, readwrite) NSNumber *isFixedExpenses;

/**
 @abstract The category type.
 */
@property (nonatomic, readwrite) MNFCategoryTypeId categoryTypeId;


/**
 @description Fetches a category with a given identifier from the server.
 
 @warning does not fetch the children of the category.
 
 @param theCulture you can explicitly state the culture you want for the categories you are fetching. If nil is passed it uses the default culture of the user which can be set in MNFUser.
 @param completion A completion block returning either an MNFCategory or an error.
 
 @return MNFJob containing the result as an NSArray of MNFCategories or an error if applicable.
 */
+(MNFJob*)fetchWithId:(NSNumber *)identifier culture:(nullable NSString*)theCulture completion:(nullable MNFCategoryCompletionHandler)completion;

/**
 @description Fetches all user created categories
 
 @param theCulture you can explicitly state the culture you want for the categories you are fetching. If nil is passed it uses the default culture of the user which can be set in MNFUser.
 @param completion A completion block returning an NSArrary of MNFCategories or an error if applicable.
 
 @return MNFJob containing the results as an NSArrary of MNFCategories or an error if applicable.

 */
+(MNFJob*)fetchUserCreatedCategoriesWithCulture:(nullable NSString*)theCulture completion:(nullable MNFMultipleCategoriesCompletionHandler)completion;

/**
 @description Fetches all system categories.
 
 @param theCulture you can explicitly state the culture you want for the categories you are fetching. If nil is passed it uses the default culture of the user which can be set in MNFUser.
 @param completion A completion block returning an NSArray of MNFCategories or an error.
 
 @return MNFJob containing the results as an NSArray of MNFCategories or an error if applicable.
 */
+(MNFJob*)fetchSystemCategoriesWithCulture:(nullable NSString*)theCulture completion:(nullable MNFMultipleCategoriesCompletionHandler)completion;

/**
 @description Fetches all categories both system and user categories.
 
 @param theCulture you can explicitly state the culture you want for the categories you are fetching. If nil is passed it uses the default culture of the user which can be set in MNFUser.
 @param completion a completion block returning an NSArray of MNFCategories or an error.
 
 @return MNFJob containing the results as an NSArray of MNFCategories or an error if applicable.
 */
+(MNFJob*)fetchCategoriesWithCulture:(nullable NSString*)theCulture completion:(nullable MNFMultipleCategoriesCompletionHandler)completion;

/**
 @description Fetches all categories and creates the tree structure for the categories
 
 @param theCulture you can explicitly state the culture you want for the categories you are fetching. If nil is passed it uses the default culture of the user which can be set in MNFUser.
 @param completion a block returning an NSArray of MNFCategories in a tree structure or an error.
 
 @return MNFJob containing the results as an NSArray of MNFCategories or an error if applicable
 */
+(MNFJob*)fetchCategoryTreeWithCulture:(nullable NSString*)theCulture completion:(nullable MNFMultipleCategoriesCompletionHandler)completion;

/**
 @description Fetches the category types.
 
 @param completion A completion block with an NSArray of MNFCategoryType instances or an error if one occurred.
 
 @return A job returning an NSArray of MNFCategoryType instances.
 */
+(MNFJob*)fetchCategoryTypesWithCompletion:(nullable MNFMultipleCategoryTypesCompletionHandler)completion;

/**
 @description Creates a user category and returns it with a completion block. User categories can be distinguished by system categories using the isSystemCategory parameter.
 
 @param theName The name of the category to be created.
 @param isFixedExpense A boolean variable wrapped in an NSNumber to indicate whether the category is a fixed expense or not. If nil is passed then by default it is not a fixed expense.
 @param theCategoryType An integer variable wrapped in an NSNumber to indicate the type of cateogry.
 @param completion An MNFCategory sent in the completion block or an error if one occurred.
 
 @return An MNFCategory sent in the completion block or an error if one occurred.
 */
+(MNFJob*)createUserParentCategoryWithName:(NSString *)theName isFixedExpense:(nullable NSNumber*)isFixedExpense categoryType:(MNFCategoryTypeId)theCategoryType completion:(nullable MNFCategoryCompletionHandler)completion;

/**
 @description Creates a user category and returns it with a completion block. User categories can be distinguished by system categories using the isSystemCategory parameter.
 
 @param theName The name of the category to be created.
 @param isFixedExpense A boolean variable wrapped in an NSNumber to indicate whether the category is a fixed expense or not. If nil is passed then by default it is not a fixed expense.
 @param theParentCategoryType An integer variable wrapped in an NSNumber to indicate the type of cateogry.
 @param theParentCategoryId The id of the parent of the userCategory. Pass nil if you want the category to be a parent category.
 @param completion An MNFCategory sent in the completion block or an error if one occurred.
 
 @return An MNFCategory sent in the completion block or an error if one occurred.
 */
+(MNFJob*)createUserChildCategoryWithName:(NSString *)theName isFixedExpense:(nullable NSNumber *)isFixedExpense parentCategoryType:(MNFCategoryTypeId)theParentCategoryType parentCategoryId:(NSNumber *)theParentCategoryId completion:(nullable MNFCategoryCompletionHandler)completion;

/**
 @description Saves changes to the user category to the server. Or if it is a new category, it creates it on the server and updates it.
 
 @param completion A completion block returning the server result and an error.
 
 @return MNFJob A job containing the server result and an error.
 */
-(MNFJob*)saveWithCompletion:(nullable MNFErrorOnlyCompletionHandler)completion;

/** 
 @description Refreshes the given category by fetching it from the server.

 @warning does not update the children of the category.
 
 @param completion A completion returning an NSError if the refresh failed.
 
 @return MNFJob containing an NSError if the refresh failed.
 */
-(MNFJob*)refreshWithCompletion:(nullable MNFErrorOnlyCompletionHandler)completion;

/**
 @description Deletes the user category from the server.
 
 @param completion A completion block returning an error.
 
 @return MNFJob A job containing an error.
 
 @warning Remember to deallocate objects that have been deleted from the server.
 */
-(MNFJob*)deleteCategoryWithConnectedRules:(nullable NSNumber*)deleteConnectedRules moveTransactionsToNewCategoryId:(nullable NSNumber *)theNewCategoryId completion:(nullable MNFErrorOnlyCompletionHandler)completion;

/**
 @description Creates a category tree from a list of categories.
 
 @param categories The categories to use to create the tree.
 
 @return A category tree made from the categories provided.
 */
+ (NSArray <MNFCategory *> *)categoryTreeFromCategories:(NSArray <MNFCategory *> *)categories;

/**
 @description Creates a flat list of categories from a category tree.
 
 @param categoryTree The category tree to create the list from.
 
 @return A flat list of categories made from the category tree provided.
 */
+ (NSArray<MNFCategory *> *)categoriesFromCategoryTree:(NSArray <MNFCategory *> *)categoryTree;

@end

NS_ASSUME_NONNULL_END
