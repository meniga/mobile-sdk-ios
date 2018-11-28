//
//  MNFBudgetRule.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 27/11/2018.
//  Copyright © 2018 Meniga. All rights reserved.
//

#import "MNFBudgetRule.h"
#import "MNFInternalImports.h"

@implementation MNFBudgetRule

+ (MNFJob *)fetchRulesWithBudgetId:(NSNumber *)budgetId categoryIds:(NSString *)categoryIds startDate:(NSDate *)startDate endDate:(NSDate *)endDate allowOverlappingRules:(NSNumber *)allowOverlappingRules completion:(MNFMultipleBudgetRulesCompletionHandler)completion {
    
    [completion copy];
    
    NSString *path = [NSString stringWithFormat:@"%@/%@/%@",kMNFApiPathBudget,budgetId.stringValue,kMNFBudgetRules];
    
    MNFBasicDateValueTransformer *transformer = [MNFBasicDateValueTransformer transformer];
    
    NSMutableDictionary *jsonDict = [NSMutableDictionary dictionary];
    jsonDict[@"categoryIds"] = categoryIds;
    jsonDict[@"startDate"] = [transformer reverseTransformedValue:startDate];
    jsonDict[@"endDate"] = [transformer reverseTransformedValue:endDate];
    jsonDict[@"allowOverlappingRules"] = allowOverlappingRules;
    
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

+ (MNFJob *)budgetRuleWithBudgetId:(NSNumber *)budgetId categoryIds:(NSString *)categoryIds startDate:(NSDate *)startDate endDate:(NSDate *)endDate generationType:(NSNumber *)generationType monthInterval:(NSNumber *)monthInterval repeatUntil:(NSNumber *)repeatUntil completion:(MNFMultipleBudgetRulesCompletionHandler)completion {
    
    [completion copy];
    
    NSString *path = [NSString stringWithFormat:@"%@/%@/%@",kMNFApiPathBudget,budgetId.stringValue,kMNFBudgetRules];
    
    MNFBasicDateValueTransformer *transformer = [MNFBasicDateValueTransformer transformer];
    
    NSMutableDictionary *jsonDict = [NSMutableDictionary dictionary];
    jsonDict[@"categoryIds"] = categoryIds;
    jsonDict[@"startDate"] = [transformer reverseTransformedValue:startDate];
    jsonDict[@"endDate"] = [transformer reverseTransformedValue:endDate];
    jsonDict[@"generationType"] = generationType;
    jsonDict[@"repeatUntil"] = [transformer reverseTransformedValue:repeatUntil];
    if (monthInterval != nil) {
        jsonDict[@"recurringPattern"] = @{@"monthInterval":monthInterval};
    }
    
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

@end
