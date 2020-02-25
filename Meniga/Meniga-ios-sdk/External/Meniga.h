//
//  Meniga.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 23/10/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MNFAPIRequest.h"
#import "MNFAccount.h"
#import "MNFAccountAuthorizationType.h"
#import "MNFAccountCategory.h"
#import "MNFAccountHistoryEntry.h"
#import "MNFAccountSyncStatus.h"
#import "MNFAccountType.h"
#import "MNFAuthenticationProviderProtocol.h"
#import "MNFCategory.h"
#import "MNFCategoryScore.h"
#import "MNFCategoryType.h"
#import "MNFChallenge.h"
#import "MNFComment.h"
#import "MNFConstants.h"
#import "MNFFeed.h"
#import "MNFFeedItem.h"
#import "MNFFeedItemGroup.h"
#import "MNFJob.h"
#import "MNFMerchant.h"
#import "MNFMerchantAddress.h"
#import "MNFMerchantSeries.h"
#import "MNFNetworthAccount.h"
#import "MNFNetworthBalanceHistory.h"
#import "MNFObject.h"
#import "MNFObjectUpdater.h"
#import "MNFRealmSyncResponse.h"
#import "MNFRealmUser.h"
#import "MNFScheduledEvent.h"
#import "MNFSyncAuthRequiredParameter.h"
#import "MNFSyncAuthenticationChallenge.h"
#import "MNFSynchronization.h"
#import "MNFTag.h"
#import "MNFTransaction.h"
#import "MNFTransactionDayOverview.h"
#import "MNFTransactionFilter.h"
#import "MNFTransactionGroup.h"
#import "MNFTransactionPage.h"
#import "MNFTransactionRule.h"
#import "MNFTransactionSeries.h"
#import "MNFTransactionSeriesFilter.h"
#import "MNFTransactionSeriesStatistics.h"
#import "MNFTransactionSeriesValue.h"
#import "MNFTransactionSplitAction.h"
#import "MNFUser.h"
#import "MNFUserEvent.h"
#import "MNFUserEventSubscription.h"
#import "MNFUserEventSubscriptionDetail.h"
#import "MNFUserEventSubscriptionSetting.h"
#import "MNFUserProfile.h"

#import "MNFOffer.h"
#import "MNFOfferFilter.h"
#import "MNFOfferTransaction.h"
#import "MNFRedemptions.h"
#import "MNFReimbursementAccount.h"
#import "MNFSimilarBrand.h"
#import "MNFTermsAndConditionType.h"
#import "MNFTermsAndConditions.h"

#import "MNFUpcoming.h"
#import "MNFUpcomingBalance.h"
#import "MNFUpcomingBalanceDate.h"
#import "MNFUpcomingComment.h"
#import "MNFUpcomingDetails.h"
#import "MNFUpcomingInvoice.h"
#import "MNFUpcomingPattern.h"
#import "MNFUpcomingReconcileScore.h"
#import "MNFUpcomingRecurringPattern.h"
#import "MNFUpcomingScheduledPayment.h"
#import "MNFUpcomingThreshold.h"

#import "MNFBudget.h"
#import "MNFBudgetEntry.h"
#import "MNFBudgetFilter.h"
#import "MNFBudgetRule.h"
#import "MNFBudgetRuleRecurringPattern.h"
#import "MNFCustomChallenge.h"
#import "MNFSpendingChallenge.h"

#import "MNFAuthentication.h"
#import "MNFCurrency.h"
#import "MNFPostalCode.h"
#import "MNFPublic.h"

#import "MNFAuthentication.h"
#import "MNFImportAccountConfiguration.h"
#import "MNFLifeGoal.h"
#import "MNFLifeGoalAccountInfo.h"
#import "MNFLifeGoalHistory.h"
#import "MNFMedia.h"
#import "MNFOrganization.h"
#import "MNFOrganizationRealm.h"
#import "MNFPeerComparison.h"
#import "MNFPeerComparisonMerchants.h"
#import "MNFPeerComparisonStats.h"
#import "MNFRealmAccount.h"
#import "MNFTransactionSuggestion.h"

#import "MNFEventTracking.h"

NS_ASSUME_NONNULL_BEGIN

/**
 The Meniga class is the base class for the Meniga framework and is used to initialize the framework within an application.

 By default it is initialized with an empty apiUrl and info log level. Start by setting the base url to use the sdk.
 
 */
@interface Meniga : NSObject

+ (NSString *)sdkVersion;

/** 
 @description Method to register an authentication provider to send with network requests that conforms to the MNFAuthenticationProviderProtocol.
 
 @warning You need to register an authentication provider to be able to send headers or cookies with requests for authentication.
 
 */
+ (void)setAuthenticationProvider:(NSObject<MNFAuthenticationProviderProtocol> *)authenticationProvider;

/** 
 @description The current authentication provider that is registered.
 
 @warning You need to register an authentication provider to be able to send headers or cookies with requests for authentication.
 
 @return Returns the current authentication provider.
 */
+ (NSObject<MNFAuthenticationProviderProtocol> *)authenticationProvider;

/**
 @description A method to set different authentication providers for different classes.
 
 @param authenticationProvider The authentication provider to register.
 @param service The service name in question.
 
 @discussion This method is useful when different services of the Meniga system do not share authentication, then you can use this method to register different authentication providers for each service. For example if you keep the main pfm solution on one server and card linked marketing (clm) on another, then you can register different base url's with the [setApiURL:forService:] method and register their respective authentication providers. Any network calls made through the clm classes (such as MNFOffer) will use their specific authentication providers for authentication. Remember to always set the base authentication provider and use this method for any exceptions.
 */
+ (void)setAuthenticationProvider:(NSObject<MNFAuthenticationProviderProtocol> *)authenticationProvider
                       forService:(MNFServiceName)service;

/**
 @description Returns the authentication provider for each class in the sdk.
 
 @param service The service name in question.
 
 @return The authentication provider for this class.
 */
+ (NSObject<MNFAuthenticationProviderProtocol> *)authenticationProviderForService:(MNFServiceName)service;

/** @description The base url for the sdk to communicate with a server running the Meniga services.
 
 @warning You need to set the api url to be able to use the Meniga sdk.
 
 @param apiURL the url to the server. Example format: wwww.urlofservices.net
 */
+ (void)setApiURL:(NSString *)apiURL;

/** @description A mehtod that returns the base url that is being used to connect to meniga services within the sdk.
 
 @return returns an example string for the current base url.
 */
+ (NSString *)apiURL;

/**
 @abstract Here you can set specific base urls for each class in the sdk.
 
 @param apiURL The url to the server.
 @param service The service name in question.
 
 @discussion This method is useful when certain parts of the Meniga system reside on different servers. Always set the general base url with the setApiURL: method and then setting any additional url for exceptions where a certain service resides on a different server. For example the main pfm solution may reside on one server and one service such as synchronization may reside on a different server for whatever reason. In that case you can set the base url through setApiUrl: that will work for the entire sdk and set a different url for [MNFSynchronization class]. Any network calls made through the synchronization class will then be forwarded to this specific url.
 
 @code [Meniga setApiURL:@"www.mainurl.com"];
 [Meniga setApiURL:@"www.differenturl.com" forService:MNFServiceNameSync];
 */
+ (void)setApiURL:(NSString *)apiURL forService:(MNFServiceName)service;

/**
 @abstract The api culture to be injected into the Accept-Language header.
 
 @discussion This culture effectively overrides all culture query parameters in method calls.
 
 */
+ (nullable NSString *)apiCulture;

/**
 @abstract Sets the Accept-Language header for all requests sent to the server. Defaults to nil if no culture is provided.
 @discussion This culture effectively overrides all culture query parameters in method calls.
 
 */
+ (void)setApiCulture:(nullable NSString *)culture;

/**
 @abstract Returns the apiURL for each class in the sdk.
 
 @param service The service name in question.
 
 @return The url to the server for this class.
 */
+ (NSString *)apiURLForService:(MNFServiceName)service;

/**
 @description Sets the log level of the sdk to the appropriate log level for informative events within the sdk. Defaults to kMNFLogLevelInfo
 
 @param logLevel The log level you want to use within the sdk.
 
 */
+ (void)setLogLevel:(MNFLogLevel)logLevel;

/** 
 @description The current log level of the sdk.
 
 @return Returns the current log level.
 */
+ (MNFLogLevel)logLevel;

/**
 Sets the timezone used internally in dateformatting when serializing and deserializing NSDate objects. Default is [NSTimeZone timeZoneForSecondsFromGMT:0].
 
 @param timeZone The specified time zone.
 */
+ (void)setTimeZone:(NSTimeZone *)timeZone;

/**
 Returns the timezone used internally in dateformatting when serializing and deserializing NSDate objects. Returns nil of the property has not been set.
 */
+ (NSTimeZone *)timeZone;

/**
 Here you can set the timeoutIntervalForRequest on the NSURLSessionConfiguration used in the internal network NSURLSession object.
 
 @see NSULRSessionConfiguration documentation for details.
 
 @param timeoutInterval The timeoutInterval for a request. If zero is set, the default value of 60 seconds is used.
 
 @warning This property should be set before any network requests are made with the sdk.
 */
+ (void)setRequestTimeoutInterval:(NSTimeInterval)timeoutInterval;

/**
 Returns the timout interval for requests. Returns zero if this property has not been set.
 
 @see NSURLSessionConfiguration documentation for details.
 
 @return NSTimeInterval The timout interval for request.
 */
+ (NSTimeInterval)requestTimeoutInterval;

/**
 Here you can set the timeoutIntervalForResource on the NSURLSessionConfiguration used in the internal network NSURLSession object.
 
 @see NSULRSessionConfiguration documentation for details.
 
 @param timeoutInterval The timeoutInterval for a resource. If zero is set, the default value of 7 days is used.
 
 @warning This property should be set before any network requests are made with the sdk.
 */
+ (void)setResourceTimeoutInterval:(NSTimeInterval)timeoutInterval;

/**
 Returns the timout interval for resource. Returns zero if this property has not been set.
 
 @see NSURLSessionConfiguration documentation for details.
 
 @return NSTimeInterval The timout interval for resource.
 */
+ (NSTimeInterval)resourceTimeoutInterval;

/**
 Here you can customise the url session configuration used by the sdk url session. If not set the sdk uses the defaultConfiguration setting.
 
 @see NSURLSessionConfiguration documentation for details.
 
 @param sessionConfiguration The session configuration the sdk will use.
 
 @warning This property should be set before any network requests are made with the sdk.
 */
+ (void)setSessionConfiguration:(NSURLSessionConfiguration *)sessionConfiguration;

/**
 Returns the session configuration used by the sdk url session.
 
 @see NSURLSessionConfiguration documentation for details.
 
 @return NSURLSessionConfiguration The session configuration for the url session.
 */
+ (NSURLSessionConfiguration *)sessionConfiguration;

/**
 Here you can pass an NSURLSessionDelegate object to be used by the sdk url session.
 
 @note This sdk will have a weak reference to this object. The sdk url session will retain this object.
 @see NSURLSessionDelegate documentation for details.
 
 @warning This property should be set before any network requests are made with the sdk.
 */
+ (void)setSessionDelegate:(id<NSURLSessionDelegate>)delegate;

/**
 Returns the session delegate passed to the sdk.
 
 @see NSURLSessionDelegate documentation for details.
 
 @return sessionDelegate The session delegate set for the sdk url session.
 */
+ (id<NSURLSessionDelegate>)sessionDelegate;

/**
 Here you can set a custom notification for a specific status code that returns from a request f.x. when there is a 502 error and you want to notifify your app anywhere a request has been made.
 
 @param notificationName The name of the notification to be posted. If nil removes any previous notification name for the status code.
 @param notificationCenter The notification center to use. If nil removes any previous notification center for the status code.
 @param statusCode The status code to signal the notification.
 */
+ (void)setNotificationName:(nullable NSString *)notificationName
     withNotifiactionCenter:(nullable NSNotificationCenter *)notificationCenter
              forStatusCode:(NSInteger)statusCode;

/**
 Returns the notification name for a status code.
 
 @param statusCode The status code to signal the notification.
 
 @return NSString The notification name for the status code.
 */
+ (NSString *)notificationNameForStatusCode:(NSInteger)statusCode;

/**
 Returns the notification center for a status code.
 
 @param statusCode The status code to signal the notification.
 
 @return NSNotificationCenter The notification center for the status code.
 */
+ (NSNotificationCenter *)notificationCenterForStatusCode:(NSInteger)statusCode;

@end

NS_ASSUME_NONNULL_END
