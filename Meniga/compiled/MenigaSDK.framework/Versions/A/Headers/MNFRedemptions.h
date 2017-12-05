//
//  MNFRedemptions.h
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 5/17/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface MNFScheduledReimbursement: NSObject

@property (nonatomic, strong, nullable, readonly) NSDate *date;
@property (nonatomic, strong, nullable, readonly) NSString *account;
@property (nonatomic, strong, nullable, readonly) NSNumber *amount;

@end

/**
 @abstract The meta data containing information on all of the redemptions so far such as all of the redeemed amount of the transactions, number of activated offers and other usefule information such as scheduled reimbursements
 */
@interface MNFRedemptionsMetaData: MNFObject

@property (nonatomic, strong, nullable, readonly) NSNumber *redeemedAmount;
@property (nonatomic, strong, nullable, readonly) NSNumber *nextReimbursementAmount;
@property (nonatomic, strong, nullable, readonly) NSNumber *activatedOffers;
@property (nonatomic, strong, nullable, readonly) NSNumber *spentAmount;
@property (nonatomic, strong, nullable, readonly) NSNumber *totalCount;
@property (nonatomic, strong, nullable, readonly) NSArray <MNFScheduledReimbursement *> *scheduledReimbursements;

@end

@interface MNFRedemptions : MNFObject

+(MNFJob*)fetchRedemptionsFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate skip:(NSNumber *)skip take:(NSNumber *)take completion:(MNFRedemptionsCompletionHandler)completion;

@end

NS_ASSUME_NONNULL_END
