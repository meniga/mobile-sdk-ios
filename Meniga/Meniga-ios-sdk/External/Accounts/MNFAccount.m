//
//  MNFAccount.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 23/10/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFAccount.h"
#import "MNFAccountAuthorizationType.h"
#import "MNFAccountCategory.h"
#import "MNFAccountHistoryEntry.h"
#import "MNFAccountType.h"
#import "MNFInternalImports.h"

@implementation MNFAccount

+ (MNFJob *)fetchWithId:(NSNumber *)identifier completion:(MNFAccountCompletionHandler)completion {
    [completion copy];

    NSString *path = [NSString stringWithFormat:@"%@/%@", kMNFAPIPathAccounts, [identifier stringValue]];

    __block MNFJob *job = [self
        apiRequestWithPath:path
                 pathQuery:nil
                  jsonBody:nil
                HTTPMethod:kMNFHTTPMethodGET
                   service:MNFServiceNameAccounts
                completion:^(MNFResponse *_Nullable response) {
                    kObjectBlockDataDebugLog;

                    if (response.error == nil) {
                        if ([response.result isKindOfClass:[NSDictionary class]]) {
                            MNFAccount *account = [MNFAccount initWithServerResult:response.result];

                            [MNFObject executeOnMainThreadWithJob:job
                                                       completion:completion
                                                        parameter:account
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

+ (MNFJob *)fetchAccountsWithFilter:(MNFAccountFilter *)filter
                         completion:(MNFMultipleAccountsCompletionHandler)completion {
    [completion copy];

    NSDictionary *query = nil;
    if (filter != nil) {
        query = [MNFJsonAdapter JSONDictFromObject:(id<MNFJsonAdapterDelegate>)filter option:0 error:nil];
    }

    MNFLogDebug(@"Account query dict: %@", query);

    __block MNFJob *job = [self
        apiRequestWithPath:kMNFAPIPathAccounts
                 pathQuery:query
                  jsonBody:nil
                HTTPMethod:kMNFHTTPMethodGET
                   service:MNFServiceNameAccounts
                completion:^(MNFResponse *_Nullable response) {
                    kObjectBlockDataDebugLog;

                    if (response.error == nil) {
                        if ([response.result isKindOfClass:[NSArray class]]) {
                            NSArray *accounts = [MNFAccount initWithServerResults:response.result];
                            [MNFObject executeOnMainThreadWithJob:job
                                                       completion:completion
                                                        parameter:accounts
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

+ (MNFJob *)fetchAccountCategoriesWithCompletion:(MNFMultipleAccountCategoriesCompletionHandler)completion {
    __block MNFJob *job = [self
        apiRequestWithPath:kMNFAccountCategories
                 pathQuery:nil
                  jsonBody:nil
                HTTPMethod:kMNFHTTPMethodGET
                   service:MNFServiceNameAccounts
                completion:^(MNFResponse *_Nullable response) {
                    kObjectBlockDataDebugLog;

                    if (response.error == nil) {
                        if ([response.result isKindOfClass:[NSArray class]]) {
                            NSArray *accountTypes = [MNFAccountCategory initWithServerResults:response.result];
                            [MNFObject executeOnMainThreadWithJob:job
                                                       completion:completion
                                                        parameter:accountTypes
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

+ (MNFJob *)fetchAccountAuthorizationTypesWithCompletion:
    (MNFMultipleAccountAuthorizationTypesCompletionHandler)completion {
    __block MNFJob *job = [self
        apiRequestWithPath:kMNFAccountAuthorizationTypes
                 pathQuery:nil
                  jsonBody:nil
                HTTPMethod:kMNFHTTPMethodGET
                   service:MNFServiceNameAccounts
                completion:^(MNFResponse *_Nullable response) {
                    kObjectBlockDataDebugLog;

                    if (response.error == nil) {
                        if ([response.result isKindOfClass:[NSArray class]]) {
                            NSArray *authorizationTypes =
                                [MNFAccountAuthorizationType initWithServerResults:response.result];
                            [MNFObject executeOnMainThreadWithJob:job
                                                       completion:completion
                                                        parameter:authorizationTypes
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

+ (MNFJob *)fetchAccountTypesWithCompletion:(MNFMultipleAccountTypesCompletionHandler)completion {
    __block MNFJob *job = [self
        apiRequestWithPath:kMNFAccountTypes
                 pathQuery:nil
                  jsonBody:nil
                HTTPMethod:kMNFHTTPMethodGET
                   service:MNFServiceNameAccounts
                completion:^(MNFResponse *_Nullable response) {
                    kObjectBlockDataDebugLog;

                    if (response.error == nil) {
                        if ([response.result isKindOfClass:[NSArray class]]) {
                            NSArray *accountTypes = [MNFAccountType initWithServerResults:response.result];
                            [MNFObject executeOnMainThreadWithJob:job
                                                       completion:completion
                                                        parameter:accountTypes
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

- (MNFJob *)fetchMetadataWithCompletion:(MNFMultipleMetadataCompletionHandlers)completion {
    [completion copy];

    NSString *path = [NSString
        stringWithFormat:@"%@/%@/%@", kMNFAPIPathAccounts, [self.identifier stringValue], kMNFAccountMetadata];

    __block MNFJob *job = [[self class]
        apiRequestWithPath:path
                 pathQuery:nil
                  jsonBody:nil
                HTTPMethod:kMNFHTTPMethodGET
                   service:MNFServiceNameAccounts
                completion:^(MNFResponse *_Nullable response) {
                    kObjectBlockDataDebugLog;

                    if (response.error == nil) {
                        if ([response.result isKindOfClass:[NSArray class]]) {
                            [MNFObject executeOnMainThreadWithJob:job
                                                       completion:completion
                                                        parameter:response.result
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

- (MNFJob *)fetchMetadataForKey:(NSString *)key withCompletion:(MNFMetadataValueCompletionHandler)completion {
    [completion copy];

    NSString *path = [NSString
        stringWithFormat:@"%@/%@/%@/%@", kMNFAPIPathAccounts, [self.identifier stringValue], kMNFAccountMetadata, key];

    __block MNFJob *job = [[self class]
        apiRequestWithPath:path
                 pathQuery:nil
                  jsonBody:nil
                HTTPMethod:kMNFHTTPMethodGET
                   service:MNFServiceNameAccounts
                completion:^(MNFResponse *_Nullable response) {
                    kObjectBlockDataDebugLog;

                    if (response.error == nil) {
                        if ([response.result isKindOfClass:[NSDictionary class]]) {
                            NSString *value = [(NSDictionary *)response.result objectForKey:@"value"];

                            [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:value error:nil];

                        } else {
                            [MNFObject
                                executeOnMainThreadWithJob:job
                                                completion:completion
                                                 parameter:nil
                                                     error:[MNFErrorUtils
                                                               errorForUnexpectedDataOfType:[response.result class]
                                                                                   expected:[NSString class]]];
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

- (MNFJob *)setMetadataValue:(NSString *)value
                      forKey:(NSString<NSCopying> *)aKey
                  completion:(MNFErrorOnlyCompletionHandler)completion {
    [completion copy];

    NSString *path = [NSString
        stringWithFormat:@"%@/%@/%@", kMNFAPIPathAccounts, [self.identifier stringValue], kMNFAccountMetadata];

    NSDictionary *json = @{ @"name": aKey, @"value": value };
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:json options:0 error:nil];

    __block MNFJob *job = [[self class] apiRequestWithPath:path
                                                 pathQuery:nil
                                                  jsonBody:jsonData
                                                HTTPMethod:kMNFHTTPMethodPUT
                                                   service:MNFServiceNameAccounts
                                                completion:^(MNFResponse *_Nullable response) {
                                                    kObjectBlockDataDebugLog;

                                                    [MNFObject executeOnMainThreadWithJob:job
                                                                               completion:completion
                                                                                    error:response.error];
                                                }];

    return job;
}

- (MNFJob *)refreshWithCompletion:(MNFErrorOnlyCompletionHandler)completion {
    [completion copy];

    NSString *path = [NSString stringWithFormat:@"%@/%@", kMNFAPIPathAccounts, [self.identifier stringValue]];

    __block MNFJob *job = [[self class]
        apiRequestWithPath:path
                 pathQuery:nil
                  jsonBody:nil
                HTTPMethod:kMNFHTTPMethodGET
                   service:MNFServiceNameAccounts
                completion:^(MNFResponse *_Nullable response) {
                    kObjectBlockDataDebugLog;

                    if (response.error == nil) {
                        if ([response.result isKindOfClass:[NSDictionary class]]) {
                            [MNFJsonAdapter refreshObject:self
                                             withJsonDict:response.result
                                                   option:kMNFAdapterOptionNoOption
                                                    error:nil];
                            [MNFObject executeOnMainThreadWithJob:job completion:completion error:nil];

                        } else {
                            [MNFObject
                                executeOnMainThreadWithJob:job
                                                completion:completion
                                                     error:[MNFErrorUtils
                                                               errorForUnexpectedDataOfType:[response.result class]
                                                                                   expected:[NSDictionary class]]];
                        }
                    } else {
                        [MNFObject executeOnMainThreadWithJob:job completion:completion error:response.error];
                    }
                }];

    return job;
}

- (MNFJob *)saveWithCompletion:(MNFErrorOnlyCompletionHandler)completion {
    [completion copy];

    NSMutableDictionary *mutableDictionary = [NSMutableDictionary dictionary];
    MNFNumberToBoolValueTransformer *transformer = [MNFNumberToBoolValueTransformer transformer];

    if (self.name != nil) {
        [mutableDictionary setObject:self.name forKey:@"name"];
    }
    if (self.isHidden != nil) {
        [mutableDictionary setObject:[transformer reverseTransformedValue:self.isHidden] forKey:@"isHidden"];
    }
    if (self.isDisabled != nil) {
        [mutableDictionary setObject:[transformer reverseTransformedValue:self.isDisabled] forKey:@"isDisabled"];
    }
    if (self.orderId != nil) {
        [mutableDictionary setObject:self.orderId forKey:@"orderId"];
    }
    if (self.emergencyFundBalanceLimit != nil) {
        [mutableDictionary setObject:self.emergencyFundBalanceLimit forKey:@"emergencyFundBalanceLimit"];
    }

    NSData *data = [NSJSONSerialization dataWithJSONObject:mutableDictionary options:0 error:nil];

    NSString *path = [NSString stringWithFormat:@"%@/%@", kMNFAPIPathAccounts, [self.identifier stringValue]];

    __block MNFJob *job = [self updateWithApiPath:path
                                        pathQuery:nil
                                         jsonBody:data
                                       httpMethod:kMNFHTTPMethodPUT
                                          service:MNFServiceNameAccounts
                                       completion:^(MNFResponse *_Nullable response) {
                                           kObjectBlockDataDebugLog;

                                           [MNFObject executeOnMainThreadWithJob:job
                                                                      completion:completion
                                                                           error:response.error];
                                       }];

    return job;
}

- (MNFJob *)deleteAccountWithCompletion:(MNFErrorOnlyCompletionHandler)completion {
    [completion copy];

    NSString *path = [NSString stringWithFormat:@"%@/%@", kMNFAPIPathAccounts, [self.identifier stringValue]];

    __block MNFJob *job = [self deleteWithApiPath:path
                                        pathQuery:nil
                                         jsonBody:nil
                                          service:MNFServiceNameAccounts
                                       completion:^(MNFResponse *_Nullable response) {
                                           kObjectBlockDataDebugLog;

                                           [MNFObject executeOnMainThreadWithJob:job
                                                                      completion:completion
                                                                           error:response.error];
                                       }];

    return job;
}

- (MNFJob *)fetchHistoryFromDate:(NSDate *)fromDate
                          toDate:(NSDate *)toDate
                          sortBy:(NSString *)sortBy
                       ascending:(BOOL)ascending
                      completion:(MNFMultipleAccountHistoryCompletionHandler)completion {
    [completion copy];

    if (![sortBy isEqualToString:@"Balance"] && ![sortBy isEqualToString:@"BalanceDate"] && sortBy != nil) {
        [MNFObject
            executeOnMainThreadWithCompletion:completion
                               withParameters:nil
                                          and:[MNFErrorUtils errorWithCode:kMNFErrorInvalidParameter
                                                                   message:@"Sorting descriptor is incorrect. Please "
                                                                           @"use \"Balance\" or \"BalanceDate\" to "
                                                                           @"indicate which parameter to sort by."]];
        MNFJob *job = [MNFJob
            jobWithError:[MNFErrorUtils errorWithCode:kMNFErrorInvalidParameter
                                              message:@"Sorting descriptor is incorrect. Please use \"Balance\" or "
                                                      @"\"BalanceDate\" to indicate which parameter to sort by."]];

        return job;
    }

    if (!ascending && sortBy != nil) {
        sortBy = [@"-" stringByAppendingString:sortBy];
    }

    NSString *path =
        [NSString stringWithFormat:@"%@/%@/%@", kMNFAPIPathAccounts, [self.identifier stringValue], kMNFAccountHistory];
    MNFBasicDateValueTransformer *transformer = [MNFBasicDateValueTransformer transformer];
    NSString *dateFrom = [transformer reverseTransformedValue:fromDate];
    NSString *dateTo = [transformer reverseTransformedValue:toDate];

    NSMutableDictionary *jsonQuery =
        [NSMutableDictionary dictionaryWithObjectsAndKeys:dateFrom, @"dateFrom", dateTo, @"dateTo", nil];
    if (sortBy != nil) {
        [jsonQuery setObject:sortBy forKey:@"sort"];
    }

    __block MNFJob *job = [[self class]
        apiRequestWithPath:path
                 pathQuery:[jsonQuery copy]
                  jsonBody:nil
                HTTPMethod:kMNFHTTPMethodGET
                   service:MNFServiceNameAccounts
                completion:^(MNFResponse *_Nullable response) {
                    kObjectBlockDataDebugLog;

                    if (response.error == nil) {
                        if ([response.result isKindOfClass:[NSArray class]]) {
                            NSArray *historyEntries = [MNFAccountHistoryEntry initWithServerResults:response.result];
                            [MNFObject executeOnMainThreadWithJob:job
                                                       completion:completion
                                                        parameter:historyEntries
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

#pragma mark - Description

- (NSString *)description {
    return
        [NSString stringWithFormat:@"Account %@ identifier: %@, accountIdentifier: %@, accountTypeId: %@, balance: %@",
                                   [super description],
                                   self.identifier,
                                   self.accountIdentifier,
                                   self.accountTypeId,
                                   self.balance];
}

#pragma mark - json delegate

- (NSDictionary *)jsonKeysMapToProperties {
    return @{ @"identifier": @"id" };
}
- (NSDictionary *)propertyKeysMapToJson {
    return @{ @"identifier": @"id" };
}

- (NSDictionary *)propertyValueTransformers {
    return @{
        @"lastUpdate": [MNFBasicDateValueTransformer transformer],
        @"createDate": [MNFBasicDateValueTransformer transformer],
        @"attachedToUserDate": [MNFBasicDateValueTransformer transformer]
    };
}

- (NSSet *)propertiesToIgnoreJsonDeserialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

- (NSSet *)propertiesToIgnoreJsonSerialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

@end
