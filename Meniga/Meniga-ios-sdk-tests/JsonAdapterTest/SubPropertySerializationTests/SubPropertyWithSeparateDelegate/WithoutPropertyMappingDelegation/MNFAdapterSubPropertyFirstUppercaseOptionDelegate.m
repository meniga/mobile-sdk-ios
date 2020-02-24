//
//  MNFAdapterSubPropertyFirstLowercaseOptionDelegate.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 4/13/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFAdapterSubPropertyFirstUppercaseOptionDelegate.h"
#import "MNFJsonAdapterSubclassedProperty.h"
#import "MNFAdapterSubTestObject.h"

@implementation MNFAdapterSubPropertyFirstUppercaseOptionDelegate

-(NSDictionary*)subclassedProperties {
    return @{ @"comment" : [MNFJsonAdapterSubclassedProperty subclassedPropertyWithClass:[MNFAdapterSubTestObject class] delegate:nil option:kMNFAdapterOptionFirstLetterUppercase], @"allComments" : [MNFJsonAdapterSubclassedProperty subclassedPropertyWithClass:[MNFAdapterSubTestObject class] delegate:nil option:kMNFAdapterOptionFirstLetterUppercase] };
}


@end
