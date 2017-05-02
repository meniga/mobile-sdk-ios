//
//  MNFOffer.h
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 4/27/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFObject.h"
#import "MNFOfferFilter.h"
#import "MNFOfferRelevanceHook.h"
#import "MNFMerchantLocation.h"

NS_ASSUME_NONNULL_BEGIN

@interface MNFOffer : MNFObject

/**
 @abstract The title of the offer
 */
@property (nonatomic, copy, readonly) NSString *title;

/**
 @abstract A description of the offer for the user.
 */
@property (nonatomic, copy, readonly) NSString *offerDescription;


/**
 @abstract An identifier for the brand the offer is promoting for.
 */
@property (nonatomic, copy, readonly) NSNumber *brandId;

/**
 @abstract The name of the brand the offer is promoting for.
 */
@property (nonatomic, copy, readonly) NSString *brandName;

/**
 @abstract Offer validation token that can be used to fetch and activate offers without being logged in (email etc.)
 */
@property (nonatomic, copy, readonly) NSString *validationToken;

/**
 @abstract The state of the offer. The offer can have four different states: activated, available, declined and expired.
*/
@property (nonatomic, copy, readonly) NSString *state;

/**
 @abstract The reward type can be of type percentage or fixed amount.
 */
@property (nonatomic, copy, readonly) NSString *rewardType;

/**
 @abstract The reward amount, if the reward type is percentage it returns the percentage of the reward.
 */
@property (nonatomic, strong, readonly) NSNumber *reward;

/**
 @abstract Total amount redeemed when using the offer.
 */
@property (nonatomic, strong, readonly) NSNumber *totalRedeemedAmount;

/**
 @abstract Minimum amount which you have to purchase for in order to receive cashback for the offer.
 */
@property (nonatomic, strong, readonly) NSNumber *minimumPurchaseAmount;

/**
 @abstract Maximum Redemption possible on the offer.
 */
@property (nonatomic, strong, readonly) NSNumber *maximumRedemptionPerOffer;

/**
 @abstract Maximum redemption per purchase for the offer.
 */
@property (nonatomic, strong, readonly) NSNumber *maximumRedemptionPerPurchase;

/**
 @abstract Minimum amount to be accumulated to receive cashback.
 */
@property (nonatomic, strong, readonly) NSNumber *minimumAccumulatedAmount;

/**
 @abstract Maximum purchase amount eligable for cashback.
 */
@property (nonatomic, strong, readonly) NSNumber *maximumPurchase;

/**
 @abstract The last amount payed out of the cashback earned of the offer to the user.
 */
@property (nonatomic, strong, readonly) NSNumber *lastReimbursementAmount;

/**
 @abstract Last time the user got payed out of the cashback earned of the offer.
 */
@property (nonatomic, strong, readonly) NSDate *lastReimbursementDate;

/**
 @abstract Amount of casbhack to be paid to the user on next payout.
 */
@property (nonatomic, strong, readonly) NSNumber *scheduledReimbursementAmount;

/**
 @abstract The date for the next payout.
 */
@property (nonatomic, strong, readonly) NSDate *scheduledReimbursementDate;

/**
 @abstract The days left of the offer.
 */
@property (nonatomic, strong, readonly) NSNumber *daysLeft;

/**
 @abstract The date the offer became available to the user.
 */
@property (nonatomic, strong, readonly) NSDate *validFrom;

/**
 @abstract The date the offer expired.
 */
@property (nonatomic, strong, readonly) NSDate *validTo;

/**
 @abstract The date the offer was accepted by the user.
 */
@property (nonatomic, strong, readonly) NSDate *activatedDate;

/**
 @abstract The date the offer was declined by the user.
 */
@property (nonatomic, strong, readonly) NSDate *declineDate;

/**
 @abstract Id of the merchant.
 */
@property (nonatomic, strong, readonly) NSNumber *merchantId;

/**
 @abstract Name of the merchant.
 */
@property (nonatomic, copy, readonly) NSString *merchantName;

/**
 @abstract Merchant declined
 */
@property (nonatomic, strong, readonly) NSNumber *merchantDeclined;

/**
 @abstract Whether the offer activates automatically when the user has made his first purchase at the store.
 */
@property (nonatomic, strong, readonly) NSNumber *activateOfferOnFirstPurchase;


// MARK: Need to investigate the format of the relevance hook
/**
 @abstract The reason why you got this offer.
 */
@property (nonatomic, copy, readonly) MNFOfferRelevanceHook *relevanceHook;

/**
 @abstract Total amount spent on similar brands.
 */
@property (nonatomic, strong, readonly) NSNumber *totalSpendingAtSimilarBrands;

/**
 @abstract The total amount spent on the offer.
 */
@property (nonatomic, strong, readonly) NSNumber *totalSpendingOnOffer;

/**
 @abstract The ratio between total spending on offer as compared to everthing spent on the offer and at similar brands.
 */
@property (nonatomic, strong, readonly) NSNumber *offerSimilarBrandsSpendingRatio;


/**
 @abstract The location of the merchant
 */
@property (nonatomic, strong, readonly) NSArray <MNFMerchantLocation *> *merchantLocations;


/**
 @abstract Fetches an object with a given identifier from the server.
 
 @param identifier The server identifier for the offer.
 @param completion A completion block returns an instance of MNFOffer or an error.
 
 @return MNFJob A job containing an MNFOffer and error.
 */
+(MNFJob*)fetchWithId:(NSNumber *)identifier completion:(nullable MNFOfferCompletionHandler)completion;

/**
 @bastract Fetches an offer based on the token.
 
 @param theToken Token of the offer to fetch.
 @param completion A completion block returning the offer from the token or an error.
 
 @return A MNFJob containing the offer as a result or an error if applicable.
 */
+(MNFJob*)fetchWithToken:(NSString *)theToken completion:(nullable MNFOfferCompletionHandler)completion;

/**
 @abstract Fetch Offers with a filter where you can skip a certain amount and take a certain amount for every request to the server.
 
 @param offerFilter The filter for the offers. If nil no filter is used.
 @param skip Defines the number of records to skip in the request. If nil no records are skipped.
 @param take Defines the number of records to fetch in the request. If nil only 20 offers are fetched.
 @param completion A completion block returning an array of offers or an error.
 
 @return MNFJob A job containing an array of offers or an error.
 */
+(MNFJob*)fetchOffersWithFilter:(nullable MNFOfferFilter *)offerFilter take:(nullable NSNumber *)take skip:(nullable NSNumber *)skip completion:(nullable MNFMultipleOffersCompletionHandler)completion;

/**
 @abstract Activate an offer with a token.
 
 @param theToken The token of the offer that is going to be activated.
 @param completion A completion block returning an error.
 
 @return MNFJob A job containing an error.
 */
+(MNFJob*)activateOfferWithToken:(NSString *)theToken completion:(nullable MNFErrorOnlyCompletionHandler)completion;


/**
 @abstract Fetch nearby merchant locations for offer.
 
 
 */
+(MNFJob *)fetchMerchantLocationsWithOfferId:(NSNumber *)offerId latitude:(NSNumber *)latitude longitude:(NSNumber *)longitude radiusKm:(NSNumber *)radiusKm limitLocations:(NSNumber *)limitLocations;

/**
 @abstract Activates or de-activates offers component for the user.
 
 @param enable Used to indicate whether you want activate or de-activate the offers component.
 @param completion A completion block returning an error.
 
 @return MNFJob A job containing an error.
 */
+(MNFJob*)enableOffers:(BOOL)enable completion:(nullable MNFErrorOnlyCompletionHandler)completion;

/**
 @abstract Method used to accept the terms and conditions for the offer component.
 
 @param completion A completion block returning an error.
 
 @return MNFJob A job containing an error.
 */
+(MNFJob*)acceptOffersTermsAndConditionsWithCompletion:(nullable MNFErrorOnlyCompletionHandler)completion;


//MARK: Instance Methods

/**
 @abstract Fetches similar brands the user has done some business for the given offer. It gives you a list of brand names, their ids and the amount spent at the brand.
 
 @param theOfferId The id of the offer.
 @param completion A completion block returning an array of similar brands, similar brand metadata or an error.
 
 @return MNFJob A job containing an array of similar brands or an error.
 */
-(MNFJob*)fetchSimilarBrandSpendingWithCompletion:(nullable MNFOfferSimilarBrandSpendingCompletionHandler)completion;

/**
 @abstract Fetches all the transactions that have been redeemed for the given offer.
 
 @param completion A completion block returning an array of offer transactions or an error.
 
 @return MNFJob A job containing an array of offer transactions or an error.
 */
-(MNFJob*)fetchRedeemedTransactionsWithCompletion:(MNFMultipleOfferTransactionsCompletionHandler)completion;

/**
 @abstract Used to activate/accept or de-activate/decline the offer.
 
 @param activate Used to activate or de-activate the offer.
 @param completion A completion block returning an error.
 
 @return MNFJob A job containing an error.
 */
-(MNFJob*)activateOffer:(BOOL)activate completion:(MNFErrorOnlyCompletionHandler)completion;

/**
 @abstract Mark the offer as seen for analytics on the backend. This method is not used for local or backend state. As prior stated this is purely for analytics.
 */
-(MNFJob *)markAsSeenWithCompletion:(MNFErrorOnlyCompletionHandler)completion;


@end

NS_ASSUME_NONNULL_END
