//
//  MNFBudgetRule.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 27/11/2018.
//  Copyright © 2018 Meniga. All rights reserved.
//

#import "MNFBudgetRule.h"
#import "MNFBudgetRuleRecurringPattern.h"
#import "MNFInternalImports.h"

@implementation MNFBudgetRule

+ (MNFJob *)fetchRulesWithBudgetId:(NSNumber *)budgetId categoryIds:(NSString *)categoryIds startDate:(NSDate *)startDate endDate:(NSDate *)endDate allowOverlappingRules:(NSNumber *)allowOverlappingRules completion:(MNFMultipleBudgetRulesCompletionHandler)completion {
    
    [completion copy];
    
    NSString *path = [NSString stringWithFormat:@"%@/%@/%@",kMNFApiPathBudget,budgetId.stringValue,kMNFBudgetRules];
    
    MNFBasicDateValueTransformer *transformer = [MNFBasicDateValueTransformer transformer];
    MNFNumberToBoolValueTransformer *boolTransformer = [MNFNumberToBoolValueTransformer transformer];
    
    NSMutableDictionary *jsonDict = [NSMutableDictionary dictionary];
    jsonDict[@"categoryIds"] = categoryIds;
    jsonDict[@"startDate"] = [transformer reverseTransformedValue:startDate];
    jsonDict[@"endDate"] = [transformer reverseTransformedValue:endDate];
    jsonDict[@"allowOverlappingRules"] = [boolTransformer reverseTransformedValue:allowOverlappingRules];
    
    __block MNFJob *job = [MNFObject apiRequestWithPath:path pathQuery:[jsonDict copy] jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameBudget completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
            
            if ([response.result isKindOfClass:[NSArray class]]) {
                
                NSArray *budgetRules = [self initWithServerResults:response.result];
                
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:budgetRules error:nil];
                
            }
            else {
                
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error: [MNFErrorUtils errorForUnexpectedDataOfType:[response.result class] expected:[NSArray class]] ];
                
            }
            
        }
        else {
            
            [MNFObject executeOnMainThreadWithCompletion:completion withParameters:nil and:response.error];
            
        }
    }];
    
    return job;
}

+ (MNFJob *)createBudgetRules:(NSArray<MNFBudgetRule *> *)budgetRulesToCreate budgetId:(NSNumber *)budgetId completion:(MNFMultipleBudgetRulesCompletionHandler)completion {
    
    [completion copy];
    
    NSString *path = [NSString stringWithFormat:@"%@/%@/%@",kMNFApiPathBudget,budgetId.stringValue,kMNFBudgetRules];
    
    NSMutableDictionary *jsonDict = [NSMutableDictionary dictionary];
    NSArray *rules = [MNFJsonAdapter JSONArrayFromArray:budgetRulesToCreate option:kMNFAdapterOptionNoOption error:nil];
    jsonDict[@"rules"] = rules;
    
    __block MNFJob *job = [MNFObject apiRequestWithPath:path pathQuery:[jsonDict copy] jsonBody:nil HTTPMethod:kMNFHTTPMethodPOST service:MNFServiceNameBudget completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
            
            if ([response.result isKindOfClass:[NSArray class]]) {
                
                NSArray *budgetRules = [self initWithServerResults:response.result];
                
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:budgetRules error:nil];
                
            }
            else {
                
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error: [MNFErrorUtils errorForUnexpectedDataOfType:[response.result class] expected:[NSArray class]] ];
                
            }
            
        }
        else {
            
            [MNFObject executeOnMainThreadWithCompletion:completion withParameters:nil and:response.error];
            
        }
    }];
    
    return job;
}

- (MNFJob *)deleteWithCompletion:(MNFErrorOnlyCompletionHandler)completion {
    
    [completion copy];
    
    NSString *path = [NSString stringWithFormat:@"%@/%@/%@/%@",kMNFApiPathBudget,self.budgetId.stringValue,kMNFBudgetRules,self.identifier.stringValue];
    
    __block MNFJob *job = [self deleteWithApiPath:path pathQuery:nil jsonBody:nil service:MNFServiceNameBudget completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        [MNFObject executeOnMainThreadWithJob:job completion:completion error:response.error];
    }];
    
    return job;
}

#pragma mark - json delegate

-(NSDictionary*)jsonKeysMapToProperties {
    return @{@"identifier":@"id"};
}

-(NSDictionary*)propertyKeysMapToJson {
    return @{@"identifier":@"id"};
}

-(NSDictionary*)propertyValueTransformers {
    return @{@"startDate":[MNFBasicDateValueTransformer transformer],
             @"endDate":[MNFBasicDateValueTransformer transformer],
             @"updatedAt":[MNFBasicDateValueTransformer transformer]
             };
}

-(NSSet *)propertiesToIgnoreJsonDeserialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

-(NSSet *)propertiesToIgnoreJsonSerialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

-(NSDictionary*)subclassedProperties {
    return @{
             @"recurringPattern": [MNFJsonAdapterSubclassedProperty subclassedPropertyWithClass: [MNFBudgetRuleRecurringPattern class] option: kMNFAdapterOptionNoOption]
             };
}

@end
