//
//  MenigaAdapterTest.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 10/23/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNFJsonAdapterTestObject.h"
#import "MNFJsonAdapterTestObjectsDelegateSpecificProperties.h"
#import "MNFJsonAdapterTestObjectPropertiesFirstUppercase.h"
#import "MNFJsonAdapterTestObjectPropertiesFirstUppercaseDelegate.h"
#import "MNFJsonAdapterTestUppercaseValueTransformerDelegate.h"
#import "MNFJsonAdapterTestFirstUppercaseValueTransformerDelegate.h"
#import "MNFJsonAdapterTestDelegateConformingObject.h"
#import "MNFJsonAdapterTestValueTransformerDelegate.h"
#import "MNFJsonAdapterIgnoreErrorTestObject.h"
#import "MNFJsonAdapterJsonKeyMapToPropertyErrorTestObject.h"
#import "MNFJsonAdapterPropertyKeyMapToJsonErrorTestObject.h"
#import "MNFJsonAdapterRestrictedPRopertyErrorTestObject.h"
#import "MNFJsonAdapterCustomCreationTestObject.h"
#import "MNFSeparateNormalOptionDelegateObject.h"
#import "MNFSeparateFirstUppercaseOptionUpdateDelegateObject.h"
#import "MNFSeparateNormalOptionUpdateDelegateObject.h"
#import "MNFSeparateFirstUppercaseOptionDelegateObject.h"
#import "MNFJsonAdapter.h"
#import "NSStringUtils.h"

@interface MenigaAdapterTest : XCTestCase <MNFJsonAdapterDelegate>

@end

@implementation MenigaAdapterTest


#pragma mark - String options

-(void)testStringFirstUppercaseOption {
    
    NSString *lowercaseString = @"lowercase";
    
    NSString *outcome = [NSStringUtils stringWithOption:kMNFAdapterOptionFirstLetterUppercase fromString:lowercaseString];
    
    XCTAssertNotNil(outcome);
    XCTAssert([outcome isKindOfClass:[NSString class]]);
    XCTAssertTrue([outcome isEqualToString:@"Lowercase"]);
    XCTAssertFalse([outcome isEqualToString:@"lowercase"]);
    
}

-(void)testStringFirstLowercaseOption {
    
    NSString *uppercaseString = @"UPPERCASE";
    
    NSString *outcome = [NSStringUtils stringWithOption:kMNFAdapterOptionFirstLetterLowercase fromString:uppercaseString];
    
    XCTAssertNotNil(outcome);
    XCTAssert([outcome isKindOfClass:[NSString class]]);
    XCTAssertTrue([outcome isEqualToString:@"uPPERCASE"]);
    XCTAssertFalse([outcome isEqualToString:@"UPPERCASE"]);
}

-(void)testStringUppercaseOption {
    
    NSString *lowercaseString = @"lowercase";
    
    NSString *outcome = [NSStringUtils stringWithOption:kMNFAdapterOptionUppercase fromString:lowercaseString];
    
    XCTAssertNotNil(outcome);
    XCTAssert([outcome isKindOfClass:[NSString class]]);
    XCTAssertTrue([outcome isEqualToString:@"LOWERCASE"]);
    XCTAssertFalse([outcome isEqualToString:@"lowercase"]);
    
}

-(void)testStringLowercaseOption {
    
    NSString *uppercaseString = @"UPPERCASE";
    
    NSString *outcome = [NSStringUtils stringWithOption:kMNFAdapterOptionLowercase fromString:uppercaseString];
    
    XCTAssertNotNil(outcome);
    XCTAssert([outcome isKindOfClass:[NSString class]]);
    XCTAssertTrue([outcome isEqualToString:@"uppercase"]);
    XCTAssertFalse([outcome isEqualToString:@"UPPERCASE"]);
    
}


#pragma mark - Deserialization

-(void)testAutomaticSingleDeserialization {
    
    NSString *jsonPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"jsonSingleAdapterTest" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    
    MNFJsonAdapterTestObject *testObj = [MNFJsonAdapter objectOfClass:[MNFJsonAdapterTestObject class] jsonDict:jsonDict option:kMNFAdapterOptionNoOption error:nil];
    
    XCTAssertNotNil(jsonData);
    XCTAssertNotNil(jsonDict);
    
    XCTAssertNotNil(testObj);
    // these should be automatically serialized as they match the json
    XCTAssertNotNil(testObj.userId);
    XCTAssertNotNil(testObj.title);
    XCTAssertNotNil(testObj.body);
    // this is not in the json and should not be serialized
    XCTAssertNil(testObj.postId);
    
}

#pragma mark - Deserialization Option Tests

-(void)testAutomaticSingleDeserializationWithFirstUppercaseOption {
    
    NSString *jsonPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"jsonAdapterSingleTestFirstUppercase" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    
    MNFJsonAdapterTestObject *testObj = [MNFJsonAdapter objectOfClass:[MNFJsonAdapterTestObject class] jsonDict:jsonDict option:kMNFAdapterOptionFirstLetterUppercase error:nil];
    
    XCTAssertNotNil(jsonData);
    XCTAssertNotNil(jsonDict);
    XCTAssertNotNil(testObj);
    
    // these should be automatically serialized as they match the json
    XCTAssertNotNil(testObj.userId);
    XCTAssertNotNil(testObj.title);
    XCTAssertNotNil(testObj.body);
    
    // this is not in the json and should not be serialized
    XCTAssertNil(testObj.postId);
    
}

-(void)testAutomaticSingleDeserialiationWithUppercaseOption {
    
    NSString *jsonPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"jsonAdapterSingleTestUppercase" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    
    MNFJsonAdapterTestObject *testObj = [MNFJsonAdapter objectOfClass:[MNFJsonAdapterTestObject class] jsonDict:jsonDict option:kMNFAdapterOptionUppercase error:nil];
    
    XCTAssertNotNil(jsonData);
    XCTAssertNotNil(jsonDict);
    
    XCTAssertNotNil(testObj);
    
    // these should be automatically serialized as they match the json
    XCTAssertNotNil(testObj.userId);
    XCTAssertNotNil(testObj.title);
    XCTAssertNotNil(testObj.body);
    
    // this is not in the json and should not be serialized
    XCTAssertNil(testObj.postId);
    
}

-(void)testAutomaticSingleDeserializationWithFirstLowercaseOption {
    
    NSString *jsonPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"jsonSingleAdapterTest" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    
    MNFJsonAdapterTestObjectPropertiesFirstUppercase *testObj = [MNFJsonAdapter objectOfClass:[MNFJsonAdapterTestObjectPropertiesFirstUppercase class] jsonDict:jsonDict option:kMNFAdapterOptionFirstLetterLowercase error:nil];
    
    XCTAssertNotNil(jsonPath);
    XCTAssertNotNil(jsonData);
    
    XCTAssertNotNil(testObj);
    
    // these should be automatically serialized as they match the json
    XCTAssertNotNil(testObj.UserId);
    XCTAssertNotNil(testObj.Title);
    XCTAssertNotNil(testObj.Body);
    
    // this is not in the json and should not be serialized
    XCTAssertNil(testObj.PostId);
    
}

-(void)testAutomaticSingleDeserializationWithLowercaseOption {
    
    NSString *jsonPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"jsonAdapaterSingleTestLowercase" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    
    MNFJsonAdapterTestObjectPropertiesFirstUppercase *testObj = [MNFJsonAdapter objectOfClass:[MNFJsonAdapterTestObjectPropertiesFirstUppercase class] jsonDict:jsonDict option:kMNFAdapterOptionLowercase error:nil];
    
    XCTAssertNotNil(jsonData);
    XCTAssertNotNil(jsonDict);
    
    XCTAssertNotNil(testObj);
    
    // these should be automatically serialized as they match the json
    XCTAssertNotNil(testObj.UserId);
    XCTAssertNotNil(testObj.Title);
    XCTAssertNotNil(testObj.Body);
    
    // this is not in the json and should not be serialized
    XCTAssertNil(testObj.PostId);
    
}

#pragma mark - Deserialization With Delegate

-(void)testAutomaticSingleDeserializationWithDelegate {
    
    NSString *jsonPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"jsonSingleAdapterTest" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    
    MNFJsonAdapterTestDelegateConformingObject *testObj = [MNFJsonAdapter objectOfClass:[MNFJsonAdapterTestDelegateConformingObject class] jsonDict:jsonDict option:kMNFAdapterOptionNoOption error:nil];
    
    XCTAssertNotNil(jsonData);
    XCTAssertNotNil(jsonDict);
    
    XCTAssertNotNil(testObj);
    
    // these objects should be serialized by default as they exist in the json
    XCTAssertEqualObjects(testObj.userId, @1);
    XCTAssertEqualObjects(testObj.title, @"sunt aut facere repellat provident occaecati excepturi optio reprehenderit");
    // the value Id is mapped to postId in this objects delegate and should therefor not be nil
    XCTAssertEqualObjects(testObj.postId, @2);
    
    // this property is ignored in the json serialization in the delegate of the object and should be nil
    XCTAssertNil(testObj.body);
    
}

-(void)testAutomaticSingleDeserializationWithSepcificPropertiesDelegate {
    
    NSString *jsonPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"jsonSingleAdapterTest" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    
    MNFJsonAdapterTestObjectsDelegateSpecificProperties *testObject = [MNFJsonAdapter objectOfClass:[MNFJsonAdapterTestObjectsDelegateSpecificProperties class] jsonDict:jsonDict option:0 error:nil];
    
    XCTAssertNotNil(jsonData);
    XCTAssertNotNil(jsonDict);
    
    XCTAssertNotNil(testObject);
    
    // the properties that are supposed to be deserialized based on the delegate
    XCTAssertEqualObjects(testObject.userId, @1);
    XCTAssertEqualObjects(testObject.postId, @2);
    
    // these should not be serialized as they were not declared in the delegate
    XCTAssertNil(testObject.title);
    XCTAssertNil(testObject.body);
    
}

-(void)testAutomaticSingleDeserializationWithDelegateFirstLetterUppercaseOption {
    
    NSString *jsonPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"jsonAdapterSingleTestFirstUppercase" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    
    MNFJsonAdapterTestDelegateConformingObject *testObj = [MNFJsonAdapter objectOfClass:[MNFJsonAdapterTestDelegateConformingObject class] jsonDict:jsonDict option:kMNFAdapterOptionFirstLetterUppercase error:nil];
    
    XCTAssertNotNil(jsonData);
    XCTAssertNotNil(jsonDict);
    
    XCTAssertNotNil(testObj);
    
    // these should be automatically serialized as they match the json
    XCTAssertEqualObjects(testObj.userId, @1);
    XCTAssertEqualObjects(testObj.title, @"sunt aut facere repellat provident occaecati excepturi optio reprehenderit");
    // the id in the json is mapped to the postId
    XCTAssertEqualObjects(testObj.postId, @2);
    
    // this value is ignored in the delegate of the object
    XCTAssertNil(testObj.body);
    
}

-(void)testAutomaticSingleDeserializationWithDelegateUppercaseOption {
    
    NSString *jsonPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"jsonAdapterSingleTestUppercase" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    
    MNFJsonAdapterTestDelegateConformingObject *testObj = [MNFJsonAdapter objectOfClass:[MNFJsonAdapterTestDelegateConformingObject class] jsonDict:jsonDict option:kMNFAdapterOptionUppercase error:nil];
    
    XCTAssertNotNil(jsonData);
    XCTAssertNotNil(jsonDict);
    
    XCTAssertNotNil(testObj);
    
    // these should be automatically serialized as they match the json
    XCTAssertEqualObjects(testObj.userId, @1);
    XCTAssertEqualObjects(testObj.title, @"sunt aut facere repellat provident occaecati excepturi optio reprehenderit");
    // this value is mapped from id in the json
    XCTAssertEqualObjects(testObj.postId, @2);
    
    // this value is ignored in the delegate of the object
    XCTAssertNil(testObj.body);
    
}

-(void)testAutomaticSingleDeserializationWithDelegateFirstLowercaseOption {
    
    NSString *jsonPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"jsonSingleAdapterTest" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    
    MNFJsonAdapterTestObjectPropertiesFirstUppercaseDelegate *testObj = [MNFJsonAdapter objectOfClass:[MNFJsonAdapterTestObjectPropertiesFirstUppercaseDelegate class] jsonDict:jsonDict option:kMNFAdapterOptionFirstLetterLowercase error:nil];
    
    XCTAssertNotNil(jsonPath);
    XCTAssertNotNil(jsonData);
    
    XCTAssertNotNil(testObj);

    // these should be automatically serialized
    XCTAssertEqualObjects(testObj.UserId, @1);
    XCTAssertEqualObjects(testObj.Title, @"sunt aut facere repellat provident occaecati excepturi optio reprehenderit");
    // this property is mapped from the id in the json
    XCTAssertEqualObjects(testObj.PostId, @2);
    
    // this property should be ignored
    XCTAssertNil(testObj.Body);
    
}

-(void)testAutomaticSingleDeserializationWithDelegateLowercaseOption {
    
    NSString *jsonPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"jsonAdapaterSingleTestLowercase" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    
    MNFJsonAdapterTestObjectPropertiesFirstUppercaseDelegate *testObj = [MNFJsonAdapter objectOfClass:[MNFJsonAdapterTestObjectPropertiesFirstUppercaseDelegate class] jsonDict:jsonDict option:kMNFAdapterOptionLowercase error:nil];
    
    XCTAssertNotNil(jsonData);
    XCTAssertNotNil(jsonDict);
    
    XCTAssertNotNil(testObj);
    
    // these should be automatically serialized
    XCTAssertNotNil(testObj.UserId);
    XCTAssertNotNil(testObj.Title);
    // this value is mapped from the id in the json
    XCTAssertNotNil(testObj.PostId);
    
    // this value should be ignored from the json
    XCTAssertNil(testObj.Body);
    
}

-(void)testAutomaticArrayDeserialization {
    
    NSString *jsonPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"jsonArrayAdapterTest" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    
    NSArray *allDeserializedObjects = [MNFJsonAdapter objectsOfClass:[MNFJsonAdapterTestObject class] jsonArray:jsonArray option:kMNFAdapterOptionNoOption error:nil];
    
    // make sure the test data is contructed correctly
    XCTAssertNotNil(jsonData);
    XCTAssertNotNil(jsonArray);
    
    XCTAssertNotNil(allDeserializedObjects);
    XCTAssertEqual(allDeserializedObjects.count, 100);
    
    for (MNFJsonAdapterTestObject *currentObj in allDeserializedObjects) {
        XCTAssert([currentObj isKindOfClass:[MNFJsonAdapterTestObject class]]);
        // these should be automatically serialized
        XCTAssertNotNil(currentObj.userId);
        XCTAssertNotNil(currentObj.title);
        XCTAssertNotNil(currentObj.body);
        // should be nil as it isn't in the json file, it should be mapped to Id
        XCTAssertNil(currentObj.postId);
    }
    
}

#pragma mark - Deserialization With Custom Object Creation

-(void)testDeserializationWithCustomObjectCreation {
    
    NSString *jsonPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"jsonSingleAdapterTest" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    
    MNFJsonAdapterCustomCreationTestObject *createdObj = [MNFJsonAdapter objectOfClass:[MNFJsonAdapterCustomCreationTestObject class] jsonDict:jsonDict option:0 error:nil];
    
    XCTAssertNotNil(jsonPath);
    XCTAssertNotNil(jsonData);
    XCTAssertNotNil(jsonDict);
    
    XCTAssertEqualObjects(createdObj.userId, @1);
    //XCTAssertEqualObjects(createdObj.postId, @1);
    XCTAssertEqualObjects(createdObj.title, @"sunt aut facere repellat provident occaecati excepturi optio reprehenderit");
    XCTAssertEqualObjects(createdObj.body, @"quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto");
    XCTAssertEqualObjects(createdObj.propertySetAtCustomInitialization, @"Great Stuff!");
    
}

-(void)testDeserializationWithCustomObjectCreationLowercaseOption {
    
    NSString *jsonPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"jsonAdapaterSingleTestLowercase" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    
    MNFJsonAdapterCustomCreationTestObject *createdObj = [MNFJsonAdapter objectOfClass:[MNFJsonAdapterCustomCreationTestObject class] jsonDict:jsonDict option:kMNFAdapterOptionLowercase error:nil];
    
    XCTAssertNotNil(jsonPath);
    XCTAssertNotNil(jsonData);
    XCTAssertNotNil(jsonDict);
    
    XCTAssertEqualObjects(createdObj.userId, @1);
    //XCTAssertEqualObjects(createdObj.postId, @1);
    XCTAssertEqualObjects(createdObj.title, @"sunt aut facere repellat provident occaecati excepturi optio reprehenderit");
    XCTAssertEqualObjects(createdObj.body, @"quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto");
    XCTAssertEqualObjects(createdObj.propertySetAtCustomInitialization, @"Great Stuff!");
}

-(void)testDeserializationWithCustomObjectCreationUppercaseOption {
    
    NSString *jsonPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"jsonAdapterSingleTestUppercase" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    
    MNFJsonAdapterCustomCreationTestObject *createdObj = [MNFJsonAdapter objectOfClass:[MNFJsonAdapterCustomCreationTestObject class] jsonDict:jsonDict option:kMNFAdapterOptionUppercase error:nil];
    
    XCTAssertNotNil(jsonPath);
    XCTAssertNotNil(jsonData);
    XCTAssertNotNil(jsonDict);
    
    XCTAssertEqualObjects(createdObj.userId, @1);
    //XCTAssertEqualObjects(createdObj.postId, @1);
    XCTAssertEqualObjects(createdObj.title, @"sunt aut facere repellat provident occaecati excepturi optio reprehenderit");
    XCTAssertEqualObjects(createdObj.body, @"quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto");
    XCTAssertEqualObjects(createdObj.propertySetAtCustomInitialization, @"Great Stuff!");
}

-(void)testDeserializationWithCustomObjectCreationFirstUppercaseOption {
    
    NSString *jsonPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"jsonAdapterSingleTestFirstUppercase" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    
    MNFJsonAdapterCustomCreationTestObject *createdObj = [MNFJsonAdapter objectOfClass:[MNFJsonAdapterCustomCreationTestObject class] jsonDict:jsonDict option:kMNFAdapterOptionFirstLetterUppercase error:nil];
    
    XCTAssertNotNil(jsonPath);
    XCTAssertNotNil(jsonData);
    XCTAssertNotNil(jsonDict);
    
    XCTAssertEqualObjects(createdObj.userId, @1);
    //XCTAssertEqualObjects(createdObj.postId, @1);
    XCTAssertEqualObjects(createdObj.title, @"sunt aut facere repellat provident occaecati excepturi optio reprehenderit");
    XCTAssertEqualObjects(createdObj.body, @"quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto");
    XCTAssertEqualObjects(createdObj.propertySetAtCustomInitialization, @"Great Stuff!");
    
}

-(void)testDeserializationWithArrayOfCustomObjectCreation {
    
    NSString *jsonPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"jsonArrayAdapterTest" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    
    NSArray *allDeserializedObjects = [MNFJsonAdapter objectsOfClass:[MNFJsonAdapterCustomCreationTestObject class] jsonArray:jsonArray option:0 error:nil];
    
    XCTAssertNotNil(allDeserializedObjects);
    XCTAssertTrue(allDeserializedObjects.count == 100);
    
    for (MNFJsonAdapterCustomCreationTestObject *customCreationObj in allDeserializedObjects) {
        
        XCTAssertNotNil(customCreationObj.userId);
        XCTAssertNil(customCreationObj.postId);
        XCTAssertNotNil(customCreationObj.title);
        XCTAssertNotNil(customCreationObj.body);
        
        XCTAssertEqualObjects(customCreationObj.propertySetAtCustomInitialization, @"Great Stuff!");
        
    }
    
}

#pragma mark - Deserialization Value Transformer

-(void)testAutomaticDeserializationDateStringTransformer {
    
    NSString *jsonPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"jsonAdapterTestValueTransformer" ofType:@"json"];
    
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    
    MNFJsonAdapterTestValueTransformerDelegate *testObj = [MNFJsonAdapter objectOfClass:[MNFJsonAdapterTestValueTransformerDelegate class] jsonDict:jsonDict option:0 error:nil];
    
    XCTAssertNotNil(jsonData);
    XCTAssertNotNil(jsonDict);
    
    XCTAssertNotNil(testObj);
    
    XCTAssertNotNil(testObj.name);
    XCTAssertNotNil(testObj.birthday);
    
}

-(void)testAutomaticDeserializationDateStringFirstUppercaseValueTransformer {
    NSString *jsonPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"jsonAdapterTestFirstUppercaseValueTransformer" ofType:@"json"];
    
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    
    MNFJsonAdapterTestValueTransformerDelegate *testObj = [MNFJsonAdapter objectOfClass:[MNFJsonAdapterTestValueTransformerDelegate class] jsonDict:jsonDict option:kMNFAdapterOptionFirstLetterUppercase error:nil];
    
    XCTAssertNotNil(jsonData);
    XCTAssertNotNil(jsonDict);
    
    XCTAssertNotNil(testObj);
    
    XCTAssertNotNil(testObj.name);
    XCTAssertNotNil(testObj.birthday);
}

-(void)testAutomaticDeserializationDateStringUppercaseValueTransformer {
    NSString *jsonPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"jsonAdapterTestUppercaseValueTransformer" ofType:@"json"];
    
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    
    MNFJsonAdapterTestValueTransformerDelegate *testObj = [MNFJsonAdapter objectOfClass:[MNFJsonAdapterTestValueTransformerDelegate class] jsonDict:jsonDict option:kMNFAdapterOptionUppercase error:nil];
    
    XCTAssertNotNil(jsonData);
    XCTAssertNotNil(jsonDict);
    
    XCTAssertNotNil(testObj);
    
    XCTAssertNotNil(testObj.name);
    XCTAssertNotNil(testObj.birthday);
}

-(void)testAutomaticDeserializationDateStringLowercaseValueTransformer {
    NSString *jsonPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"jsonAdapterTestValueTransformer" ofType:@"json"];
    
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    
    MNFJsonAdapterTestUppercaseValueTransformerDelegate *testObj = [MNFJsonAdapter objectOfClass:[MNFJsonAdapterTestUppercaseValueTransformerDelegate class] jsonDict:jsonDict option:kMNFAdapterOptionLowercase error:nil];
    
    XCTAssertNotNil(jsonData);
    XCTAssertNotNil(jsonDict);
    
    XCTAssertNotNil(testObj);
    
    XCTAssertNotNil(testObj.NAME);
    XCTAssertNotNil(testObj.BIRTHDAY);
}

-(void)testAutomaticDeserializationDateStringFirstLowercaseValueTransformer {
    NSString *jsonPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"jsonAdapterTestValueTransformer" ofType:@"json"];
    
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
        
    MNFJsonAdapterTestFirstUppercaseValueTransformerDelegate *testObj = [MNFJsonAdapter objectOfClass:[MNFJsonAdapterTestFirstUppercaseValueTransformerDelegate class] jsonDict:jsonDict option:kMNFAdapterOptionFirstLetterLowercase error:nil];
    
    XCTAssertNotNil(jsonData);
    XCTAssertNotNil(jsonDict);
    
    XCTAssertNotNil(testObj);
    
    XCTAssertNotNil(testObj.Name);
    XCTAssertNotNil(testObj.Birthday);
}


#pragma mark - Deserialization With Custom Delegate Object

-(void)testAutomaticDeserializationWithCustomDelegateObjectNoOption {
    
    NSString *jsonPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"jsonSingleAdapterTest" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    
    MNFJsonAdapterTestObject *testObj = [MNFJsonAdapter objectOfClass:[MNFJsonAdapterTestObject class] delegate:[[MNFSeparateNormalOptionDelegateObject alloc] init] jsonDict:jsonDict option:kMNFAdapterOptionNoOption error:nil];
    
    XCTAssertNotNil(jsonPath);
    XCTAssertNotNil(jsonData);
    XCTAssertNotNil(jsonDict);
    XCTAssertNotNil(testObj);
    
    XCTAssertEqualObjects(testObj.userId, @2);
    XCTAssertEqualObjects(testObj.postId, nil);
    XCTAssertEqualObjects(testObj.body, @"quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto");
    XCTAssertEqualObjects(testObj.title, nil);
    
}

-(void)testAutomaticDeserializationWithCustomDelegateObjectFirstLowercaseOption {
    
    NSString *jsonPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"jsonSingleAdapterTest" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    
    MNFJsonAdapterTestObjectPropertiesFirstUppercase *testObj = [MNFJsonAdapter objectOfClass:[MNFJsonAdapterTestObjectPropertiesFirstUppercase class] delegate:[[MNFSeparateFirstUppercaseOptionDelegateObject alloc] init] jsonDict:jsonDict option:kMNFAdapterOptionFirstLetterLowercase error:nil];
    
    XCTAssertNotNil(jsonPath);
    XCTAssertNotNil(jsonData);
    XCTAssertNotNil(jsonDict);
    XCTAssertNotNil(testObj);
    
    XCTAssertEqualObjects(testObj.UserId, @2);
    XCTAssertEqualObjects(testObj.PostId, nil);
    XCTAssertEqualObjects(testObj.Body, @"quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto");
    XCTAssertEqualObjects(testObj.Title, nil);
    
}

-(void)testAutomaticDeserializationWithCustomDelegateObjectLowercaseOption {
    
    NSString *jsonPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"jsonSingleAdapterTest" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    
    MNFJsonAdapterTestObjectPropertiesFirstUppercase *testObj = [MNFJsonAdapter objectOfClass:[MNFJsonAdapterTestObjectPropertiesFirstUppercase class] delegate:[[MNFSeparateFirstUppercaseOptionDelegateObject alloc] init] jsonDict:jsonDict option:kMNFAdapterOptionFirstLetterLowercase error:nil];
    
    XCTAssertNotNil(jsonPath);
    XCTAssertNotNil(jsonData);
    XCTAssertNotNil(jsonDict);
    XCTAssertNotNil(testObj);
    
    XCTAssertEqualObjects(testObj.UserId, @2);
    XCTAssertEqualObjects(testObj.PostId, nil);
    XCTAssertEqualObjects(testObj.Body, @"quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto");
    XCTAssertEqualObjects(testObj.Title, nil);
    
}

-(void)testAutomaticDeserializationWithCustomDelegateObjectFirstUppercaseOption {
    
    NSString *jsonPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"jsonAdapaterSingleTestLowercase" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    
    MNFJsonAdapterTestObjectPropertiesFirstUppercase *testObj = [MNFJsonAdapter objectOfClass:[MNFJsonAdapterTestObjectPropertiesFirstUppercase class] delegate:[[MNFSeparateFirstUppercaseOptionDelegateObject alloc] init] jsonDict:jsonDict option:kMNFAdapterOptionFirstLetterLowercase error:nil];
    
    XCTAssertNotNil(jsonPath);
    XCTAssertNotNil(jsonData);
    XCTAssertNotNil(jsonDict);
    XCTAssertNotNil(testObj);
    
    XCTAssertEqualObjects(testObj.UserId, @1);
    XCTAssertEqualObjects(testObj.PostId, nil);
    XCTAssertEqualObjects(testObj.Body, @"quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto");
    XCTAssertEqualObjects(testObj.Title, nil);
    
}

-(void)testAutomaticDeserializationWithCustomDelegateObjectUppercaseOption {
    
    NSString *jsonPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"jsonAdapterSingleTestUppercase" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    
    MNFJsonAdapterTestObject *testObj = [MNFJsonAdapter objectOfClass:[MNFJsonAdapterTestObject class] delegate:[[MNFSeparateNormalOptionDelegateObject alloc] init] jsonDict:jsonDict option:kMNFAdapterOptionUppercase error:nil];
    
    XCTAssertNotNil(jsonPath);
    XCTAssertNotNil(jsonData);
    XCTAssertNotNil(jsonDict);
    XCTAssertNotNil(testObj);
    
    XCTAssertEqualObjects(testObj.userId, @2);
    XCTAssertEqualObjects(testObj.postId, nil);
    XCTAssertEqualObjects(testObj.body, @"quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto");
    XCTAssertEqualObjects(testObj.title, nil);
    
}


#pragma mark - Deserialization object update
-(void)testAutomaticDeserializationObjectUpdate {
    
    NSString *jsonPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"jsonSingleAdapterTest" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    
    MNFJsonAdapterTestObject *testObj = [MNFJsonAdapter objectOfClass:[MNFJsonAdapterTestObject class] jsonDict:jsonDict option:kMNFAdapterOptionNoOption error:nil];
    
    NSMutableDictionary *mutJsonDict = [jsonDict mutableCopy];
    [mutJsonDict setObject:@2 forKey:@"userId"];
    [mutJsonDict setObject:@42 forKey:@"id"];
    [mutJsonDict setObject:@"aaaw yeah!" forKey:@"title"];
    [mutJsonDict setObject:@"Boku wa nihongo o hanasukoto ga dekinai!" forKey:@"body"];
    
    [MNFJsonAdapter refreshObject:testObj withJsonDict:[mutJsonDict copy] option:kMNFAdapterOptionNoOption error:nil];
    
    XCTAssertNotNil(jsonData);
    XCTAssertNotNil(jsonDict);
    
    XCTAssertNotNil(testObj);
    
    // these should be automatically serialized as they match the json
    XCTAssertEqualObjects(testObj.userId, @2);
    XCTAssertEqualObjects(testObj.title, @"aaaw yeah!");
    XCTAssertEqualObjects(testObj.body, @"Boku wa nihongo o hanasukoto ga dekinai!");
    
    // this is not in the json and should not be serialized
    XCTAssertEqualObjects(testObj.postId, nil);
}

-(void)testAutomaticDeserializationObjectUpdateFirstLetterUppercaseOption {
    NSString *jsonPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"jsonAdapterSingleTestFirstUppercase" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    
    MNFJsonAdapterTestObject *testObj = [MNFJsonAdapter objectOfClass:[MNFJsonAdapterTestObject class] jsonDict:jsonDict option:kMNFAdapterOptionFirstLetterUppercase error:nil];
    
    NSMutableDictionary *mutJsonDict = [jsonDict mutableCopy];
    [mutJsonDict setObject:@2 forKey:@"UserId"];
    [mutJsonDict setObject:@42 forKey:@"Id"];
    [mutJsonDict setObject:@"aaaw yeah!" forKey:@"Title"];
    [mutJsonDict setObject:@"Boku wa nihongo o hanasukoto ga dekinai!" forKey:@"Body"];
    
    [MNFJsonAdapter refreshObject:testObj withJsonDict:[mutJsonDict copy] option:kMNFAdapterOptionFirstLetterUppercase error:nil];
    
    XCTAssertNotNil(jsonData);
    XCTAssertNotNil(jsonDict);
    
    XCTAssertNotNil(testObj);
    
    // these should be automatically serialized as they match the json
    XCTAssertEqualObjects(testObj.userId, @2);
    XCTAssertEqualObjects(testObj.title, @"aaaw yeah!");
    XCTAssertEqualObjects(testObj.body, @"Boku wa nihongo o hanasukoto ga dekinai!");
    
    // this is not in the json and should not be serialized
    XCTAssertEqualObjects(testObj.postId, nil);
}

-(void)testAutomaticDeserializationObjectUpdateUppercaseOption {
    NSString *jsonPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"jsonAdapterSingleTestUppercase" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    
    MNFJsonAdapterTestObject *testObj = [MNFJsonAdapter objectOfClass:[MNFJsonAdapterTestObject class] jsonDict:jsonDict option:kMNFAdapterOptionUppercase error:nil];
    
    NSMutableDictionary *mutJsonDict = [jsonDict mutableCopy];
    [mutJsonDict setObject:@2 forKey:@"USERID"];
    [mutJsonDict setObject:@42 forKey:@"ID"];
    [mutJsonDict setObject:@"aaaw yeah!" forKey:@"TITLE"];
    [mutJsonDict setObject:@"Boku wa nihongo o hanasukoto ga dekinai!" forKey:@"BODY"];
    
    [MNFJsonAdapter refreshObject:testObj withJsonDict:[mutJsonDict copy] option:kMNFAdapterOptionUppercase error:nil];
    
    XCTAssertNotNil(jsonData);
    XCTAssertNotNil(jsonDict);
    
    XCTAssertNotNil(testObj);
    
    // these should be automatically serialized as they match the json
    XCTAssertEqualObjects(testObj.userId, @2);
    XCTAssertEqualObjects(testObj.title, @"aaaw yeah!");
    XCTAssertEqualObjects(testObj.body, @"Boku wa nihongo o hanasukoto ga dekinai!");
    
    // this is not in the json and should not be serialized
    XCTAssertEqualObjects(testObj.postId, nil);
}

-(void)testAutomaticDeserializationObjectUpdateFirstLetterLowercaseOption {
    NSString *jsonPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"jsonSingleAdapterTest" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    
    MNFJsonAdapterTestObjectPropertiesFirstUppercase *testObj = [MNFJsonAdapter objectOfClass:[MNFJsonAdapterTestObjectPropertiesFirstUppercase class] jsonDict:jsonDict option:kMNFAdapterOptionFirstLetterLowercase error:nil];
    
    NSMutableDictionary *mutJsonDict = [jsonDict mutableCopy];
    [mutJsonDict setObject:@2 forKey:@"userId"];
    [mutJsonDict setObject:@42 forKey:@"id"];
    [mutJsonDict setObject:@"aaaw yeah!" forKey:@"title"];
    [mutJsonDict setObject:@"Boku wa nihongo o hanasukoto ga dekinai!" forKey:@"body"];
    
    [MNFJsonAdapter refreshObject:testObj withJsonDict:[mutJsonDict copy] option:kMNFAdapterOptionFirstLetterLowercase error:nil];
    
    XCTAssertNotNil(jsonPath);
    XCTAssertNotNil(jsonData);
    
    XCTAssertNotNil(testObj);
    
    // these should be automatically serialized as they match the json
    XCTAssertEqualObjects(testObj.UserId, @2);
    XCTAssertEqualObjects(testObj.Title, @"aaaw yeah!");
    XCTAssertEqualObjects(testObj.Body, @"Boku wa nihongo o hanasukoto ga dekinai!");
    
    // this is not in the json and should not be serialized
    XCTAssertEqualObjects(testObj.PostId, nil);
}

-(void)testAutomaticDeserializationObjectUpdateLowercaseOption {
    NSString *jsonPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"jsonAdapaterSingleTestLowercase" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    
    MNFJsonAdapterTestObjectPropertiesFirstUppercase *testObj = [MNFJsonAdapter objectOfClass:[MNFJsonAdapterTestObjectPropertiesFirstUppercase class] jsonDict:jsonDict option:kMNFAdapterOptionLowercase error:nil];
    
    NSMutableDictionary *mutJsonDict = [jsonDict mutableCopy];
    [mutJsonDict setObject:@2 forKey:@"userid"];
    [mutJsonDict setObject:@42 forKey:@"id"];
    [mutJsonDict setObject:@"aaaw yeah!" forKey:@"title"];
    [mutJsonDict setObject:@"Boku wa nihongo o hanasukoto ga dekinai!" forKey:@"body"];
    
    [MNFJsonAdapter refreshObject:testObj withJsonDict:[mutJsonDict copy] option:kMNFAdapterOptionLowercase error:nil];
    
    XCTAssertNotNil(jsonData);
    XCTAssertNotNil(jsonDict);
    
    XCTAssertNotNil(testObj);
    
    // these should be automatically serialized as they match the json
    XCTAssertEqualObjects(testObj.UserId, @2);
    XCTAssertEqualObjects(testObj.Title, @"aaaw yeah!");
    XCTAssertEqualObjects(testObj.Body, @"Boku wa nihongo o hanasukoto ga dekinai!");
    
    // this is not in the json and should not be serialized
    XCTAssertEqualObjects(testObj.PostId, nil);
}


#pragma mark - Deserialization Object Update Separate Delegation Object

-(void)testAutomaticDeserializationObjectUpdateSeparateDelegate {
    
    NSString *jsonPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"jsonSingleAdapterTest" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    
    MNFJsonAdapterTestObject *testObj = [MNFJsonAdapter objectOfClass:[MNFJsonAdapterTestObject class] jsonDict:jsonDict option:kMNFAdapterOptionNoOption error:nil];
    
    NSMutableDictionary *mutJsonDict = [jsonDict mutableCopy];
    [mutJsonDict setObject:@2 forKey:@"userId"];
    [mutJsonDict setObject:@42 forKey:@"uglyId"];
    [mutJsonDict setObject:@"aaaw yeah!" forKey:@"title"];
    [mutJsonDict setObject:@"Boku wa nihongo o hanasukoto ga dekinai!" forKey:@"body"];
    
    [MNFJsonAdapter refreshObject:testObj delegate:[[MNFSeparateNormalOptionUpdateDelegateObject alloc] init] jsonDict:[mutJsonDict copy] option:kMNFAdapterOptionNoOption error:nil];
    
    XCTAssertNotNil(jsonData);
    XCTAssertNotNil(jsonDict);
    
    XCTAssertNotNil(testObj);
    
    // these should be automatically serialized as they match the json
    XCTAssertEqualObjects(testObj.userId, @2);
    XCTAssertEqualObjects(testObj.postId, @42);
    XCTAssertEqualObjects(testObj.title, @"aaaw yeah!");
    // prior value of the body key, no the serialized value
    XCTAssertEqualObjects(testObj.body,  @"quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto");
    
}

-(void)testAutomaticDeserializationObjectUpdateFirstLetterUppercaseOptionSeparateDelegate {
    NSString *jsonPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"jsonAdapterSingleTestFirstUppercase" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    
    MNFJsonAdapterTestObject *testObj = [MNFJsonAdapter objectOfClass:[MNFJsonAdapterTestObject class] jsonDict:jsonDict option:kMNFAdapterOptionFirstLetterUppercase error:nil];
    
    NSMutableDictionary *mutJsonDict = [jsonDict mutableCopy];
    [mutJsonDict setObject:@2 forKey:@"UserId"];
    [mutJsonDict setObject:@42 forKey:@"UglyId"];
    [mutJsonDict setObject:@"aaaw yeah!" forKey:@"Title"];
    [mutJsonDict setObject:@"Boku wa nihongo o hanasukoto ga dekinai!" forKey:@"Body"];
    
    [MNFJsonAdapter refreshObject:testObj delegate:[[MNFSeparateNormalOptionUpdateDelegateObject alloc] init] jsonDict:[mutJsonDict copy] option:kMNFAdapterOptionFirstLetterUppercase error:nil];
    
    XCTAssertNotNil(jsonData);
    XCTAssertNotNil(jsonDict);
    
    XCTAssertNotNil(testObj);
    
    // these should be automatically serialized as they match the json
    XCTAssertEqualObjects(testObj.userId, @2);
    XCTAssertEqualObjects(testObj.postId, @42);
    XCTAssertEqualObjects(testObj.title, @"aaaw yeah!");
    // this was not serilaized this is the prior value of the property
    XCTAssertEqualObjects(testObj.body, @"quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto");
}

-(void)testAutomaticDeserializationObjectUpdateUppercaseOptionSeparateDelegate {
    NSString *jsonPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"jsonAdapterSingleTestUppercase" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    
    MNFJsonAdapterTestObject *testObj = [MNFJsonAdapter objectOfClass:[MNFJsonAdapterTestObject class] jsonDict:jsonDict option:kMNFAdapterOptionUppercase error:nil];
    
    NSMutableDictionary *mutJsonDict = [jsonDict mutableCopy];
    [mutJsonDict setObject:@2 forKey:@"USERID"];
    [mutJsonDict setObject:@42 forKey:@"UGLYID"];
    [mutJsonDict setObject:@"aaaw yeah!" forKey:@"TITLE"];
    [mutJsonDict setObject:@"Boku wa nihongo o hanasukoto ga dekinai!" forKey:@"BODY"];
    
    [MNFJsonAdapter refreshObject:testObj delegate:[[MNFSeparateNormalOptionUpdateDelegateObject alloc] init] jsonDict:[mutJsonDict copy] option:kMNFAdapterOptionUppercase error:nil];
    
    XCTAssertNotNil(jsonData);
    XCTAssertNotNil(jsonDict);
    
    XCTAssertNotNil(testObj);
    
    // these should be automatically serialized as they match the json
    XCTAssertEqualObjects(testObj.userId, @2);
    XCTAssertEqualObjects(testObj.postId, @42);
    XCTAssertEqualObjects(testObj.title, @"aaaw yeah!");
    // this was not serilaized this is the prior value of the property
    XCTAssertEqualObjects(testObj.body,  @"quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto");
    
}

-(void)testAutomaticDeserializationObjectUpdateFirstLetterLowercaseOptionSeparateDelegate {
    NSString *jsonPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"jsonSingleAdapterTest" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    
    MNFJsonAdapterTestObjectPropertiesFirstUppercase *testObj = [MNFJsonAdapter objectOfClass:[MNFJsonAdapterTestObjectPropertiesFirstUppercase class] jsonDict:jsonDict option:kMNFAdapterOptionFirstLetterLowercase error:nil];
    
    NSMutableDictionary *mutJsonDict = [jsonDict mutableCopy];
    [mutJsonDict setObject:@2 forKey:@"id"];
    [mutJsonDict setObject:@42 forKey:@"uglyId"];
    [mutJsonDict setObject:@"aaaw yeah!" forKey:@"title"];
    [mutJsonDict setObject:@"Boku wa nihongo o hanasukoto ga dekinai!" forKey:@"body"];
    
    [MNFJsonAdapter refreshObject:testObj delegate:[[MNFSeparateFirstUppercaseOptionUpdateDelegateObject alloc] init] jsonDict:[mutJsonDict copy] option:kMNFAdapterOptionFirstLetterLowercase error:nil];
    
    XCTAssertNotNil(jsonPath);
    XCTAssertNotNil(jsonData);
    
    XCTAssertNotNil(testObj);
    
    // these should be automatically serialized as they match the json
    XCTAssertEqualObjects(testObj.UserId, @2);
    XCTAssertEqualObjects(testObj.PostId, @42);
    XCTAssertEqualObjects(testObj.Title, @"aaaw yeah!");
    // this was not serilaized this is the prior value of the property
    XCTAssertEqualObjects(testObj.Body, @"quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto");
    
}

-(void)testAutomaticDeserializationObjectUpdateLowercaseOptionSeparateDelegate {
    NSString *jsonPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"jsonAdapaterSingleTestLowercase" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    
    MNFJsonAdapterTestObjectPropertiesFirstUppercase *testObj = [MNFJsonAdapter objectOfClass:[MNFJsonAdapterTestObjectPropertiesFirstUppercase class] jsonDict:jsonDict option:kMNFAdapterOptionLowercase error:nil];
    
    NSMutableDictionary *mutJsonDict = [jsonDict mutableCopy];
    [mutJsonDict setObject:@2 forKey:@"id"];
    [mutJsonDict setObject:@42 forKey:@"uglyid"];
    [mutJsonDict setObject:@"aaaw yeah!" forKey:@"title"];
    [mutJsonDict setObject:@"Boku wa nihongo o hanasukoto ga dekinai!" forKey:@"body"];
    
    [MNFJsonAdapter refreshObject:testObj delegate:[[MNFSeparateFirstUppercaseOptionUpdateDelegateObject alloc] init] jsonDict:[mutJsonDict copy] option:kMNFAdapterOptionLowercase error:nil];
    
    XCTAssertNotNil(jsonData);
    XCTAssertNotNil(jsonDict);
    
    XCTAssertNotNil(testObj);
    
    // these should be automatically serialized as they match the json
    XCTAssertEqualObjects(testObj.UserId, @2);
    XCTAssertEqualObjects(testObj.PostId, @42);
    XCTAssertEqualObjects(testObj.Title, @"aaaw yeah!");
    // this was not serilaized this is the prior value of the property
    XCTAssertEqualObjects(testObj.Body, @"quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto");
}


#pragma mark - Serialization

-(void)testAutomaticSerialization {
    
    MNFJsonAdapterTestObject *testObj = [MNFJsonAdapterTestObject initWithUserId:[NSNumber numberWithInt:10] postId:nil body:nil title:@"Title"];
    
    NSDictionary *serializedDict = [MNFJsonAdapter JSONDictFromObject:testObj option:kMNFAdapterOptionNoOption error:nil];
    
    XCTAssertNotNil(testObj);
    XCTAssertNotNil(serializedDict);
    
    XCTAssert([serializedDict[@"userId"] isEqualToNumber:[NSNumber numberWithInt:10]]);
    XCTAssert(serializedDict[@"postId"] == [NSNull null]);
    XCTAssert(serializedDict[@"body"] == [NSNull null]);
    XCTAssert([serializedDict[@"title"] isEqualToString:@"Title"]);
}

-(void)testAutomaticSerializationWithFirstLowercaseOption {
    
    MNFJsonAdapterTestObjectPropertiesFirstUppercase *testObj = [MNFJsonAdapterTestObjectPropertiesFirstUppercase initWithUserId:[NSNumber numberWithInt:7] postId:[NSNumber numberWithInt:19] body:@"Test body" title:@"Test title"];
    
    NSDictionary *serializedDict = [MNFJsonAdapter JSONDictFromObject:testObj option:kMNFAdapterOptionFirstLetterLowercase error:nil];
    
    XCTAssertNotNil(testObj);
    XCTAssertNotNil(serializedDict);
    
    XCTAssertTrue([serializedDict[@"userId"] isEqualToNumber:[NSNumber numberWithInt:7]]);
    XCTAssertTrue([serializedDict[@"postId"] isEqualToNumber:[NSNumber numberWithInt:19]]);
    XCTAssertTrue([serializedDict[@"body"] isEqualToString:@"Test body"]);
    XCTAssertTrue([serializedDict[@"title"] isEqualToString:@"Test title"]);
    
}

-(void)testAutomaticSerializationWithFirstUppercaseOption {
    
    MNFJsonAdapterTestObject *testObj = [MNFJsonAdapterTestObject initWithUserId:[NSNumber numberWithInt:10] postId:nil body:nil title:@"Title"];
    
    NSDictionary *serializedDict = [MNFJsonAdapter JSONDictFromObject:testObj option:kMNFAdapterOptionFirstLetterUppercase error:nil];
    
    XCTAssertNotNil(testObj);
    XCTAssertNotNil(serializedDict);
    
    XCTAssertNil(serializedDict[@"userId"]);
    XCTAssertNil(serializedDict[@"postId"]);
    XCTAssertNil(serializedDict[@"body"]);
    XCTAssertNil(serializedDict[@"title"]);
    
    XCTAssertTrue([serializedDict[@"UserId"] isEqualToNumber:[NSNumber numberWithInt:10]]);
    XCTAssertTrue([serializedDict[@"PostId"] isEqual:[NSNull null]]);
    XCTAssertTrue([serializedDict[@"Body"] isEqual:[NSNull null]]);
    XCTAssertTrue([serializedDict[@"Title"] isEqualToString:@"Title"]);
}

-(void)testAutomaticSerializationWithUppercaseOption {
    
    MNFJsonAdapterTestObject *testObj = [MNFJsonAdapterTestObject initWithUserId:[NSNumber numberWithInt:8] postId:[NSNumber numberWithInt:3] body:nil title:@"Test title"];
    
    NSDictionary *serializedDict = [MNFJsonAdapter JSONDictFromObject:testObj option:kMNFAdapterOptionUppercase error:nil];
    
    XCTAssertNotNil(testObj);
    XCTAssertNotNil(serializedDict);
    
    XCTAssertNil(serializedDict[@"userId"]);
    XCTAssertNil(serializedDict[@"postId"]);
    XCTAssertNil(serializedDict[@"body"]);
    XCTAssertNil(serializedDict[@"title"]);
    
    XCTAssertTrue([serializedDict[@"USERID"] isEqualToNumber:[NSNumber numberWithInt:8]]);
    XCTAssertTrue([serializedDict[@"POSTID"] isEqualToNumber:[NSNumber numberWithInt:3]]);
    XCTAssertTrue([serializedDict[@"BODY"] isEqual:[NSNull null]]);
    XCTAssertTrue([serializedDict[@"TITLE"] isEqualToString:@"Test title"]);
}

-(void)testAutomaticSerializationWithLowercaseOption {
    
    MNFJsonAdapterTestObject *testObj = [MNFJsonAdapterTestObject initWithUserId:nil postId:[NSNumber numberWithInt:7] body:@"Test body" title:nil];
    
    NSDictionary *serializedDict = [MNFJsonAdapter JSONDictFromObject:testObj option:kMNFAdapterOptionLowercase error:nil];
    
    XCTAssertNotNil(testObj);
    XCTAssertNotNil(serializedDict);
    
    XCTAssertNil(serializedDict[@"userId"]);
    XCTAssertNil(serializedDict[@"postId"]);
    
    XCTAssertTrue([serializedDict[@"userid"] isEqual:[NSNull null]]);
    XCTAssertTrue([serializedDict[@"postid"] isEqualToNumber:[NSNumber numberWithInt:7]]);
    XCTAssertTrue([serializedDict[@"body"] isEqualToString:@"Test body"]);
    XCTAssertTrue([serializedDict[@"title"] isEqual:[NSNull null]]);
}

#pragma mark - Serialization With Delegate


-(void)testAutomaticSerializationWithDelegate {
    
    MNFJsonAdapterTestDelegateConformingObject *testObj = [MNFJsonAdapterTestDelegateConformingObject initWithUserId:[NSNumber numberWithInt:10] postId:[NSNumber numberWithInt:9] body:@"Body" title:@"Title"];
    
    NSDictionary *serializedDict = [MNFJsonAdapter JSONDictFromObject:testObj option:kMNFAdapterOptionNoOption error:nil];
    
    XCTAssertNotNil(testObj);
    XCTAssertNotNil(serializedDict);
    
    // this key should be ignored and should therefor be nil
    XCTAssertNil(serializedDict[@"userId"]);
    // this key should be mapped and therefor should be nil
    XCTAssertNil(serializedDict[@"postId"]);
    
    // All of these should be serialized and therefor not be nil
    XCTAssertNotNil(serializedDict[@"id"]);
    XCTAssertNotNil(serializedDict[@"body"]);
    XCTAssertNotNil(serializedDict[@"title"]);
    
    // check if the values correspond to what we initialized them to
    XCTAssertTrue([serializedDict[@"id"] isEqualToNumber:[NSNumber numberWithInt:9]]);
    XCTAssertTrue([serializedDict[@"body"] isEqualToString:@"Body"]);
    XCTAssertTrue([serializedDict[@"title"] isEqualToString:@"Title"]);
    
}

-(void)testAutomaticSerializationWithSpecificPropertiesDelegate {
    MNFJsonAdapterTestObjectsDelegateSpecificProperties *testObj = [MNFJsonAdapterTestObjectsDelegateSpecificProperties initWithUserId:nil postId:[NSNumber numberWithInt:6] body:@"Test body" title:nil];
    
    NSDictionary *serializeDict = [MNFJsonAdapter JSONDictFromObject:testObj option:0 error:nil];
    
    XCTAssertNotNil(testObj);
    XCTAssertNotNil(serializeDict);
    
    // these keys are explicitly declared to be serialized in the delegate
    XCTAssertTrue([serializeDict[@"id"] isEqualToNumber:[NSNumber numberWithInt:6]]);
    XCTAssertTrue([serializeDict[@"userId"] isEqual:[NSNull null]]);
    
    // these keys should be ignored
    XCTAssertNil(serializeDict[@"title"]);
    XCTAssertNil(serializeDict[@"body"]);
}

-(void)testAutomaticSerializationWithDelegateFirstLetterUppercaseOption {
    
    MNFJsonAdapterTestDelegateConformingObject *testObj = [MNFJsonAdapterTestDelegateConformingObject initWithUserId:[NSNumber numberWithInt:10] postId:[NSNumber numberWithInt:9] body:@"Test body" title:@"Test title"];
    
    NSDictionary *serializedDict = [MNFJsonAdapter JSONDictFromObject:testObj option:kMNFAdapterOptionFirstLetterUppercase error:nil];
    
    XCTAssertNotNil(testObj);
    XCTAssertNotNil(serializedDict);
    
    // all keys should have first uppercase so the normal ones should result in nil
    XCTAssertNil(serializedDict[@"userId"]);
    XCTAssertNil(serializedDict[@"postId"]);
    XCTAssertNil(serializedDict[@"body"]);
    XCTAssertNil(serializedDict[@"title"]);
    
    // this key shold be ignored and therefor be nil
    XCTAssertNil(serializedDict[@"UserId"]);
    // this key should be mapped and therefor be nil
    XCTAssertNil(serializedDict[@"postId"]);
    
    XCTAssertTrue([serializedDict[@"Id"] isEqualToNumber:[NSNumber numberWithInt:9]]);
    XCTAssertTrue([serializedDict[@"Body"] isEqualToString:@"Test body"]);
    XCTAssertTrue([serializedDict[@"Title"] isEqualToString:@"Test title"]);
}

-(void)testAutomaticSerializationWtihDelegateUppercaseOption {
    
    MNFJsonAdapterTestDelegateConformingObject *testObj = [MNFJsonAdapterTestDelegateConformingObject initWithUserId:[NSNumber numberWithInt:10] postId:[NSNumber numberWithInt:9] body:@"Test body" title:@"Test title"];
    
    NSDictionary *serializedDict = [MNFJsonAdapter JSONDictFromObject:testObj option:kMNFAdapterOptionUppercase error:nil];
    
    XCTAssertNotNil(testObj);
    XCTAssertNotNil(serializedDict);
    
    // all keys should be uppercase uppercase so the normal ones should result in nil
    XCTAssertNil(serializedDict[@"userId"]);
    XCTAssertNil(serializedDict[@"postId"]);
    XCTAssertNil(serializedDict[@"body"]);
    XCTAssertNil(serializedDict[@"title"]);
    
    // this key shold be ignored and therefor be nil
    XCTAssertNil(serializedDict[@"USERID"]);
    // this key should be mapped and therefor be nil
    XCTAssertNil(serializedDict[@"POSTID"]);
    
    XCTAssertTrue([serializedDict[@"ID"] isEqualToNumber:[NSNumber numberWithInt:9]]);
    XCTAssertTrue([serializedDict[@"BODY"] isEqualToString:@"Test body"]);
    XCTAssertTrue([serializedDict[@"TITLE"] isEqualToString:@"Test title"]);
    
}

-(void)testAutomaticSerilaizationWithDelegateFirstLetterLowercaseOption {
    
    MNFJsonAdapterTestObjectPropertiesFirstUppercaseDelegate *testObj = [MNFJsonAdapterTestObjectPropertiesFirstUppercaseDelegate initWithUserId:[NSNumber numberWithInt:11] postId:[NSNumber numberWithInt:93] body:@"Test body" title:@"Test title"];
    
    NSDictionary *serializedDict = [MNFJsonAdapter JSONDictFromObject:testObj option:kMNFAdapterOptionFirstLetterLowercase error:nil];
    
    XCTAssertNotNil(testObj);
    XCTAssertNotNil(serializedDict);
    
    // all keys should have first letter in lowercase so the normal ones should result in nil
    XCTAssertNil(serializedDict[@"UserId"]);
    XCTAssertNil(serializedDict[@"PostId"]);
    XCTAssertNil(serializedDict[@"Body"]);
    XCTAssertNil(serializedDict[@"Title"]);
    
    // this key should be ignored and therefor be nil
    XCTAssertNil(serializedDict[@"userId"]);
    // this key should be mapped and therefor be nil
    XCTAssertNil(serializedDict[@"postId"]);
    
    XCTAssertTrue([serializedDict[@"id"] isEqualToNumber:[NSNumber numberWithInt:93]]);
    XCTAssertTrue([serializedDict[@"body"] isEqualToString:@"Test body"]);
    XCTAssertTrue([serializedDict[@"title"] isEqualToString:@"Test title"]);
    
}


#pragma mark - Serialization With Seperate Delegate

-(void)testSerializationWithSeparateDelegateNoOption {
    
    MNFJsonAdapterTestObject *testObj = [MNFJsonAdapterTestObject initWithUserId:[NSNumber numberWithInt:10] postId:nil body:@"someBody" title:@"Title"];
    
    NSDictionary *serializedDict = [MNFJsonAdapter JSONDictFromObject:testObj delegate:[[MNFSeparateNormalOptionDelegateObject alloc] init] option:kMNFAdapterOptionNoOption error:nil];
    
    XCTAssertNotNil(testObj);
    XCTAssertNotNil(serializedDict);
    
    XCTAssert([serializedDict[@"userIdentifier"] isEqualToNumber:[NSNumber numberWithInt:10]]);
    XCTAssert(serializedDict[@"postId"] == [NSNull null]);
    XCTAssert(serializedDict[@"body"] == nil);
    XCTAssert([serializedDict[@"title"] isEqualToString:@"Title"]);
    
}

-(void)testSerializationWithSeparateDelegateFirstLowercaseOption {
    
    MNFJsonAdapterTestObjectPropertiesFirstUppercase *testObj = [MNFJsonAdapterTestObjectPropertiesFirstUppercase initWithUserId:[NSNumber numberWithInt:7] postId:[NSNumber numberWithInt:19] body:@"Test body" title:@"Test title"];
    
    NSDictionary *serializedDict = [MNFJsonAdapter JSONDictFromObject:testObj delegate:[[MNFSeparateFirstUppercaseOptionDelegateObject alloc] init] option:kMNFAdapterOptionFirstLetterLowercase error:nil];
    
    XCTAssertNotNil(testObj);
    XCTAssertNotNil(serializedDict);
    
    XCTAssertTrue([serializedDict[@"userIdentifier"] isEqualToNumber:[NSNumber numberWithInt:7]]);
    XCTAssertTrue([serializedDict[@"postId"] isEqualToNumber:[NSNumber numberWithInt:19]]);
    XCTAssertTrue([serializedDict[@"body"] isEqualToString:@"Test body"]);
    XCTAssertTrue(serializedDict[@"Title"] == nil);
    
}

-(void)testSerializationWithSeparateDelegateLowercaseOption {
    
    MNFJsonAdapterTestObject *testObj = [MNFJsonAdapterTestObject initWithUserId:nil postId:[NSNumber numberWithInt:7] body:@"Test body" title:nil];
    
    NSDictionary *serializedDict = [MNFJsonAdapter JSONDictFromObject:testObj delegate:[[MNFSeparateNormalOptionDelegateObject alloc] init] option:kMNFAdapterOptionLowercase error:nil];
    
    XCTAssertNotNil(testObj);
    XCTAssertNotNil(serializedDict);
    
    XCTAssertNil(serializedDict[@"userId"]);
    XCTAssertNil(serializedDict[@"postId"]);
    
    XCTAssertTrue([serializedDict[@"useridentifier"] isEqual:[NSNull null]]);
    XCTAssertTrue([serializedDict[@"postid"] isEqualToNumber:[NSNumber numberWithInt:7]]);
    XCTAssertTrue(serializedDict[@"body"] == nil);
    XCTAssertTrue([serializedDict[@"title"] isEqual:[NSNull null]]);
}

-(void)testSerializationWithSeparateDelegateFirstUppercaseOption {
    
    MNFJsonAdapterTestObject *testObj = [MNFJsonAdapterTestObject initWithUserId:[NSNumber numberWithInt:10] postId:nil body:nil title:@"Title"];
    
    NSDictionary *serializedDict = [MNFJsonAdapter JSONDictFromObject:testObj delegate:[[MNFSeparateNormalOptionDelegateObject alloc] init] option:kMNFAdapterOptionFirstLetterUppercase error:nil];
    
    XCTAssertNotNil(testObj);
    XCTAssertNotNil(serializedDict);
    
    XCTAssertNil(serializedDict[@"userId"]);
    XCTAssertNil(serializedDict[@"postId"]);
    XCTAssertNil(serializedDict[@"body"]);
    XCTAssertNil(serializedDict[@"title"]);
    
    XCTAssertTrue([serializedDict[@"UserIdentifier"] isEqualToNumber:[NSNumber numberWithInt:10]]);
    XCTAssertTrue([serializedDict[@"PostId"] isEqual:[NSNull null]]);
    XCTAssertTrue(serializedDict[@"Body"] == nil);
    XCTAssertTrue([serializedDict[@"Title"] isEqualToString:@"Title"]);
}

-(void)testSerializationWithSeparateDelegateUppercaseOption {
    
    MNFJsonAdapterTestObject *testObj = [MNFJsonAdapterTestObject initWithUserId:[NSNumber numberWithInt:8] postId:[NSNumber numberWithInt:3] body:nil title:@"Test title"];
    
    NSDictionary *serializedDict = [MNFJsonAdapter JSONDictFromObject:testObj delegate:[[MNFSeparateNormalOptionDelegateObject alloc] init] option:kMNFAdapterOptionUppercase error:nil];
    
    XCTAssertNotNil(testObj);
    XCTAssertNotNil(serializedDict);
    
    XCTAssertNil(serializedDict[@"userId"]);
    XCTAssertNil(serializedDict[@"postId"]);
    XCTAssertNil(serializedDict[@"body"]);
    XCTAssertNil(serializedDict[@"title"]);
    
    XCTAssertTrue([serializedDict[@"USERIDENTIFIER"] isEqualToNumber:[NSNumber numberWithInt:8]]);
    XCTAssertTrue([serializedDict[@"POSTID"] isEqualToNumber:[NSNumber numberWithInt:3]]);
    XCTAssertTrue(serializedDict[@"BODY"] == nil);
    XCTAssertTrue([serializedDict[@"TITLE"] isEqualToString:@"Test title"]);
}


#pragma mark - Serialization Value Transformer 

-(void)testAutomaticSerializationWithTransformer {
    
    MNFJsonAdapterTestValueTransformerDelegate *testObj = [[MNFJsonAdapterTestValueTransformerDelegate alloc] initWithName:@"name" birthday:[NSDate date]];
    
    NSDictionary *serializeDict = [MNFJsonAdapter JSONDictFromObject:testObj option:0 error:nil];
    
    XCTAssertNotNil(testObj);
    XCTAssertNotNil(serializeDict);
    
    XCTAssertNotNil(serializeDict[@"name"]);
    XCTAssertNotNil(serializeDict[@"birthday"]);
    
    XCTAssertTrue([serializeDict[@"name"] isEqualToString:@"name"]);
}

-(void)testAutomaticSerializationFirstUppercaseWithTransformer {
    MNFJsonAdapterTestValueTransformerDelegate *testObj = [[MNFJsonAdapterTestValueTransformerDelegate alloc] initWithName:@"The Name" birthday:[NSDate date]];
    
    NSDictionary *serializeDict = [MNFJsonAdapter JSONDictFromObject:testObj option:kMNFAdapterOptionFirstLetterUppercase error:nil];
    
    XCTAssertNotNil(testObj);
    XCTAssertNotNil(serializeDict);
    
    XCTAssertNil(serializeDict[@"name"]);
    XCTAssertNil(serializeDict[@"birthday"]);
    
    XCTAssertNotNil(serializeDict[@"Name"]);
    XCTAssertNotNil(serializeDict[@"Birthday"]);
    
    XCTAssertTrue([serializeDict[@"Name"] isEqualToString:@"The Name"]);
}

-(void)testAutomaticSerializationUppercaseWithTransformer {
    MNFJsonAdapterTestValueTransformerDelegate *testObj = [[MNFJsonAdapterTestValueTransformerDelegate alloc] initWithName:@"The Name" birthday:[NSDate date]];
    
    NSDictionary *serializeDict = [MNFJsonAdapter JSONDictFromObject:testObj option:kMNFAdapterOptionUppercase error:nil];
    
    XCTAssertNotNil(testObj);
    XCTAssertNotNil(serializeDict);
    
    XCTAssertNil(serializeDict[@"name"]);
    XCTAssertNil(serializeDict[@"birthday"]);
    
    XCTAssertNotNil(serializeDict[@"NAME"]);
    XCTAssertNotNil(serializeDict[@"BIRTHDAY"]);
    
    XCTAssertTrue([serializeDict[@"NAME"] isEqualToString:@"The Name"]);
}

-(void)testAutomaticSerializationFirstLowercaseWithTransformer {
    
    MNFJsonAdapterTestFirstUppercaseValueTransformerDelegate *testObj = [[MNFJsonAdapterTestFirstUppercaseValueTransformerDelegate alloc] initWithName:@"The Name" birthday:[NSDate date]];
    
    NSDictionary *serializeDict = [MNFJsonAdapter JSONDictFromObject:testObj option:kMNFAdapterOptionFirstLetterLowercase error:nil];
    
    XCTAssertNotNil(testObj);
    XCTAssertNotNil(serializeDict);
    
    XCTAssertNil(serializeDict[@"Name"]);
    XCTAssertNil(serializeDict[@"Birthday"]);
    
    XCTAssertNotNil(serializeDict[@"name"]);
    XCTAssertNotNil(serializeDict[@"birthday"]);
    
    XCTAssertTrue([serializeDict[@"name"] isEqualToString:@"The Name"]);
}

-(void)testAutomaticSerializationLowercaseWithTransformer {
    
    MNFJsonAdapterTestUppercaseValueTransformerDelegate *testObj = [[MNFJsonAdapterTestUppercaseValueTransformerDelegate alloc] initWithName:@"The Name" birthday:[NSDate date]];
    
    NSDictionary *serializeDict = [MNFJsonAdapter JSONDictFromObject:testObj option:kMNFAdapterOptionLowercase error:nil];
    
    XCTAssertNotNil(testObj);
    XCTAssertNotNil(serializeDict);
    
    XCTAssertNil(serializeDict[@"NAME"]);
    XCTAssertNil(serializeDict[@"BIRTHDAY"]);
    
    XCTAssertNotNil(serializeDict[@"name"]);
    XCTAssertNotNil(serializeDict[@"birthday"]);
    
    XCTAssertTrue([serializeDict[@"name"] isEqualToString:@"The Name"]);
}


#pragma mark - Error Tests Deserialization

-(void)testRestrictedPropertyErrorDeserialization {
    
    NSString *jsonPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"jsonSingleAdapterTest" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    NSError *error;
    
    MNFJsonAdapterRestrictedPRopertyErrorTestObject *testObj = [MNFJsonAdapter objectOfClass:[MNFJsonAdapterRestrictedPRopertyErrorTestObject class] jsonDict:jsonDict option:kMNFAdapterOptionNoOption error:&error];
    
    XCTAssertNotNil(jsonDict);
    XCTAssertNotNil(testObj);
//    XCTAssertNotNil(error);
//    
//    XCTAssertTrue(error.code == kMenigaJsonErrorRestrictedPropertyUsed);
    
}

-(void)testIgnoredPropertyErrorDeserialization {
    
    NSString *jsonPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"jsonSingleAdapterTest" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    NSError *error;
    
    MNFJsonAdapterIgnoreErrorTestObject *testObj = [MNFJsonAdapter objectOfClass:[MNFJsonAdapterIgnoreErrorTestObject class] jsonDict:jsonDict option:kMNFAdapterOptionNoOption error:&error];
    
    XCTAssertNotNil(jsonData);
    XCTAssertNotNil(jsonDict);
    XCTAssertNotNil(error);
    XCTAssertNotNil(testObj);
    
    XCTAssertTrue(error.code == kMenigaJsonErrorIgnoredPropertyKeyNotFound);
    
    // these should be automatically serialized as they match the json
    XCTAssertNotNil(testObj.userId);
    XCTAssertNotNil(testObj.title);
    XCTAssertNotNil(testObj.body);
    // this is not in the json and should not be serialized
    XCTAssertNotNil(testObj.postId);
    
}

-(void)testJsonKeyMapToPropertyErrorDeserialization {
    
    NSString *jsonPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"jsonSingleAdapterTest" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    NSError *error;
    
    MNFJsonAdapterJsonKeyMapToPropertyErrorTestObject *testObj = [MNFJsonAdapter objectOfClass:[MNFJsonAdapterJsonKeyMapToPropertyErrorTestObject class] jsonDict:jsonDict option:kMNFAdapterOptionNoOption error:&error];
    
    XCTAssertNotNil(jsonData);
    XCTAssertNotNil(jsonDict);
    XCTAssertNotNil(error);
    XCTAssertNotNil(testObj);
    
    XCTAssertTrue(error.code == kMenigaJsonErrorMapPropertyKeyNotFound);
    
    XCTAssertNotNil(testObj.userId);
    XCTAssertNotNil(testObj.title);
    
    XCTAssertNil(testObj.body);
    XCTAssertNil(testObj.postId);
    
}

#pragma mark - Error Test Serialization

-(void)testRestrictedPropertyKeyErrorSerialization {
    
    MNFJsonAdapterRestrictedPRopertyErrorTestObject *testObj = [[MNFJsonAdapterRestrictedPRopertyErrorTestObject alloc] init];
    
    NSError *error;
    
    NSDictionary *jsonDict = [MNFJsonAdapter JSONDictFromObject:testObj option:kMNFAdapterOptionNoOption error:&error];
    
    XCTAssertNotNil(testObj);
    XCTAssertNotNil(jsonDict);
//    XCTAssertNotNil(error);
//    
//    XCTAssertTrue(error.code == kMenigaJsonErrorRestrictedPropertyUsed);
}

// is crashing need to check
-(void)testPropertyKeyMapToJsonErrorSerialization {
    
    MNFJsonAdapterPropertyKeyMapToJsonErrorTestObject *testObj = [MNFJsonAdapterPropertyKeyMapToJsonErrorTestObject initWithUserId:[NSNumber numberWithInt:1] postId:[NSNumber numberWithInt:10] body:@"Some body" title:@"Some title"];
    
    NSError *error;
    
    NSDictionary *jsonDict = [MNFJsonAdapter JSONDictFromObject:testObj option:kMNFAdapterOptionNoOption error:&error];
    
    XCTAssertNotNil(testObj);
    XCTAssertNotNil(jsonDict);
//    XCTAssertNotNil(error);
    
    //XCTAssertTrue(error.code == kMenigaJsonErrorMapPropertyKeyNotFound);
    
    XCTAssertNotNil(jsonDict[@"body"]);
    XCTAssertNotNil(jsonDict[@"title"]);
    
    XCTAssertNil(jsonDict[@"id"]);
    XCTAssertNil(jsonDict[@"userId"]);
    
}

-(void)testIgnoredPropertyErrorSerialization {
    
    MNFJsonAdapterIgnoreErrorTestObject *testObj = [MNFJsonAdapterIgnoreErrorTestObject initWithUserId:[NSNumber numberWithInt:1] postId:[NSNumber numberWithInt:2] body:@"Some body" title:@"Some title"];
    
    NSError *error;
    
    NSDictionary *jsonDict = [MNFJsonAdapter JSONDictFromObject:testObj option:kMNFAdapterOptionNoOption error:&error];
    
    XCTAssertNotNil(testObj);
    XCTAssertNotNil(jsonDict);
    XCTAssertNotNil(error);
    
    XCTAssertTrue(error.code == kMenigaJsonErrorIgnoredPropertyKeyNotFound);
    
    XCTAssertNotNil(jsonDict[@"id"]);
    XCTAssertNotNil(jsonDict[@"body"]);
    XCTAssertNotNil(jsonDict[@"title"]);
    XCTAssertNotNil(jsonDict[@"userId"]);
    
}

@end
