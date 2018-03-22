//
//  MNFTestFactory.m
//  Meniga-ios-sdk-tests
//
//  Created by Haukur Ísfeld on 21/03/2018.
//  Copyright © 2018 Meniga. All rights reserved.
//

#import "MNFTestFactory.h"

static NSDictionary *apiSpecDictionary;

@implementation MNFTestFactory

+(void)initialize {
    
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:self] pathForResource:@"apispec" ofType:@"json"]];
    apiSpecDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
}

#pragma mark - accounts api
+(NSDictionary*)accountModel {
    return apiSpecDictionary[@"definitions"][@"Meniga.Core.Api.Models.AccountModel"][@"properties"];
}
+(NSDictionary*)accountTypeModel {
    return apiSpecDictionary[@"definitions"][@"Meniga.Core.Api.Models.AccountTypeModel"][@"properties"];
}
+(NSDictionary*)accountCategoryModel {
    return apiSpecDictionary[@"definitions"][@"Meniga.Core.Api.Models.AccountTypeCategory"][@"properties"];
}
+(NSDictionary*)accountAuthorizationTypeModel {
    return apiSpecDictionary[@"definitions"][@"Meniga.Core.Api.Models.NameId"][@"properties"];
}
+(NSDictionary*)accountHistoryEntryModel {
    return apiSpecDictionary[@"definitions"][@"Meniga.Core.Api.Models.AccountBalanceHistory"][@"properties"];
}
+(NSDictionary*)importAccountConfigurationModel {
    return apiSpecDictionary[@"definitions"][@"Meniga.Core.Api.Models.ImportAccountConfigurationModel"][@"properties"];
}

#pragma mark - authentication api
+(NSDictionary*)authenticationModel {
    return apiSpecDictionary[@"definitions"][@"Meniga.Core.Authentication.Api.Models.AuthenticationResponse"][@"properties"];
}

#pragma mark - budgets api
+(NSDictionary*)budgetModel {
    return apiSpecDictionary[@"definitions"][@"Meniga.Component.Budgets.Api.Models.Responses.BudgetHeaderMessage"][@"properties"];
}
+(NSDictionary*)budgetEntryModel {
    return apiSpecDictionary[@"definitions"][@"Meniga.Component.Budgets.Api.Models.Responses.BudgetEntryMessage"][@"properties"];
}

@end
