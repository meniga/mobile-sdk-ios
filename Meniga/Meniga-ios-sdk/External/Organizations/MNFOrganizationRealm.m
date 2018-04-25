//
//  MNFOrganizationRealm.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 08/05/2017.
//  Copyright © 2017 Meniga. All rights reserved.
//

#import "MNFOrganizationRealm.h"

@implementation MNFOrganizationRealm

#pragma mark - json delegate
- (NSDictionary*)jsonKeysMapToProperties {
    
    return @{@"identifier" : @"id",
             @"realmDescription" : @"description",
             @"realmIdentifier" : @"identifier"};
}

- (NSDictionary*)propertyKeysMapToJson {
    return @{@"identifier" : @"id",
             @"realmDescription" : @"description",
             @"realmIdentifier" : @"identifier"};
}

@end
