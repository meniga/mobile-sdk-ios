//
//  MNFTransactionGroup.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 14/12/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFObject.h"

NS_ASSUME_NONNULL_BEGIN

/**
 The MNFTransactionGroup class represents a list of transactions in a transaction page grouped together by either date or category.
 
 A transaction group is automatically created when performing grouping on a transaction page.
 */
@interface MNFTransactionGroup : MNFObject

/**
 @abstract The transactions in the group.
 */
@property (nonatomic,copy,readonly) NSArray *  _Nullable transactions;

/**
 @abstract The sum of the transactions in the group.
 */
@property (nonatomic,strong,readonly) NSNumber * _Nullable sum;

/**
 @abstract The rule by which the transactions are grouped.
 */
@property (nonatomic,readonly) MNFGroupedBy groupedBy;

/**
 @abstract The identifier of the group.
 
 @discussion If transactions are grouped by categories this will be the categoryId with NSNumber format. If transactions are grouped by date this will be the date with NSDate format.
 */
@property (nonatomic,strong,readonly) id  _Nullable groupId;

/**
 @abstract Initializes a transaction group object with a list of transactions. The list has to be sorted and grouped beforehand.
 
 @param groupedBy The rule by which the transactions are grouped.
 @param transactions The transactions of the group.
 
 @return An instance of MNFTransactionGroup.
 */
+(instancetype)groupBy:(MNFGroupedBy)groupedBy WithTransactions:(NSArray*)transactions;

@end

NS_ASSUME_NONNULL_END
