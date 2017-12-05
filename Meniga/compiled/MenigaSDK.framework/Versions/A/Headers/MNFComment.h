//
//  MNFComment.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 17/02/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFObject.h"

NS_ASSUME_NONNULL_BEGIN

/**
 The MNFComment class encapsulates comment json data from the server in an object.
 
 A comment should not be initialized directly but rather fetched from the server through fetching transactions. A comment can be created by posting a comment to a transaction.
 */
@interface MNFComment : MNFObject

///******************************
/// @name Immutable properties
///******************************

/**
 @abstract The identifier of the person who created the comment.
 */
@property (nonatomic,strong,readonly) NSNumber *personId;

/**
 @abstract The date the comment was created.
 */
@property (nonatomic,strong,readonly) NSDate *createdDate;

/**
 @abstract The date the comment was last modified.
 */
@property (nonatomic,strong,readonly) NSDate *modifiedDate;

/**
 @abstract The identifier of the transaction the comment belongs to.
 */
@property (nonatomic,strong,readonly) NSNumber *transactionId;

///******************************
/// @name Mutable properties
///******************************

/**
 @abstract The actual comment.
 */
@property (nonatomic,copy) NSString * _Nullable comment;

///************************************
/// @name Saving
///************************************

/**
 @abstract Saves changes to a comment to the server.
 
 @param completion A completion block returning a result and an error.
 
 @return An MNFJob containing a result and an error.
 */
-(MNFJob*)saveWithCompletion:(nullable MNFErrorOnlyCompletionHandler)completion;

///************************************
/// @name Deleting
///************************************

/**
 @abstract Deletes a comment from the server.
 
 @param completion A completion block returning an error.
 
 @return An MNFJob containing an error.
 
 @warning Remember to deallocate objects that have been deleted from the server.
 */
-(MNFJob*)deleteCommentWithCompletion:(nullable MNFErrorOnlyCompletionHandler)completion;

@end

NS_ASSUME_NONNULL_END
