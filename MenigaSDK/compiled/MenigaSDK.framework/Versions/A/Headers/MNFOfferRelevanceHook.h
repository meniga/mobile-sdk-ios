//
//  MNFOfferRelevanceHook.h
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 12/8/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface MNFOfferRelevanceHook : MNFObject

@property (nonatomic, strong, readonly) NSString *relevanceHookDetails;

@property (nonatomic, strong, readonly) NSString *text;


@end

NS_ASSUME_NONNULL_END
