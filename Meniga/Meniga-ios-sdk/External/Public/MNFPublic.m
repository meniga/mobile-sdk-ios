//
//  MNFPublic.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 23/02/2017.
//  Copyright © 2017 Meniga. All rights reserved.
//

#import "MNFPublic.h"
#import "MNFCurrency.h"
#import "MNFInternalImports.h"

@implementation MNFPublic

+ (MNFJob *)fetchPublicSettingsWithCompletion:(MNFPublicCompletionHandler)completion {
    [completion copy];

    __block MNFJob *job = [self
        apiRequestWithPath:kMNFPublicSettings
                 pathQuery:nil
                  jsonBody:nil
                HTTPMethod:kMNFHTTPMethodGET
                   service:MNFServiceNamePublic
                completion:^(MNFResponse *_Nullable response) {
                    kObjectBlockDataDebugLog;

                    if (response.error == nil) {
                        if ([response.result isKindOfClass:[NSDictionary class]]) {
                            MNFPublic *publicSettings = [MNFPublic initWithServerResult:response.result];

                            [MNFObject executeOnMainThreadWithJob:job
                                                       completion:completion
                                                        parameter:publicSettings
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

#pragma mark - json delegates
- (NSDictionary *)subclassedProperties {
    return @{
        @"currencies": [MNFJsonAdapterSubclassedProperty subclassedPropertyWithClass:[MNFCurrency class]
                                                                              option:kMNFAdapterOptionNoOption]
    };
}

@end
