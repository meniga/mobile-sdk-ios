//
//  MNFPeerComparison.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 15/03/2018.
//  Copyright © 2018 Meniga. All rights reserved.
//

#import "MNFObject.h"
#import "MNFPeerComparisonStats.h"
#import "MNFPeerComparisonMerchants.h"

NS_ASSUME_NONNULL_BEGIN

@interface MNFPeerComparison : MNFObject

@property (nonatomic,copy,readonly) NSArray <NSNumber*> *categoryIds;
@property (nonatomic,copy,readonly) NSArray <NSString*> *months;
@property (nonatomic,copy,readonly) NSArray <MNFPeerComparisonStats*> *user;
@property (nonatomic,copy,readonly) NSArray <MNFPeerComparisonStats*> *community;
@property (nonatomic,copy,readonly) NSArray <MNFPeerComparisonMerchants*> *userMerchants;
@property (nonatomic,copy,readonly) NSArray <MNFPeerComparisonMerchants*> *communityMerchants;
@property (nonatomic,copy,readonly) NSString *status;
@property (nonatomic,copy,readonly) NSString *statusMessage;

/**
 Fetches a list of peer comparison statistics for the user.
 
 @param categoryIds A comma separarted list of category ids that should be compared.
 @param excludeUser Whether the user's statistics are omitted. If null they are included.
 @param previousMonths Number of previous months to be compared. Supported values are 1,3,6 and 12.
 @param groupCategories Whether the result is aggregated over all give category ids or broken down by category. Default is false.
 @param segmentBy A comma separated list of user properties to be used for finding similar users in community. Supported values are 'age','gender','income','postalcode','numberofkids','numberofcars' and 'livingspace'.
 @param completion A completion block returning a list of peer comparison objects and an error.
 
 @return An MNFJob containing a list of peer comparison objects and an error.
 */
+(MNFJob*)fetchPeerComparisonWithCategoryIds:(nullable NSString*)categoryIds
                                 excludeUser:(nullable NSNumber*)excludeUser
                              previousMonths:(nullable NSNumber*)previousMonths
                             groupCategories:(nullable NSNumber*)groupCategories
                                   segmentBy:(nullable NSNumber*)segmentBy
                                  completion:(nullable MNFPeerComparisonCompletionHandler)completion;

+(MNFJob*)fetchTopMerchantsWithLimit:(nullable NSNumber*)limit
                              rankBy:(nullable NSNumber*)rankBy
                         excludeUser:(nullable NSNumber*)excludeUser
                         categoryIds:(nullable NSString*)categoryIds
                      previousMonths:(nullable NSNumber*)previousMonths
                     groupCategories:(nullable NSNumber*)groupCategories
                           segmentBy:(nullable NSNumber*)segmentBy
                          completion:(nullable MNFPeerComparisonCompletionHandler)completion;

@end

NS_ASSUME_NONNULL_END
