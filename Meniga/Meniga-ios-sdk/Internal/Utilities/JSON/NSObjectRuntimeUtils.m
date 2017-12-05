//
//  NSObjectRuntimeUtils.m
//  Meniga-ios-sdk
//
//  Created by Aske Bendtsen on 20/10/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "NSObjectRuntimeUtils.h"
#import <objc/runtime.h>

@implementation NSObjectRuntimeUtils

+(id)objectWithClass:(Class)theClass modelDictionary:(NSDictionary *)theDictionary error:(NSError **)theError {
    
    Class someClass = theClass;
    
    id object = [[[someClass class] alloc] init];
    
    for (NSString *key in theDictionary) {
        
        id value = theDictionary[key];
        [self validateAndSetValue:value propertyKey:key onModel:object error:theError];
        
    }
    
    return object;
}

+(id)objectWithClass:(Class)theClass modelArray:(NSArray<MNFJsonAdapterKeyAndProperty *> *)theArray error:(NSError *__autoreleasing *)theError {
    
    Class someClass = theClass;
    
    id object = [[[someClass class] alloc] init];
    
    [self updateModel:object Witharray:theArray error:theError];
    
    return object;
}

+(void)enumeratePropertiesOnClass:(Class)class UsingBlock:(void (^)(objc_property_t property, BOOL *stop))block {
    [block copy];
    
    BOOL stop = NO;
    
    // compare the class names as we do not want to serialize the properties for the NSObject
    while (stop == NO && class != nil) {
        
        unsigned int count = 0;
        objc_property_t *properties = class_copyPropertyList(class, &count);
                
        for (int i = 0; i < count; i++) {
            block(properties[i], &stop);

            if (stop) {
                break;
            }
        }
        
        class = [class superclass];
        
        free(properties);
    }
}

+(void)updateModel:(NSObject*)model Witharray:(NSArray<MNFJsonAdapterKeyAndProperty *> *)theArray error:(NSError *__autoreleasing *)theError {
    
    for (MNFJsonAdapterKeyAndProperty *jsonKeyAndPropObj in theArray) {
        
        [self validateAndSetValue:jsonKeyAndPropObj.propertyValue propertyKey:jsonKeyAndPropObj.propertyKey onModel:model error:theError];
        
    }
    
}

+(void)validateAndSetValue:(id)theValue propertyKey:(NSString *)thePropertyKey onModel:(NSObject*)model error:(NSError **)theError {
    
    Class theClass = [self classOfProperty:thePropertyKey onModel:model];
    
    if (theValue != nil && theClass != nil && [theValue isKindOfClass:theClass] == YES) {
        if(theValue == [NSNull null]) {
            
            [model setValue:nil forKey:thePropertyKey];
            
        }
        else {
            [model setValue:theValue forKey:thePropertyKey];
        }
        
        
    }
//    else if(theValue == [NSNull null]) {
//        
//        [model setValue:nil forKey:thePropertyKey];
//        
//    }
}

+(Class)classOfProperty:(NSString*) propertyName onModel:(NSObject*)model
{
    // Get Class of property to be populated.
    Class propertyClass = nil;
    objc_property_t property = class_getProperty([model class], [propertyName UTF8String]);
    NSString *propertyAttributes = [NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
    NSArray *splitPropertyAttributes = [propertyAttributes componentsSeparatedByString:@","];
    if (splitPropertyAttributes.count > 0)
    {
        // xcdoc://ios//library/prerelease/ios/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtPropertyIntrospection.html
        NSString *encodeType = splitPropertyAttributes[0];
        NSArray *splitEncodeType = [encodeType componentsSeparatedByString:@"\""];
        
        if (splitEncodeType.count < 2) {
            // is not an object, might be a bool, int or other scalar type.
            return nil;
        }
        NSString *className = splitEncodeType[1];
        propertyClass = NSClassFromString(className);
    }
    return propertyClass;
}

@end
