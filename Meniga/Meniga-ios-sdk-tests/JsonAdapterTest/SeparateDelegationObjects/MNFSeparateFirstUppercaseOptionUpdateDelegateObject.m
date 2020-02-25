//
//  MNFSeparateFirstUppercaseOptionUpdateDelegateObject.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 4/11/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFSeparateFirstUppercaseOptionUpdateDelegateObject.h"

@implementation MNFSeparateFirstUppercaseOptionUpdateDelegateObject

- (NSDictionary *)jsonKeysMapToProperties {
    return @{ @"UserId": @"Id", @"PostId": @"UglyId" };
}

- (NSDictionary *)propertyKeysMapToJson {
    return @{ @"UserId": @"Id", @"PostId": @"UglyId" };
}

- (NSSet *)propertiesToIgnoreJsonDeserialization {
    return [NSSet setWithObject:@"Body"];
}

@end
