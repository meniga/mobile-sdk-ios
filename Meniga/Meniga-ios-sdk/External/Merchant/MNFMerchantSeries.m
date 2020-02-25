//
//  MNFMerchantSeries.m
//  Meniga-ios-sdk
//
//  Created by Aske Bendtsen on 17/01/17.
//  Copyright © 2017 Meniga. All rights reserved.
//

#import "MNFMerchantSeries.h"
#import "MNFObject_Private.h"
#import "MNFTransactionFilter.h"

@implementation MNFMerchantSeries

+ (nonnull MNFJob *)fetchMerchantSeriesWithTransactionFilter:(nonnull MNFTransactionFilter *)seriesFilter
                                       merchantSeriesOptions:(nonnull MNFMerchantSeriesOptions *)merchantOptions
                                              withCompletion:(nullable MNFMerchantSeriesCompletionHandler)completion {
    NSDictionary *jsonDict = @{
        @"transactionFilter": [MNFJsonAdapter JSONDictFromObject:seriesFilter option:0 error:nil],
        @"options": [MNFJsonAdapter JSONDictFromObject:merchantOptions option:0 error:nil]
    };

    NSData *jsonData = [MNFJsonAdapter JSONDataFromDictionary:jsonDict];

    MNFLogDebug(@"Merchant series request: %@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);

    NSString *path = [NSString stringWithFormat:@"%@%@", kMNFApiPathMerchants, kMNFApiPathMerchantSeries];

    __block MNFJob *job = [self
        apiRequestWithPath:path
                 pathQuery:nil
                  jsonBody:jsonData
                HTTPMethod:kMNFHTTPMethodPOST
                   service:MNFServiceNameMerchants
                completion:^(MNFResponse *_Nullable response) {
                    kObjectBlockDataDebugLog;

                    if (response.error == nil) {
                        if ([response.result isKindOfClass:[NSArray class]]) {
                            NSArray *merchantSeries = [self initWithServerResults:response.result];
                            [MNFObject executeOnMainThreadWithJob:job
                                                       completion:completion
                                                        parameter:merchantSeries
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

@end
