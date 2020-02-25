//
//  MNFMerchantAddress.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 07/04/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFMerchantAddress.h"

@implementation MNFMerchantAddress

#pragma mark - Json Adapter Delegate

- (NSSet *)propertiesToIgnoreJsonDeserialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

- (NSSet *)propertiesToIgnoreJsonSerialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

#pragma mark - Description
- (NSString *)description {
    return [NSString stringWithFormat:@"Merchant address %@, city: %@, country: %@, countryCode: %@, latitude: %@, "
                                      @"longitude: %@, postalCode: %@, streetLine1: %@, streetLine2: %@",
                                      [super description],
                                      self.city,
                                      self.country,
                                      self.countryCode,
                                      self.latitude,
                                      self.longitude,
                                      self.postalCode,
                                      self.streetLine1,
                                      self.streetLine2];
}

@end
