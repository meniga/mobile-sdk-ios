//
//  MNFTransactionRuleTest.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 22/04/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNFIntegrationTestSetup.h"
#import "MNFTransactionRule.h"
#import "MNFTransactionSplitAction.h"

@interface MNFTransactionRuleTest : MNFIntegrationTestSetup

@end

@implementation MNFTransactionRuleTest

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

-(void)testCreateTransactionRule {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFJob *job = [MNFTransactionRule createRuleWithName:@"name" textCriteria:@"criteria" textCriteriaOperatorType:@0 dateMatchTypeCriteria:@0 daysLimitCriteria:nil amountLimitTypeCriteria:nil amountLimitSignCriteria:nil amountCriteria:nil accountCategoryCriteria:nil acceptAction:@0 monthShiftAction:nil removeAction:nil textAction:@"some text action" commentAction:@"some comment action" categoryIdAction:@81 splitActions:nil flagAction:nil applyOnExisting:@YES completion:^(MNFTransactionRule * _Nullable rule, NSError * _Nullable error) {
        
        XCTAssertNotNil(rule);
        XCTAssertEqualObjects(rule.name, @"name");
        XCTAssertEqualObjects(rule.textCriteria, @"criteria");
        XCTAssertEqualObjects(rule.textCriteriaOperatorType, @0);
        XCTAssertEqualObjects(rule.dateMatchTypeCriteria, @0);
        XCTAssertEqualObjects(rule.daysLimitCriteria, nil);
        XCTAssertEqualObjects(rule.amountLimitTypeCriteria, nil);
        XCTAssertEqualObjects(rule.amountLimitSignCriteria, nil);
        XCTAssertEqualObjects(rule.accountCategoryCriteria, nil);
        XCTAssertEqualObjects(rule.acceptAction, @0);
        XCTAssertEqualObjects(rule.monthShiftAction, nil);
        XCTAssertEqualObjects(rule.removeAction, nil);
        XCTAssertEqualObjects(rule.textAction, @"some text action");
        XCTAssertEqualObjects(rule.commentAction, @"some comment action");
        XCTAssertEqualObjects(rule.categoryIdAction, @81);
        XCTAssertEqualObjects(rule.splitActions, @[]);
        XCTAssertEqualObjects(rule.flagAction, nil);
        
        XCTAssertNil(error);
        
        [expectation fulfill];
        
    }];
    
    [job handleCompletion:^(MNFTransactionRule * _Nullable rule, id _Nullable metadata, NSError * _Nullable error) {
        
        XCTAssertNotNil(rule);
        XCTAssertEqualObjects(rule.name, @"name");
        XCTAssertEqualObjects(rule.textCriteria, @"criteria");
        XCTAssertEqualObjects(rule.textCriteriaOperatorType, @0);
        XCTAssertEqualObjects(rule.dateMatchTypeCriteria, @0);
        XCTAssertEqualObjects(rule.daysLimitCriteria, nil);
        XCTAssertEqualObjects(rule.amountLimitTypeCriteria, nil);
        XCTAssertEqualObjects(rule.amountLimitSignCriteria, nil);
        XCTAssertEqualObjects(rule.accountCategoryCriteria, nil);
        XCTAssertEqualObjects(rule.acceptAction, @0);
        XCTAssertEqualObjects(rule.monthShiftAction, nil);
        XCTAssertEqualObjects(rule.removeAction, nil);
        XCTAssertEqualObjects(rule.textAction, @"some text action");
        XCTAssertEqualObjects(rule.commentAction, @"some comment action");
        XCTAssertEqualObjects(rule.categoryIdAction, @81);
        XCTAssertEqualObjects(rule.splitActions, @[]);
        XCTAssertEqualObjects(rule.flagAction, nil);
        
        XCTAssertNil(metadata);
        XCTAssertNil(error);
        
    }];
    
    [self waitForExpectationsWithTimeout:kMNFIntegrationTestWaitTime handler:nil];
}

-(void)testCreateChangeEverythingAndSaveAndFetch {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    
    
    [MNFTransactionRule createRuleWithName:@"rule" textCriteria:@"criteria" textCriteriaOperatorType:@0 dateMatchTypeCriteria:@0 daysLimitCriteria:@0 amountLimitTypeCriteria:@0 amountLimitSignCriteria:@0 amountCriteria:@0 accountCategoryCriteria:@"accountCategoryCriteria" acceptAction:@0 monthShiftAction:@0 removeAction:@0 textAction:@"action" commentAction:@"comment action" categoryIdAction:@81 splitActions:@[[MNFTransactionSplitAction transactionSplitActionWithRatio:@0.1 amount:@100 categoryId:@81]] flagAction:@0 applyOnExisting:@YES completion:^(MNFTransactionRule * _Nullable rule, NSError * _Nullable error) {
       
        XCTAssertNotNil(rule);
        XCTAssertEqualObjects(rule.name, @"rule");
        XCTAssertEqualObjects(rule.textCriteria, @"criteria");
        XCTAssertEqualObjects(rule.textCriteriaOperatorType, @0);
        XCTAssertEqualObjects(rule.dateMatchTypeCriteria, @0);
        XCTAssertEqualObjects(rule.daysLimitCriteria, @0);
        XCTAssertEqualObjects(rule.amountLimitTypeCriteria, @0);
        XCTAssertEqualObjects(rule.amountLimitSignCriteria, @0);
        XCTAssertEqualObjects(rule.amountCriteria, @0);
        XCTAssertEqualObjects(rule.accountCategoryCriteria, @"accountCategoryCriteria");
        XCTAssertEqualObjects(rule.acceptAction, @0);
        XCTAssertEqualObjects(rule.monthShiftAction, @0);
        XCTAssertEqualObjects(rule.removeAction, @0);
        XCTAssertEqualObjects(rule.textAction, @"action");
        XCTAssertEqualObjects(rule.commentAction, @"comment action");
        XCTAssertEqualObjects(rule.categoryIdAction, @81);
        XCTAssertTrue(rule.splitActions.count != 0);
        XCTAssertNotEqualObjects(rule.splitActions.firstObject.identifier, @0);
        XCTAssertNotEqualObjects(rule.splitActions.firstObject.transactionRuleId, @0);
        XCTAssertEqualObjects(rule.splitActions.firstObject.ratio, @0.1);
        XCTAssertEqualObjects(rule.splitActions.firstObject.amount, @100);
        XCTAssertEqualObjects(rule.splitActions.firstObject.categoryId, @81);
        XCTAssertEqualObjects(rule.flagAction, @0);
        
        XCTAssertEqualObjects(error, nil);
        
        rule.name = @"new rule";
        rule.textCriteria = @"new criteria";
        rule.textCriteriaOperatorType = @1;
        rule.dateMatchTypeCriteria = @1;
        rule.daysLimitCriteria = @1;
        rule.amountLimitTypeCriteria = @1;
        rule.amountLimitSignCriteria = @1;
        rule.amountCriteria = @1;
        rule.accountCategoryCriteria = @"new accountCategoryCriteria";
        rule.acceptAction = @1;
        rule.monthShiftAction = @1;
        rule.removeAction = @1;
        rule.textAction = @"new action";
        rule.commentAction = @"new comment action";
        rule.categoryIdAction = @59;
        rule.splitActions.firstObject.ratio = @0.2;
        rule.splitActions.firstObject.amount = @1000;
        rule.splitActions.firstObject.categoryId = @59;
        rule.flagAction = @1;
        
        [rule saveAndApplyOnExisting:@YES completion:^(NSError *error) {
           
            MNFJob *job = [MNFTransactionRule fetchRuleWithId:rule.identifier completion:^(MNFTransactionRule *fetchedRule, NSError *error) {
               
                XCTAssertEqualObjects(rule.name, fetchedRule.name);
                XCTAssertEqualObjects(rule.textCriteria, fetchedRule.textCriteria);
                XCTAssertEqualObjects(rule.textCriteriaOperatorType, fetchedRule.textCriteriaOperatorType);
                XCTAssertEqualObjects(rule.dateMatchTypeCriteria, fetchedRule.dateMatchTypeCriteria);
                XCTAssertEqualObjects(rule.daysLimitCriteria, fetchedRule.daysLimitCriteria);
                XCTAssertEqualObjects(rule.amountLimitTypeCriteria, fetchedRule.amountLimitTypeCriteria);
                XCTAssertEqualObjects(rule.amountLimitSignCriteria, fetchedRule.amountLimitSignCriteria);
                XCTAssertEqualObjects(rule.amountCriteria, fetchedRule.amountCriteria);
                XCTAssertEqualObjects(rule.accountCategoryCriteria, fetchedRule.accountCategoryCriteria);
                XCTAssertEqualObjects(rule.acceptAction, fetchedRule.acceptAction);
                XCTAssertEqualObjects(rule.monthShiftAction, fetchedRule.monthShiftAction);
                XCTAssertEqualObjects(rule.removeAction, fetchedRule.removeAction);
                XCTAssertEqualObjects(rule.textAction, fetchedRule.textAction);
                XCTAssertEqualObjects(rule.commentAction, fetchedRule.commentAction);
                XCTAssertEqualObjects(rule.categoryIdAction, fetchedRule.categoryIdAction);
                XCTAssertEqualObjects(rule.categoryIdAction, fetchedRule.categoryIdAction);
                XCTAssertEqualObjects(rule.splitActions.firstObject.identifier, fetchedRule.splitActions.firstObject.identifier);
                XCTAssertEqualObjects(rule.splitActions.firstObject.transactionRuleId, fetchedRule.splitActions.firstObject.transactionRuleId);
                XCTAssertEqualObjects(rule.splitActions.firstObject.ratio, fetchedRule.splitActions.firstObject.ratio);
                XCTAssertEqualObjects(rule.splitActions.firstObject.amount, fetchedRule.splitActions.firstObject.amount);
                XCTAssertEqualObjects(rule.splitActions.firstObject.categoryId, fetchedRule.splitActions.firstObject.categoryId);
                XCTAssertEqualObjects(rule.flagAction, fetchedRule.flagAction);
                
                XCTAssertNil(error);
                
                [expectation fulfill];
                
            }];
            
            [job handleCompletion:^(MNFTransactionRule *fetchedRule, id _Nullable metadata, NSError * _Nullable error) {
               
                XCTAssertEqualObjects(rule.name, fetchedRule.name);
                XCTAssertEqualObjects(rule.textCriteria, fetchedRule.textCriteria);
                XCTAssertEqualObjects(rule.textCriteriaOperatorType, fetchedRule.textCriteriaOperatorType);
                XCTAssertEqualObjects(rule.dateMatchTypeCriteria, fetchedRule.dateMatchTypeCriteria);
                XCTAssertEqualObjects(rule.daysLimitCriteria, fetchedRule.daysLimitCriteria);
                XCTAssertEqualObjects(rule.amountLimitTypeCriteria, fetchedRule.amountLimitTypeCriteria);
                XCTAssertEqualObjects(rule.amountLimitSignCriteria, fetchedRule.amountLimitSignCriteria);
                XCTAssertEqualObjects(rule.amountCriteria, fetchedRule.amountCriteria);
                XCTAssertEqualObjects(rule.accountCategoryCriteria, fetchedRule.accountCategoryCriteria);
                XCTAssertEqualObjects(rule.acceptAction, fetchedRule.acceptAction);
                XCTAssertEqualObjects(rule.monthShiftAction, fetchedRule.monthShiftAction);
                XCTAssertEqualObjects(rule.removeAction, fetchedRule.removeAction);
                XCTAssertEqualObjects(rule.textAction, fetchedRule.textAction);
                XCTAssertEqualObjects(rule.commentAction, fetchedRule.commentAction);
                XCTAssertEqualObjects(rule.categoryIdAction, fetchedRule.categoryIdAction);
                XCTAssertEqualObjects(rule.splitActions.firstObject.identifier, fetchedRule.splitActions.firstObject.identifier);
                XCTAssertEqualObjects(rule.splitActions.firstObject.transactionRuleId, fetchedRule.splitActions.firstObject.transactionRuleId);
                XCTAssertEqualObjects(rule.splitActions.firstObject.ratio, fetchedRule.splitActions.firstObject.ratio);
                XCTAssertEqualObjects(rule.splitActions.firstObject.amount, fetchedRule.splitActions.firstObject.amount);
                XCTAssertEqualObjects(rule.splitActions.firstObject.categoryId, fetchedRule.splitActions.firstObject.categoryId);
                XCTAssertEqualObjects(rule.flagAction, fetchedRule.flagAction);
                
                XCTAssertNil(metadata);
                XCTAssertNil(error);
                
            }];
            
        }];
        
    }];
    
    [self waitForExpectationsWithTimeout:kMNFIntegrationTestWaitTime handler:nil];
    
}

-(void)testSaveAndFetchTransactionRuleWithId {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [MNFTransactionRule createRuleWithName:@"name" textCriteria:@"criteria" textCriteriaOperatorType:@0 dateMatchTypeCriteria:@0 daysLimitCriteria:nil amountLimitTypeCriteria:nil amountLimitSignCriteria:nil amountCriteria:nil accountCategoryCriteria:nil acceptAction:@0 monthShiftAction:nil removeAction:nil textAction:@"some text action" commentAction:@"some comment action" categoryIdAction:@81 splitActions:nil flagAction:nil applyOnExisting:@YES completion:^(MNFTransactionRule * _Nullable rule, NSError * _Nullable error) {
       
        XCTAssertNotNil(rule);
        XCTAssertNil(error);
        
        rule.name = @"New name";
        rule.amountCriteria = @10;
        
        [rule saveAndApplyOnExisting:@NO completion:^(NSError * _Nullable error) {
           
            XCTAssertEqualObjects(rule.name, @"New name");
            XCTAssertEqualObjects(rule.amountCriteria, @10);
            
            XCTAssertNil(error);
            
            MNFJob *job = [MNFTransactionRule fetchRuleWithId:rule.identifier completion:^(MNFTransactionRule * _Nullable fetchedTransactionRule, NSError * _Nullable error) {
               
                XCTAssertEqualObjects(rule.identifier, fetchedTransactionRule.identifier);
                // MARK: Updating the name parameter does not do anything, backend took a dumper on that one
                XCTAssertEqualObjects(rule.name, fetchedTransactionRule.name);
                XCTAssertEqualObjects(rule.amountCriteria, fetchedTransactionRule.amountCriteria);
                XCTAssertEqualObjects(rule.textCriteria, fetchedTransactionRule.textCriteria);
                XCTAssertEqualObjects(rule.textCriteriaOperatorType, fetchedTransactionRule.textCriteriaOperatorType);
                XCTAssertEqualObjects(rule.dateMatchTypeCriteria, fetchedTransactionRule.dateMatchTypeCriteria);
                XCTAssertEqualObjects(rule.acceptAction, fetchedTransactionRule.acceptAction);
                XCTAssertEqualObjects(rule.textAction, fetchedTransactionRule.textAction);
                XCTAssertEqualObjects(rule.commentAction, fetchedTransactionRule.commentAction);
                XCTAssertEqualObjects(rule.categoryIdAction, fetchedTransactionRule.categoryIdAction);
                
                XCTAssertNil(error);
                
                [expectation fulfill];
                
            }];
            
            [job handleCompletion:^(MNFTransactionRule * _Nullable fetchedTransactionRule, id _Nullable metadata, NSError * _Nullable error) {
               
                XCTAssertEqualObjects(rule.identifier, fetchedTransactionRule.identifier);
                // MARK: Updating the name parameter does not do anything, backend took a dumper on that one
                XCTAssertEqualObjects(rule.name, fetchedTransactionRule.name);
                XCTAssertEqualObjects(rule.amountCriteria, fetchedTransactionRule.amountCriteria);
                XCTAssertEqualObjects(rule.textCriteria, fetchedTransactionRule.textCriteria);
                XCTAssertEqualObjects(rule.textCriteriaOperatorType, fetchedTransactionRule.textCriteriaOperatorType);
                XCTAssertEqualObjects(rule.dateMatchTypeCriteria, fetchedTransactionRule.dateMatchTypeCriteria);
                XCTAssertEqualObjects(rule.acceptAction, fetchedTransactionRule.acceptAction);
                XCTAssertEqualObjects(rule.textAction, fetchedTransactionRule.textAction);
                XCTAssertEqualObjects(rule.commentAction, fetchedTransactionRule.commentAction);
                XCTAssertEqualObjects(rule.categoryIdAction, fetchedTransactionRule.categoryIdAction);
                
                XCTAssertNil(metadata);
                XCTAssertNil(error);
                
            }];
            
            
        }];
        
    }];
    
    [self waitForExpectationsWithTimeout:kMNFIntegrationTestWaitTime handler:nil];
}

-(void)testCreateTwoRulesFetchMultipleRulesAndDelete {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFJob *job = [MNFTransactionRule createRuleWithName:@"first rule" textCriteria:@"text criteria one" textCriteriaOperatorType:@0 dateMatchTypeCriteria:@0 daysLimitCriteria:@1 amountLimitTypeCriteria:@100 amountLimitSignCriteria:@1 amountCriteria:@1000 accountCategoryCriteria:@"account criteria" acceptAction:@0 monthShiftAction:@1 removeAction:nil textAction:nil commentAction:nil categoryIdAction:nil splitActions:nil flagAction:nil applyOnExisting:@NO completion:^(MNFTransactionRule * ruleOne, NSError * _Nullable error) {
       
        XCTAssertNotNil(ruleOne);
        XCTAssertEqualObjects(ruleOne.name, @"first rule");
        XCTAssertEqualObjects(ruleOne.textCriteria, @"text criteria one");
        XCTAssertEqualObjects(ruleOne.textCriteriaOperatorType, @0);
        XCTAssertEqualObjects(ruleOne.dateMatchTypeCriteria, @0);
        XCTAssertEqualObjects(ruleOne.daysLimitCriteria, @1);
        XCTAssertEqualObjects(ruleOne.amountLimitTypeCriteria, @100);
        XCTAssertEqualObjects(ruleOne.amountLimitSignCriteria, @1);
        XCTAssertEqualObjects(ruleOne.amountCriteria, @1000);
        XCTAssertEqualObjects(ruleOne.accountCategoryCriteria, @"account criteria");
        XCTAssertEqualObjects(ruleOne.acceptAction, @0);
        XCTAssertEqualObjects(ruleOne.monthShiftAction, @1);
        
        XCTAssertEqualObjects(ruleOne.removeAction, nil);
        XCTAssertEqualObjects(ruleOne.textAction, nil);
        XCTAssertEqualObjects(ruleOne.commentAction, nil);
        XCTAssertEqualObjects(ruleOne.categoryIdAction, nil);
        XCTAssertEqualObjects(ruleOne.splitActions, @[]);
        XCTAssertEqualObjects(ruleOne.flagAction, nil);
        
        XCTAssertNil(error);
        
        MNFJob *secondJob = [MNFTransactionRule createRuleWithName:@"secondRule" textCriteria:nil textCriteriaOperatorType:nil dateMatchTypeCriteria:nil daysLimitCriteria:nil amountLimitTypeCriteria:nil amountLimitSignCriteria:nil amountCriteria:nil accountCategoryCriteria:nil acceptAction:nil monthShiftAction:nil removeAction:@0 textAction:@"text action" commentAction:@"comment action" categoryIdAction:@1 splitActions:nil flagAction:@1 applyOnExisting:@YES completion:^(MNFTransactionRule * ruleTwo, NSError * _Nullable error) {
           
            XCTAssertEqualObjects(ruleTwo.name, @"secondRule");
           
            XCTAssertEqualObjects(ruleTwo.textCriteria, nil);
            XCTAssertEqualObjects(ruleTwo.textCriteriaOperatorType, nil);
            XCTAssertEqualObjects(ruleTwo.dateMatchTypeCriteria, nil);
            XCTAssertEqualObjects(ruleTwo.daysLimitCriteria, nil);
            XCTAssertEqualObjects(ruleTwo.amountLimitTypeCriteria, nil);
            XCTAssertEqualObjects(ruleTwo.amountLimitSignCriteria, nil);
            XCTAssertEqualObjects(ruleTwo.amountCriteria, nil);
            XCTAssertEqualObjects(ruleTwo.accountCategoryCriteria, nil);
            XCTAssertEqualObjects(ruleTwo.acceptAction, nil);
            XCTAssertEqualObjects(ruleTwo.monthShiftAction, nil);
            
            XCTAssertEqualObjects(ruleTwo.removeAction, @0);
            XCTAssertEqualObjects(ruleTwo.textAction, @"text action");
            XCTAssertEqualObjects(ruleTwo.commentAction, @"comment action");
            XCTAssertEqualObjects(ruleTwo.categoryIdAction, @1);
            XCTAssertEqualObjects(ruleTwo.splitActions, @[]);
            XCTAssertEqualObjects(ruleTwo.flagAction, @1);
            
            XCTAssertNil(error);
            
            MNFJob *thirdJob = [MNFTransactionRule fetchRulesWithCompletion:^(NSArray <MNFTransactionRule *> *rules, NSError *error) {
                
                XCTAssertNotNil(rules);
                XCTAssertTrue(rules.count == 2);
                
                XCTAssertNil(error);
                
                MNFJob *fourthJob = [rules.firstObject deleteRuleWithCompletion:^(NSError *error) {
                   
                    XCTAssertTrue(rules.firstObject.isDeleted == YES);
                    
                    XCTAssertNil(error);
                    
                    [expectation fulfill];
                    
                }];
                
                [fourthJob handleCompletion:^(id _Nullable result, id _Nullable metadata, NSError * _Nullable error) {
                    
                    XCTAssertTrue(rules.firstObject.isDeleted == YES);
                    
                    XCTAssertNil(metadata);
                    XCTAssertNil(error);
                    
                }];
                
            }];
            
            [thirdJob handleCompletion:^(NSArray <MNFTransactionRule *> *rules, id _Nullable metadata, NSError * _Nullable error) {
               
                XCTAssertNotNil(rules);
                XCTAssertTrue(rules.count == 2);
                
                XCTAssertNil(metadata);
                XCTAssertNil(error);
                
            }];
            
        }];
        
        [secondJob handleCompletion:^(MNFTransactionRule *ruleTwo, id _Nullable metadata, NSError * _Nullable error) {
           
            XCTAssertEqualObjects(ruleTwo.name, @"secondRule");
            
            XCTAssertEqualObjects(ruleTwo.textCriteria, nil);
            XCTAssertEqualObjects(ruleTwo.textCriteriaOperatorType, nil);
            XCTAssertEqualObjects(ruleTwo.dateMatchTypeCriteria, nil);
            XCTAssertEqualObjects(ruleTwo.daysLimitCriteria, nil);
            XCTAssertEqualObjects(ruleTwo.amountLimitTypeCriteria, nil);
            XCTAssertEqualObjects(ruleTwo.amountLimitSignCriteria, nil);
            XCTAssertEqualObjects(ruleTwo.amountCriteria, nil);
            XCTAssertEqualObjects(ruleTwo.accountCategoryCriteria, nil);
            XCTAssertEqualObjects(ruleTwo.acceptAction, nil);
            XCTAssertEqualObjects(ruleTwo.monthShiftAction, nil);
            
            XCTAssertEqualObjects(ruleTwo.removeAction, @0);
            XCTAssertEqualObjects(ruleTwo.textAction, @"text action");
            XCTAssertEqualObjects(ruleTwo.commentAction, @"comment action");
            XCTAssertEqualObjects(ruleTwo.categoryIdAction, @1);
            XCTAssertEqualObjects(ruleTwo.splitActions, @[]);
            XCTAssertEqualObjects(ruleTwo.flagAction, @1);
            
            XCTAssertNil(metadata);
            XCTAssertNil(error);
            
        }];
        
    }];
    
    [job handleCompletion:^(MNFTransactionRule *ruleOne, id _Nullable metadata, NSError * _Nullable error) {
       
        XCTAssertNotNil(ruleOne);
        XCTAssertEqualObjects(ruleOne.name, @"first rule");
        XCTAssertEqualObjects(ruleOne.textCriteria, @"text criteria one");
        XCTAssertEqualObjects(ruleOne.textCriteriaOperatorType, @0);
        XCTAssertEqualObjects(ruleOne.dateMatchTypeCriteria, @0);
        XCTAssertEqualObjects(ruleOne.daysLimitCriteria, @1);
        XCTAssertEqualObjects(ruleOne.amountLimitTypeCriteria, @100);
        XCTAssertEqualObjects(ruleOne.amountLimitSignCriteria, @1);
        XCTAssertEqualObjects(ruleOne.amountCriteria, @1000);
        XCTAssertEqualObjects(ruleOne.accountCategoryCriteria, @"account criteria");
        XCTAssertEqualObjects(ruleOne.acceptAction, @0);
        XCTAssertEqualObjects(ruleOne.monthShiftAction, @1);
        
        XCTAssertEqualObjects(ruleOne.removeAction, nil);
        XCTAssertEqualObjects(ruleOne.textAction, nil);
        XCTAssertEqualObjects(ruleOne.commentAction, nil);
        XCTAssertEqualObjects(ruleOne.categoryIdAction, nil);
        XCTAssertEqualObjects(ruleOne.splitActions, @[]);
        XCTAssertEqualObjects(ruleOne.flagAction, nil);
        
        XCTAssertNil(metadata);
        XCTAssertNil(error);
        
    }];
    
    [self waitForExpectationsWithTimeout:kMNFIntegrationTestWaitTime handler:nil];
}

@end
