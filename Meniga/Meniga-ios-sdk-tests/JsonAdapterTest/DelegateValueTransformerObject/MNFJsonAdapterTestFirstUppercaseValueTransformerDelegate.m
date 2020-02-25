//
//  MNFJsonAdapterTestFirstUppercaseValueTransformerDelegate.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 11/5/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFJsonAdapterTestFirstUppercaseValueTransformerDelegate.h"
#import "MNFJsonAdaoterTestTransformer.h"

@implementation MNFJsonAdapterTestFirstUppercaseValueTransformerDelegate

- (id)init {
    if (self = [super init]) {
        _Birthday = nil;
        _Name = nil;
    }

    return self;
}

- (id)initWithName:(NSString *)theName birthday:(NSDate *)theBirthday {
    if (self = [super init]) {
        _Name = theName;
        _Birthday = theBirthday;
    }

    return self;
}

- (NSDictionary *)propertyValueTransformers {
    return @{ @"Birthday": [MNFJsonAdaoterTestTransformer transformer] };
}

@end
