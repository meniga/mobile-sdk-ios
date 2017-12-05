//
//  MNFUserEventSubscriptionSetting.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 11/07/2017.
//  Copyright © 2017 Meniga. All rights reserved.
//

#import "MNFObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface MNFUserEventSubscriptionSetting : MNFObject

@property (nonatomic,strong,readonly) NSString *settingsIdentifier;
@property (nonatomic,strong) NSString *value;
@property (nonatomic,strong,readonly) NSString *dataType;

- (MNFJob*)saveWithCompletion:(nullable MNFErrorOnlyCompletionHandler)completion;

@end

NS_ASSUME_NONNULL_END
