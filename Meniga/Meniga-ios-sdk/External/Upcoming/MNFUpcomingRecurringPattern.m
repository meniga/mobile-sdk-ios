//
//  MNFUpcomingRecurringPattern.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 30/09/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFUpcomingRecurringPattern.h"
#import "MNFInternalImports.h"
#import "MNFUpcomingPattern.h"

@implementation MNFUpcomingRecurringPattern

+ (MNFJob *)fetchWithId:(NSNumber *)identifier completion:(MNFRecurringPatternCompletionHandler)completion {
    [completion copy];

    NSString *path = [NSString stringWithFormat:@"%@/%@", kMNFUpcomingRecurring, [identifier stringValue]];

    __block MNFJob *job = [self
        apiRequestWithPath:path
                 pathQuery:nil
                  jsonBody:nil
                HTTPMethod:kMNFHTTPMethodGET
                   service:MNFServiceNameUpcoming
                completion:^(MNFResponse *_Nullable response) {
                    kObjectBlockDataDebugLog;

                    if (response.error == nil) {
                        if ([response.result isKindOfClass:[NSDictionary class]]) {
                            MNFUpcomingRecurringPattern *pattern =
                                [MNFUpcomingRecurringPattern initWithServerResult:response.result];

                            [MNFObject executeOnMainThreadWithJob:job
                                                       completion:completion
                                                        parameter:pattern
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

+ (MNFJob *)fetchRecurringPatternsWithStatuses:(NSString *)statuses
                                         types:(NSString *)types
                                    completion:(MNFMultipleRecurringPatternsCompletionHandler)completion {
    [completion copy];

    NSMutableDictionary *jsonQuery = [NSMutableDictionary dictionary];
    jsonQuery[@"statuses"] = statuses;
    jsonQuery[@"types"] = types;

    __block MNFJob *job = [MNFObject
        apiRequestWithPath:kMNFUpcomingRecurring
                 pathQuery:[jsonQuery copy]
                  jsonBody:nil
                HTTPMethod:kMNFHTTPMethodGET
                   service:MNFServiceNameUpcoming
                completion:^(MNFResponse *_Nullable response) {
                    kObjectBlockDataDebugLog;

                    if (response.error == nil) {
                        if ([response.result isKindOfClass:[NSArray class]]) {
                            NSArray *patterns = [MNFUpcomingRecurringPattern initWithServerResults:response.result];

                            [MNFObject executeOnMainThreadWithJob:job
                                                       completion:completion
                                                        parameter:patterns
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
                        [MNFObject executeOnMainThreadWithJob:job
                                                   completion:completion
                                                    parameter:nil
                                                        error:response.error];
                    }
                }];

    return job;
}

- (MNFJob *)deleteRecurringPatternWithCompletion:(MNFErrorOnlyCompletionHandler)completion {
    [completion copy];

    NSString *path = [NSString stringWithFormat:@"%@/%@", kMNFUpcomingRecurring, [self.identifier stringValue]];

    __block MNFJob *job = [self deleteWithApiPath:path
                                        pathQuery:nil
                                         jsonBody:nil
                                          service:MNFServiceNameUpcoming
                                       completion:^(MNFResponse *_Nullable response) {
                                           kObjectBlockDataDebugLog;

                                           [MNFObject executeOnMainThreadWithJob:job
                                                                      completion:completion
                                                                           error:response.error];
                                       }];

    return job;
}

#pragma mark - json adaptor delegate

- (NSDictionary *)jsonKeysMapToProperties {
    return @{ @"identifier": @"id" };
}

- (NSDictionary *)propertyValueTransformers {
    return @{ @"repeatUntil": [MNFBasicDateValueTransformer transformer] };
}
- (NSSet *)propertiesToIgnoreJsonSerialization {
    return [NSSet setWithArray:@[
        @"identifier",
        @"text",
        @"amountInCurrency",
        @"currencyCode",
        @"categoryId",
        @"accountId",
        @"isWatched",
        @"isFlagged",
        @"type",
        @"objectstate",
        @"description",
        @"debugDescription",
        @"superclass",
        @"mutableProperties",
        @"dirty",
        @"deleted",
        @"isNew",
        @"keyValueStore"
    ]];
}

- (NSSet *)propertiesToIgnoreJsonDeserialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

- (NSDictionary *)subclassedProperties {
    return @{
        @"pattern": [MNFJsonAdapterSubclassedProperty subclassedPropertyWithClass:[MNFUpcomingPattern class]
                                                                           option:kMNFAdapterOptionNoOption]
    };
}

@end
