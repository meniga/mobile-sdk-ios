//
//  MNFUpcomingBalance.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 30/09/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFUpcomingBalance.h"
#import "MNFInternalImports.h"
#import "MNFUpcomingBalanceDate.h"

@implementation MNFUpcomingBalance

+ (MNFJob *)fetchBalancesWithDateTo:(NSDate *)dateTo
             includeOverdueFromDate:(NSDate *)overdueFromDate
                         accountIds:(NSString *)accountIds
                    includeUnlinked:(BOOL)includeUnlinked
                 useAvailableAmount:(BOOL)useAvailableAmount
                         completion:(MNFBalancesCompletionHandler)completion {
    [completion copy];

    MNFBasicDateValueTransformer *transformer = [MNFBasicDateValueTransformer transformer];
    NSMutableDictionary *jsonQuery = [NSMutableDictionary dictionary];
    jsonQuery[@"dateTo"] = [transformer reverseTransformedValue:dateTo];
    jsonQuery[@"includeOverdueFromDate"] = [transformer reverseTransformedValue:overdueFromDate];
    jsonQuery[@"accountIds"] = accountIds;
    jsonQuery[@"includeUnlinked"] = includeUnlinked ? @"true" : @"false";
    jsonQuery[@"useAvailableAmount"] = useAvailableAmount ? @"true" : @"false";

    __block MNFJob *job = [MNFObject
        apiRequestWithPath:KMNFUpcomingBalances
                 pathQuery:[jsonQuery copy]
                  jsonBody:nil
                HTTPMethod:kMNFHTTPMethodGET
                   service:MNFServiceNameUpcoming
                completion:^(MNFResponse *_Nullable response) {
                    kObjectBlockDataDebugLog;

                    if (response.error == nil) {
                        if ([response.result isKindOfClass:[NSDictionary class]]) {
                            MNFUpcomingBalance *balance = [MNFUpcomingBalance initWithServerResult:response.result];

                            [MNFObject executeOnMainThreadWithJob:job
                                                       completion:completion
                                                        parameter:balance
                                                            error:nil];

                        } else {
                            [MNFObject
                                executeOnMainThreadWithJob:job
                                                completion:completion
                                                 parameter:nil
                                                     error:[MNFErrorUtils
                                                               errorForUnexpectedDataOfType:[response.result class]
                                                                                   expected:[NSDictionary class]]];
                        }
                    } else {
                        [MNFObject executeOnMainThreadWithJob:job
                                                   completion:completion
                                                    parameter:nil
                                                        error:response.error];
                    }
                }];

    return job;
}

#pragma mark - json adaptor delegate

- (NSDictionary *)jsonKeysMapToProperties {
    return @{ @"identifier": @"id" };
}
- (NSSet *)propertiesToIgnoreJsonSerialization {
    return [NSSet setWithArray:@[
        @"identifier",
        @"objectstate",
        @"description",
        @"debugDescription",
        @"superclass",
        @"mutableProperties"
    ]];
}

- (NSSet *)propertiesToIgnoreJsonDeserialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

- (NSDictionary *)subclassedProperties {
    return @{
        @"balanceDates": [MNFJsonAdapterSubclassedProperty subclassedPropertyWithClass:[MNFUpcomingBalanceDate class]
                                                                                option:kMNFAdapterOptionNoOption]
    };
}

@end
