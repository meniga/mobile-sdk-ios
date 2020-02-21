//
//  MNFJsonAdaoterTestTransformer.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 11/2/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFJsonAdaoterTestTransformer.h"

static NSDateFormatter *formatter = nil;

@implementation MNFJsonAdaoterTestTransformer

+ (instancetype)transformer {
    MNFJsonAdaoterTestTransformer *testTrans = [[self alloc] init];
    
    return testTrans;
}

+ (Class)transformedValueClass {
    return [NSDate class];
}

+ (BOOL)allowsReverseTransformation {
    return YES;
}

- (id)transformedValue:(id)value {
    
    if (formatter == nil) {
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd/MM/yyyy"];
    }
    
    if (value == nil) {
        return nil;
    }
    
    NSDate *theDate = [formatter dateFromString:value];
    
    return theDate;
}

- (id)reverseTransformedValue:(id)value {
    
    
    if (formatter == nil) {
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd/MM/yyyy"];
    }
    
    if (value == nil) {
        return nil;
    }
 
    return [formatter stringFromDate:value];
}

@end
