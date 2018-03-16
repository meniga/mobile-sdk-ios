//
//  MENIGAAutomaticSerializer.m
//  MENIGAAutomaticJson
//
//  Created by Mathieu Grettir Skulason on 10/5/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFJsonAdapter.h"
#import "NSStringUtils.h"
#import "NSObjectRuntimeUtils.h"
#import "MNFLogger.h"
#import "MNFJsonAdapterKeyAndProperty.h"
#import "MNFJsonAdapterValueTransformer.h"
#import "MNFJsonAdapterSubclassedProperty.h"

static NSString *JsonAdapterDomain = @"com.Meniga.JsonAdapter";


@implementation MNFJsonAdapter

#pragma mark - Public Deserialization Methods

//

+(id)objectOfClass:(Class)theClass jsonDict:(NSDictionary *)theJsonDict option:(MNFAdapterOption)theAdapterOption error:(NSError *__autoreleasing *)theError {
    
    MNFLogDebug(@"Deserialize object with type: %@, option: %ld",theClass,theAdapterOption);
    MNFLogVerbose(@"Deserialize object with type: %@ option: %ld, json dictionary: %@", theClass, theAdapterOption, theJsonDict);
    
    id theDelegate = nil;
    
    // if the class implements the method than classMethod will not be nil and we can call it safely on the class
    if (class_respondsToSelector(theClass, @selector(init)) == YES) {
        theDelegate = [[theClass alloc] init];
    }

    return [self objectOfClass:theClass delegate:theDelegate jsonDict:theJsonDict option:theAdapterOption error:theError];
    
}

+(NSArray *)objectsOfClass:(Class)theClass jsonArray:(NSArray *)theJsonArray option:(MNFAdapterOption)theAdapterOption error:(NSError *__autoreleasing *)theError {
    
    MNFLogDebug(@"Deserialize NSArray of objects with type: %@ option: %ld", theClass, theAdapterOption);
    MNFLogVerbose(@"Deserialize NSArry of objects with type: %@ option: %ld, json dictionary: %@", theClass, theAdapterOption, theJsonArray);
    
    id theDelegate = nil;
    
    // if the class implements the method than classMethod will not be nil and we can call it safely on the class
    if (class_respondsToSelector(theClass, @selector(init)) == YES) {
        theDelegate = [[theClass alloc] init];
    }
    
    return [self objectsOfClass:theClass delegate:theDelegate jsonArray:theJsonArray option:theAdapterOption error:theError];
}

// Creating objects with a seperate delegate than the object itself

+(id)objectOfClass:(Class)theClass delegate:(id<MNFJsonAdapterDelegate>)theDelegate jsonDict:(NSDictionary *)theJsonDict option:(MNFAdapterOption)theAdapterOption error:(NSError *__autoreleasing *)theError {
    
    
    MNFJsonAdapter *tmpSerializer = [[[self class] alloc] init];
    
    
    return [tmpSerializer p_createInstanceFromClass:theClass delegate:theDelegate jsonDict:theJsonDict propertyKeys:[tmpSerializer p_propertyKeysForClass:theClass delegate:theDelegate option:theAdapterOption error:theError] option:theAdapterOption];
}

+(NSArray*)objectsOfClass:(Class)theClass delegate:(id<MNFJsonAdapterDelegate>)theDelegate jsonArray:(NSArray *)theJsonArray option:(MNFAdapterOption)theAdapterOption error:(NSError *__autoreleasing *)theError {
    
    
    MNFJsonAdapter *tmpSerializer = [[[self class] alloc] init];
    
    
    return [tmpSerializer p_createInstancesForClass:theClass delegate:theDelegate jsonArray:theJsonArray propertyKeys:[tmpSerializer p_propertyKeysForClass:theClass delegate:theDelegate option:theAdapterOption error:theError] option:theAdapterOption];
    
}

// Refreshing objects

+(void)refreshObject:(NSObject <MNFJsonAdapterDelegate> *)theModel withJsonDict:(NSDictionary *)theJsonDict option:(MNFAdapterOption)theAdapterOption error:(NSError *__autoreleasing *)theError {
    
    MNFJsonAdapter *tmpSerializer = [[[self class] alloc] init];
    
    MNFLogDebug(@"Deserialize object: %@ option: %ld", theModel, theAdapterOption);
    MNFLogVerbose(@"Deserialize object: %@ option: %ld, json dictionary: %@", theModel, theAdapterOption, theJsonDict);
    
    // the delegate is the model in this call by default for simplicity and usability
    [tmpSerializer p_refreshInstance:theModel delegate:theModel jsonDict:theJsonDict propertyKeys:[tmpSerializer p_propertyKeysForClass:[theModel class] delegate:theModel option:theAdapterOption error:theError] option:theAdapterOption error:theError];
    
    MNFLogVerbose(@"Object after refresh: %@ with json dictionary: %@", theModel, theJsonDict);
}

+(void)refreshObject:(NSObject <MNFJsonAdapterDelegate> *)theModel delegate:(id<MNFJsonAdapterDelegate>)theDelegate jsonDict:(NSDictionary *)theJsonDict option:(MNFAdapterOption)theAdapterOption error:(NSError *__autoreleasing *)theError {
    
    MNFJsonAdapter *tmpSerializer = [[[self class] alloc] init];
    
    MNFLogDebug(@"Deserialize object: %@ option: %ld", theModel, theAdapterOption);
    MNFLogVerbose(@"Deserialize object: %@ option: %ld json dictionary: %@", theModel, theAdapterOption, theJsonDict);
    
    if (theDelegate == nil) {
        [tmpSerializer p_refreshInstance:theModel delegate:theModel jsonDict:theJsonDict propertyKeys:[tmpSerializer p_propertyKeysForClass:[theModel class] delegate:theModel option:theAdapterOption error:theError] option:theAdapterOption error:theError];
    }
    else {
        [tmpSerializer p_refreshInstance:theModel delegate:theDelegate jsonDict:theJsonDict propertyKeys:[tmpSerializer p_propertyKeysForClass:[theModel class] delegate:theDelegate option:theAdapterOption error:theError] option:theAdapterOption error:theError];
    }
    
    MNFLogVerbose(@"Object after refresh: %@ with json dictionary: %@", theModel, theJsonDict, theError);
    
}

#pragma mark - Create the property list for the deserialization

-(NSDictionary *)p_propertyKeysForClass:(Class)theClass delegate:(id <MNFJsonAdapterDelegate>)theDelegate option:(MNFAdapterOption)theOption error:(NSError **)theError {
    
    // get all the property keys for the given class
    NSDictionary *propertyKeys = [self p_propertyKeyDictionaryAssociatedWithClass:theClass error:theError];
    
    // check if the class conforms to the serializer protocol to map values
    // or exclude values from the json
        
    if ([theDelegate respondsToSelector:@selector(propertiesToDeserialize)]) {
        propertyKeys = [self p_propertyDictFromSet:[theDelegate propertiesToDeserialize]];
    }
    else if ([theDelegate respondsToSelector:@selector(propertiesToIgnoreJsonDeserialization)]) {
        if ([theDelegate propertiesToIgnoreJsonDeserialization] != nil) {
            propertyKeys = [self p_removeIgnoredPropertiesInDictionary:propertyKeys ignoredProperties:[theDelegate propertiesToIgnoreJsonDeserialization] error:theError];
        }
    }
    
    if ([theDelegate respondsToSelector:@selector(jsonKeysMapToProperties)]) {
        if ([theDelegate jsonKeysMapToProperties] != nil) {
            propertyKeys = [self p_mapPropertyDictionaryKeys:propertyKeys mapDictionary:[theDelegate jsonKeysMapToProperties] error:theError];
        }
    }
    propertyKeys = [self p_updateOnlyDictionaryKeys:propertyKeys option:theOption];
    
    return propertyKeys;
    
}


#pragma mark - Private Inititalizers

-(NSArray *)p_createInstancesForClass:(Class)theClass delegate:(id <MNFJsonAdapterDelegate>)theDelegate jsonArray:(NSArray *)theJsonArray propertyKeys:(NSDictionary *)thePropertyKeys option:(MNFAdapterOption)theOption {
    
    NSMutableArray *arr = [NSMutableArray array];
    
    
    for (NSDictionary *dict in theJsonArray) {
        [arr addObject:[self p_createInstanceFromClass:theClass delegate:theDelegate jsonDict:dict propertyKeys:thePropertyKeys option:theOption]];
    }
    
    return arr;
}

-(id)p_createInstanceFromClass:(Class <MNFJsonAdapterDelegate>)theClass delegate:(id <MNFJsonAdapterDelegate>)theDelegate jsonDict:(NSDictionary *)theJsonDict propertyKeys:(NSDictionary *)thePropertyKeys option:(MNFAdapterOption)theOption {
    
    NSArray *array = [[self class] p_createModelDictionaryWithDelegate:theDelegate jsonDict:theJsonDict propertyKeys:thePropertyKeys option:theOption];
    
    id createdObject;
    
    if ([[theDelegate class] respondsToSelector:@selector(objectToPopulate)]) {
        createdObject = [[theDelegate class] objectToPopulate];
        [NSObjectRuntimeUtils updateModel:createdObject Witharray:array error:nil];
    }
    else {
        createdObject = [NSObjectRuntimeUtils objectWithClass:theClass modelArray:array error:nil];
    }
    
    return createdObject;
}

-(void)p_refreshInstance:(NSObject<MNFJsonAdapterDelegate> *)theModel delegate:(id <MNFJsonAdapterDelegate>)theDelegate jsonDict:(NSDictionary *)theJsonDict propertyKeys:(NSDictionary *)thePropertyKeys option:(MNFAdapterOption)theOption error:(NSError **)theError {
    
    NSArray <MNFJsonAdapterKeyAndProperty *> *array = [[self class] p_createModelDictionaryWithDelegate:theModel jsonDict:theJsonDict propertyKeys:thePropertyKeys option:theOption];
    
    for (MNFJsonAdapterKeyAndProperty *currentAdapterObj in array) {
        [NSObjectRuntimeUtils validateAndSetValue:currentAdapterObj.propertyValue propertyKey:currentAdapterObj.propertyKey onModel:theModel error:theError];
    }
}

+(NSArray*)p_createModelDictionaryWithDelegate:(id <MNFJsonAdapterDelegate>)theDelegate jsonDict:(NSDictionary*)theJsonDict propertyKeys:(NSDictionary*)thePropertyKeys option:(MNFAdapterOption)theOption {
    
    NSDictionary *transformedDict = nil;
    NSDictionary *subPropertyDict = nil;
    
    if ([theDelegate respondsToSelector:@selector(propertyValueTransformers)] == YES) {
        transformedDict = [theDelegate propertyValueTransformers];
    }
    
    if ([theDelegate respondsToSelector:@selector(subclassedProperties)] == YES) {
        subPropertyDict = [theDelegate subclassedProperties];
    }
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSString *jsonKey in theJsonDict) {
        
        id propertyName = [thePropertyKeys objectForKey:jsonKey];
        id jsonValue = theJsonDict[jsonKey];
        
        // check if the property exist
        if (propertyName != nil) {
            
            if (transformedDict != nil && [transformedDict objectForKey:propertyName] != nil && [[transformedDict objectForKey:propertyName] isKindOfClass:[NSValueTransformer class]] == YES && jsonValue != [NSNull null]) {
                
                NSValueTransformer *transformer = [transformedDict objectForKey:propertyName];
                jsonValue = [transformer transformedValue:jsonValue];
                
            }
            
            // should use json key as we do not want the user to have to conform to
            // the options
            if (subPropertyDict != nil && [subPropertyDict objectForKey:propertyName] != nil) {
                
                MNFJsonAdapterSubclassedProperty *subclassProperty = [subPropertyDict objectForKey:propertyName];
                
                jsonValue = [self createSubObjectWithClass:subclassProperty.propertyClass delegate:subclassProperty.propertyDelegate option:subclassProperty.propertyOption jsonDict:jsonValue];
                                
            }
            
            // get the json value and set it on the corresponding mapped or non mapped key
            // which will then be set on the object the key corresponds to the variable name.
            [array addObject:[MNFJsonAdapterKeyAndProperty jsonAdapterKey:propertyName value:jsonValue]];
            
        }
    }
    
    return array;
}

+(id)createSubObjectWithClass:(Class)theClass delegate:(id <MNFJsonAdapterDelegate>)theDelegate option:(MNFAdapterOption)theOption jsonDict:(NSDictionary *)theJsonDict {
    
    MNFJsonAdapterValueTransformer *valueTrans = [MNFJsonAdapterValueTransformer transformerWithClass:theClass delegate:theDelegate option:theOption];
    
    return [valueTrans transformedValue:theJsonDict error:nil];
}


#pragma mark - Public Serialization for objects


#pragma mark - Array Serialization Inititalizers

+(NSArray *)JSONArrayFromArray:(NSArray *)theModels option:(MNFAdapterOption)theAdapterOption error:(NSError *__autoreleasing *)theError {
    
    if (theModels.count == 0) {
        // MARK: if the error is nil and there's no check it'll crash. Does this happen elsewhere?
        if (theError != nil) {
            *theError = [NSError errorWithDomain:@"JsonAdapterDomain" code:5765 userInfo:@{ NSLocalizedDescriptionKey : @"Cannot serialize an empty array" }];
        }
        
        MNFLogError(@"Cannot serialize an empty array");
        MNFLogVerbose(@"Cannot serialize an empty array");
        return nil;
    }
    
    
    return [self JSONArrayFromArray:theModels delegate:[theModels firstObject] option:theAdapterOption error:theError];
    
}

+(NSArray *)JSONArrayFromArray:(NSArray *)theModels delegate:(id<MNFJsonAdapterDelegate>)theDelegate option:(MNFAdapterOption)theAdapterOption error:(NSError *__autoreleasing *)theError {
    
    MNFJsonAdapter *automaticSerializer = [[MNFJsonAdapter alloc] init];
    
    MNFLogInfo(@"Serialize NSArray of objects");
    MNFLogDebug(@"Serialize NSArray of objects");
    
    NSDictionary *propertyKeys = [automaticSerializer p_createPropertyKeyDictionaryForObject:[theModels firstObject] delegate:theDelegate option:theAdapterOption error:theError];
    
    NSMutableArray *jsonDictArray = [NSMutableArray array];
    
    for (id object in theModels) {
        NSDictionary *jsonDict = [automaticSerializer p_createPeropertyValueDictionaryForObject:object delegate:theDelegate propertyDictionary:propertyKeys option:theAdapterOption];
        
        if (jsonDict != nil) {
            [jsonDictArray addObject:jsonDict];
        }
    }
    
    return jsonDictArray;
    
}

#pragma mark - Dictionary serialization Initializers

+(NSDictionary *)JSONDictFromObject:(id<MNFJsonAdapterDelegate>)theModel option:(MNFAdapterOption)theAdapterOption error:(NSError **)theError {
    
    
    return [self JSONDictFromObject:theModel delegate:theModel option:theAdapterOption error:theError];
}

+(NSDictionary *)JSONDictFromObject:(id)theModel delegate:(id<MNFJsonAdapterDelegate>)theDelegate option:(MNFAdapterOption)theAdapterOption error:(NSError *__autoreleasing *)theError {
    
    MNFJsonAdapter *automaticSerializer = [[MNFJsonAdapter alloc] init];
    
    MNFLogInfo(@"Serialize NSDictionary for object with type: %@", [theModel class]);
    MNFLogDebug(@"Serialize NSDictionary for object with type: %@", [theModel class]);
    
    return [automaticSerializer p_createJSONDictFromObject:theModel delegate:theDelegate option:theAdapterOption error:theError];
    
}


#pragma mark - Data Serialization Initializers

+(NSData *)JSONDataFromObject:(id<MNFJsonAdapterDelegate>)theModel option:(MNFAdapterOption)theAdapterOption error:(NSError *__autoreleasing *)theError {
    
    
    return [self JSONDataFromObject:theModel delegate:theModel option:theAdapterOption error:theError];
}

+(NSData *)JSONDataFromObject:(id)theModel delegate:(id<MNFJsonAdapterDelegate>)theDelegate option:(MNFAdapterOption)theAdapterOption error:(NSError *__autoreleasing *)theError {
    
    MNFJsonAdapter *automaticSerializer = [[MNFJsonAdapter alloc] init];
    
    MNFLogInfo(@"Serialize NSData for object with type: %@", [theModel class]);
    MNFLogDebug(@"Serialize NSData for object with type: %@", [theModel class]);
    
    return [automaticSerializer p_createJSONDataFromObject:theModel delegate:theDelegate option:theAdapterOption error:theError];
    
}

#pragma mark - Public convenience methods

+(NSData*)JSONDataFromDictionary:(NSDictionary *)theDictionary {
    NSData *data = [NSJSONSerialization dataWithJSONObject:theDictionary options:0 error:nil];
    return data;
}
+(id)objectFromJSONData:(NSData *)theJSONData {
    return [NSJSONSerialization JSONObjectWithData:theJSONData options:0 error:nil];
}


#pragma mark - Private Initializers


-(NSData *)p_createJSONDataFromObject:(id)theModel delegate:(id <MNFJsonAdapterDelegate>)theDelegate option:(MNFAdapterOption)theAdapterOption error:(NSError **)theError {
    
    NSDictionary *theDict = [self p_createJSONDictFromObject:theModel delegate:theDelegate option:theAdapterOption error:theError];
    
    return [NSJSONSerialization dataWithJSONObject:theDict options:0 error:nil];
}

-(NSDictionary *)p_createJSONDictFromObject:(id)theModel delegate:(id <MNFJsonAdapterDelegate>)theDelegate option:(MNFAdapterOption)theAdapterOption error:(NSError **)theError {
    
    NSDictionary *propertyKeys = [self p_createPropertyKeyDictionaryForObject:theModel delegate:theDelegate option:theAdapterOption error:theError];
    
    // now get the values of the properties and store them in an NSDictionary
    NSDictionary *newJsonDict = [self p_createPeropertyValueDictionaryForObject:theModel delegate:theDelegate propertyDictionary:propertyKeys option:theAdapterOption];
    
    
    return newJsonDict;
}


#pragma mark - Serialization Dictionary Helpers

-(NSDictionary *)p_createPropertyKeyDictionaryForObject:(id <MNFJsonAdapterDelegate>)theModel delegate:(id <MNFJsonAdapterDelegate>)theDelegate option:(MNFAdapterOption)theAdapterOption error:(NSError **)theError {
    
    NSDictionary *propertyKeys = [self p_propertyKeyDictionaryAssociatedWithClass:[theModel class] error:theError];
    
    // if we have properties to serialize make
    if ([theDelegate respondsToSelector:@selector(propertiesToSerialize)]) {
        propertyKeys = [self p_propertyDictFromSet:[theDelegate propertiesToSerialize]];
    }
    else if([theDelegate respondsToSelector:@selector(propertiesToIgnoreJsonSerialization)]) {
        
        if ([theDelegate propertiesToIgnoreJsonSerialization] != nil) {
            
            propertyKeys = [self p_removeIgnoredPropertiesInDictionary:propertyKeys ignoredProperties:[theDelegate propertiesToIgnoreJsonSerialization] error:theError];
        }
    }
    
    if ([theDelegate respondsToSelector:@selector(propertyKeysMapToJson)]) {
        if ([theDelegate propertyKeysMapToJson] != nil) {
            propertyKeys = [self p_mapPropertyKeyValues:propertyKeys mapDictionary:[theDelegate propertyKeysMapToJson] error:theError];
        }
    }
    
    propertyKeys = [self p_updateOnlyDictionaryValues:propertyKeys option:theAdapterOption];
    
    return propertyKeys;
}

-(NSDictionary *)p_createDictionaryForObject:(NSObject *)theModelObject withProperties:(NSSet *)theProperties {
    
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    
    for (NSString *currentProperty in theProperties) {
        
        id value = [theModelObject valueForKey:currentProperty];
        if (value != nil) {
            [mutableDict setValue:value forKey:currentProperty];
        }
        else {
            [mutableDict setValue:[NSNull null] forKey:currentProperty];
        }
        
    }
    
    return mutableDict;
}

/** Has to be an NSObject to be able to call value for key with a protocol. */
-(NSDictionary *)p_createPeropertyValueDictionaryForObject:(NSObject*)theModelObject delegate:(id <MNFJsonAdapterDelegate>)theDelegate propertyDictionary:(NSDictionary *)thePropertyDictionary option:(MNFAdapterOption)theOption {
    
    NSMutableDictionary *newDict = [NSMutableDictionary dictionary];
    
    
    NSDictionary *transformerDict = nil;
    NSDictionary *subPropertyDict = nil;
    
    // the value transformers for specific preoperties
    if ([theDelegate respondsToSelector:@selector(propertyValueTransformers)] == YES) {
        transformerDict = [theDelegate propertyValueTransformers];
    }
    
    // sub properties
    
    // a list of the keys and classes of the sub properties
    if ([theDelegate respondsToSelector:@selector(subclassedProperties)] == YES) {
        subPropertyDict = [theDelegate subclassedProperties];
    }
    
    
    for (NSString *currentProperty in thePropertyDictionary) {
        
        id value = [theModelObject valueForKey:currentProperty];
        
        if (transformerDict != nil && value != nil && [transformerDict valueForKey:currentProperty] != nil && [[transformerDict valueForKey:currentProperty] isKindOfClass:[NSValueTransformer class]] == YES) {
            
            NSValueTransformer *transformer = [transformerDict valueForKey:currentProperty];
            value = [transformer reverseTransformedValue:value];

        }
        
        if (subPropertyDict != nil && [subPropertyDict objectForKey:currentProperty] != nil && [[subPropertyDict objectForKey:currentProperty] isKindOfClass:[MNFJsonAdapterSubclassedProperty class]] == YES) {
            
            MNFJsonAdapterSubclassedProperty *subclassProperty = [subPropertyDict objectForKey:currentProperty];

            value = [self createSubObjectWithClass:subclassProperty.propertyClass delegate:subclassProperty.propertyDelegate option:subclassProperty.propertyOption object:value];
        }
        
        if (value != nil) {
            [newDict setObject:value forKey:thePropertyDictionary[currentProperty]];
        }
        else {
            [newDict setObject:[NSNull null] forKey:thePropertyDictionary[currentProperty]];
        }
        
    }
    
    return newDict;
}

-(id)createSubObjectWithClass:(Class)theClass delegate:(id <MNFJsonAdapterDelegate>)theDelegate option:(MNFAdapterOption)theOption object:(id)theObject {
    
    MNFJsonAdapterValueTransformer *valueTransformer = [MNFJsonAdapterValueTransformer transformerWithClass:theClass delegate:theDelegate option:theOption];
    
    return [valueTransformer reverseTransformedValue:theObject error:nil];
    
}

#pragma mark - NSDictionary Property Helpers for Mapping / Ignoring properties

-(NSDictionary *)p_propertyDictFromSet:(NSSet *)thePropertySet {
    
    NSMutableDictionary *newDict = [NSMutableDictionary dictionary];
    
    for (NSString *propertyName in thePropertySet) {
        
        [newDict setObject:propertyName forKey:propertyName];
        
    }
    
    return newDict;
}

- (NSDictionary *)p_propertyKeyDictionaryAssociatedWithClass:(Class)theClass error:(NSError **)theError {
    
    NSMutableDictionary *propertyDict = [NSMutableDictionary dictionary];
    
    [NSObjectRuntimeUtils enumeratePropertiesOnClass:theClass UsingBlock:^(objc_property_t property, BOOL *stop) {
        NSString *keyName = @(property_getName(property));
        
        [propertyDict setObject:keyName forKey:keyName];
    }];
    
    
    NSDictionary *dictWithoutRestrictedKeys = [self p_removeNSObjectPropertiesFromDict: propertyDict];
    
    return dictWithoutRestrictedKeys;
}

-(NSDictionary *)p_removeNSObjectPropertiesFromDict:(NSMutableDictionary *)theDict {
    
    [NSObjectRuntimeUtils enumeratePropertiesOnClass:[NSObject class] UsingBlock:^(objc_property_t property, BOOL *stop) {
        NSString *propertyName = @(property_getName(property));
        
        [theDict removeObjectForKey:propertyName];
    }];
    
    
    return theDict;
}

// maps a json field to a new property in the object, where the key is the properties name
-(NSDictionary *)p_mapPropertyDictionaryKeys:(NSDictionary *)thePropertyDictToMap mapDictionary:(NSDictionary *)theMapDictionary error:(NSError **)theError {
    
    NSMutableDictionary *dictionaryToReturn = [NSMutableDictionary dictionaryWithDictionary:thePropertyDictToMap];
    
    for (NSString *mapPropertyKey in theMapDictionary) {
        
        BOOL foundPropertyToMap = NO;
        
        for(NSString *propertyKey in thePropertyDictToMap) {
           
            if ([propertyKey isEqualToString:mapPropertyKey]) {
                // se the name of the dictionary key to the one of the json in the mapping
                // set its value to the property key value so we know which property the json key
                // corresponds to
                [dictionaryToReturn setObject:propertyKey forKey:theMapDictionary[mapPropertyKey]];
                [dictionaryToReturn removeObjectForKey: propertyKey];
                if (theMapDictionary[propertyKey] == nil) {
                    [dictionaryToReturn removeObjectForKey:propertyKey];
                }
                
                foundPropertyToMap = YES;
                
            }
            
        }
        
        if (foundPropertyToMap == NO && theError != nil) {
            *theError = [NSError errorWithDomain:JsonAdapterDomain code:kMenigaJsonErrorMapPropertyKeyNotFound userInfo:@{ NSLocalizedDescriptionKey: [NSString stringWithFormat:@"%@ %@ %@", NSLocalizedString(@"<MenigaJsonAdapterMapPropertyNotFoundKeyErrorPartOne>", @""), mapPropertyKey, NSLocalizedString(@"<MenigaJsonAdapterMapPropertyNotFoundKeyErrorPartTwo>", @"")] }];
            MNFLogError(@"Could not find property: %@ to map to from json", mapPropertyKey);
        }
    }
    
    return dictionaryToReturn;
}

// maps the property key values to the new mapping to create the json
-(NSDictionary *)p_mapPropertyKeyValues:(NSDictionary *)thePropertyDict mapDictionary:(NSDictionary *)theMapDictionary error:(NSError **)theError {
    
    NSMutableDictionary *newDict = [NSMutableDictionary dictionaryWithDictionary:thePropertyDict];
    
    for (NSString *mapPropertyKey in theMapDictionary) {
        
        BOOL foundPropertyToMap = NO;
        for (NSString *propertyKey in thePropertyDict) {
            if ([propertyKey isEqualToString:mapPropertyKey]) {
                [newDict setObject:theMapDictionary[mapPropertyKey] forKey:propertyKey];
                foundPropertyToMap = YES;
            }
            
        }
        
        if (foundPropertyToMap == NO) {
            // MARK: Why is this uncommented?
//            *theError = [NSError errorWithDomain:JsonAdapterDomain code:kMenigaJsonErrorMapPropertyKeyNotFound userInfo:@{ NSLocalizedDescriptionKey: [NSString stringWithFormat:@"%@ %@ %@", NSLocalizedString(@"<MenigaJsonAdapterMapPropertyNotFoundKeyErrorPartOne>", @""), mapPropertyKey, NSLocalizedString(@"<MenigaJsonAdapterMapPropertyNotFoundKeyErrorPartTwo>", @"")] }];
//            MNFLogError(@"Could not find property: %@ to map to json", mapPropertyKey);
        }
    }
    
    return newDict;
}

/** Removes properties in the ignored properties NSSet if they exist in the property dictionary. This serves
 the functionality to delete properties which we do not want to de/serialize. */
-(NSDictionary *)p_removeIgnoredPropertiesInDictionary:(NSDictionary *)thePropertyDict ignoredProperties:(NSSet *)thePropertiesToIgnore error:(NSError **)theError {
    
    NSMutableDictionary *dictionaryToReturn = [NSMutableDictionary dictionaryWithDictionary:thePropertyDict];
    
    for (NSString *ignoredPropertyKey in thePropertiesToIgnore) {
        
        BOOL foundIgnoredPropertyKey = NO;
        
        for (NSString *propertyKey in thePropertyDict) {
            if ([ignoredPropertyKey isEqualToString:propertyKey]) {
                foundIgnoredPropertyKey = YES;
                [dictionaryToReturn removeObjectForKey:propertyKey];
                
            }
        }
        
        
        if (foundIgnoredPropertyKey == NO && theError != nil) {
            MNFLogError(@"Could not find key to ignore: %@", ignoredPropertyKey);
            MNFLogInfo(@"Could not find key to ignore: %@", ignoredPropertyKey);
            MNFLogDebug(@"Could not find key to ignore: %@", ignoredPropertyKey);
            *theError = [NSError errorWithDomain:JsonAdapterDomain code:kMenigaJsonErrorIgnoredPropertyKeyNotFound userInfo: @{ NSLocalizedDescriptionKey : [NSString stringWithFormat:@"%@: %@", NSLocalizedString(@"<MenigaJsonAdapterIgnoredPropertyKeyNotFoundErro>", @""), ignoredPropertyKey]} ];
        }
    }
    
    return dictionaryToReturn;
}


#pragma mark - Methods for updating the dictionary with option


-(NSDictionary *)p_updateOnlyDictionaryValues:(NSDictionary *)theDict option:(MNFAdapterOption)theAdapterOption {
    NSMutableDictionary *newDict = [NSMutableDictionary dictionary];
    
    for (NSString *key in theDict) {
        
        NSString *dictValue = theDict[key];
        
        [newDict setObject:[NSStringUtils stringWithOption:theAdapterOption fromString:dictValue] forKey:key];
        
    }
    
    return newDict;
}


-(NSDictionary *)p_updateOnlyDictionaryKeys:(NSDictionary *)theDict option:(MNFAdapterOption)theAdapterOption {
    
    NSMutableDictionary *newDict = [NSMutableDictionary dictionary];
    
    for (NSString *key in theDict) {
        
        NSString *dictValue = theDict[key];
        
        [newDict setObject:dictValue forKey:[NSStringUtils stringWithOption:theAdapterOption fromString:key]];
        
    }
    
    return newDict;
}


/** Updates the dictionary keys and values  */
-(NSDictionary *)p_updateDictionaryKeysAndValues:(NSDictionary *)theDict option:(MNFAdapterOption)theAdapterOption {
    
    NSMutableDictionary *newDict = [NSMutableDictionary dictionary];
    
    for (NSString *key in theDict) {
        
        NSString *dictValue = theDict[key];
        
        [newDict setObject:[NSStringUtils stringWithOption:theAdapterOption fromString:dictValue] forKey:[NSStringUtils stringWithOption:theAdapterOption fromString:key]];
    }
    
    return newDict;
}


@end

