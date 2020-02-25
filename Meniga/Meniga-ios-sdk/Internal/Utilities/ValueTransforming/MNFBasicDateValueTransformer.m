//
//  MNFBasicDateValueTransformer.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 04/11/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFBasicDateValueTransformer.h"
#import "MNFISO8601DateFormatter.h"
#import "Meniga.h"

static MNFISO8601DateFormatter *s_dateFormatter;

@implementation MNFBasicDateValueTransformer

+ (void)initialize {
    s_dateFormatter = [[MNFISO8601DateFormatter alloc] init];
    s_dateFormatter.includeTime = YES;
    if ([Meniga timeZone]) {
        s_dateFormatter.defaultTimeZone = [Meniga timeZone];
    } else {
        s_dateFormatter.defaultTimeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    }
}

+ (instancetype)transformer {
    MNFBasicDateValueTransformer *transformer = [[self alloc] init];

    return transformer;
}

+ (Class)transformedValueClass {
    return [NSDate class];
}

+ (BOOL)allowsReverseTransformation {
    return YES;
}
- (id)transformedValue:(id)value {
    if (value == nil || [value isEqual:[NSNull null]]) {
        return nil;
    }
    return [s_dateFormatter dateFromString:(NSString *)value];
}

- (id)reverseTransformedValue:(id)value {
    if (value == nil || [value isEqual:[NSNull null]]) {
        return nil;
    }

    NSString *string = [s_dateFormatter stringFromDate:(NSDate *)value];

    NSArray<NSString *> *stringWithoutTimeZone = [string componentsSeparatedByString:@"+"];

    return stringWithoutTimeZone.firstObject;
}

@end
