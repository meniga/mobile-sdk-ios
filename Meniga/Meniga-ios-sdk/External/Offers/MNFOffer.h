//
//  MNFOffer.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 23/10/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFObject.h"

/**
 The MNFOffer class encapsulates offer json data form the server in an object.
 
 An offer should not be directly initialized but instead should be constructed with data from the server.
 The response from the server will be automatically converted to an MNFOffer object.
 */
@interface MNFOffer : MNFObject


/**
 @abstract The server identifier of the offer.
 */
@property (nonatomic,strong,readonly) NSNumber *offerId;

/**
 @abstract The title of the offer.
 */
@property (nonatomic,strong,readonly) NSString *title;

/**
 @abstract The description of the offer.
 */
@property (nonatomic,strong,readonly) NSString *offerDescription;

/**
 @abstract The validation token of the offer.
 */
@property (nonatomic,strong,readonly) NSString *validationToken;

/**
 @abstract The display state of the offer.
 */
@property (nonatomic,strong,readonly) NSNumber *displayState;

/**
 @abstract The starting time of the offer.
 */
@property (nonatomic,strong,readonly) NSDate *validFrom;

/**
 @abstract The category of the offer.
 */
@property (nonatomic,strong,readonly) NSString *offerCategory;

/**
 @abstract The merchant offering the offer.
 */
@property (nonatomic,strong,readonly) NSString *merchant;

/**
 @abstract The icon code for the offer's category.
 */
@property (nonatomic,strong,readonly) NSString *categoryDisplay;

/**
 @abstract Transactions related to the offer.
 */
@property (nonatomic,strong,readonly) NSArray *transactionContainer;

/**
 @abstract The last cashback payment made to the user.
 */
@property (nonatomic,strong,readonly) NSNumber *lastPayment;

/**
 @abstract The date for the last payment.
 */
@property (nonatomic,strong,readonly) NSDate *lastPaymentDate;

/**
 @abstract The date for the next payment.
 */
@property (nonatomic,strong,readonly) NSDate *nextPaymentDate;

/**
 @abstract The amount of the next payment.
 */
@property (nonatomic,strong,readonly) NSNumber *nextPaymentScheduledAmount;

/**
 @abstract The filename of the partner's image.
 */
@property (nonatomic,strong,readonly) NSString *partnerImageFilename;

/**
 @abstract The Id of the merchant.
 */
@property (nonatomic,strong,readonly) NSNumber *merchantId;

/**
 @abstract The end time of the offer.
 */
@property (nonatomic,strong,readonly) NSDate *validTo;

/**
 @abstract The reward type of the offer.
 */
@property (nonatomic,strong,readonly) NSNumber *rewardType;

/**
 @abstract The reward amount of the offer.
 */
@property (nonatomic,strong,readonly) NSNumber *reward;

/**
 @abstract The minimum purchase amount.
 */
@property (nonatomic,strong,readonly) NSNumber *minimumPurchaseAmount;

/**
 @abstract The maximum number of purchases that can be redeemed.
 */
@property (nonatomic,strong,readonly) NSNumber *maximumPurchaseEvents;

/**
 @abstract The maximum cashback per purchase.
 */
@property (nonatomic,strong,readonly) NSNumber *maximumCashbackPerPurchase;

/**
 @abstract The maximum cashback per offer.
 */
@property (nonatomic,strong,readonly) NSNumber *maximumCashbackPerOffer;

/**
 @abstract The minimum accumulated amount to redeemable.
 */
@property (nonatomic,strong,readonly) NSNumber *minimumAccumulatedAmount;

/**
 @abstract The total redeemed amount.
 */
@property (nonatomic,strong,readonly) NSNumber *totalRedeemedAmount;

/**
 @abstract The total repayed amount.
 */
@property (nonatomic,strong,readonly) NSNumber *totalRepayedAmount;

/**
 @abstract The number of days left of the offer.
 */
@property (nonatomic,strong,readonly) NSNumber *daysleft;

/**
 @abstract The offer goal (onboarding, uplift, loyalty, rescue).
 */
@property (nonatomic,strong,readonly) NSNumber *offerGoal;

/**
 @abstract The reason for the offer.
 */
@property (nonatomic,strong,readonly) NSString *offerReason;

/**
 @abstract The date the offer was accepted.
 */
@property (nonatomic,strong,readonly) NSDate *acceptanceDate;

/**
 @abstract The date the offer was available to the user.
 */
@property (nonatomic,strong,readonly) NSDate *availableFrom;

/**
 @abstract The cashback prediction of the offer.
 */
@property (nonatomic,strong,readonly) NSDictionary *cashbackPrediction;

/**
 @abstract The date the offer was declined.
 */
@property (nonatomic,strong,readonly) NSDate *declineDate;

/**
 @abstract Whether the offer was declined because the merchant declined.
 */
@property (nonatomic,strong,readonly) NSNumber *merchantDeclined;

/**
 @abstract The offer's category Id.
 */
@property (nonatomic,strong,readonly) NSNumber *offerCategoryId;

/**
 @abstract The offer's repayment records.
 */
@property (nonatomic,strong,readonly) NSArray *repaymentRecords;

/**
 @abstract The website of the merchant behind the offer.s
 */
@property (nonatomic,strong,readonly) NSString *merchantWebsite;

/**
 @description Fetches an offer with a given identifier from the server
 
 @param identifier The identifier of the offer
 
 @return The completion block returns an MNFOffer and an error.
 */
+(void)fetchWithId:(NSNumber *)identifier completion:(MNFFetchOfferCompletionHandler)completion;

+(MNFJob*)fetchWithId:(NSNumber *)identifier;

/**
 @description Fetches all offers available to the user.
 
 @return The completion block returns an array of offers and an error.
 */
+(void)fetchOffersWithCompletion:(MNFCompletionHandler)completion;

/**
 @description Fetches all offers available to the user.
 
 @return MNFJob A job containing an array of offers or an error.
 */
+(MNFJob*)fetchOffers;

/**
 @description Creates a repayment account that receives cashback from offers.
 
 @param displayName The display name of the repayment account
 @param repaymentType The repayment type of the account.
 @param accountInfo The account information such as bank number, social security number etc.
 
 @return The completion block returns the server result and an error.
 */
+(void)createRepaymentAccountWithDisplayName:(NSString*)displayName repaymentType:(NSString*)repaymentType accountInfo:(NSString*)accountInfo completion:(MNFCompletionHandler)completion;

/**
 @description Creates a repayment account that receives cashback from offers.
 
 @param displayName The display name of the repayment account
 @param repaymentType The repayment type of the account.
 @param accountInfo The account information such as bank number, social security number etc.
 
 @return MNFJob A job containing the server result or an error.
 */
+(MNFJob*)createRepaymentAccountWithDisplayName:(NSString*)displayName repaymentType:(NSString*)repaymentType accountInfo:(NSString*)accountInfo;

/**
 @description Deletes a repayment account with a given identifier.
 
 @param accountId The identifier for the account
 
 @return The completion block returns the server result and an error.
 */
+(void)deleteRepaymentAccountWithId:(NSString*)accountId completion:(MNFCompletionHandler)completion;

/**
 @description Deletes a repayment account with a given identifier.
 
 @param accountId The identifier for the account
 
 @return MNFJob A job containing the server result or an error.
 */
+(MNFJob*)deleteRepaymentAccountWithId:(NSString*)accountId;

/**
 @description Updates a repayment account with given parameters.
 
 @param accountId The identifier for the account to be updated.
 @param displayName The new display name.
 @param accountInfo The new account information.
 
 @return The completion block returns the server result and an error.
 */
+(void)updateRepaymentAccountWithId:(NSString*)accountId displayName:(NSString*)displayName accountInfo:(NSString*)accountInfo completion:(MNFCompletionHandler)completion;

/**
 @description Updates a repayment account with given parameters.
 
 @param accountId The identifier for the account to be updated.
 @param displayName The new display name.
 @param accountInfo The new account information.
 
 @return MNFJob A job containing the server result and an error.
 */
+(MNFJob*)updateRepaymentAccountWithId:(NSString*)accountId displayName:(NSString*)displayName accountInfo:(NSString*)accountInfo;

/**
 @description Fetches the terms and conditions for cashback offers.
 
 @return The completion block returns the server result and an error.
 */
+(void)getTermsAndConditionsWithCompletion:(MNFCompletionHandler)completion;

/**
 @description Fetches the terms and conditions for cashback offers.
 
 @return MNFJob A job containing the server result and an error.s
 */
+(MNFJob*)getTermsAndConditions;

/**
 @description Accepts the terms and conditions for cashback offers.
 
 @return The completion block returns the server result and an error.
 */
+(void)acceptTermsAndConditionsWithCompletion:(MNFCompletionHandler)completion;

/**
 @description Accepts the terms and conditions for cashback offers.
 
 @return MNFJob A job containing the server result and an error.
 */
+(MNFJob*)acceptTermsAndConditions;

/**
 @description Accepts the offer.
 
 @return The completion block returns the server result and an error.
 */
-(void)acceptOfferWithCompletion:(MNFCompletionHandler)completion;

/**
 @description Accepts the offer.
 
 @return MNFJob A job containing the server result and an error.
 */
-(MNFJob*)acceptOffer;

/**
 @description Declines the offer.
 
 @return The completion block returns the server result and an error.
 */
-(void)declineOfferWithCompletion:(MNFCompletionHandler)completion;

/**
 @description Declines the offer.
 
 @return MNFJob A job containing the server result and an error.
 */
-(MNFJob*)declineOffer;

/**
 @description Refreshes the offer with data from the server.
 
 @return The completion block returns an error.
 */
-(void)refreshWithCompletion:(MNFErrorOnlyCompletionHandler)completion;

/**
 @description Refreshes the offer with data from the server.
 
 @return MNFJob A job containing an error.
 */
-(MNFJob*)refresh;

@end
