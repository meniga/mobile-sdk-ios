//
//  MNFCustomChallenge.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 26/01/17.
//  Copyright © 2017 Meniga. All rights reserved.
//

#import "MNFCustomChallenge.h"

@implementation MNFCustomChallenge

- (NSSet *)propertiesToIgnoreJsonSerialization {
    return [NSSet setWithObjects:@"objectstate",
                                 @"dirty",
                                 @"deleted",
                                 @"isNew",
                                 @"keyValueStore",
                                 @"mutableProperties",
                                 @"identifier",
                                 @"spentAmount",
                                 nil];
}

@end
