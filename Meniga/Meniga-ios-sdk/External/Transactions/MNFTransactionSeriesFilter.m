//
//  MNFTransactionSeriesFilter.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 22/01/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFTransactionSeriesFilter.h"
#import "MNFInternalImports.h"

@implementation MNFTransactionSeriesFilter

#pragma mark - Json Adapter Delegate

- (NSDictionary *)propertyValueTransformers {
    return @{
        @"overTime": [MNFNumberToBoolValueTransformer transformer],
        @"includeTransactions": [MNFNumberToBoolValueTransformer transformer],
        @"includeTransactionIds": [MNFNumberToBoolValueTransformer transformer]
    };
}

- (NSSet *)propertiesToIgnoreJsonDeserialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

- (NSSet *)propertiesToIgnoreJsonSerialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

#pragma mark - Description
- (NSString *)description {
    return
        [NSString stringWithFormat:@"Transaction series filter %@ transactionFilter: %@, timeResolution: %@, overTime: "
                                   @"%@, includeTransactions: %@, includeTransactionIds: %@, seriesSelectors: %@",
                                   [super description],
                                   self.transactionFilter,
                                   self.timeResolution,
                                   self.overTime,
                                   self.includeTransactions,
                                   self.includeTransactionIds,
                                   self.seriesSelectors];
}

@end
