//
//  MNFSimilarBrand.h
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 5/17/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFObject.h"

@interface MNFSimilarBrandMetaData : MNFObject

/**
 @abstract The start date of all of the similar brands when fetched from the similar brand spending of an offer.
 */
@property (nonatomic, strong, nullable, readonly) NSDate *startDate;

/**
 @abstract The end date of all of the similar brands when fetched from the similar brand spending of an offer.
 */
@property (nonatomic, strong, nullable, readonly) NSDate *endDate;

@end

@interface MNFSimilarBrand : MNFObject

@property (nonatomic, copy, nullable, readonly) NSString *brandName;
@property (nonatomic, copy, nullable, readonly) NSNumber *brandId;
@property (nonatomic, copy, nullable, readonly) NSNumber *spentAmount;

@end
