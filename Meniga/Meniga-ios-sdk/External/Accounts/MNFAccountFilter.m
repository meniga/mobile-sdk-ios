//
//  MNFAccountFilter.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 10/10/17.
//  Copyright © 2017 Meniga. All rights reserved.
//

#import "MNFAccountFilter.h"
#import "MNFJsonAdapterDelegate.h"
#import "MNFNumberToBoolValueTransformer.h"

@interface MNFAccountFilter () <MNFJsonAdapterDelegate>

@end

@implementation MNFAccountFilter

- (id)init {
    if (self = [super init]) {
        _skip = @0;
        _take = @1000;

        _realmIdentifier = nil;
        _accountIdentifier = nil;
        _accountCategory = nil;

        _includeHidden = [NSNumber numberWithBool:NO];
        _includeDisabled = [NSNumber numberWithBool:NO];
    }

    return self;
}

- (NSDictionary *)propertyValueTransformers {
    return @{
        @"includeHidden": [MNFNumberToBoolValueTransformer transformer],
        @"includeDisabled": [MNFNumberToBoolValueTransformer transformer]
    };
}

@end
