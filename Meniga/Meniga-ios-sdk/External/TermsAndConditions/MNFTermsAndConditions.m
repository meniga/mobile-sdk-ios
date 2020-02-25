//
//  MNFTermsAndConditions.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 5/3/17.
//  Copyright © 2017 Meniga. All rights reserved.
//

#import "MNFTermsAndConditions.h"
#import "MNFBasicDateValueTransformer.h"
#import "MNFInternalImports.h"
#import "MNFObject.h"

@interface MNFTermsAndConditions () <MNFJsonAdapterDelegate>

@end

@implementation MNFTermsAndConditions

+ (MNFJob *)fetchTermsAndConditionsWithCompletion:(MNFMultipleTermsAndConditionsCompletionHandler)completion {
    [completion copy];

    __block MNFJob *job = [MNFObject
        apiRequestWithPath:kMNFApiPathTerms
                 pathQuery:nil
                  jsonBody:nil
                HTTPMethod:kMNFHTTPMethodGET
                   service:MNFServiceNameTerms
                completion:^(MNFResponse *response) {
                    kObjectBlockDataDebugLog;

                    if (response.error == nil) {
                        if ([response.result isKindOfClass:[NSArray class]]) {
                            NSArray *termsAndConditions = [MNFTermsAndConditions initWithServerResults:response.result];

                            [MNFObject executeOnMainThreadWithJob:job
                                                       completion:completion
                                                        parameter:termsAndConditions
                                                            error:nil];

                        } else {
                            [MNFObject executeOnMainThreadWithJob:job
                                                       completion:completion
                                                        parameter:nil
                                                            error:response.error];
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

+ (MNFJob *)fetchTermsAndConditionsWithId:(NSNumber *)identifier
                               completion:(MNFTermsAndConditionsCompletionHandler)completion {
    [completion copy];

    NSString *path = [NSString stringWithFormat:@"%@/%@", kMNFApiPathTerms, identifier];

    __block MNFJob *job = [self
        apiRequestWithPath:path
                 pathQuery:nil
                  jsonBody:nil
                HTTPMethod:kMNFHTTPMethodGET
                   service:MNFServiceNameTerms
                completion:^(MNFResponse *response) {
                    if (response.error == nil) {
                        if ([response.result isKindOfClass:[NSDictionary class]]) {
                            MNFTermsAndConditions *termsAndConditions =
                                [MNFTermsAndConditions initWithServerResult:response.result];

                            [MNFObject executeOnMainThreadWithJob:job
                                                       completion:completion
                                                        parameter:termsAndConditions
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

+ (MNFJob *)acceptTermsAndConditionsWithId:(NSNumber *)identifier completion:(MNFErrorOnlyCompletionHandler)completion {
    NSString *path = [NSString stringWithFormat:kMNFAcceptTerms, identifier];

    __block MNFJob *job = [MNFObject apiRequestWithPath:path
                                              pathQuery:nil
                                               jsonBody:nil
                                             HTTPMethod:kMNFHTTPMethodPOST
                                                service:MNFServiceNameTerms
                                             completion:^(MNFResponse *response) {
                                                 [MNFObject executeOnMainThreadWithJob:job
                                                                            completion:completion
                                                                             parameter:response.error];
                                             }];

    return job;
}

#pragma mark - Instance Methods

- (MNFJob *)acceptTermsAndConditionsWithCompletion:(MNFErrorOnlyCompletionHandler)completion {
    NSString *path = [NSString stringWithFormat:kMNFAcceptTerms, self.termsAndConditionsType.identifier];

    __block MNFJob *job = [MNFObject apiRequestWithPath:path
                                              pathQuery:nil
                                               jsonBody:nil
                                             HTTPMethod:kMNFHTTPMethodPOST
                                                service:MNFServiceNameTerms
                                             completion:^(MNFResponse *response) {
                                                 [MNFObject executeOnMainThreadWithJob:job
                                                                            completion:completion
                                                                             parameter:response.error];
                                             }];

    return job;
}

- (MNFJob *)declineTermsAndConditionsWithCompletion:(MNFErrorOnlyCompletionHandler)completion {
    NSString *path = [NSString stringWithFormat:kMNFDeclineTerms, self.termsAndConditionsType.identifier];

    __block MNFJob *job = [MNFObject apiRequestWithPath:path
                                              pathQuery:nil
                                               jsonBody:nil
                                             HTTPMethod:kMNFHTTPMethodPOST
                                                service:MNFServiceNameTerms
                                             completion:^(MNFResponse *response) {
                                                 [MNFObject executeOnMainThreadWithJob:job
                                                                            completion:completion
                                                                             parameter:response.error];
                                             }];

    return job;
}

- (NSDictionary *)propertyValueTransformers {
    return @{
        @"creationDate": [MNFBasicDateValueTransformer transformer],
        @"modifiedAt": [MNFBasicDateValueTransformer transformer]
    };
}

- (NSDictionary<NSString *, MNFJsonAdapterSubclassedProperty *> *)subclassedProperties {
    return @{
        @"termsAndConditionsType":
            [MNFJsonAdapterSubclassedProperty subclassedPropertyWithClass:[MNFTermsAndConditionType class]
                                                                 delegate:[[MNFTermsAndConditionType alloc] init]
                                                                   option:kMNFAdapterOptionNoOption]
    };
}

@end
