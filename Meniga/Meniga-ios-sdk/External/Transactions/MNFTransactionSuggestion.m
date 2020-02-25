//
//  MNFTransactionSuggestion.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 15/03/2018.
//  Copyright © 2018 Meniga. All rights reserved.
//

#import "MNFTransactionSuggestion.h"
#import "MNFInternalImports.h"

@implementation MNFTransactionSuggestion

+ (MNFJob *)fetchTransactionSuggestionsWithText:(NSString *)text
                                suggestionTypes:(NSString *)suggestionTypes
                onlyShowResultsWithTransactions:(NSNumber *)onlyShowResultsWithTransactions
                                           take:(NSNumber *)take
                                           sort:(NSString *)sort
                                         filter:(MNFTransactionFilter *)filter
                                     completion:(MNFTransactionSuggestionsCompletionHandler)completion {
    [completion copy];

    NSMutableDictionary *jsonQuery = [NSMutableDictionary dictionary];
    jsonQuery[@"text"] = text;
    jsonQuery[@"suggestionTypes"] = suggestionTypes;
    jsonQuery[@"onlyShowResultsWithTransactions"] = onlyShowResultsWithTransactions;
    jsonQuery[@"take"] = take;
    jsonQuery[@"sort"] = sort;
    NSDictionary *filterDict = [MNFJsonAdapter JSONDictFromObject:filter option:kMNFAdapterOptionNoOption error:nil];
    [jsonQuery addEntriesFromDictionary:filterDict];

    __block MNFJob *job = [self
        apiRequestWithPath:kMNFTransactionSuggestions
                 pathQuery:[jsonQuery copy]
                  jsonBody:nil
                HTTPMethod:kMNFHTTPMethodGET
                   service:MNFServiceNameTransactions
                completion:^(MNFResponse *_Nullable response) {
                    kObjectBlockDataDebugLog;

                    if (response.error == nil) {
                        if ([response.result isKindOfClass:[NSArray class]]) {
                            NSArray *suggestions = [self initWithServerResults:response.result];

                            [MNFObject executeOnMainThreadWithJob:job
                                                       completion:completion
                                                        parameter:suggestions
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

#pragma mark - json adaptor delegate methods
- (NSDictionary *)jsonKeysMapToProperties {
    return @{ @"identifier": @"id" };
}

- (NSDictionary *)propertyKeysMapToJson {
    return @{ @"identifier": @"id" };
}

@end
