//
//  MNFBudgetRuleRecurringPattern.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 29/11/2018.
//  Copyright © 2018 Meniga. All rights reserved.
//

#import "MNFObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface MNFBudgetRuleRecurringPattern : MNFObject

///******************************
/// @name Mutable properties
///******************************

/**
 The monthly interval of the recurrence.
 */
@property (nonatomic,strong) NSNumber *_Nullable monthInterval;

@end

NS_ASSUME_NONNULL_END
