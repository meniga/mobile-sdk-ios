//
//  MNFAdapterSubPropertyUppercaseOptionDelegate.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 4/13/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFAdapterSubPropertyUppercaseOptionDelegate.h"
#import "MNFAdapterSubTestObject.h"
#import "MNFJsonAdapterSubclassedProperty.h"

@implementation MNFAdapterSubPropertyUppercaseOptionDelegate

- (NSDictionary *)subclassedProperties {
    return @{
        @"comment": [MNFJsonAdapterSubclassedProperty subclassedPropertyWithClass:[MNFAdapterSubTestObject class]
                                                                         delegate:nil
                                                                           option:kMNFAdapterOptionUppercase],
        @"allComments": [MNFJsonAdapterSubclassedProperty subclassedPropertyWithClass:[MNFAdapterSubTestObject class]
                                                                             delegate:nil
                                                                               option:kMNFAdapterOptionUppercase]
    };
}

@end
