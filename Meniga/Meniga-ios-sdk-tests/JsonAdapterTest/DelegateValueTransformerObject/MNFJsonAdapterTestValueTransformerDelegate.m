//
//  MNFJsonAdapterTestValueTransformerDelegate.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 11/2/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFJsonAdapterTestValueTransformerDelegate.h"
#import "MNFJsonAdaoterTestTransformer.h"

@implementation MNFJsonAdapterTestValueTransformerDelegate

- (id)initWithName:(NSString *)theName birthday:(NSDate *)theBirthday {
    if (self = [super init]) {
        _name = theName;
        _birthday = theBirthday;
    }

    return self;
}

- (id)init {
    if (self = [super init]) {
        _name = nil;
        _birthday = nil;
    }
    return self;
}

- (NSDictionary *)propertyValueTransformers {
    return @{ @"birthday": [MNFJsonAdaoterTestTransformer transformer] };
}

@end
