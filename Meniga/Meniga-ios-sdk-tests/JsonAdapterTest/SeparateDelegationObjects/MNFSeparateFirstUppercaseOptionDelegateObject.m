//
//  MNFSeparateFirstUppercaseOptionDelegateObject.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 4/11/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFSeparateFirstUppercaseOptionDelegateObject.h"

@implementation MNFSeparateFirstUppercaseOptionDelegateObject

- (NSDictionary *)propertyKeysMapToJson {
    return @{ @"UserId": @"userIdentifier" };
}

- (NSDictionary *)jsonKeysMapToProperties {
    return @{ @"UserId": @"id" };
}

- (NSSet *)propertiesToIgnoreJsonDeserialization {
    return [NSSet setWithObject:@"Title"];
}

- (NSSet *)propertiesToIgnoreJsonSerialization {
    return [NSSet setWithObject:@"Title"];
}

@end
