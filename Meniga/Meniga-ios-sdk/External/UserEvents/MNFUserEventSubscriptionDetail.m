//
//  MNFUserEventSubscriptionDetail.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 10/07/2017.
//  Copyright © 2017 Meniga. All rights reserved.
//

#import "MNFUserEventSubscriptionDetail.h"
#import "MNFInternalImports.h"
#import "MNFUserEventSubscription.h"
#import "MNFUserEventSubscriptionSetting.h"

@implementation MNFUserEventSubscriptionDetail

+ (MNFJob *)fetchSubscriptionDetailsWithCompletion:(MNFUserEventSubscriptionDetailCompletionHandler)completion {
    [completion copy];

    __block MNFJob *job = [self
        apiRequestWithPath:kMNFUserEventsSubscriptionDetails
                 pathQuery:nil
                  jsonBody:nil
                HTTPMethod:kMNFHTTPMethodGET
                   service:MNFServiceNameUserEvents
                completion:^(MNFResponse *_Nullable response) {
                    kObjectBlockDataDebugLog;

                    if (response.error == nil) {
                        if ([response.result isKindOfClass:[NSArray class]]) {
                            NSArray *subscriptionDetails = [self initWithServerResults:response.result];

                            [MNFObject executeOnMainThreadWithJob:job
                                                       completion:completion
                                                        parameter:subscriptionDetails
                                                            error:nil];

                        } else {
                            [MNFObject
                                executeOnMainThreadWithJob:job
                                                completion:completion
                                                 parameter:nil
                                                     error:[MNFErrorUtils
                                                               errorForUnexpectedDataOfType:[response.result class]
                                                                                   expected:[NSArray class]]];
                        }

                    } else {
                        [MNFObject executeOnMainThreadWithCompletion:completion withParameters:nil and:response.error];
                    }
                }];

    return job;
}

- (NSSet *)propertiesToIgnoreJsonDeserialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

- (NSDictionary<NSString *, MNFJsonAdapterSubclassedProperty *> *)subclassedProperties {
    return @{
        @"subscriptions": [MNFJsonAdapterSubclassedProperty subclassedPropertyWithClass:[MNFUserEventSubscription class]
                                                                                 option:kMNFAdapterOptionNoOption],
        @"settings":
            [MNFJsonAdapterSubclassedProperty subclassedPropertyWithClass:[MNFUserEventSubscriptionSetting class]
                                                                   option:kMNFAdapterOptionNoOption],
        @"children":
            [MNFJsonAdapterSubclassedProperty subclassedPropertyWithClass:[MNFUserEventSubscriptionDetail class]
                                                                   option:kMNFAdapterOptionNoOption]
    };
}

@end
