//
//  MNFTermsAndConditionType.h
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 5/3/17.
//  Copyright © 2017 Meniga. All rights reserved.
//

#import "MNFObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface MNFTermsAndConditionType : MNFObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *termsAndConditionTypeDescription;

+(MNFJob *)fetchTermsAndConditionTypes:(MNFMultipleTermsAndConditionTypesCompletionHandler)completion;

+(MNFJob *)fetchTermsAndConditionWithIdentifier:(NSNumber *)identifier completion:(MNFTermsAndConditionTypeCompletionHandler)completion;

@end

NS_ASSUME_NONNULL_END
