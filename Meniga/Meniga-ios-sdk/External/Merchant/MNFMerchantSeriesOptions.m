//
//  MNFMerchantSeriesOptions.m
//  Meniga-ios-sdk
//
//  Created by Aske Bendtsen on 19/01/17.
//  Copyright © 2017 Meniga. All rights reserved.
//

#import "MNFMerchantSeriesOptions.h"

@implementation MNFMerchantSeriesOptions

- (instancetype)init {
    self = [super init];
    if (self) {
        self.maxMerchants = @10;
        self.measurement = @"nettoAmount";
        self.includeUnMappedMerchants = @NO;
        self.useParentMerchantIds = @NO;
    }
    return self;
}

@end
