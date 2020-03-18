//
//  MNFNetworthHistory.h
//  Meniga-ios-sdk
//
//  Created by Aske Bendtsen on 30/03/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFObject.h"
NS_ASSUME_NONNULL_BEGIN

@interface MNFNetworthBalanceHistory : MNFObject
/**
 @abstract ID of the networth account
 @discussion The Meniga AccountID of the account from which this balance belongs to.
 */
@property (nonatomic, strong, readonly) NSNumber *accountId;
/**
 @abstract Balance of the networth account
 @discussion Balance at the time of last update.
 */
@property (nonatomic, strong) NSNumber *balance;
/**
 @abstract Date of the balance of the networth account
 @discussion The time at which the balance was recorded.
 */
@property (nonatomic, strong) NSDate *balanceDate;
/**
 @abstract Whether the balance history has been created with default values.
 @discussion Indicates if the entry has been generated with default values. This happens when there is missing months (in the database) between the start and end date ranges sent in by the client.
 */
@property (nonatomic, strong, readonly) NSNumber *isDefault;

/**
 The balance of the networth account in user currency.
 */
@property (nonatomic, strong, readonly) NSNumber *balanceInUserCurrency;

/**
 @abstract Deletes the object on the remote.
 @param completion completion executing with an error or result
 @discussion When an object has been deleted on the remote, it is marked deleted internally. All future actions on the local object will be ignored. It is recomended to deallocate the object and remove from any collection or container.
 
 @return Returns an MNFJob with a result or error.
 */
- (MNFJob *)deleteWithCompletion:(nullable MNFErrorOnlyCompletionHandler)completion;

/**
 @abstract Saves the object to the remote.
 @param completion completion executing with an error or result
 @discussion Only the mutable properties of the object will be updated.
 @return Returns an MNFJob with a result or error.
 */
- (MNFJob *)saveWithCompletion:(nullable MNFErrorOnlyCompletionHandler)completion;

@end

NS_ASSUME_NONNULL_END
