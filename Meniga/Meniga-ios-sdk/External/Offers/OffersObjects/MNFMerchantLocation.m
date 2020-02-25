//
//  MNFMerchantLocation.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 3/2/17.
//  Copyright © 2017 Meniga. All rights reserved.
//

#import "MNFMerchantLocation.h"

@implementation MNFMerchantLocation

#pragma mark - Json Adapter Delegate

- (NSDictionary *)jsonKeysMapToProperties {
    return @{ @"identifier": @"id", @"merchantIdentifier": @"identifier" };
}

- (NSDictionary *)propertyKeysMapToJson {
    return @{ @"identifier": @"id", @"merchantIdentifier": @"identifier" };
}

@end
