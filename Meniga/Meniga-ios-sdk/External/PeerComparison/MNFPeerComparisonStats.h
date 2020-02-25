//
//  MNFPeerComparisonStats.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 15/03/2018.
//  Copyright © 2018 Meniga. All rights reserved.
//

#import "MNFObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface MNFPeerComparisonStats : MNFObject

@property (nonatomic, strong, readonly) NSNumber *transactionAmountAverage;
@property (nonatomic, strong, readonly) NSNumber *amountSumAverage;
@property (nonatomic, strong, readonly) NSNumber *transactionCountAverage;

@end

NS_ASSUME_NONNULL_END
