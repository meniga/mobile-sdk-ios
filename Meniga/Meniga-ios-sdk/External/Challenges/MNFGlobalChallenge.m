//
//  MNFGlobalChallenge.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 26/01/17.
//  Copyright © 2017 Meniga. All rights reserved.
//

#import "MNFGlobalChallenge.h"

@implementation MNFGlobalChallenge
- (NSSet *)propertiesToIgnoreJsonSerialization {
    return [NSSet setWithObjects:@"objectstate",
                                 @"deleted",
                                 @"dirty",
                                 @"isNew",
                                 @"keyValueStore",
                                 @"mutableProperties",
                                 @"identifier",
                                 @"targetAmount",
                                 @"spentAmount",
                                 nil];
}
@end
