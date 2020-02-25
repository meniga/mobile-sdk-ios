//
//  MNFPostalCode.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 23/02/2017.
//  Copyright © 2017 Meniga. All rights reserved.
//

#import "MNFPostalCode.h"
#import "MNFInternalImports.h"

@implementation MNFPostalCode

+ (MNFJob *)fetchPostalCode:(NSString *)postalCode withCompletion:(MNFPostalCodeCompletionHandler)completion {
    [completion copy];

    NSString *path = [NSString stringWithFormat:@"%@/%@", kMNFPublicPostalCodes, postalCode];

    __block MNFJob *job = [self
        apiRequestWithPath:path
                 pathQuery:nil
                  jsonBody:nil
                HTTPMethod:kMNFHTTPMethodGET
                   service:MNFServiceNamePublic
                completion:^(MNFResponse *_Nullable response) {
                    kObjectBlockDataDebugLog;

                    if (response.error == nil) {
                        if ([response.result isKindOfClass:[NSDictionary class]]) {
                            MNFPostalCode *postalCode = [MNFPostalCode initWithServerResult:response.result];

                            [MNFObject executeOnMainThreadWithJob:job
                                                       completion:completion
                                                        parameter:postalCode
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

+ (MNFJob *)fetchPostalCodesWithCompletion:(MNFMultiplePostalCodesCompletionHandler)completion {
    [completion copy];

    __block MNFJob *job = [self
        apiRequestWithPath:kMNFPublicPostalCodes
                 pathQuery:nil
                  jsonBody:nil
                HTTPMethod:kMNFHTTPMethodGET
                   service:MNFServiceNamePublic
                completion:^(MNFResponse *_Nullable response) {
                    kObjectBlockDataDebugLog;

                    if (response.error == nil) {
                        if ([response.result isKindOfClass:[NSArray class]]) {
                            NSArray *postalCodes = [MNFPostalCode initWithServerResults:response.result];

                            [MNFObject executeOnMainThreadWithJob:job
                                                       completion:completion
                                                        parameter:postalCodes
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
