//
//  MNFUserEventSubscriptionDetail.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 10/07/2017.
//  Copyright © 2017 Meniga. All rights reserved.
//

#import "MNFObject.h"

NS_ASSUME_NONNULL_BEGIN

@class MNFUserEventSubscription;
@class MNFUserEventSubscriptionSetting;

@interface MNFUserEventSubscriptionDetail : MNFObject

@property (nonatomic, strong, readonly) NSString *userEventTypeIdentifier;
@property (nonatomic, strong, readonly) NSArray<MNFUserEventSubscription *> *subscriptions;
@property (nonatomic, strong, readonly) NSArray<MNFUserEventSubscriptionSetting *> *settings;
@property (nonatomic, strong, readonly) NSArray<MNFUserEventSubscriptionDetail *> *children;

+ (MNFJob *)fetchSubscriptionDetailsWithCompletion:(nullable MNFUserEventSubscriptionDetailCompletionHandler)completion;

@end

NS_ASSUME_NONNULL_END
