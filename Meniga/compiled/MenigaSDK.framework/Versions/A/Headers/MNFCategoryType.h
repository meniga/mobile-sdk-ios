//
//  MNFCategoryType.h
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 4/11/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MNFObject.h"

NS_ASSUME_NONNULL_BEGIN

/**
 @abstract An MNFCategoryType object has an identifier and name. The identifier property is an NSNumber inherited from the MNFObject and is used as a unique identifier. The name better describes the category type and its function.
 */
@interface MNFCategoryType : MNFObject

/**
 @abstract A parameter with the name of the category type
 */
@property (nonatomic, readonly, strong) NSString *name;

@end

NS_ASSUME_NONNULL_END