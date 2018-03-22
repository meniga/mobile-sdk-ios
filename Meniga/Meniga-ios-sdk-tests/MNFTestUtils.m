//
//  MNFTestUtils.m
//  Meniga-ios-sdk-tests
//
//  Created by Haukur Ísfeld on 21/03/2018.
//  Copyright © 2018 Meniga. All rights reserved.
//

#import "MNFTestUtils.h"
#import "MNFObject.h"
#import <objc/runtime.h>

@implementation MNFTestUtils

+(BOOL)validateApiModel:(NSDictionary*)apiModel withModelObject:(MNFObject*)modelObject {
    
    NSLog(@"Api model: %@",apiModel);
    
    BOOL isValid = YES;
    for (NSString *key in apiModel.allKeys) {
        
        NSString *modelKey = key;
        if ([[modelObject jsonKeysMapToProperties] allKeysForObject:key].count > 0) {
            modelKey = [[[modelObject jsonKeysMapToProperties] allKeysForObject:key] firstObject];
        }
        if (![modelObject respondsToSelector:NSSelectorFromString(modelKey)]) {
            NSLog(@"Api validation failed, could not find model key: %@",modelKey);
            isValid = NO;
            break;
        }
        else {
            objc_property_t property = class_getProperty([modelObject class], [modelKey UTF8String]);
            NSString *propertyAttributes = [NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
            NSArray *splitPropertyAttributes = [propertyAttributes componentsSeparatedByString:@","];
            if (splitPropertyAttributes.count > 0) {
                NSString *encodeType = splitPropertyAttributes[0];
                NSArray *splitEncodeType = [encodeType componentsSeparatedByString:@"\""];
                NSString *className = splitEncodeType[1];
                if (![MNFTestUtils validatePropertyType:className withModel:apiModel[key]]) {
                    NSLog(@"Api validation failed, wrong type for model key: %@",modelKey);
                    isValid = NO;
                    break;
                }
            }
        }
    }
    
    return isValid;
}

+(BOOL)validatePropertyType:(NSString *)propertyType withModel:(NSDictionary*)model {
    
    NSString *modelType = model[@"type"];
    NSString *modelFormat = model[@"format"];
    NSString *ref = model[@"$ref"];
    
    if ([modelType isEqualToString:@"string"] && [propertyType isEqualToString:@"NSString"]) {
        return YES;
    }
    if ([modelType isEqualToString:@"boolean"] && [propertyType isEqualToString:@"NSNumber"]) {
        return YES;
    }
    if ([modelType isEqualToString:@"integer"] && [propertyType isEqualToString:@"NSNumber"]) {
        return YES;
    }
    if ([modelType isEqualToString:@"number"] && [propertyType isEqualToString:@"NSNumber"]) {
        return YES;
    }
    if ([modelType isEqualToString:@"array"] && [propertyType isEqualToString:@"NSArray"]) {
        return YES;
    }
    if ([modelFormat isEqualToString:@"date-time"] && [propertyType isEqualToString:@"NSDate"]) {
        return YES;
    }
    if (ref != nil && ([propertyType isEqualToString:@"NSDictionary"] || [NSClassFromString(propertyType) isSubclassOfClass:[MNFObject class]])) {
        return YES;
    }
    
    return NO;
}

@end
