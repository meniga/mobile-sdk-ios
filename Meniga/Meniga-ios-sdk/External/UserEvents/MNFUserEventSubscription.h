//
//  MNFUserEventSubscription.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 10/07/2017.
//  Copyright © 2017 Meniga. All rights reserved.
//

#import "MNFObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface MNFUserEventSubscription : MNFObject

@property (nonatomic, strong, readonly) NSString *channelName;
@property (nonatomic, strong, readonly) NSNumber *isSubscribed;
@property (nonatomic, strong, readonly) NSNumber *canUpdateSubscription;

@end

NS_ASSUME_NONNULL_END
