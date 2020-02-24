//
//  MNFNumberToBoolValueTransformer.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 12/01/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFNumberToBoolValueTransformer.h"

@implementation MNFNumberToBoolValueTransformer

+ (instancetype)transformer {
    MNFNumberToBoolValueTransformer *transformer = [[self alloc] init];
    
    return transformer;
}

-(id)transformedValue:(id)value {
    if (value == nil || value == [NSNull null] || ![value isKindOfClass:[NSNumber class]]) {
        return value;
    }
    
    if ([value isEqualToString:@"false"] || [value isEqualToString:@"NO"]) {
        return @NO;
    }
    return @YES;
}

-(id)reverseTransformedValue:(id)value {
    if (value == nil || value == [NSNull null] || ![value isKindOfClass:[NSNumber class]]) {
        return value;
    }
    
    if ([value intValue] == 0) {
        return @"false";
    }
    return @"true";
}

@end
