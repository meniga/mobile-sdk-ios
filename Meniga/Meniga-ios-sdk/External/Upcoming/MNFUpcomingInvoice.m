//
//  MNFUpcomingInvoice.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 30/09/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFUpcomingInvoice.h"
#import "MNFInternalImports.h"

@implementation MNFUpcomingInvoice

#pragma mark - json adaptor delegate

- (NSDictionary *)jsonKeysMapToProperties {
    return @{ @"identifier": @"id", @"invoiceIdentifier": @"identifier" };
}

- (NSDictionary *)propertyValueTransformers {
    return @{
        @"issuedDate": [MNFBasicDateValueTransformer transformer],
        @"dueDate": [MNFBasicDateValueTransformer transformer],
        @"finalDueDate": [MNFBasicDateValueTransformer transformer],
        @"bookingDate": [MNFBasicDateValueTransformer transformer]
    };
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
