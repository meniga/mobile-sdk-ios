//
//  MNFNumberToStringValueTRansformer.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 4/11/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFNumberToStringValueTransformer.h"

@implementation MNFNumberToStringValueTransformer

+(instancetype)transformer {
    MNFNumberToStringValueTransformer *trans = [[MNFNumberToStringValueTransformer alloc] init];
    
    return trans;
}

+(BOOL)allowsReverseTransformation {
    return YES;
}

-(id)transformedValue:(id)value {
    
    if (value == nil || [value isKindOfClass:[NSString class]] == NO) {
        return nil;
    }

    return [NSNumber numberWithInt:[value intValue]];
    
}

-(id)reverseTransformedValue:(id)value {
    
    if (value == nil || [value isKindOfClass:[NSNumber class]] == NO) {
        return nil;
    }
    
    return [(NSNumber*)value stringValue];
    
}

@end
