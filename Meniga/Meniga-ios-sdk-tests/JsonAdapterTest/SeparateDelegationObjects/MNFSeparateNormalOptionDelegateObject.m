//
//  MNFSeparateNormalOptionDelegateObject.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 4/11/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFSeparateNormalOptionDelegateObject.h"

@implementation MNFSeparateNormalOptionDelegateObject

- (NSDictionary *)jsonKeysMapToProperties {
    return @{ @"userId": @"id" };
}

- (NSDictionary *)propertyKeysMapToJson {
    return @{ @"userId": @"userIdentifier" };
}

- (NSSet *)propertiesToIgnoreJsonDeserialization {
    return [NSSet setWithObject:@"title"];
}

- (NSSet *)propertiesToIgnoreJsonSerialization {
    return [NSSet setWithObject:@"body"];
}

@end
