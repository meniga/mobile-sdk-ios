//
//  MNFUpcomingBalanceDate.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 30/09/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFUpcomingBalanceDate.h"
#import "MNFInternalImports.h"

@implementation MNFUpcomingBalanceDate

#pragma mark - json adaptor delegate

- (NSDictionary *)jsonKeysMapToProperties {
    return @{ @"identifier": @"id" };
}

- (NSDictionary *)propertyValueTransformers {
    return @{ @"date": [MNFBasicDateValueTransformer transformer] };
}
- (NSSet *)propertiesToIgnoreJsonSerialization {
    return [NSSet setWithArray:@[
        @"identifier",
        @"objectstate",
        @"description",
        @"debugDescription",
        @"superclass",
        @"mutableProperties"
    ]];
}

- (NSSet *)propertiesToIgnoreJsonDeserialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

@end
