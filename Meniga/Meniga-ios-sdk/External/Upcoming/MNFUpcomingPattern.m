//
//  MNFUpcomingPattern.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 30/09/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFUpcomingPattern.h"

@implementation MNFUpcomingPattern

#pragma mark - json adapter delegate
- (NSSet *)propertiesToIgnoreJsonSerialization {
    return [NSSet setWithArray:@[
        @"identifier",
        @"text",
        @"amountInCurrency",
        @"currencyCode",
        @"categoryId",
        @"accountId",
        @"isWatched",
        @"isFlagged",
        @"type",
        @"objectstate",
        @"description",
        @"debugDescription",
        @"superclass",
        @"mutableProperties",
        @"dirty",
        @"deleted",
        @"isNew",
        @"keyValueStore"
    ]];
}

@end
