//
//  MNFTermsAndConditionType.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 5/3/17.
//  Copyright © 2017 Meniga. All rights reserved.
//

#import "MNFTermsAndConditionType.h"
#import "MNFInternalImports.h"

@interface MNFTermsAndConditionType () <MNFJsonAdapterDelegate>

@end

@implementation MNFTermsAndConditionType

+ (MNFJob *)fetchTermsAndConditionTypes:(MNFMultipleTermsAndConditionTypesCompletionHandler)completion {
    __block MNFJob *job = [self
        apiRequestWithPath:kMNFTermTypes
                 pathQuery:nil
                  jsonBody:nil
                HTTPMethod:kMNFHTTPMethodGET
                   service:MNFServiceNameTerms
                completion:^(MNFResponse *response) {
                    kObjectBlockDataDebugLog;

                    if (response.error == nil) {
                        if ([response.result isKindOfClass:[NSArray class]]) {
                            NSArray *termsAndConditionTypes =
                                [MNFTermsAndConditionType initWithServerResults:response.result];
                            [MNFObject executeOnMainThreadWithJob:job
                                                       completion:completion
                                                        parameter:termsAndConditionTypes
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

+ (MNFJob *)fetchTermsAndConditionWithIdentifier:(NSNumber *)identifier
                                      completion:(MNFTermsAndConditionTypeCompletionHandler)completion {
    [completion copy];

    NSString *path = [NSString stringWithFormat:@"%@/%@", kMNFApiPathTerms, [identifier stringValue]];

    __block MNFJob *job = [self
        apiRequestWithPath:path
                 pathQuery:nil
                  jsonBody:nil
                HTTPMethod:kMNFHTTPMethodGET
                   service:MNFServiceNameTerms
                completion:^(MNFResponse *response) {
                    kObjectBlockDataDebugLog;

                    if (response.error == nil) {
                        if ([response.result isKindOfClass:[NSDictionary class]]) {
                            MNFTermsAndConditionType *termsType =
                                [MNFTermsAndConditionType initWithServerResult:response.result];

                            [MNFObject executeOnMainThreadWithJob:job
                                                       completion:completion
                                                        parameter:termsType
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

- (NSDictionary *)jsonKeysMapToProperties {
    return @{ @"identifier": @"id", @"termsAndConditionTypeDescription": @"description" };
}

- (NSDictionary *)propertyKeysMapToJson {
    return @{ @"identifier": @"id", @"termsAndConditionTypeDescription": @"description" };
}

- (NSSet *)propertiesToIgnoreJsonDeserialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

- (NSSet *)propertiesToIgnoreJsonSerialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

@end
