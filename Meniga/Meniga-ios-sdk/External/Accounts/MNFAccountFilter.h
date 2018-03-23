//
//  MNFAccountFilter.h
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 10/10/17.
//  Copyright © 2017 Meniga. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MNFJsonAdapterDelegate.h"

@interface MNFAccountFilter : NSObject <MNFJsonAdapterDelegate>

/**
 @abstract The number of items to skip in the request. Defaults to 0.
 */
@property (nonatomic, strong, readwrite, nullable) NSNumber *skip;

/**
 @abstract The number of accounts to fetch from 0 - 1000. Defaults to 1000.
 */
@property (nonatomic, strong, readwrite, nullable) NSNumber *take;

/**
 @abstract The realm identifier for which you want to fetch accounts for. Defaults to nil.
 */
@property (nonatomic, strong, readwrite, nullable) NSString *realmIdentifier;

/**
 @abstract The accouunt identifier for which you wan to fetch accounts for.
 */
@property (nonatomic, strong, readwrite, nullable) NSString *accountIdentifier;

/**
 @abstract The category of the account based on the categories from the fetch account categories method.
 */
@property (nonatomic, strong, readwrite, nullable) NSString *accountCategory;

/**
 @abstract A boolean indicating whether you want to include hidden accounts. Defaults to false.
 */
@property (nonatomic, strong, readwrite, nullable) NSNumber *includeHidden;

/**
 @abstract A boolean indicating whether you want to include disabled accounts. Defaults to false.
 */
@property (nonatomic, strong, readwrite, nullable) NSNumber *includeDisabled;

@end
