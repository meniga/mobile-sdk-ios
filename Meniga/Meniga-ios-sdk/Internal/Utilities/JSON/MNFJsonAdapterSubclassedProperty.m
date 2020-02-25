//
//  MNFJsonAdapterSubclassedProperty.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 4/13/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFJsonAdapterSubclassedProperty.h"

@implementation MNFJsonAdapterSubclassedProperty

+ (instancetype)subclassedPropertyWithClass:(Class)theClass option:(MNFAdapterOption)theOption {
    MNFJsonAdapterSubclassedProperty *subProperty = [[[self class] alloc] initWithClass:theClass
                                                                               delegate:[[theClass alloc] init]
                                                                                 option:theOption];

    return subProperty;
}

+ (instancetype)subclassedPropertyWitoutDelegate:(Class)theClass option:(MNFAdapterOption)theOption {
    MNFJsonAdapterSubclassedProperty *subProperty = [[[self class] alloc] initWithClass:theClass
                                                                               delegate:nil
                                                                                 option:theOption];

    return subProperty;
}

+ (instancetype)subclassedPropertyWithClass:(Class)theClass
                                   delegate:(id<MNFJsonAdapterDelegate>)theDelegate
                                     option:(MNFAdapterOption)theOption {
    MNFJsonAdapterSubclassedProperty *subProperty = [[MNFJsonAdapterSubclassedProperty alloc] initWithClass:theClass
                                                                                                   delegate:theDelegate
                                                                                                     option:theOption];

    return subProperty;
}

- (instancetype)initWithClass:(Class)theClass
                     delegate:(id<MNFJsonAdapterDelegate>)theDelegate
                       option:(MNFAdapterOption)theOption {
    if (self = [super init]) {
        _propertyClass = theClass;
        _propertyDelegate = theDelegate;
        _propertyOption = theOption;
    }

    return self;
}

@end
