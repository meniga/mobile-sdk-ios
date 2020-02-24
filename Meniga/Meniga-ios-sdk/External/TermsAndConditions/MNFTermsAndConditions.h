//
//  MNFTermsAndConditions.h
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 5/3/17.
//  Copyright © 2017 Meniga. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MNFTermsAndConditionType.h"
#import "MNFObject.h"

@interface MNFTermsAndConditions : MNFObject

/**
 @abstract The date the terms and conditions were created.
 */
@property (nonatomic, strong) NSDate *creationDate;

/**
 @abstract The text of the terms and conditions.
 */
@property (nonatomic, strong) NSString *content;

/**
 @abstract The culture of the terms which represents the language they are in.
 */
@property (nonatomic, strong) NSString *culture;

/**
 @abstract The type of terms and condition you are interacting with as there can be multiple types of terms and conditions. This object has the identifier of the terms, it's name and a description.
 */
@property (nonatomic, strong) MNFTermsAndConditionType *termsAndConditionsType;

/**
 @abstract Whether the terms have been accepted or not.
 */
@property (nonatomic, strong) NSNumber *acceptanceRequired;

/**
 @abstract The state of the terms and conditions.
 */
@property (nonatomic, strong) NSString *termsAndConditionsState;

/**
 @abstract The last time the terms and conditions were modified.
 */
@property (nonatomic, strong) NSDate *modifiedAt;


+(MNFJob *)fetchTermsAndConditionsWithCompletion:(MNFMultipleTermsAndConditionsCompletionHandler)completion;

+(MNFJob *)fetchTermsAndConditionsWithId:(NSNumber *)identifier completion:(MNFTermsAndConditionsCompletionHandler)completion;

+(MNFJob *)acceptTermsAndConditionsWithId:(NSNumber*)identifier completion:(MNFErrorOnlyCompletionHandler)completion;

-(MNFJob *)acceptTermsAndConditionsWithCompletion:(MNFErrorOnlyCompletionHandler)completion;

-(MNFJob *)declineTermsAndConditionsWithCompletion:(MNFErrorOnlyCompletionHandler)completion;

@end
