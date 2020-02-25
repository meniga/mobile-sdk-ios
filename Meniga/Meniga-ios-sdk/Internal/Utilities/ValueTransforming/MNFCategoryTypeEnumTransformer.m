//
//  MNFCategoryTypeEnumTransformer.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 4/20/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFCategoryTypeEnumTransformer.h"
#import "MNFCategoryType.h"
#import "MNFInternalImports.h"

@implementation MNFCategoryTypeEnumTransformer

+ (instancetype)transformer {
    MNFCategoryTypeEnumTransformer *enumTrans = [[MNFCategoryTypeEnumTransformer alloc] init];

    return enumTrans;
}

- (id)transformedValue:(id)value {
    if (value != nil && [value isKindOfClass:[NSString class]] == YES) {
        NSString *categoryTypeName = (NSString *)value;

        NSNumber *categoryTypeNumber = [NSStringUtils createCategoryTypeIdFromString:categoryTypeName];

        return categoryTypeNumber;
    }

    return nil;
}

@end
