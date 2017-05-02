//
//  MNFCategoryScore.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 07/04/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFObject.h"

NS_ASSUME_NONNULL_BEGIN

/**
 The MNFCategoryScore class represents the probability of a category applying to a particular merchant or transaction.
 */
@interface MNFCategoryScore : MNFObject

///******************************
/// @name Immutable properties
///******************************

/**
 @abstract The id of the category.
 */
@property (nonatomic,strong,readonly) NSNumber *categoryId;

/**
 @abstract The likelyhood score of the category ranging from 0 (zero likelyhood) to 1 (highest likelyhood).
 */
@property (nonatomic,strong,readonly) NSNumber *score;

@end

NS_ASSUME_NONNULL_END