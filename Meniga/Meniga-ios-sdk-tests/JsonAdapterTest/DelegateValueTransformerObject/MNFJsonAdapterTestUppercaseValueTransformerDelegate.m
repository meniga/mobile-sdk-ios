//
//  MNFJsonAdapterTestUppercaseValueTransformerDelegate.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 11/5/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFJsonAdapterTestUppercaseValueTransformerDelegate.h"
#import "MNFJsonAdaoterTestTransformer.h"

@implementation MNFJsonAdapterTestUppercaseValueTransformerDelegate

- (id)init {
    if (self = [super init]) {
        _NAME = nil;
        _BIRTHDAY = nil;
    }

    return self;
}

- (id)initWithName:(NSString *)theName birthday:(NSDate *)theBirthday {
    if (self = [super init]) {
        _NAME = theName;
        _BIRTHDAY = theBirthday;
    }

    return self;
}

- (NSDictionary *)propertyValueTransformers {
    return @{ @"BIRTHDAY": [MNFJsonAdaoterTestTransformer transformer] };
}

@end
