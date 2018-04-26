//
//  NSObjectRuntimeUtils.h
//  Meniga-ios-sdk
//
//  Created by Aske Bendtsen on 20/10/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MNFJsonAdapterKeyAndProperty.h"
#import <objc/runtime.h>

@interface NSObjectRuntimeUtils : NSObject

+(id)objectWithClass:(Class)theClass modelDictionary:(NSDictionary *)theDictionary error:(NSError **)theError;
+(id)objectWithClass:(Class)theClass modelArray:(NSArray<MNFJsonAdapterKeyAndProperty *> *)theArray error:(NSError *__autoreleasing *)theError;
+(void)enumeratePropertiesOnClass:(Class)class UsingBlock:(void (^)(objc_property_t property, BOOL *stop))block;
+(BOOL)updateModel:(NSObject*)model Witharray:(NSArray<MNFJsonAdapterKeyAndProperty *> *)theArray error:(NSError *__autoreleasing *)theError;
+(BOOL)validateAndSetValue:(id)theValue propertyKey:(NSString *)thePropertyKey onModel:(NSObject*)model error:(NSError **)theError;
+(Class)classOfProperty:(NSString*)propertyName onModel:(NSObject*)model;

@end
