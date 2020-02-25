//
//  MNFTransactionSeriesValue.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 08/03/2017.
//  Copyright © 2017 Meniga. All rights reserved.
//

#import "MNFTransactionSeriesValue.h"
#import "MNFInternalImports.h"

@implementation MNFTransactionSeriesValue

#pragma mark - json adapter delegate
- (NSDictionary *)propertyValueTransformers {
    return @{ @"date": [MNFBasicDateValueTransformer transformer] };
}
@end
