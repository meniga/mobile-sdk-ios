//
//  MNFFeedItem.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 11/11/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFFeedItem.h"
#import "MNFFeed.h"
#import "MNFFeedItem_Private.h"
#import "MNFInternalImports.h"
#import "MNFTransaction.h"
#import "MNFUserEvent.h"

@implementation MNFFeedItem

@synthesize model;

#pragma mark - Delegate methods
- (NSDictionary *)propertyValueTransformers {
    return @{ @"date": [MNFBasicDateValueTransformer transformer] };
}
- (NSSet *)propertiesToIgnoreJsonDeserialization {
    return [NSSet setWithObjects:@"model", nil];
}

@end
