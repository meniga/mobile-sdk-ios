//
//  MNFRealmSyncResponse.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 20/04/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFRealmSyncResponse.h"
#import "MNFAccountSyncStatus.h"
#import "MNFBasicDateValueTransformer.h"
#import "MNFJsonAdapter.h"
#import "MNFJsonAdapterSubclassedProperty.h"
#import "MNFSyncAuthenticationChallenge.h"

@implementation MNFRealmSyncResponse

#pragma mark - json delegates
- (NSDictionary<NSString *, MNFJsonAdapterSubclassedProperty *> *)subclassedProperties {
    return @{
        @"authenticationChallenge":
            [MNFJsonAdapterSubclassedProperty subclassedPropertyWithClass:[MNFSyncAuthenticationChallenge class]
                                                                   option:kMNFAdapterOptionNoOption],
        @"accountSyncStatuses":
            [MNFJsonAdapterSubclassedProperty subclassedPropertyWithClass:[MNFAccountSyncStatus class]
                                                                   option:kMNFAdapterOptionNoOption]
    };
}

- (NSDictionary *)propertyValueTransformers {
    return @{
        @"realmSyncEndDate": [MNFBasicDateValueTransformer transformer],
        @"realmSyncStartDate": [MNFBasicDateValueTransformer transformer]
    };
}

@end
