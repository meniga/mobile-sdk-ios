//
//  MNFLifeGoalAccountInfo.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 15/03/2018.
//  Copyright © 2018 Meniga. All rights reserved.
//

#import "MNFObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface MNFLifeGoalAccountInfo : MNFObject

/**
 The name of the life goal bank account.
 */
@property (nonatomic, copy, readonly) NSString *name;

/**
 The id of the life goal bank account.
 */
@property (nonatomic, strong, readonly) NSNumber *accountId;

/**
 The balance of the account.
 */
@property (nonatomic, strong, readonly) NSNumber *balance;

@end

NS_ASSUME_NONNULL_END
