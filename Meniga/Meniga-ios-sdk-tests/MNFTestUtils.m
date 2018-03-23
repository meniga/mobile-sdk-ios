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
        
    if (apiModel == nil) { return NO; }
    
    BOOL isValid = YES;
    for (NSString *key in apiModel.allKeys) {
        
        NSString *modelKey = key;
        if ([modelObject respondsToSelector:@selector(jsonKeysMapToProperties)]) {
            if ([[modelObject jsonKeysMapToProperties] allKeysForObject:key].count > 0) {
                modelKey = [[[modelObject jsonKeysMapToProperties] allKeysForObject:key] firstObject];
            }
        }
        if ([modelObject respondsToSelector:@selector(propertiesToIgnoreJsonSerialization)]) {
            if ([[modelObject propertiesToIgnoreJsonDeserialization] containsObject:modelKey]) {
                continue;
            }
        }
        if (![modelObject respondsToSelector:NSSelectorFromString(modelKey)]) {
            NSLog(@"Api validation failed for model: %@, could not find model key: %@",NSStringFromClass([modelObject class]),modelKey);
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
                    NSLog(@"Api validation failed for model: %@, wrong type for model key: %@",NSStringFromClass([modelObject class]),modelKey);
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
    if ((ref != nil || [modelType isEqualToString:@"object"]) && ([propertyType isEqualToString:@"NSDictionary"] || [NSClassFromString(propertyType) isSubclassOfClass:[MNFObject class]])) {
        return YES;
    }
    
    return NO;
}

+(BOOL)validateFilterParameters:(NSArray <NSDictionary*> *)filterParameters withModelObject:(id <MNFJsonAdapterDelegate>)modelObject {
    
    NSLog(@"Filter parameters: %@",filterParameters);
    
    if (filterParameters == nil) { return NO; }
    
    BOOL isValid = YES;
    for (NSDictionary *parameter in filterParameters) {
        
        NSString *key = parameter[@"name"];
        NSString *modelKey = parameter[@"name"];
        if ([modelObject respondsToSelector:@selector(jsonKeysMapToProperties)]) {
            if ([[modelObject jsonKeysMapToProperties] allKeysForObject:key].count > 0) {
                modelKey = [[[modelObject jsonKeysMapToProperties] allKeysForObject:key] firstObject];
            }
        }
        if (![modelObject respondsToSelector:NSSelectorFromString(modelKey)]) {
            NSLog(@"Api validation failed for model: %@, could not find model key: %@",NSStringFromClass([modelObject class]),modelKey);
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
                if (![MNFTestUtils validatePropertyType:className withModel:parameter]) {
                    NSLog(@"Api validation failed for model: %@, wrong type for model key: %@",NSStringFromClass([modelObject class]),modelKey);
                    isValid = NO;
                    break;
                }
            }
        }
    }
    
    return isValid;
}

@end
