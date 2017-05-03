//
//  MNFUpcomingComment.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 30/09/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFObject.h"

NS_ASSUME_NONNULL_BEGIN

/**
 The MNFUpcomingComment class contains information on a comment made to an upcoming transaction.
 */
@interface MNFUpcomingComment : MNFObject

///******************************
/// @name Immutable properties
///******************************

/**
 The date the comment was created.
 */
@property (nonatomic,strong,readonly) NSDate *created;

/**
 The date the comment was modified.
 */
@property (nonatomic,strong,readonly) NSDate *modified;

/**
 The actual comment.
 */
@property (nonatomic,copy,readonly) NSString *comment;

@end

NS_ASSUME_NONNULL_END