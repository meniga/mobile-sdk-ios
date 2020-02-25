//
//  MNFUpcomingThreshold.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 30/09/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFObject.h"

NS_ASSUME_NONNULL_BEGIN

/**
 The MNFUpcomingThreshold class contains information on a threshold the user has set for an account.
 */
@interface MNFUpcomingThreshold : MNFObject

///******************************
/// @name Immutable properties
///******************************

/**
 The id of the account group for which the threshold is valid.
 */
@property (nonatomic, strong, readonly) NSNumber *accountSetId MNF_DEPRECATED("Not available in api version 3.8");

/**
 The currency of the threshold set's threshold values. If all associated accounts are in the same currency then that currency is used. If the account currencies are different the user currency is used.
 */
@property (nonatomic, strong, readonly) NSString *currencyCode;

///******************************
/// @name Mutable properties
///******************************

/**
 A collection of account ids for which the threshold is valid. If nothing specified the threshold will be applied to all the user's accounts.
 */
@property (nonatomic, copy) NSArray *accountIds;

/**
 A collection of lower thresholds for the thresholds set in the currency of 'CurrencyCode'.
 */
@property (nonatomic, copy) NSArray *lowerThresholds;

/**
 A collection of upper thresholds for the thresholds set in the currency of 'CurrencyCode'.
 */
@property (nonatomic, copy) NSArray *upperThresholds;

/**
 A decimal specifying the value of the threshold.
 */
@property (nonatomic, strong) NSNumber *value MNF_DEPRECATED("Not available in api version 3.8");

/**
 Whether the threshold is an upper limit or not.
 */
@property (nonatomic, strong) NSNumber *isUpperLimit MNF_DEPRECATED("Not available in api version 3.8");

/**
 Fetches a threshold with a given identifier.
 
 @param identifier The id of the threshold.
 @param completion A completion block returning a threshold and an error.
 
 @return MNFJob A job containing a threshold and an error.
 */
+ (MNFJob *)fetchWithId:(NSNumber *)identifier
             completion:(nullable MNFThresholdCompletionHandler)completion
    MNF_DEPRECATED("Not available in api version 3.8");

/**
 Fetches a list of thresholds filtered by account ids.
 
 @param accountIds A comma seperated string of account ids to filter by. If nil returns all.
 @param completion A completion block returning a list of thresholds and an error.
 
 @return MNFJob A job containing a list of thresholds and an error.
 */
+ (MNFJob *)fetchThresholdsWithAccountIds:(nullable NSString *)accountIds
                               completion:(nullable MNFMultipleThresholdsCompletionHandler)completion;

/**
 Creates a threshold on the server for give account ids.
 
 @param value The value of the threshold.
 @param isUpperLimit Whether the threshold is an upper limit or not.
 @param accountIds A list of account ids for which the threshold is valid.
 @param completion A completion block returning the created threshold and an error.
 
 @return MNFJob A job containing the created threshold and an error.
 */
+ (MNFJob *)createThresholdWithValue:(nullable NSNumber *)value
                        isUpperLimit:(nullable NSNumber *)isUpperLimit
                          accountIds:(NSArray<NSNumber *> *)accountIds
                          completion:(nullable MNFThresholdCompletionHandler)completion
    MNF_DEPRECATED("User 'createThresholdSetWithLowerThresholds:...' instead");

/**
 Creates a threshold on the server for give account ids.
 
 @param lowerThresholds A list of lower thresholds.
 @param upperThresholds A list of upper thresholds.
 @param accountIds A list of account ids for which the threshold is valid.
 @param completion A completion block returning the created threshold and an error.
 
 @return MNFJob A job containing the created threshold and an error.
 */
+ (MNFJob *)createThresholdSetWithLowerThresholds:(NSArray<NSNumber *> *)lowerThresholds
                                  upperThresholds:(NSArray<NSNumber *> *)upperThresholds
                                       accountIds:(NSArray<NSNumber *> *)accountIds
                                       completion:(nullable MNFThresholdCompletionHandler)completion;

/**
 Deletes the threshold from the server.
 
 @param completion A completion block returning an error.
 
 @return MNFJob A job containing an error.
 
 @note Remember to deallocate objects that have been deleted from the server.
 */
- (MNFJob *)deleteThresholdWithCompletion:(nullable MNFErrorOnlyCompletionHandler)completion;

/**
 Save changes to a threshold on the server.
 
 @param completion A completion block returning an error.
 
 @return MNFJob A job containing an error.s
 */
- (MNFJob *)saveWithCompletion:(nullable MNFErrorOnlyCompletionHandler)completion;

@end

NS_ASSUME_NONNULL_END
