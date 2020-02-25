//
//  MNFCategoryIntegrationTest.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 4/19/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNFIntegrationTestSetup.h"

#import "MNFCategory.h"
#import "MNFCategoryType.h"

@interface MNFCategoryIntegrationTest : MNFIntegrationTestSetup

@end

@implementation MNFCategoryIntegrationTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark - Test Fetch

- (void)testFetchSystemCategories {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.

    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];

    MNFJob *job = [MNFCategory fetchSystemCategoriesWithCulture:nil
                                                     completion:^(NSArray<MNFCategory *> *categories, NSError *error) {
                                                         XCTAssertTrue(categories.count != 0);
                                                         XCTAssertNil(error);

                                                         for (MNFCategory *category in categories) {
                                                             XCTAssertEqualObjects(category.isSystemCategory, @1);
                                                         }

                                                         [expectation fulfill];
                                                     }];

    [job handleCompletion:^(NSArray<MNFCategory *> *result, id _Nullable metaData, NSError *_Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertTrue(result.count != 0);

        for (MNFCategory *category in result) {
            XCTAssertEqualObjects(category.isSystemCategory, @YES);
        }

        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];

    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

- (void)testFetchUserCreatedCategories {
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];

    MNFJob *job = [MNFCategory
        createUserParentCategoryWithName:@"New Category"
                          isFixedExpense:@1
                            categoryType:kMNFCategoryTypeExcluded
                              completion:^(MNFCategory *newCategory, NSError *secondError) {
                                  XCTAssertEqual(newCategory.categoryTypeId, kMNFCategoryTypeExcluded);
                                  XCTAssertEqualObjects(newCategory.name, @"New Category");
                                  XCTAssertEqualObjects(newCategory.parentCategoryId, nil);
                                  XCTAssertEqualObjects(newCategory.isFixedExpenses, @1);

                                  XCTAssertNil(secondError);

                                  [MNFCategory
                                      fetchUserCreatedCategoriesWithCulture:nil
                                                                 completion:^(NSArray *userCreatedCategories,
                                                                              NSError *thirdError) {
                                                                     XCTAssertTrue(userCreatedCategories.count == 1);
                                                                     XCTAssertNil(thirdError);

                                                                     [expectation fulfill];
                                                                 }];
                              }];

    [job handleCompletion:^(MNFCategory *newCategory, id _Nullable metaData, NSError *_Nullable error) {
        XCTAssertEqual(newCategory.categoryTypeId, kMNFCategoryTypeExcluded);
        XCTAssertEqualObjects(newCategory.name, @"New Category");
        XCTAssertEqualObjects(newCategory.parentCategoryId, nil);
        XCTAssertEqualObjects(newCategory.isFixedExpenses, @1);

        XCTAssertNil(error);
    }];

    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

- (void)testFetchAllCategories {
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];

    [MNFCategory
        createUserParentCategoryWithName:@"New category"
                          isFixedExpense:@0
                            categoryType:kMNFCategoryTypeIncome
                              completion:^(MNFCategory *newCategory, NSError *firstError) {
                                  XCTAssertEqualObjects(newCategory.name, @"New category");
                                  XCTAssertEqualObjects(newCategory.isFixedExpenses, @0);
                                  XCTAssertEqualObjects(newCategory.isSystemCategory, @0);
                                  XCTAssertEqualObjects(newCategory.parentCategoryId, nil);
                                  XCTAssertEqual(newCategory.categoryTypeId, kMNFCategoryTypeIncome);

                                  XCTAssertNil(firstError);

                                  MNFJob *job = [MNFCategory
                                      fetchCategoriesWithCulture:nil
                                                      completion:^(NSArray *allCategories, NSError *secondError) {
                                                          XCTAssertTrue(allCategories.count != 0);
                                                          XCTAssertNil(secondError);

                                                          int numSystemCategories = 0;
                                                          int numUserCategories = 0;
                                                          for (MNFCategory *currentCategory in allCategories) {
                                                              if ([currentCategory.isSystemCategory boolValue] == YES) {
                                                                  numSystemCategories++;
                                                              } else {
                                                                  numUserCategories++;
                                                              }
                                                          }

                                                          XCTAssertTrue(numSystemCategories == allCategories.count - 1);
                                                          XCTAssertTrue(numUserCategories == 1);

                                                          [expectation fulfill];
                                                      }];

                                  [job handleCompletion:^(NSArray *allCategories,
                                                          id _Nullable metaData,
                                                          NSError *_Nullable secondError) {
                                      XCTAssertTrue(allCategories.count != 0);
                                      XCTAssertNil(secondError);
                                      XCTAssertNil(metaData);

                                      int numSystemCategories = 0;
                                      int numUserCategories = 0;
                                      for (MNFCategory *currentCategory in allCategories) {
                                          if ([currentCategory.isSystemCategory boolValue] == YES) {
                                              numSystemCategories++;
                                          } else {
                                              numUserCategories++;
                                          }
                                      }

                                      XCTAssertTrue(numSystemCategories == allCategories.count - 1);
                                      XCTAssertTrue(numUserCategories == 1);
                                  }];
                              }];

    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

- (void)testFetchWithIdNewlyCreatedParentCategory {
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];

    MNFJob *job = [MNFCategory
        createUserParentCategoryWithName:@"New name"
                          isFixedExpense:@1
                            categoryType:kMNFCategoryTypeIncome
                              completion:^(MNFCategory *newCategory, NSError *error) {
                                  XCTAssertEqualObjects(newCategory.name, @"New name");
                                  XCTAssertNil(error);

                                  MNFJob *secondJob = [MNFCategory
                                      fetchWithId:newCategory.identifier
                                          culture:nil
                                       completion:^(MNFCategory *fetchedCategory, NSError *error) {
                                           XCTAssertEqualObjects(fetchedCategory.name, newCategory.name);
                                           XCTAssertEqualObjects(fetchedCategory.isFixedExpenses,
                                                                 newCategory.isFixedExpenses);
                                           XCTAssertEqual(fetchedCategory.categoryTypeId, newCategory.categoryTypeId);
                                           XCTAssertEqualObjects(fetchedCategory.parentCategoryId,
                                                                 newCategory.parentCategoryId);
                                           XCTAssertEqual(fetchedCategory.categoryTypeId, kMNFCategoryTypeIncome);

                                           XCTAssertNil(error);

                                           [expectation fulfill];
                                       }];

                                  [secondJob handleCompletion:^(MNFCategory *fetchedCategory,
                                                                id _Nullable metaData,
                                                                NSError *_Nullable error) {
                                      XCTAssertEqualObjects(fetchedCategory.name, newCategory.name);
                                      XCTAssertEqualObjects(fetchedCategory.isFixedExpenses,
                                                            newCategory.isFixedExpenses);
                                      XCTAssertEqual(fetchedCategory.categoryTypeId, newCategory.categoryTypeId);
                                      XCTAssertEqualObjects(fetchedCategory.parentCategoryId,
                                                            newCategory.parentCategoryId);
                                      XCTAssertEqual(fetchedCategory.categoryTypeId, kMNFCategoryTypeIncome);

                                      XCTAssertNil(metaData);
                                      XCTAssertNil(error);
                                  }];
                              }];

    [job handleCompletion:^(MNFCategory *newCategory, id metadata, NSError *error) {
        XCTAssertEqualObjects(newCategory.name, @"New name");
        XCTAssertNil(metadata);
        XCTAssertNil(error);
    }];

    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

- (void)testFetchWithIdSystemTransaction {
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];

    [MNFCategory
        fetchSystemCategoriesWithCulture:nil
                              completion:^(NSArray *systemCategories, NSError *error) {
                                  XCTAssertTrue(systemCategories.count != 0);
                                  XCTAssertNil(error);

                                  MNFCategory *firstCategory = [systemCategories firstObject];

                                  MNFJob *job = [MNFCategory
                                      fetchWithId:firstCategory.identifier
                                          culture:nil
                                       completion:^(MNFCategory *fetchedCategory, NSError *error) {
                                           XCTAssertEqualObjects(fetchedCategory.identifier, firstCategory.identifier);
                                           XCTAssertEqualObjects(fetchedCategory.name, firstCategory.name);
                                           XCTAssertEqualObjects(fetchedCategory.isFixedExpenses,
                                                                 firstCategory.isFixedExpenses);
                                           XCTAssertEqualObjects(fetchedCategory.parentCategoryId,
                                                                 firstCategory.parentCategoryId);

                                           XCTAssertNil(error);

                                           [expectation fulfill];
                                       }];

                                  [job handleCompletion:^(MNFCategory *fetchedCategory,
                                                          id _Nullable metaData,
                                                          NSError *_Nullable error) {
                                      XCTAssertEqualObjects(fetchedCategory.identifier, firstCategory.identifier);
                                      XCTAssertEqualObjects(fetchedCategory.name, firstCategory.name);
                                      XCTAssertEqualObjects(fetchedCategory.isFixedExpenses,
                                                            firstCategory.isFixedExpenses);
                                      XCTAssertEqualObjects(fetchedCategory.parentCategoryId,
                                                            firstCategory.parentCategoryId);

                                      XCTAssertNil(metaData);
                                      XCTAssertNil(error);
                                  }];
                              }];

    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

- (void)testFetchCategoryTree {
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];

    MNFJob *job = [MNFCategory
        fetchCategoryTreeWithCulture:nil
                          completion:^(NSArray *categoryTree, NSError *error) {
                              XCTAssertTrue(categoryTree.count != 0);
                              XCTAssertNil(error);

                              for (MNFCategory *category in categoryTree) {
                                  XCTAssertNil(category.parentCategoryId);

                                  for (MNFCategory *subCategory in category.children) {
                                      XCTAssertEqualObjects(subCategory.parentCategoryId, category.identifier);
                                  }
                              }

                              [expectation fulfill];
                          }];

    [job handleCompletion:^(NSArray *categoryTree, id _Nullable metaData, NSError *_Nullable error) {
        XCTAssertTrue(categoryTree.count != 0);
        XCTAssertNil(error);

        for (MNFCategory *category in categoryTree) {
            XCTAssertNil(category.parentCategoryId);

            for (MNFCategory *subCategory in category.children) {
                XCTAssertEqualObjects(subCategory.parentCategoryId, category.identifier);
            }
        }

        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];

    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

- (void)testFetchCategoryTypes {
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];

    MNFJob *job = [MNFCategory fetchCategoryTypesWithCompletion:^(NSArray *categoryTypes, NSError *error) {
        XCTAssertTrue(categoryTypes.count != 0);
        XCTAssertNil(error);

        [expectation fulfill];
    }];

    [job handleCompletion:^(NSArray *result, id _Nullable metaData, NSError *_Nullable error) {
        XCTAssertTrue(result.count != 0);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];

    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

#pragma mark - Creating Categories

- (void)testCreateUserCreatedParentCategory {
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];

    MNFJob *job =
        [MNFCategory createUserParentCategoryWithName:@"New Category"
                                       isFixedExpense:@1
                                         categoryType:kMNFCategoryTypeExpenses
                                           completion:^(MNFCategory *newCategory, NSError *secondError) {
                                               XCTAssertEqual(newCategory.categoryTypeId, kMNFCategoryTypeExpenses);
                                               XCTAssertEqualObjects(newCategory.name, @"New Category");
                                               XCTAssertEqualObjects(newCategory.parentCategoryId, nil);
                                               XCTAssertEqualObjects(newCategory.isFixedExpenses, @1);

                                               XCTAssertNil(secondError);

                                               [expectation fulfill];
                                           }];

    [job handleCompletion:^(MNFCategory *newCategory, id _Nullable metaData, NSError *_Nullable error) {
        XCTAssertEqual(newCategory.categoryTypeId, kMNFCategoryTypeExpenses);
        XCTAssertEqualObjects(newCategory.name, @"New Category");
        XCTAssertEqualObjects(newCategory.parentCategoryId, nil);
        XCTAssertEqualObjects(newCategory.isFixedExpenses, @1);

        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];

    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

- (void)testCreateUserCreatedCategoryWithParent {
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];

    [MNFCategory
        fetchCategoriesWithCulture:nil
                        completion:^(NSArray *categories, NSError *error) {
                            XCTAssertTrue(categories.count != 0);
                            XCTAssertNil(error);

                            [MNFCategory fetchCategoryTypesWithCompletion:^(NSArray *categoryTypes,
                                                                            NSError *secondError) {
                                XCTAssertTrue(categoryTypes.count != 0);
                                XCTAssertNil(secondError);

                                MNFCategoryType *categoryType = [categoryTypes firstObject];

                                MNFCategory *category;
                                // must assert that the category we are adding as parent is not a child
                                for (MNFCategory *currentCat in categories) {
                                    if (currentCat.parentCategoryId == nil) {
                                        category = currentCat;
                                        break;
                                    }
                                }

                                MNFJob *job = [MNFCategory
                                    createUserChildCategoryWithName:@"Epic name"
                                                     isFixedExpense:@0
                                                 parentCategoryType:category.categoryTypeId
                                                   parentCategoryId:category.identifier
                                                         completion:^(MNFCategory *newCategory, NSError *thirdError) {
                                                             XCTAssertEqualObjects(newCategory.name, @"Epic name");
                                                             XCTAssertEqual(newCategory.categoryTypeId,
                                                                            [categoryType.identifier intValue]);
                                                             XCTAssertEqualObjects(newCategory.parentCategoryId,
                                                                                   category.identifier);
                                                             XCTAssertEqualObjects(newCategory.isFixedExpenses, @0);

                                                             XCTAssertNil(thirdError);
                                                             [expectation fulfill];
                                                         }];

                                [job handleCompletion:^(
                                         MNFCategory *newCategory, id _Nullable metaData, NSError *_Nullable error) {
                                    XCTAssertEqualObjects(newCategory.name, @"Epic name");
                                    XCTAssertEqual(newCategory.categoryTypeId, [categoryType.identifier intValue]);
                                    XCTAssertEqualObjects(newCategory.parentCategoryId, category.identifier);
                                    XCTAssertEqualObjects(newCategory.isFixedExpenses, @0);

                                    XCTAssertNil(metaData);
                                    XCTAssertNil(error);
                                }];
                            }];
                        }];

    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

#pragma mark - Instance Methods

- (void)testSaveCategory {
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];

    [MNFCategory
        createUserParentCategoryWithName:@"New Category"
                          isFixedExpense:@1
                            categoryType:kMNFCategoryTypeSavings
                              completion:^(MNFCategory *createdCategory, NSError *secondError) {
                                  XCTAssertEqualObjects(createdCategory.name, @"New Category");
                                  XCTAssertEqualObjects(createdCategory.isFixedExpenses, @1);
                                  XCTAssertEqualObjects(createdCategory.isSystemCategory, @0);
                                  XCTAssertEqual(createdCategory.categoryTypeId, kMNFCategoryTypeSavings);

                                  XCTAssertNil(secondError);

                                  createdCategory.name = @"Another Cool Name";
                                  createdCategory.categoryTypeId = kMNFCategoryTypeIncome;

                                  [createdCategory saveWithCompletion:^(NSError *thirdError) {
                                      XCTAssertNil(thirdError);

                                      MNFJob *job = [MNFCategory
                                          fetchWithId:createdCategory.identifier
                                              culture:nil
                                           completion:^(MNFCategory *updatedCategory, NSError *fourthError) {
                                               XCTAssertEqualObjects(updatedCategory.name, @"Another Cool Name");
                                               XCTAssertEqual(updatedCategory.categoryTypeId, kMNFCategoryTypeIncome);

                                               XCTAssertNil(fourthError);

                                               [expectation fulfill];
                                           }];

                                      [job handleCompletion:^(MNFCategory *updatedCategory,
                                                              id _Nullable metaData,
                                                              NSError *_Nullable error) {
                                          XCTAssertEqualObjects(updatedCategory.name, @"Another Cool Name");
                                          XCTAssertEqual(updatedCategory.categoryTypeId, kMNFCategoryTypeIncome);

                                          XCTAssertNil(metaData);
                                          XCTAssertNil(error);
                                      }];
                                  }];
                              }];

    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

- (void)testRefreshCategory {
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];

    [MNFCategory createUserParentCategoryWithName:@"Categooory"
                                   isFixedExpense:@1
                                     categoryType:kMNFCategoryTypeSavings
                                       completion:^(MNFCategory *newCategory, NSError *error) {
                                           newCategory.name = @"Some new name";
                                           newCategory.categoryTypeId = kMNFCategoryTypeIncome;

                                           MNFJob *job = [newCategory refreshWithCompletion:^(NSError *secondError) {
                                               XCTAssertNil(secondError);

                                               XCTAssertEqualObjects(newCategory.name, @"Categooory");
                                               XCTAssertEqual(newCategory.categoryTypeId, kMNFCategoryTypeSavings);

                                               [expectation fulfill];
                                           }];

                                           [job handleCompletion:^(id result, id metadata, NSError *error) {
                                               XCTAssertNil(error);
                                               XCTAssertNil(metadata);

                                               XCTAssertEqualObjects(newCategory.name, @"Categooory");
                                               XCTAssertEqual(newCategory.categoryTypeId, kMNFCategoryTypeSavings);
                                           }];
                                       }];

    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

- (void)testDeleteCategory {
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];

    [MNFCategory
        createUserParentCategoryWithName:@"Cool Category"
                          isFixedExpense:@1
                            categoryType:kMNFCategoryTypeExcluded
                              completion:^(MNFCategory *newCategory, NSError *secondError) {
                                  XCTAssertEqualObjects(newCategory.name, @"Cool Category");
                                  XCTAssertEqualObjects(newCategory.isFixedExpenses, @1);
                                  XCTAssertEqual(newCategory.categoryTypeId, kMNFCategoryTypeExcluded);
                                  XCTAssertEqualObjects(newCategory.isSystemCategory, @0);

                                  XCTAssertNil(secondError);

                                  MNFJob *job = [newCategory
                                      deleteCategoryWithConnectedRules:[NSNumber numberWithBool:NO]
                                       moveTransactionsToNewCategoryId:nil
                                                            completion:^(NSError *thirdError) {
                                                                //MARK: Server returns invalid json because it sends an empty body back with a 200 status code, should be 204 status code so that it is handled correctly.
                                                                // we will have to wait for backend to fix it nothing we can do for now.
                                                                XCTAssertTrue(newCategory.isDeleted == YES);
                                                                XCTAssertNil(thirdError);

                                                                MNFJob *secondJob = [MNFCategory
                                                                    fetchWithId:newCategory.identifier
                                                                        culture:nil
                                                                     completion:^(MNFCategory *fetchedCategory,
                                                                                  NSError *fourthError) {
                                                                         XCTAssertNil(fetchedCategory);
                                                                         XCTAssertNotNil(fourthError);

                                                                         [expectation fulfill];
                                                                     }];

                                                                [secondJob
                                                                    handleCompletion:^(MNFCategory *category,
                                                                                       id _Nullable metaData,
                                                                                       NSError *_Nullable error) {
                                                                        XCTAssertNil(category);
                                                                        XCTAssertNil(metaData);
                                                                        XCTAssertNotNil(error);
                                                                    }];
                                                            }];

                                  [job handleCompletion:^(id result, id metadata, NSError *thirdError) {
                                      XCTAssertTrue(newCategory.isDeleted == YES);

                                      XCTAssertNil(thirdError);
                                      XCTAssertNil(metadata);
                                  }];
                              }];

    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

@end
