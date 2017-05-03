//
//  MNFUserCategory.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 23/10/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFObject.h"

/**
 The MNFUserCategory class encapsulates user created category json data from the server in an object.
 
 A user category can be directly initialized and saved to be created on the server.
 */
@interface MNFUserCategory : MNFObject  {

@protected
    NSArray *_children;
}

/**
 @abstract The server identifier of a category.
 */
@property (nonatomic,strong,readonly) NSNumber *categoryId;

/**
 @abstract The default name of a parent category when presented as 'other' category
 */
@property (nonatomic,strong,readonly) NSString *otherCategoryName;

/**
 @abstract Whether the category is a public category or a user created category.
 */
@property (nonatomic,strong,readonly) NSNumber *isPublic;

/**
 @abstract The category rank.
 */
@property (nonatomic,strong,readonly) NSNumber *categoryRank;

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

//Mutable state

/**
 @abstract The name of the category.
 */
@property (nonatomic,strong,readwrite) NSString *name;

/**
 @abstract The server identifier of a parent category.
 
 @discussion If the category is not a child category this value is nil.
 */
@property (nonatomic,strong,readwrite) NSNumber *parentCategoryId;

/**
 @abstract Whether the category is a fixed expenses category.
 */
@property (nonatomic,strong,readwrite) NSNumber *isFixedExpenses;

/**
 @abstract The category type.
 */
@property (nonatomic,strong,readwrite) NSNumber *categoryType;

/**
 @description Fetches a user category with a given identifier from the server.
 
 @return The completion block returns either an MNFCategory or MNFUserCategory and an error.
 */
+(void)fetchWithId:(NSNumber *)identifier completion:(void (^)(id category, NSError *error))completion;

/**
 @description Fetches a user category with a given identifier from the server.
 
 @return MNFJob A job containing either an MNFCategory or MNFUserCategory and an error.
 */
+(MNFJob*)fetchWithId:(NSNumber *)identifier;

/**
 @description Fetches a list of all user categories from the server.
 
 @return The completion block returns an array of user categories and an error.
 */
+(void)fetchUserCategoriesWithCompletion:(void (^)(NSArray *userCategories, NSError *error))completion;

/**
 @description Fetches a list of all user categories from the server.
 
 @return MNFJob A job containing an array of user categories and an error.
 */
+(MNFJob*)fetchUserCategories;

/**
 @description Fetches the user category tree.
 
 @return The completion block returns an array of MNFUserCategory and an error. Each category contains an array of child categories.
 */
+(void)fetchUserCategoryTreeWithCompletion:(void (^)(NSArray *categoryTree, NSError *error))completion;

/**
 @description Fetches the user category tree.
 
 @return MNFJob A job containing an array of MNFUserCategory and an error. Each category contains an array of child categories.
 */
+(MNFJob*)fetchUserCategoryTree;

/**
 @description Saves changes to the user category to the server.
 
 @return The completion block returns the server result and an error.
 */
-(void)saveWithCompletion:(MNFSaveCompletionHandler)completion;

/**
 @description Saves changes to the user category to the server.
 
 @return MNFJob A job containing the server result and an error.
 */
-(MNFJob*)save;

/**
 @description Refreshes the user category with data from the server.
 
 @return The completion block returns an error.
 */
-(void)refreshWithCompletion:(MNFErrorOnlyCompletionHandler)completion;

/**
 @description Refreshes the user category with data from the server.
 
 @return MNFJob A job containing an error.
 */
-(MNFJob*)refresh;

/**
 @description Deletes the user category from the server.
 
 @return The completion block returns an error.
 
 @warning Remember to deallocate objects that have been deleted from the server.
 */
-(void)deleteWithCompletion:(MNFDeleteCompletionHandler)completion;

/**
 @description Deletes the user category from the server.
 
 @return MNFJob A job containing an error.
 
 @warning Remember to deallocate objects that have been deleted from the server.
 */
-(MNFJob*)deleteCategory;


@end
