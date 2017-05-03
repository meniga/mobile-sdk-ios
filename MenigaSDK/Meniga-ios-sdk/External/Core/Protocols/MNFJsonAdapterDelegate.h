//
//  MNFJsonAdapterDelegate.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 11/12/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MNFJsonAdapterSubclassedProperty;

// delegate to communicate with objects

/** A delegate objects can conform to if they want to customize the serialization/deserialization process using delegation. */
@protocol MNFJsonAdapterDelegate <NSObject>


@optional

/**
 @description If you want to a property key in the json to be mapped to a new one when you deserialize the json, you declare the property name as key and the name you want it mapped to in the value.
 
 @warning Property keys you declare in the NSDictionary are case sensitive, make sure they are correctly typed otherwise they are ignored.
 
 @retun NSDictionary
 
 */
-(NSDictionary *)jsonKeysMapToProperties;


/**
 @description If you want to a property key to be mapped to a new one when you serialize for the json you declare the property name as key and the name you want it mapped to in the value. Example is an object with a property name called name, which he wants mapped to firstName for the serialized json object. you would declare an NSDictionary as such @{ @"name" : @"firstName" }
 
 @warning Property keys you declare in the NSDictionary are case sensitive, make sure they are correctly typed otherwise they are ignored.
 
 @retun NSDictionary
 
 */
-(NSDictionary *)propertyKeysMapToJson;

/**
 @description If you do not want all the properties of the object to be serialized automatically you can ignore specific properties. Declare the properties you want serialized using NSString in the NSSet.
 
 @warning Properties you declare in the NSSet are case sensitive, make sure they are correctly typed otherwise they are ignored.
 
 @return NSSet
 */
-(NSSet *)propertiesToIgnoreJsonSerialization;


/**
 @description If you do not want all the properties of the object to be deserialized automatically you can ignore specific properties. Declare the properties you want serialized using NSString in the NSSet.
 
 @warning Properties you declare in the NSSet are case sensitive, make sure they are correctly typed otherwise they are ignored.
 
 @return NSSet
 */
-(NSSet *)propertiesToIgnoreJsonDeserialization;


/**
 @description A delegate method which enables you to declares the properties you want serialized and ignores all other properties. Declare the properties you want serialized using NSString in the NSSet. It still maps the properties using the propertyKeysMapToJson.
 
 @warning Properties you declare in the NSSet are case sensitive, make sure they are correctly typed otherwise they are ignored.
 
 @return NSSet
 */
-(NSSet *)propertiesToSerialize;


/**
 @description A delegate method which enables you to declares the properties you want deserialized and ignores all other properties. Declare the properties you want deserialized unsing NSString in the NSSet. It still maps the properties using the jsonKeysMapToProperties.
 
 @warning Properties you declare in the NSSet are case sensitive, make sure they are correctly typed otherwise they are ignored.
 
 @return NSSet
 */
-(NSSet *)propertiesToDeserialize;


/**
 @description A delegate method which has a key associated with a property of the associated object to serialize, and holds a NSValueTransformer in the dictionary for the given property.
 
 The NSValueTransformer has to allow reverse transformation if it is to serialize an object. The transformedValue: method is used for deserialization of the property and reverseTransformedValue: for the serialization of an object.
 
 @return NSDictionary
 
 @warning if the value transformer does not return the correct type it will cause a runtime exception. The key in the dictionary needs to match the property (case sensitive) or it will be ignored.
 */

-(NSDictionary *)propertyValueTransformers;

/**
 
 @description A delegate method which has a key that represent the property key that you want to be serialized/deserialized
 
 */
-(NSDictionary <NSString *, MNFJsonAdapterSubclassedProperty *> *)subclassedProperties;


/** 
 
 @description A delegate method which returns an object that will be populated with the json information instead of using the default alloc / init on the class object. This is in order to use with f.e. Core Data where you have should not use alloc / init or any other uses where you would like to have a custom initializer for the json adapter populated objects.
 
 */
+(id)objectToPopulate;

@end
