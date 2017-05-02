//
//  MNFAdapterSubPropertyUppercaseOptionDelegate.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 4/13/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFAdapterSubPropertyUppercaseOptionDelegate.h"
#import "MNFJsonAdapterSubclassedProperty.h"
#import "MNFAdapterSubTestObject.h"

@implementation MNFAdapterSubPropertyUppercaseOptionDelegate

-(NSDictionary*)subclassedProperties {
    return @{ @"comment" : [MNFJsonAdapterSubclassedProperty subclassedPropertyWithClass:[MNFAdapterSubTestObject class] delegate:nil option:kMNFAdapterOptionUppercase], @"allComments" : [MNFJsonAdapterSubclassedProperty subclassedPropertyWithClass:[MNFAdapterSubTestObject class] delegate:nil option:kMNFAdapterOptionUppercase] };
}

@end
