//
//  MNFCategoryTest.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 03/11/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNFCategory.h"
#import "MNFCategoryType.h"
#import "MNFNetwork.h"
#import "MNFNetworkProtocolForTesting.h"
#import "MNFObjectTypes.h"
#import "MNFObject_Private.h"
#import "GCDUtils.h"

@interface MNFCategoryTest : XCTestCase {
    MNFCategory *_sut;
}

@end

@implementation MNFCategoryTest

- (void)setUp {
    [super setUp];
    [MNFNetwork initializeForTesting];
    
    NSData *createData = [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"categoryResponse" ofType:@"json"]];
    
    NSDictionary *categoryDict = [NSJSONSerialization JSONObjectWithData:createData options:0 error:nil];
    categoryDict = [categoryDict objectForKey:@"data"];
    
    _sut = [MNFCategory initWithServerResult:categoryDict];
    
}

- (void)tearDown {
    [MNFNetwork flushForTesting];
    [super tearDown];
}

-(void)testCreateNewCategory {
    
    MNFCategory *newCategory = [[MNFCategory alloc] init];
    
    XCTAssertTrue(newCategory.isNew == YES);
    
}

- (void)testFetchCategoryWithIdWithCompletion {
    [MNFNetworkProtocolForTesting setObjectType:MNFCategoryObject];
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Something"];
    MNFJob *job = [MNFCategory fetchWithId:@81 culture:nil completion:^(MNFCategory *category, NSError *error) {
        
        XCTAssertEqualObjects(category.identifier, @81);
        XCTAssertEqualObjects(category.name, @"Alcohol");
        XCTAssertEqualObjects(category.parentCategoryId, @70);
        XCTAssertEqualObjects(category.isSystemCategory, @1);
        XCTAssertEqualObjects(category.isFixedExpenses, @0);
        XCTAssertEqual(category.categoryTypeId, 0);
        XCTAssertEqualObjects(category.categoryRank, @"NotUseful");
        XCTAssertEqualObjects(category.budgetGenerationType, @12);
        XCTAssertEqualObjects(category.children, nil);
        XCTAssertNil(category.categoryContextId);
        XCTAssertEqualObjects(category.orderId, @0);
        XCTAssertEqualObjects(category.displayData, @"e636");
        XCTAssertTrue(category.isNew == NO);
        
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

-(void)testFetchPublicCategories {
    
    NSData *responseData = [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"categoriesPublicResponse" ofType:@"json"]];
    
    [MNFNetworkProtocolForTesting setResponseData:responseData];
    
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFJob *job = [MNFCategory fetchSystemCategoriesWithCulture:nil completion:^(NSArray *categories, NSError *error) {
        
        XCTAssertTrue(categories.count == 20);
        
        MNFCategory *firstCategory = [categories firstObject];
        XCTAssertEqualObjects(firstCategory.identifier, @81);
        XCTAssertEqualObjects(firstCategory.name, @"Alcohol");
        XCTAssertEqualObjects(firstCategory.otherCategoryName, nil);
        XCTAssertEqualObjects(firstCategory.parentCategoryId, @70);
        XCTAssertEqualObjects(firstCategory.isSystemCategory, @1);
        XCTAssertEqualObjects(firstCategory.isFixedExpenses , @0);
        XCTAssertEqual(firstCategory.categoryTypeId, 0);
        XCTAssertEqualObjects(firstCategory.categoryRank, @"NotUseful");
        XCTAssertEqualObjects(firstCategory.budgetGenerationType, @12);
        XCTAssertEqualObjects(firstCategory.categoryContextId, nil);
        XCTAssertEqualObjects(firstCategory.orderId, @0);
        XCTAssertEqualObjects(firstCategory.displayData, @"e636");
        XCTAssertTrue(firstCategory.isNew == NO);
        
        for (id object in categories) {
            MNFCategory *category = (MNFCategory*)object;
            
            XCTAssertTrue([object isKindOfClass:[MNFCategory class]] == YES);
            XCTAssertTrue(category.isNew == NO);
        }
        
        [expectation fulfill];
        
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
    
}

-(void)testFetchAndCategoryChildrenPopulation {
    
    NSData *responseData = [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"categoriesPublicWithChildCreationResponse" ofType:@"json"]];
    
    
    [MNFNetworkProtocolForTesting setResponseData:responseData];
    
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFJob *job = [MNFCategory fetchSystemCategoriesWithCulture:nil completion:^(NSArray *categories, NSError *error) {
       
        XCTAssertTrue(categories.count == 3);
        
        
        MNFCategory *firstCategory = [categories firstObject];
        XCTAssertTrue(firstCategory.children.count == 1);
        XCTAssertTrue(firstCategory.isNew == NO);
        
        MNFCategory *firstCategoryFirstSubchild = [firstCategory.children objectAtIndex:0];
        XCTAssertEqualObjects(firstCategory.identifier, firstCategoryFirstSubchild.parentCategoryId);
        XCTAssertEqualObjects(firstCategoryFirstSubchild.identifier, @118);
        XCTAssertEqualObjects(firstCategoryFirstSubchild.name, @"Alimony Paid");
        XCTAssertEqualObjects(firstCategoryFirstSubchild.parentCategoryId, @81);
        XCTAssertEqualObjects(firstCategoryFirstSubchild.isSystemCategory, @1);
        XCTAssertEqualObjects(firstCategoryFirstSubchild.isFixedExpenses, @1);
        XCTAssertEqual(firstCategoryFirstSubchild.categoryTypeId, 0);
        XCTAssertEqualObjects(firstCategoryFirstSubchild.categoryRank, @"NotUseful");
        XCTAssertEqualObjects(firstCategoryFirstSubchild.budgetGenerationType, @1);
        XCTAssertEqualObjects(firstCategoryFirstSubchild.categoryContextId, nil);
        XCTAssertEqualObjects(firstCategoryFirstSubchild.orderId, @0);
        XCTAssertEqualObjects(firstCategoryFirstSubchild.displayData, nil);
        XCTAssertTrue(firstCategoryFirstSubchild.children.count == 1);
        XCTAssertTrue(firstCategoryFirstSubchild.isNew == NO);
        
        
        MNFCategory *secondCategory = [categories objectAtIndex:1];
        XCTAssertTrue(secondCategory.children.count == 1);
        XCTAssertTrue(secondCategory.isNew == NO);
        
        MNFCategory *secondCategoryFirstSubchild = [secondCategory.children objectAtIndex:0];
        XCTAssertEqualObjects(secondCategory.identifier, secondCategoryFirstSubchild.parentCategoryId);
        XCTAssertEqualObjects(secondCategoryFirstSubchild.identifier, @134);
        XCTAssertEqualObjects(secondCategoryFirstSubchild.name, @"Art & Fine Items");
        XCTAssertEqualObjects(secondCategoryFirstSubchild.parentCategoryId, @118);
        XCTAssertEqualObjects(secondCategoryFirstSubchild.isSystemCategory, @1);
        XCTAssertEqualObjects(secondCategoryFirstSubchild.isFixedExpenses, @0);
        XCTAssertEqual(secondCategoryFirstSubchild.categoryTypeId, 0);
        XCTAssertEqualObjects(secondCategoryFirstSubchild.categoryRank, @"NotUseful");
        XCTAssertEqualObjects(secondCategoryFirstSubchild.budgetGenerationType, @12);
        XCTAssertEqualObjects(secondCategoryFirstSubchild.categoryContextId, nil);
        XCTAssertEqualObjects(secondCategoryFirstSubchild.orderId, @0);
        XCTAssertEqualObjects(secondCategoryFirstSubchild.displayData, nil);
        XCTAssertTrue(secondCategoryFirstSubchild.children.count == 0);
        XCTAssertTrue(secondCategoryFirstSubchild.isNew == NO);
        
        MNFCategory *thirdCategory = [categories objectAtIndex:2];
        XCTAssertTrue(thirdCategory.children.count == 0);
        XCTAssertTrue(thirdCategory.isNew == NO);
        
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

-(void)testFetchCategoryTree {
    
    NSData *responseData = [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"categoryTreeResponse" ofType:@"json"]];
    
    [MNFNetworkProtocolForTesting setResponseData:responseData];
    
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFJob *job = [MNFCategory fetchCategoryTreeWithCulture:nil completion:^(NSArray *categories, NSError *error) {
        
        XCTAssertTrue(categories.count == 1);
        
        MNFCategory *parentCategory = [categories firstObject];
        XCTAssertEqualObjects(parentCategory.identifier, @81);
        XCTAssertEqualObjects(parentCategory.name, @"Alcohol");
        XCTAssertEqualObjects(parentCategory.parentCategoryId, nil);
        XCTAssertEqualObjects(parentCategory.isSystemCategory, @1);
        XCTAssertEqualObjects(parentCategory.isFixedExpenses, @0);
        XCTAssertEqual(parentCategory.categoryTypeId, 0);
        XCTAssertTrue(parentCategory.children.count == 2);
        XCTAssertTrue(parentCategory.isNew == NO);
        
        MNFCategory *firstChildCategory = [parentCategory.children objectAtIndex:0];
        XCTAssertEqualObjects(firstChildCategory.identifier, @118);
        XCTAssertEqualObjects(firstChildCategory.name, @"Alimony Paid");
        XCTAssertEqualObjects(firstChildCategory.parentCategoryId, parentCategory.identifier);
        XCTAssertEqualObjects(firstChildCategory.parentCategoryId, @81);
        XCTAssertEqualObjects(firstChildCategory.isSystemCategory, @1);
        XCTAssertEqualObjects(firstChildCategory.isFixedExpenses, @1);
        XCTAssertTrue(firstChildCategory.isNew == NO);
        
        MNFCategory *secondChildCategory = [parentCategory.children objectAtIndex:1];
        XCTAssertEqualObjects(secondChildCategory.identifier, @134);
        XCTAssertEqualObjects(secondChildCategory.name, @"Art & Fine Items");
        XCTAssertEqualObjects(secondChildCategory.parentCategoryId, parentCategory.identifier);
        XCTAssertEqualObjects(secondChildCategory.parentCategoryId, @81);
        XCTAssertEqualObjects(secondChildCategory.isSystemCategory, @1);
        XCTAssertEqualObjects(secondChildCategory.isFixedExpenses, @0);
        XCTAssertTrue(secondChildCategory.isNew == NO);
        
        [expectation fulfill];
        
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:nil];
}

-(void)testRefreshCategory {
    
    MNFCategory *category = _sut;
    
    // Setting up response
    NSData *responseData = [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"categorySecondResponse" ofType:@"json"]];
    
    [MNFNetworkProtocolForTesting setResponseData:responseData];
    
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    
    // tests before refresh
    
    XCTAssertEqualObjects(category.identifier, @81);
    XCTAssertEqualObjects(category.name, @"Alcohol");
    XCTAssertEqualObjects(category.parentCategoryId, @70);
    XCTAssertEqualObjects(category.isSystemCategory, @1);
    XCTAssertEqualObjects(category.isFixedExpenses, @0);
    XCTAssertEqual(category.categoryTypeId, 0);
    XCTAssertEqualObjects(category.categoryRank, @"NotUseful");
    XCTAssertEqualObjects(category.budgetGenerationType, @12);
    XCTAssertEqualObjects(category.children, nil);
    XCTAssertNil(category.categoryContextId);
    XCTAssertEqualObjects(category.orderId, @0);
    XCTAssertEqualObjects(category.displayData, @"e636");
    XCTAssertTrue(category.isNew == NO);
    
    MNFJob *job = [category refreshWithCompletion:^(NSError *error) {
        
        XCTAssertEqualObjects(category.identifier, @81);
        XCTAssertEqualObjects(category.name, @"New Alcohol");
        XCTAssertEqualObjects(category.otherCategoryName, nil);
        XCTAssertEqualObjects(category.parentCategoryId, @82);
        XCTAssertEqualObjects(category.isSystemCategory, @1);
        XCTAssertEqualObjects(category.isFixedExpenses, @0);
        XCTAssertEqual(category.categoryTypeId, 0);
        XCTAssertEqualObjects(category.categoryRank, @"NotUseful");
        XCTAssertEqualObjects(category.budgetGenerationType, @12);
        XCTAssertEqualObjects(category.children, nil);
        XCTAssertEqualObjects(category.categoryContextId, nil);
        XCTAssertEqualObjects(category.orderId, @0);
        XCTAssertEqualObjects(category.displayData, @"e636");
        XCTAssertTrue(category.isNew == NO);
        
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

-(void)testRefreshCategoryWithNilCompletion {
    
    MNFCategory *category = _sut;
    
    
    // Setting up response
    NSData *responseData = [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"categorySecondResponse" ofType:@"json"]];
    
    [MNFNetworkProtocolForTesting setResponseData:responseData];
    
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    
    // tests before refresh
    
    XCTAssertEqualObjects(category.identifier, @81);
    XCTAssertEqualObjects(category.name, @"Alcohol");
    XCTAssertEqualObjects(category.parentCategoryId, @70);
    XCTAssertEqualObjects(category.isSystemCategory, @1);
    XCTAssertEqualObjects(category.isFixedExpenses, @0);
    XCTAssertEqual(category.categoryTypeId, 0);
    XCTAssertEqualObjects(category.categoryRank, @"NotUseful");
    XCTAssertEqualObjects(category.budgetGenerationType, @12);
    XCTAssertEqualObjects(category.children, nil);
    XCTAssertNil(category.categoryContextId);
    XCTAssertEqualObjects(category.orderId, @0);
    XCTAssertEqualObjects(category.displayData, @"e636");
    XCTAssertTrue(category.isNew == NO);
    
    [category refreshWithCompletion:nil];
    
    [GCDUtils dispatchAfterTime:0.2 completion:^{
        
        XCTAssertEqualObjects(category.identifier, @81);
        XCTAssertEqualObjects(category.name, @"New Alcohol");
        XCTAssertEqualObjects(category.otherCategoryName, nil);
        XCTAssertEqualObjects(category.parentCategoryId, @82);
        XCTAssertEqualObjects(category.isSystemCategory, @1);
        XCTAssertEqualObjects(category.isFixedExpenses, @0);
        XCTAssertEqual(category.categoryTypeId, 0);
        XCTAssertEqualObjects(category.categoryRank, @"NotUseful");
        XCTAssertEqualObjects(category.budgetGenerationType, @12);
        XCTAssertEqualObjects(category.children, nil);
        XCTAssertEqualObjects(category.categoryContextId, nil);
        XCTAssertEqualObjects(category.orderId, @0);
        XCTAssertEqualObjects(category.displayData, @"e636");
        XCTAssertTrue(category.isNew == NO);
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
    
}

-(void)testRefreshCategoryWithChildrenPopulated {
    
    NSData *responseData = [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"categoriesPublicWithChildCreationResponse" ofType:@"json"]];
    
    [MNFNetworkProtocolForTesting setResponseData:responseData];
    
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFJob *job = [MNFCategory fetchCategoriesWithCulture:nil completion:^(NSArray *categories, NSError *error) {
        
        XCTAssertTrue(categories.count == 3);
        
        
        MNFCategory *firstCategory = [categories firstObject];
        XCTAssertTrue(firstCategory.children.count == 1);
        XCTAssertTrue(firstCategory.isNew == NO);
        
        MNFCategory *firstCategoryFirstSubchild = [firstCategory.children objectAtIndex:0];
        XCTAssertEqualObjects(firstCategory.identifier, firstCategoryFirstSubchild.parentCategoryId);
        XCTAssertEqualObjects(firstCategoryFirstSubchild.identifier, @118);
        XCTAssertEqualObjects(firstCategoryFirstSubchild.name, @"Alimony Paid");
        XCTAssertEqualObjects(firstCategoryFirstSubchild.parentCategoryId, @81);
        XCTAssertEqualObjects(firstCategoryFirstSubchild.isSystemCategory, @1);
        XCTAssertEqualObjects(firstCategoryFirstSubchild.isFixedExpenses, @1);
        XCTAssertEqual(firstCategoryFirstSubchild.categoryTypeId, 0);
        XCTAssertEqualObjects(firstCategoryFirstSubchild.categoryRank, @"NotUseful");
        XCTAssertEqualObjects(firstCategoryFirstSubchild.budgetGenerationType, @1);
        XCTAssertEqualObjects(firstCategoryFirstSubchild.categoryContextId, nil);
        XCTAssertEqualObjects(firstCategoryFirstSubchild.orderId, @0);
        XCTAssertEqualObjects(firstCategoryFirstSubchild.displayData, nil);
        XCTAssertTrue(firstCategoryFirstSubchild.children.count == 1);
        XCTAssertTrue(firstCategoryFirstSubchild.isNew == NO);
        
        
        NSData *secondResponseData = [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"categorySecondResponse" ofType:@"json"]];
        
        [MNFNetworkProtocolForTesting setResponseData:secondResponseData];
        
        [firstCategory refreshWithCompletion:^(NSError *error) {
           
            XCTAssertEqualObjects(firstCategory.identifier, @81);
            XCTAssertEqualObjects(firstCategory.name, @"New Alcohol");
            XCTAssertEqualObjects(firstCategory.otherCategoryName, nil);
            XCTAssertEqualObjects(firstCategory.parentCategoryId, @82);
            XCTAssertEqualObjects(firstCategory.isSystemCategory, @1);
            XCTAssertEqualObjects(firstCategory.isFixedExpenses, @0);
            XCTAssertEqual(firstCategory.categoryTypeId, 0);
            XCTAssertEqualObjects(firstCategory.categoryRank, @"NotUseful");
            XCTAssertEqualObjects(firstCategory.budgetGenerationType, @12);
            XCTAssertEqualObjects(firstCategory.categoryContextId, nil);
            XCTAssertEqualObjects(firstCategory.orderId, @0);
            XCTAssertEqualObjects(firstCategory.displayData, @"e636");
            XCTAssertTrue(firstCategory.isNew == NO);
            
            XCTAssertTrue(firstCategory.children.count == 1);
            
            
            MNFCategory *firstUpdatedCategoryFirstSubchild = [firstCategory.children objectAtIndex:0];
            XCTAssertEqualObjects(firstCategory.identifier, firstCategoryFirstSubchild.parentCategoryId);
            XCTAssertEqualObjects(firstUpdatedCategoryFirstSubchild.identifier, @118);
            XCTAssertEqualObjects(firstUpdatedCategoryFirstSubchild.name, @"Alimony Paid");
            XCTAssertEqualObjects(firstUpdatedCategoryFirstSubchild.parentCategoryId, @81);
            XCTAssertEqualObjects(firstUpdatedCategoryFirstSubchild.isSystemCategory, @1);
            XCTAssertEqualObjects(firstUpdatedCategoryFirstSubchild.isFixedExpenses, @1);
            XCTAssertEqual(firstUpdatedCategoryFirstSubchild.categoryTypeId, 0);
            XCTAssertEqualObjects(firstUpdatedCategoryFirstSubchild.categoryRank, @"NotUseful");
            XCTAssertEqualObjects(firstUpdatedCategoryFirstSubchild.budgetGenerationType, @1);
            XCTAssertEqualObjects(firstUpdatedCategoryFirstSubchild.categoryContextId, nil);
            XCTAssertEqualObjects(firstUpdatedCategoryFirstSubchild.orderId, @0);
            XCTAssertEqualObjects(firstUpdatedCategoryFirstSubchild.displayData, nil);
            XCTAssertTrue(firstUpdatedCategoryFirstSubchild.children.count == 1);
            XCTAssertTrue(firstUpdatedCategoryFirstSubchild.isNew == NO);
            
            
            [expectation fulfill];
        }];
        
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
    
}

-(void)testRefreshCategoryWithChildPopulatedNilCompletion {
    
    NSData *responseData = [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"categoriesPublicWithChildCreationResponse" ofType:@"json"]];
    
    [MNFNetworkProtocolForTesting setResponseData:responseData];
    
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [MNFCategory fetchCategoriesWithCulture:nil completion:^(NSArray *categories, NSError *error) {
        
        XCTAssertTrue(categories.count == 3);
        
        
        MNFCategory *firstCategory = [categories firstObject];
        XCTAssertTrue(firstCategory.children.count == 1);
        XCTAssertTrue(firstCategory.isNew == NO);
        
        MNFCategory *firstCategoryFirstSubchild = [firstCategory.children objectAtIndex:0];
        XCTAssertEqualObjects(firstCategory.identifier, firstCategoryFirstSubchild.parentCategoryId);
        XCTAssertEqualObjects(firstCategoryFirstSubchild.identifier, @118);
        XCTAssertEqualObjects(firstCategoryFirstSubchild.name, @"Alimony Paid");
        XCTAssertEqualObjects(firstCategoryFirstSubchild.parentCategoryId, @81);
        XCTAssertEqualObjects(firstCategoryFirstSubchild.isSystemCategory, @1);
        XCTAssertEqualObjects(firstCategoryFirstSubchild.isFixedExpenses, @1);
        XCTAssertEqual(firstCategoryFirstSubchild.categoryTypeId, 0);
        XCTAssertEqualObjects(firstCategoryFirstSubchild.categoryRank, @"NotUseful");
        XCTAssertEqualObjects(firstCategoryFirstSubchild.budgetGenerationType, @1);
        XCTAssertEqualObjects(firstCategoryFirstSubchild.categoryContextId, nil);
        XCTAssertEqualObjects(firstCategoryFirstSubchild.orderId, @0);
        XCTAssertEqualObjects(firstCategoryFirstSubchild.displayData, nil);
        XCTAssertTrue(firstCategoryFirstSubchild.children.count == 1);
        XCTAssertTrue(firstCategoryFirstSubchild.isNew == NO);
        
        
        NSData *secondResponseData = [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"categorySecondResponse" ofType:@"json"]];
        
        [MNFNetworkProtocolForTesting setResponseData:secondResponseData];
        
        [firstCategory refreshWithCompletion:nil];
        
        [GCDUtils dispatchAfterTime:0.2 completion:^{
            
            XCTAssertEqualObjects(firstCategory.identifier, @81);
            XCTAssertEqualObjects(firstCategory.name, @"New Alcohol");
            XCTAssertEqualObjects(firstCategory.otherCategoryName, nil);
            XCTAssertEqualObjects(firstCategory.parentCategoryId, @82);
            XCTAssertEqualObjects(firstCategory.isSystemCategory, @1);
            XCTAssertEqualObjects(firstCategory.isFixedExpenses, @0);
            XCTAssertEqual(firstCategory.categoryTypeId, 0);
            XCTAssertEqualObjects(firstCategory.categoryRank, @"NotUseful");
            XCTAssertEqualObjects(firstCategory.budgetGenerationType, @12);
            XCTAssertEqualObjects(firstCategory.categoryContextId, nil);
            XCTAssertEqualObjects(firstCategory.orderId, @0);
            XCTAssertEqualObjects(firstCategory.displayData, @"e636");
            XCTAssertTrue(firstCategory.isNew == NO);
            
            XCTAssertTrue(firstCategory.children.count == 1);
            
            
            MNFCategory *firstUpdatedCategoryFirstSubchild = [firstCategory.children objectAtIndex:0];
            XCTAssertEqualObjects(firstCategory.identifier, firstCategoryFirstSubchild.parentCategoryId);
            XCTAssertEqualObjects(firstUpdatedCategoryFirstSubchild.identifier, @118);
            XCTAssertEqualObjects(firstUpdatedCategoryFirstSubchild.name, @"Alimony Paid");
            XCTAssertEqualObjects(firstUpdatedCategoryFirstSubchild.parentCategoryId, @81);
            XCTAssertEqualObjects(firstUpdatedCategoryFirstSubchild.isSystemCategory, @1);
            XCTAssertEqualObjects(firstUpdatedCategoryFirstSubchild.isFixedExpenses, @1);
            XCTAssertEqual(firstUpdatedCategoryFirstSubchild.categoryTypeId, 0);
            XCTAssertEqualObjects(firstUpdatedCategoryFirstSubchild.categoryRank, @"NotUseful");
            XCTAssertEqualObjects(firstUpdatedCategoryFirstSubchild.budgetGenerationType, @1);
            XCTAssertEqualObjects(firstUpdatedCategoryFirstSubchild.categoryContextId, nil);
            XCTAssertEqualObjects(firstUpdatedCategoryFirstSubchild.orderId, @0);
            XCTAssertEqualObjects(firstUpdatedCategoryFirstSubchild.displayData, nil);
            XCTAssertTrue(firstUpdatedCategoryFirstSubchild.children.count == 1);
            XCTAssertTrue(firstUpdatedCategoryFirstSubchild.isNew == NO);
            
            
            [expectation fulfill];
        }];
        
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
    
}

-(void)testCreateCategory {
    
    NSData *createData = [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"categoryCreateResponse" ofType:@"json"]];
    
    NSDictionary *categoryDict = [NSJSONSerialization JSONObjectWithData:createData options:0 error:nil];
    
    [MNFNetworkProtocolForTesting setResponseData:[NSJSONSerialization dataWithJSONObject:categoryDict options:0 error:nil]];
    
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFJob *job = [MNFCategory createUserParentCategoryWithName:@"Some Category Name" isFixedExpense:nil categoryType:1 completion:^(MNFCategory * _Nullable category, NSError * _Nullable error) {
        XCTAssertEqualObjects(category.identifier, @810);
        XCTAssertEqualObjects(category.name, @"Some Category Name");
        XCTAssertEqualObjects(category.parentCategoryId, nil);
        XCTAssertEqualObjects(category.otherCategoryName, nil);
        XCTAssertEqualObjects(category.isSystemCategory, @0);
        XCTAssertEqual(category.categoryTypeId, 0);
        XCTAssertEqualObjects(category.categoryRank, @"NotUseful");
        XCTAssertEqualObjects(category.budgetGenerationType, @12);
        XCTAssertEqualObjects(category.categoryContextId, nil);
        XCTAssertEqualObjects(category.orderId, @0);
        XCTAssertEqualObjects(category.displayData, @"e636");
        XCTAssertTrue(category.isNew == NO);
        
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

-(void)testCategoryDelete {
    
    [MNFNetworkProtocolForTesting setResponseData:[NSJSONSerialization dataWithJSONObject:@{ } options:0 error:nil]];

    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFJob *job = [_sut deleteCategoryWithConnectedRules:nil moveTransactionsToNewCategoryId:nil completion:^(NSError *error) {
       
        XCTAssertTrue(_sut.isDeleted == YES);
        
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
    
}

-(void)testCategoryDeleteWithCompletion {
    
    [MNFNetworkProtocolForTesting setResponseData:[NSJSONSerialization dataWithJSONObject:@{ } options:0 error:nil]];
    
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFJob *job = [_sut deleteCategoryWithConnectedRules:nil moveTransactionsToNewCategoryId:nil completion:nil];
    
    [GCDUtils dispatchAfterTime:0.1 completion:^{
        XCTAssertTrue(_sut.isDeleted == YES);
        
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
    
}

-(void)testFetchCategoryTypes {
    
    NSData *createData = [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"categoryTypesResponse" ofType:@"json"]];
    
    NSDictionary *categoryDict = [NSJSONSerialization JSONObjectWithData:createData options:0 error:nil];
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:categoryDict options:0 error:nil];
    
    [MNFNetworkProtocolForTesting setResponseData:data];
    
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFJob *job = [MNFCategory fetchCategoryTypesWithCompletion:^(NSArray *categoryTypes, NSError *error) {
       
        XCTAssertTrue(categoryTypes.count == 4);
        
        MNFCategoryType *firstType = [categoryTypes objectAtIndex:0];
        XCTAssertEqualObjects(firstType.identifier, @0);
        XCTAssertEqualObjects(firstType.name, @"Expenses");
        XCTAssertTrue(firstType.isNew == NO);
        
        MNFCategoryType *secondType = [categoryTypes objectAtIndex:1];
        XCTAssertEqualObjects(secondType.identifier, @1);
        XCTAssertEqualObjects(secondType.name, @"Income");
        XCTAssertTrue(secondType.isNew == NO);
        
        MNFCategoryType *thirdType = [categoryTypes objectAtIndex:2];
        XCTAssertEqualObjects(thirdType.identifier, @2);
        XCTAssertEqualObjects(thirdType.name, @"Savings");
        XCTAssertTrue(thirdType.isNew == NO);
        
        MNFCategoryType *fourthType = [categoryTypes objectAtIndex:3];
        XCTAssertEqualObjects(fourthType.identifier, @3);
        XCTAssertEqualObjects(fourthType.name, @"Excluded");
        XCTAssertTrue(fourthType.isNew == NO);
        
        [expectation fulfill];
        
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
    
}

/* No use in testing it as it currently does not change the object in any way
-(void)testSaveCategory {
    
}
 */

@end
