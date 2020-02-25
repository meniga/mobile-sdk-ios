//
//  MNFAccountAuthorizationType.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 11/04/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFAccountAuthorizationType.h"

@implementation MNFAccountAuthorizationType

#pragma mark - json delegates
- (NSDictionary *)jsonKeysMapToProperties {
    return @{ @"identifier": @"id" };
}

- (NSSet *)propertiesToIgnoreJsonDeserialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

- (NSSet *)propertiesToIgnoreJsonSerialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

#pragma mark - Description
- (NSString *)description {
    return [NSString stringWithFormat:@"Account authorization type %@ identifier: %@, name: %@",
                                      [super description],
                                      self.identifier,
                                      self.name];
}

@end
