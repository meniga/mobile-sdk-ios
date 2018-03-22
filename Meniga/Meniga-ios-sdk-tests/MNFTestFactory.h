//
//  MNFTestFactory.h
//  Meniga-ios-sdk-tests
//
//  Created by Haukur Ísfeld on 21/03/2018.
//  Copyright © 2018 Meniga. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MNFTestFactory : NSObject

#pragma mark - accounts api
+(NSDictionary*)accountModel;
+(NSDictionary*)accountTypeModel;
+(NSDictionary*)accountCategoryModel;
+(NSDictionary*)accountAuthorizationTypeModel;
+(NSDictionary*)accountHistoryEntryModel;
+(NSDictionary*)importAccountConfigurationModel;

#pragma mark - authentication api
+(NSDictionary*)authenticationModel;

#pragma mark - budgets api
+(NSDictionary*)budgetModel;
+(NSDictionary*)budgetEntryModel;

@end
