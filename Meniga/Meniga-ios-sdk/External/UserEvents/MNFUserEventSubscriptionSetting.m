//
//  MNFUserEventSubscriptionSetting.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 11/07/2017.
//  Copyright © 2017 Meniga. All rights reserved.
//

#import "MNFUserEventSubscriptionSetting.h"
#import "MNFObject_Private.h"

@implementation MNFUserEventSubscriptionSetting

- (MNFJob *)saveWithCompletion:(MNFErrorOnlyCompletionHandler)completion {
    [completion copy];

    NSMutableDictionary *jsonDict = [NSMutableDictionary dictionary];
    jsonDict[@"identifier"] = self.settingsIdentifier;
    jsonDict[@"value"] = self.value;
    NSDictionary *dict = @{ @"subscriptionSettings": @[[jsonDict copy]] };
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];

    __block MNFJob *job = [self updateWithApiPath:kMNFUserEventsSubscriptionDetails
                                        pathQuery:nil
                                         jsonBody:jsonData
                                       httpMethod:kMNFHTTPMethodPUT
                                          service:MNFServiceNameUserEvents
                                       completion:^(MNFResponse *_Nullable response) {
                                           kObjectBlockDataDebugLog;

                                           [MNFObject executeOnMainThreadWithJob:job
                                                                      completion:completion
                                                                           error:response.error];
                                       }];

    return job;
}

#pragma mark - json delegate
- (NSDictionary *)jsonKeysMapToProperties {
    return @{ @"settingsIdentifier": @"identifier" };
}
- (NSDictionary *)propertyKeysMapToJson {
    return @{ @"settingsIdentifier": @"identifier" };
}
- (NSSet *)propertiesToIgnoreJsonDeserialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

@end
