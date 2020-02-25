//
//  NSStringUtils.m
//  Meniga-ios-sdk
//
//  Created by Aske Bendtsen on 18/10/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "NSStringUtils.h"
#import "MNFCategory.h"

const NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

@implementation NSStringUtils

+ (NSString *)stringWithOption:(MNFAdapterOption)adapterOption fromString:(NSString *)string {
    if (adapterOption == kMNFAdapterOptionFirstLetterLowercase && string.length >= 1) {
        NSString *firstLetter = [string substringToIndex:1];
        NSString *restOfString = [string substringFromIndex:1];
        return [NSString stringWithFormat:@"%@%@", [firstLetter lowercaseString], restOfString];
    } else if (adapterOption == kMNFAdapterOptionFirstLetterUppercase && string.length >= 1) {
        NSString *firstLetter = [string substringToIndex:1];
        NSString *restOfString = [string substringFromIndex:1];
        return [NSString stringWithFormat:@"%@%@", [firstLetter uppercaseString], restOfString];
    } else if (adapterOption == kMNFAdapterOptionLowercase) {
        return [string lowercaseString];
    } else if (adapterOption == kMNFAdapterOptionUppercase) {
        return [string uppercaseString];
    }

    return string;
}

+ (NSString *)randomStringWithLength:(int)len {
    NSMutableString *randomString = [NSMutableString stringWithCapacity:len];

    for (int i = 0; i < len; i++) {
        [randomString appendFormat:@"%C", [letters characterAtIndex:arc4random_uniform((unsigned)[letters length])]];
    }

    return randomString;
}

+ (NSNumber *)createCategoryTypeIdFromString:(NSString *)string {
    if ([string isEqualToString:@"Expenses"] == YES) {
        return [NSNumber numberWithInt:kMNFCategoryTypeExpenses];
    } else if ([string isEqualToString:@"Income"] == YES) {
        return [NSNumber numberWithInt:kMNFCategoryTypeIncome];
    } else if ([string isEqualToString:@"Savings"] == YES) {
        return [NSNumber numberWithInt:kMNFCategoryTypeSavings];
    } else if ([string isEqualToString:@"Excluded"] == YES) {
        return [NSNumber numberWithInt:kMNFCategoryTypeExcluded];
    }

    return [NSNumber numberWithInt:kMNFCategoryTypeIncome];
}

@end
