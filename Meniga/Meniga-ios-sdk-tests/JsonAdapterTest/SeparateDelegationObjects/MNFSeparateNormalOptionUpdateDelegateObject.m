//
//  MNFSeparateNormalOptionUpdateDelegateObject.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 4/11/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFSeparateNormalOptionUpdateDelegateObject.h"

@implementation MNFSeparateNormalOptionUpdateDelegateObject

- (NSDictionary *)jsonKeysMapToProperties {
    return @{ @"postId": @"uglyId" };
}

- (NSDictionary *)propertyKeysMapToJson {
    return @{ @"postId": @"uglyId" };
}

- (NSSet *)propertiesToIgnoreJsonDeserialization {
    return [NSSet setWithObject:@"body"];
}

- (NSSet *)propertiesToIgnoreJsonSerialization {
    return [NSSet setWithObject:@"body"];
}

@end
