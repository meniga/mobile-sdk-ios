//
//  MNFApiValidationTest.m
//  Meniga-ios-sdk-tests
//
//  Created by Haukur Ísfeld on 21/03/2018.
//  Copyright © 2018 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNFTestFactory.h"
#import "MNFTestUtils.h"
#import "Meniga.h"
#import <objc/runtime.h>

@interface MNFApiValidationTest : XCTestCase

@end

@implementation MNFApiValidationTest

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testValidateAccountsApi {
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory accountModel] withModelObject:[MNFAccount new]]);
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory accountTypeModel] withModelObject:[MNFAccountType new]]);
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory accountCategoryModel] withModelObject:[MNFAccountCategory new]]);
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory accountAuthorizationTypeModel] withModelObject:[MNFAccountAuthorizationType new]]);
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory accountHistoryEntryModel] withModelObject:[MNFAccountHistoryEntry new]]);
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory importAccountConfigurationModel] withModelObject:[MNFImportAccountConfiguration new]]);
}

- (void)testValidateAuthenicationApi {
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory authenticationModel] withModelObject:[MNFAuthentication new]]);
}

- (void)testValidateBudgetsApi {
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory budgetModel] withModelObject:[MNFBudget new]]);
    XCTAssertTrue([MNFTestUtils validateApiModel:[MNFTestFactory budgetEntryModel] withModelObject:[MNFBudgetEntry new]]);
}

@end
