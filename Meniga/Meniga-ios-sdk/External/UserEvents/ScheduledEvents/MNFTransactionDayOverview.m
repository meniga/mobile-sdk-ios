//
//  MNFTransactionDayOverview.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 6/15/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFTransactionDayOverview.h"
#import "MNFInternalImports.h"

@interface MNFTransactionDayOverview () <MNFJsonAdapterDelegate>

@end

@implementation MNFTransactionDayOverview

- (NSDictionary *)propertyValueTransformers {
    return @{ @"date": [MNFBasicDateValueTransformer transformer] };
}

@end
