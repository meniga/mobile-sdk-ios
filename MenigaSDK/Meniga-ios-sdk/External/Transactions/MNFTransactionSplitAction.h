//
//  MNFTransactionSplitAction.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 31/03/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFObject.h"

NS_ASSUME_NONNULL_BEGIN

/**
 The MNFTransactionSplitAction class encapsulates split action json data from the server in an object.
 
 A split action can be directly initialized or initialized when fetching a transaction rule from the server.
 */
@interface MNFTransactionSplitAction : MNFObject

///************************************
/// @name Mutable properties
///************************************

/**
 @abstract The identifier of the corresponding rule.
 */
@property (nonatomic,strong) NSNumber *transactionRuleId;

/**
 @abstract Split ratio.
 */
@property (nonatomic,strong) NSNumber * _Nullable ratio;

/**
 @abstract Split amount that should be applied by the corresponding rule.
 */
@property (nonatomic,strong) NSNumber *amount;

/**
 @abstract The category id in which to put the split transaction.
 */
@property (nonatomic,strong) NSNumber *categoryId;


/**
 @abstract A convenience initializer to simply create a transaction split action. The transaction rule id and identifyer are populated by the server once it has been created.
 */
+(instancetype)transactionSplitActionWithRatio:(NSNumber *)ratio amount:(NSNumber *)amount categoryId:(NSNumber *)categoryId;

@end

NS_ASSUME_NONNULL_END
