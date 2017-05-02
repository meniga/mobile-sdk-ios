//
//  MENIGAAutomaticSerializer.h
//  MENIGAAutomaticJson
//
//  Created by Mathieu Grettir Skulason on 10/5/15.
//  Copyright © 2015 Mathieu Grettir Skulason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MNFJsonAdapterDelegate.h"

typedef NS_ENUM(NSInteger, MNFAdapterOption) {
    /** Make no changes to the keys. */
    kMNFAdapterOptionNoOption = 0,
    /** Make the first letter in the key uppercase. */
    kMNFAdapterOptionFirstLetterUppercase = 1,
    /** Make the first letter in the key lowercase. */
    kMNFAdapterOptionFirstLetterLowercase = 2,
    /** Make the entire key uppercase. */
    kMNFAdapterOptionUppercase = 3,
    /** Make the entire key lowercase */
    kMNFAdapterOptionLowercase = 4,
};

typedef NS_ENUM(NSInteger, MenigaJsonErrorCodes) {
    kMenigaJsonErrorIgnoredPropertyKeyNotFound = -10,
    kMenigaJsonErrorMapPropertyKeyNotFound = -20,
    kMenigaJsonErrorRestrictedPropertyUsed = -30
} ;


/** 
 A class to automatically serialize and deserialize model objects from json dictionaries which can be customized using the MNFJsonAdapterDelegate on the model objects you want to serialize and deserialize.
 */
@interface MNFJsonAdapter : NSObject

#pragma mark - Deserialization

/** 
 @description Deserializes a single object of type Class which is initialized with the json dictionary. By default the Class being will be used as the delegate object, if you want to use a different object as the delegate look at the method that has the delegate: parameter added to its signature.
 
 @see The class being created must conform to the MNFJsonAdapterDelegate. In order to do custom work on the object such as mapping or ignoring keys for deserialization look at the MNFJsonAdapterDelegate.
 
 @param theClass The class of the object you want instantiated which will be automatically deserialized.
 @param theJsonDict The dictionary you receive from the json which you will use to instantiate the object.
 @param theAdapterOption An option to change the keys in theJsonDict if the json dictionary has different key formatting than the properties on the object. 
 @param theError An error the user can send by reference if something goes wrong in the deserialization. currently not used.
 
 @return id (of type theClass passed as parameter)
 
 */
+(id)objectOfClass:(Class)theClass jsonDict:(NSDictionary *)theJsonDict option:(MNFAdapterOption)theAdapterOption error:(NSError **)theError;


/**
 @description Deserializes a single object of type Class which is initialized with the json dictionary. If you do not want the object of type Class being deserialized to conform to the delegate pass in a delegate object you want to use for delegation. If none is used it assumes an object of type Class will be the receiver for the delegate.
 
 @see The class being created must conform to the MNFJsonAdapterDelegate. In order to do custom work on the object such as mapping or ignoring keys for deserialization look at the MNFJsonAdapterDelegate.
 
 @param theClass The class of the object you want instantiated which will be automatically deserialized.
 @param theDelegate The object you want to conform to the MNFJsonAdapterDelegate for mapping and more custom handling of the json format.
 @param theJsonDict The dictionary you receive from the json which you will use to instantiate the object.
 @param theAdapterOption An option to change the keys in theJsonDict if the json dictionary has different key formatting than the properties on the object.
 @param theError An error the user can send by reference if something goes wrong in the deserialization. currently not used.
 
 @return id (of type theClass passed as parameter)
 
 */
+(id)objectOfClass:(Class)theClass delegate:(id <MNFJsonAdapterDelegate> )theDelegate jsonDict:(NSDictionary *)theJsonDict option:(MNFAdapterOption)theAdapterOption error:(NSError *__autoreleasing *)theError;

/**
 @description Deserializes an array of objects of type Class which is initialized with an array of NSDictionaries. By default the Class being will be used as the delegate object, if you want to use a different object as the delegate look at the method that has the delegate: parameter added to its signature.
 
@see The class being created must conform to the MNFJsonAdapterDelegate. In order to do custom work on the object such as mapping or ignoring keys for deserialization look at the MNFJsonAdapterDelegate.
 
 @param theClass The class of the object you want instantiated which will be automatically deserialized.
 @param theJsonArray The array you receive from the json which you will use to instantiate the array of objects.
 @param theAdapterOption An option to change the keys in the dictionaries of the array if the json dictionary has different key formatting than the properties on the object.
 @param theError An error the user can send by reference if something goes wrong in the deserialization. Currently not used.
 
 @return id (of type theClass passed as parameter)
 
 */
+(NSArray *)objectsOfClass:(Class)theClass jsonArray:(NSArray *)theJsonArray option:(MNFAdapterOption)theAdapterOption error:(NSError **)theError;

/**
 @description Deserializes an array of objects of type Class which is initialized with an array of NSDictionaries. If you do not now want the object of type Class being deserialized to conform to the delegate pass in a delegate object you want to use for delegation. If none is used it assumes an object of type Class will be the receiver for the delegate.
 
 @see The class being created must conform to the MNFJsonAdapterDelegate. In order to do custom work on the object such as mapping or ignoring keys for deserialization look at the MNFJsonAdapterDelegate.
 
 @param theClass The class of the object you want instantiated which will be automatically deserialized.
 @param theDelegate The object you want to conform to the MNFJsonAdapterDelegate for mapping and more custom handling of the json format.
 @param theJsonArray The array you receive from the json which you will use to instantiate the array of objects.
 @param theAdapterOption An option to change the keys in the dictionaries of the array if the json dictionary has different key formatting than the properties on the object.
 @param theError An error the user can send by reference if something goes wrong in the deserialization. Currently not used.
 
 @return id (of type theClass passed as parameter)
 
 */
+(NSArray *)objectsOfClass:(Class)theClass delegate:(id <MNFJsonAdapterDelegate>)theDelegate jsonArray:(NSArray *)theJsonArray option:(MNFAdapterOption)theAdapterOption error:(NSError *__autoreleasing *)theError;

/**
 @description Updates an object's property values with the matching values from an NSDictionary.
 
 @see The object being updated must conform to the MNFJsonAdapterDelegate.
 
 @param theModel The object whose property values are to be updated.
 @param theJsonDict The dictionary whose values will replace the objects property values matching it's keys.
 @param theAdapterOption An option to change the keys in the dictionaries if the json dictionary has different key formatting than the properties on the object.
 @param theError An error the user can send by reference if something goes wrong in the deserialization. Currently not used.
 
 @return void
 
 */
+(void)refreshObject:(NSObject <MNFJsonAdapterDelegate> *)theModel withJsonDict:(NSDictionary *)theJsonDict option:(MNFAdapterOption)theAdapterOption error:(NSError **)theError;

/**
 @description Updates an object's property values with the matching values from an NSDictionary. If you do not now want the object of type Class being deserialized to conform to the delegate pass in a delegate object you want to use for delegation. If none is used it assumes an object of type Class will be the receiver for the delegate.
 
 @see The object being updated must conform to the MNFJsonAdapterDelegate.
 
 @param theModel The object whose property values are to be updated.
 @param theDelegate The object you want to conform to the MNFJsonAdapterDelegate for mapping and more custom handling of the json format.
 @param theJsonDict The dictionary whose values will replace the objects property values matching it's keys.
 @param theAdapterOption An option to change the keys in the dictionaries if the json dictionary has different key formatting than the properties on the object.
 @param theError An error the user can send by reference if something goes wrong in the deserialization. Currently not used.
 
 @return void
 
 */
+(void)refreshObject:(NSObject *)theModel delegate:(id <MNFJsonAdapterDelegate>)theDelegate jsonDict:(NSDictionary *)theJsonDict option:(MNFAdapterOption)theAdapterOption error:(NSError **)theError;


#pragma mark - Serialization

/** 
 @description Returns an array of model objects in the given array serialized to NSDictionaries.
 
 @see For more information on the customization on serialization look at the documentation of MNFJsonAdapterDelegate
 
 @param theModels The array of objects to be serialized to a NSDictionary which conform to MNFJSonAdapterDelegate to customize the serialization process. All the objects in the array will have to be of the same class or it might result in a runtime error (not guaranteed).
 @param theAdapterOption An option to change the keys of the dictionary if the json server uses a different formatting than the properties of theModel object passed as parameter
 @param theError An error the user can send by reference if something goes wrong in the serialization.
 
 @return NSArray filled with NSDictionaries.
 
 @warning The error parameter is currently not used and all of the model objects in the array have to be of the same class.
 */

+(NSArray *)JSONArrayFromArray:(NSArray *)theModels option:(MNFAdapterOption)theAdapterOption error:(NSError **)theError;

/**
 @description Returns an array of model objects in the given array serialized to NSDictionaries using a separated delegate object.
 
 @see For more information on the customization on serialization look at the documentation of MNFJsonAdapterDelegate
 
 @param theModels The array of objects to be serialized to a NSDictionary which conform to MNFJSonAdapterDelegate to customize the serialization process. All the objects in the array will have to be of the same class or it might result in a runtime error (not guaranteed).
 @param theDelegate The object you want to conform to the MNFJsonAdapterDelegate for mapping and more custom handling of the json format.
 @param theAdapterOption An option to change the keys of the dictionary if the json server uses a different formatting than the properties of theModel object passed as parameter
 @param theError An error the user can send by reference if something goes wrong in the serialization.
 
 @return NSArray filled with NSDictionaries.
 
 @warning The error parameter is currently not used and all of the model objects in the array have to be of the same class.
 */
+(NSArray *)JSONArrayFromArray:(NSArray *)theModels delegate:(id <MNFJsonAdapterDelegate>)theDelegate option:(MNFAdapterOption)theAdapterOption error:(NSError *__autoreleasing *)theError;

/**  
 @description Returns a dictionary from the model object by using the MNFJsonAdapterDelegate you can map them to custom keys as well as ignore them to be serialized to a json server.
 
 @see For more information on the customization on serialization look at the documentation of MNFJsonAdapterDelegate.
 
 @param theModel The object to be serialized to a NSDictionary which conforms to a MNFJsonAdapterDelegate to customize the serialization process. Nil values will be made NSNull.
 @param theAdapterOption An option to change the keys of the dictionary if the json server uses a different formatting than the properties of theModel object passed as parameter.
 @param theError An error the user can send by reference if something goes wrong in the serialization.
 
 @retun NSDictionary
 
  */
+(NSDictionary *)JSONDictFromObject:(id <MNFJsonAdapterDelegate>)theModel option:(MNFAdapterOption)theAdapterOption error:(NSError **)theError;


/**
 @description Returns a dictionary from the model object by using the MNFJsonAdapterDelegate you can map them to custom keys as well as ignore them to be serialized to a json server.
 
 @see For more information on the customization on serialization look at the documentation of MNFJsonAdapterDelegate.
 
 @param theModel The object to be serialized to a NSDictionary which conforms to a MNFJsonAdapterDelegate to customize the serialization process. Nil values will be made NSNull.
 @param theAdapterOption An option to change the keys of the dictionary if the json server uses a different formatting than the properties of theModel object passed as parameter.
 @param theError An error the user can send by reference if something goes wrong in the serialization.
 
 @retun NSDictionary
 */
+(NSDictionary *)JSONDictFromObject:(id)theModel delegate:(id <MNFJsonAdapterDelegate>)theDelegate option:(MNFAdapterOption)theAdapterOption error:(NSError *__autoreleasing *)theError;

/**
 @description Returns NSData from the model object by using the MNFJsonAdapterDelegate you can map them to custom keys as well as ignore them to be serialized to a json server. This method transforms the NSDictionary from JSONDictFromObject: straight to NSData using NSJSONSerialization.
 
 @see For more information on the customization on serialization look at the documentation of MNFJsonAdapterDelegate.
 
 @param theModel The object to be serialized to NSData from an NSDictionary which conforms to a MNFJsonAdapterDelegate to customize the serialization process.
 @param theAdapterOption An option to change the keys of the dictionary if the json server uses a different formatting than the properties of theModel object passed as parameter.
 @param theError An error the user can send by reference if something goes wrong in the serialization.
 
 @retun NSData
 
 */
+(NSData *)JSONDataFromObject:(id <MNFJsonAdapterDelegate>)theModel option:(MNFAdapterOption)theAdapterOption error:(NSError **)theError;

/**
 @description Returns NSData from the model object by using the MNFJsonAdapterDelegate you can map them to custom keys as well as ignore them to be serialized to a json server. This method transforms the NSDictionary from JSONDictFromObject: straight to NSData using NSJSONSerialization.
 
 @see For more information on the customization on serialization look at the documentation of MNFJsonAdapterDelegate.
 
 @param theModel The object to be serialized to NSData from an NSDictionary which conforms to a MNFJsonAdapterDelegate to customize the serialization process.
 @param theAdapterOption An option to change the keys of the dictionary if the json server uses a different formatting than the properties of theModel object passed as parameter.
 @param theError An error the user can send by reference if something goes wrong in the serialization.
 
 @retun NSData
 */
+(NSData *)JSONDataFromObject:(id)theModel delegate:(id <MNFJsonAdapterDelegate>)theDelegate option:(MNFAdapterOption)theAdapterOption error:(NSError *__autoreleasing *)theError;


#pragma mark - convenience methods

/**
 @description Returns NSData from NSDictionary using NSJSONSerialization.
 
 @see For more information see NSJSONSerialization documentation.
 
 @param theDictionary The dictionary to be serialized to NSData.
 
 @return NSData
 */
+(NSData *)JSONDataFromDictionary:(NSDictionary *)theDictionary;

/**
 @description Returns NSDictionary from NSData using NSJSONSerialization.
 
 @see For more information see NSJSONSerialization documentation.
 
 @param theJSONData The data to be serialized to NSDictionary.
 
 @return NSDictionary
 */
+(id)objectFromJSONData:(NSData *)theJSONData;

@end
