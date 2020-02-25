//
//  MNFBudgetFilter.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 21/11/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFBudgetFilter.h"
#import "MNFInternalImports.h"

@implementation MNFBudgetFilter

#pragma mark - Json Adapter Delegate
- (NSDictionary *)propertyValueTransformers {
    return @{
        @"allowOverlappingDates": [MNFNumberToBoolValueTransformer transformer],
        @"includeOptionalHistoricalData": [MNFNumberToBoolValueTransformer transformer],
        @"startDate": [MNFBasicDateValueTransformer transformer],
        @"endDate": [MNFBasicDateValueTransformer transformer]
    };
}

- (NSSet *)propertiesToIgnoreJsonDeserialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

- (NSSet *)propertiesToIgnoreJsonSerialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

@end
