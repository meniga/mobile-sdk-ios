//
//  MNFOrganization.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 08/05/2017.
//  Copyright © 2017 Meniga. All rights reserved.
//

#import "MNFOrganization.h"
#import "MNFInternalImports.h"

@implementation MNFOrganization

+ (MNFJob *)fetchOrganizationsWithNameSearch:(NSString *)nameSearch
                                  completion:(MNFOrganizationsCompletionHandler)completion {
    [completion copy];

    NSMutableDictionary *pathQuery = [NSMutableDictionary dictionary];
    pathQuery[@"nameSearch"] = nameSearch;

    __block MNFJob *job = [self
        apiRequestWithPath:kMNFApiPathOrganizations
                 pathQuery:[pathQuery copy]
                  jsonBody:nil
                HTTPMethod:kMNFHTTPMethodGET
                   service:MNFServiceNameOrganizations
                completion:^(MNFResponse *_Nullable response) {
                    kObjectBlockDataDebugLog;

                    if (response.error == nil) {
                        if ([response.result isKindOfClass:[NSArray class]]) {
                            NSArray *organizations = [MNFOrganization initWithServerResults:response.result];
                            [MNFObject executeOnMainThreadWithJob:job
                                                       completion:completion
                                                        parameter:organizations
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

#pragma mark - json delegate
- (NSDictionary *)jsonKeysMapToProperties {
    return @{ @"identifier": @"id", @"organizationIdentifier": @"identifier" };
}

- (NSDictionary *)propertyKeysMapToJson {
    return @{ @"identifier": @"id", @"organizationIdentifier": @"identifier" };
}

- (NSDictionary *)subclassedProperties {
    return @{
        @"realms": [MNFJsonAdapterSubclassedProperty subclassedPropertyWithClass:[MNFOrganizationRealm class]
                                                                          option:kMNFAdapterOptionNoOption]
    };
}

@end
