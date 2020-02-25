//
//  MNFUserProfile.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 29/02/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFUserProfile.h"
#import "MNFInternalImports.h"

@implementation MNFUserProfile

+ (MNFJob *)fetchWithCompletion:(MNFUserProfileCompletionHandler)completion {
    [completion copy];

    __block MNFJob *job = [self
        apiRequestWithPath:kMNFUserProfile
                 pathQuery:nil
                  jsonBody:nil
                HTTPMethod:kMNFHTTPMethodGET
                   service:MNFServiceNameUsers
                completion:^(MNFResponse *_Nullable response) {
                    kObjectBlockDataDebugLog;

                    if (response.error == nil) {
                        if ([response.result isKindOfClass:[NSDictionary class]]) {
                            MNFUserProfile *profile = [self initWithServerResult:response.result];
                            [MNFObject executeOnMainThreadWithJob:job
                                                       completion:completion
                                                        parameter:profile
                                                            error:response.error];

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

- (MNFJob *)saveWithCompletion:(MNFErrorOnlyCompletionHandler)completion {
    [completion copy];

    NSDictionary *jsonDict = [MNFJsonAdapter JSONDictFromObject:self option:kMNFAdapterOptionNoOption error:nil];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDict options:0 error:nil];

    __block MNFJob *job = [self updateWithApiPath:kMNFUserProfile
                                        pathQuery:nil
                                         jsonBody:jsonData
                                       httpMethod:kMNFHTTPMethodPUT
                                          service:MNFServiceNameUsers
                                       completion:^(MNFResponse *_Nullable response) {
                                           kObjectBlockDataDebugLog;

                                           [MNFObject executeOnMainThreadWithCompletion:completion
                                                                          withParameter:response.error];
                                       }];

    return job;
}

#pragma mark - Description
- (NSString *)description {
    return [NSString
        stringWithFormat:@"User profile %@ personId: %@, gender: %@, birthYear: %@, postalCode: %@, numberInFamily: "
                         @"%@, numberOfKids: %@, numberOfCars: %@, incomeId: %@, apartmentType: %@, apartmentSize: %@, "
                         @"apartmentRooms: %@, apartmentSizeKey: %@, hasSavedProfile: %@, created: %@",
                         [super description],
                         self.personId,
                         self.gender,
                         self.birthYear,
                         self.postalCode,
                         self.numberInFamily,
                         self.numberOfKids,
                         self.numberOfCars,
                         self.incomeId,
                         self.apartmentType,
                         self.apartmentSize,
                         self.apartmentRooms,
                         self.apartmentSizeKey,
                         self.hasSavedProfile,
                         self.created];
}

#pragma mark - Delegate methodss

- (NSDictionary *)propertyValueTransformers {
    return @{
        @"birthYear": [MNFBasicDateValueTransformer transformer],
        @"created": [MNFBasicDateValueTransformer transformer]
    };
}

- (NSSet *)propertiesToIgnoreJsonSerialization {
    return [NSSet setWithArray:@[@"personId", @"hasSavedProfile", @"created", @"objectstate"]];
}

- (NSSet *)propertiesToIgnoreJsonDeserialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

@end
