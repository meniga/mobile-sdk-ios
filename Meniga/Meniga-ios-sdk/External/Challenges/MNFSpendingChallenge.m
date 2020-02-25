//
//  MNFSpendingChallenge.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 13/01/17.
//  Copyright © 2017 Meniga. All rights reserved.
//

#import "MNFSpendingChallenge.h"
#import "MNFInternalImports.h"

@implementation MNFSpendingChallenge

- (NSSet *)propertiesToIgnoreJsonSerialization {
    return [NSSet setWithObjects:@"objectstate",
                                 @"mutableProperties",
                                 @"deleted",
                                 @"dirty",
                                 @"isNew",
                                 @"keyValueStore",
                                 @"identifier",
                                 @"categoryIds",
                                 @"targetPercentage",
                                 @"spentAmount",
                                 @"recurringInterval",
                                 @"numberOfParticipants",
                                 nil];
}

@end
