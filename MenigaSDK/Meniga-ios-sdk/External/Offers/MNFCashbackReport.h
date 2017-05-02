//
//  MNFCashbackReport.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 25/11/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFObject.h"

/**
 The MNFCashbackReport class encapsulates cashback report json data in an object.
 
 A cashback report should not be directly initialized but instead should be constructed with data from the server.
 The response from the server will be automatically converted to an MNFCashbackReport object.
*/
@interface MNFCashbackReport : MNFObject

/**
 @abstract The total cashback earned on offers.
 */
@property (nonatomic,strong,readonly) NSNumber *totalCashback;

/**
 @abstract The total amount ready for payout.
 */
@property (nonatomic,strong,readonly) NSNumber *totalForPayout;

/**
 @abstract The total number of accepted offers.
 */
@property (nonatomic,strong,readonly) NSNumber *acceptedOffers;

/**
 @abstract The total number of redeemed offers.
 */
@property (nonatomic,strong,readonly) NSNumber *redeemedOffers;

/**
 @abstract The total revenue from offer related transactions.
 */
@property (nonatomic,strong,readonly) NSNumber *revenue;

/**
 @abstract The total number of offers sent to the user.
 */
@property (nonatomic,strong,readonly) NSNumber *offersSent;

/**
 @abstract The total number of offers seen by the user.
 */
@property (nonatomic,strong,readonly) NSNumber *offersSeen;

/**
 @abstract
 */
@property (nonatomic,strong,readonly) NSNumber *uniqueImpressions;

/**
 @abstract The total number of unique clicks on offers by the user.
 */
@property (nonatomic,strong,readonly) NSNumber *uniqueClicks;

/**
 @abstract Whether cashback is active for the user.
 */
@property (nonatomic,strong,readonly) NSNumber *cashbackActive;

/**
 @abstract The time cashback status was last set to active.
 */
@property (nonatomic,strong,readonly) NSDate *cashbackActiveStatusLastSet;

/**
 @abstract Whether the user has accepted terms and conditions of cashback offers.
 */
@property (nonatomic,strong,readonly) NSNumber *hasAcceptedTAndC;

/**
 @abstract The total number of offers not seen by the user.
 */
@property (nonatomic,strong,readonly) NSNumber *offersNotSeen;

/**
 @abstract A list of scheduled repayments yet to be fulfilled.
 */
@property (nonatomic,strong,readonly) NSArray *scheduledRepayments;

/**
 @abstract Whether the user has an invalid repayment account.
 */
@property (nonatomic,strong,readonly) NSNumber *hasInvalidRepaymentAccount;

/**
 @abstract A list of redeemed offers.
 
 @discussion An array of dictionaries each describing each offer transaction.
 */
@property (nonatomic,strong,readonly) NSArray *redemptions;

/**
 @description Fetches a cashback report from the server.
 
 @return The completion block returns an MNFCashbackReport and an error.
 */
+(void)fetchReportWithCompletion:(MNFFetchCashbackReportCompletionHandler)completion;

/**
 @description Fetches a cashback report from the server.
 
 @return MNFJob A job containing an MNFCashbackReport or an error.
 */
+(MNFJob*)fetchReport;

/**
 @description Refreshes the cashback report with data from the server.
 
 @return The completion block returns an error.
 */
-(void)refreshWithCompletion:(MNFErrorOnlyCompletionHandler)completion;

/**
 @description Refreshes the cashback report with data from the server.
 
 @return MNFJob A job containing an error.
 */
-(MNFJob*)refresh;

@end
