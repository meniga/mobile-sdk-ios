//
//  MNFCustomChallenge.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 26/01/17.
//  Copyright © 2017 Meniga. All rights reserved.
//

#import "MNFObject.h"

NS_ASSUME_NONNULL_BEGIN

/**
 The MNFCustomChallenge class represents a custom challenge created by the user.
 */
@interface MNFCustomChallenge : MNFObject

///******************************
/// @name Mutable properties
///******************************

/**
 The category ids of the categories for this challenge.
 */
@property (nonatomic,copy) NSArray *_Nullable categoryIds;

/**
 The target spending amount of this challenge.
 */
@property (nonatomic,strong) NSNumber *_Nullable targetAmount;

/**
 The spend amount of this challenge.
 */
@property (nonatomic,strong,readonly) NSNumber *_Nullable spentAmount;

/**
 Any custom metadata that describes this challenge.
 */
@property (nonatomic,copy) NSString *_Nullable metaData;

/**
 The interval with which this challenge repeates.
 */
@property (nonatomic,strong,readonly) NSString *_Nullable recurringInterval;

@end

NS_ASSUME_NONNULL_END
