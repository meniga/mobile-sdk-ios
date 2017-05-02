//
//  MNFBudget.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 21/11/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFBudget.h"
#import "MNFInternalImports.h"
#import "MNFBudgetFilter.h"
#import "MNFTransaction.h"

@implementation MNFBudget

+(MNFJob*)fetchBudgetsWithFilter:(MNFBudgetFilter *)filter completion:(MNFMultipleBudgetCompletionHandler)completion {
    
    [completion copy];
    
    NSDictionary *filterDict = [MNFJsonAdapter JSONDictFromObject:filter option:kMNFAdapterOptionNoOption error:nil];
    
    __block MNFJob *job = [MNFObject apiRequestWithPath:kMNFApiPathBudget pathQuery:filterDict jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameBudget completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
            
            if ([response.result isKindOfClass:[NSArray class]]) {
                
                NSArray *budgets = [self initWithServerResults:response.result];
                
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:budgets error:nil];
                
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

+(MNFJob*)fetchBudgetWithId:(NSNumber *)identifier completion:(MNFBudgetCompletionHandler)completion {
    
    [completion copy];
    
    NSString *path = [NSString stringWithFormat:@"%@/%@",kMNFApiPathBudget,identifier];
    
    __block MNFJob *job = [MNFObject apiRequestWithPath:path pathQuery:nil jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameBudget completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
            
            if ([response.result isKindOfClass:[NSDictionary class]]) {
                
                MNFBudget *budget = [self initWithServerResult:response.result];
                
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:budget error:nil];
                
            }
            else {
                
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error: [MNFErrorUtils errorForUnexpectedDataOfType:[response.result class] expected:[NSDictionary class]] ];
                
            }
            
        }
        else {
            
            [MNFObject executeOnMainThreadWithCompletion:completion withParameters:nil and:response.error];
            
        }
    }];
    
    return job;
}

+(MNFJob*)budgetWithName:(NSString *)name
            targetAmount:(NSNumber *)targetAmount
               validFrom:(NSDate *)validFrom
                 validTo:(NSDate *)validTo
             description:(NSString *)budgetDescription
     allCategoriesOfType:(NSString *)allCategoriesType
             categoryIds:(NSArray *)categoryIds
              accountIds:(NSArray *)accountIds
              completion:(MNFBudgetCompletionHandler)completion {
    
    [completion copy];
    
    NSMutableDictionary *jsonDict = [NSMutableDictionary dictionary];
    jsonDict[@"name"] = name;
    jsonDict[@"targetAmount"] = targetAmount;
    jsonDict[@"validFrom"] = [[MNFBasicDateValueTransformer transformer] reverseTransformedValue:validFrom];
    jsonDict[@"validTo"] = [[MNFBasicDateValueTransformer transformer] reverseTransformedValue:validTo];
    jsonDict[@"description"] = budgetDescription;
    jsonDict[@"allCategoriesType"] = allCategoriesType;
    jsonDict[@"categoryIds"] = categoryIds;
    jsonDict[@"accountIds"] = accountIds;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[jsonDict copy] options:0 error:nil];
    
    __block MNFJob *job = [MNFObject apiRequestWithPath:kMNFApiPathBudget pathQuery:nil jsonBody:jsonData HTTPMethod:kMNFHTTPMethodPOST service:MNFServiceNameBudget completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
            
            if ([response.result isKindOfClass:[NSDictionary class]]) {
                
                MNFBudget *budget = [self initWithServerResult:response.result];
                
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:budget error:nil];
                
            }
            else {
                
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error: [MNFErrorUtils errorForUnexpectedDataOfType:[response.result class] expected:[NSDictionary class]] ];
                
            }
            
        }
        else {
            
            [MNFObject executeOnMainThreadWithCompletion:completion withParameters:nil and:response.error];
            
        }
    }];
    
    return job;
}

+(MNFJob*)recalculateWithFilter:(MNFBudgetFilter *)filter completion:(MNFMultipleBudgetCompletionHandler)completion {
    
    [completion copy];
    
    NSDictionary *filterDict = [MNFJsonAdapter JSONDictFromObject:filter option:kMNFAdapterOptionNoOption error:nil];
    
    __block MNFJob *job = [MNFObject apiRequestWithPath:kMNFBudgetRecalculate pathQuery:filterDict jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameBudget completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
            
            if ([response.result isKindOfClass:[NSArray class]]) {
                
                NSArray *budgets = [self initWithServerResults:response.result];
                
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:budgets error:nil];
                
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

+(MNFJob*)deleteBudgets:(NSArray <MNFBudget*> *)budgets withCompletion:(MNFErrorOnlyCompletionHandler)completion {
    
    [completion copy];
    
    if (budgets.count == 0) {
        
        NSError *error = [MNFErrorUtils errorWithCode:kMNFErrorInvalidParameter message:@"The list of budgets to be deleted must not be empty"];
        [MNFObject executeOnMainThreadWithCompletion:completion withParameter: error];
        
        return [MNFJob jobWithError: error];
    }
    
    NSMutableArray *budgetIds = [NSMutableArray array];
    for (MNFBudget *budget in budgets) {
        [budgetIds addObject:budget.identifier];
    }
    
    __block MNFJob *job = [MNFObject apiRequestWithPath:kMNFApiPathBudget pathQuery:@{@"ids" : budgetIds} jsonBody:nil HTTPMethod:kMNFHTTPMethodDELETE service:MNFServiceNameBudget completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
            
            for (MNFTransaction *budget in budgets) {
                
                [budget makeDeleted];
                
            }
        }
        
        [MNFObject executeOnMainThreadWithJob:job completion:completion error:response.error];
    }];
    
    return job;
}

+(MNFJob*)deleteWithParentId:(NSNumber *)parentId completion:(MNFErrorOnlyCompletionHandler)completion {
    
    [completion copy];
    
    NSString *path = [NSString stringWithFormat:@"%@/%@",kMNFBudgetRecurring,parentId];
    
    __block MNFJob *job = [MNFObject apiRequestWithPath:path pathQuery:nil jsonBody:nil HTTPMethod:kMNFHTTPMethodDELETE service:MNFServiceNameBudget completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        [MNFObject executeOnMainThreadWithJob:job completion:completion error:response.error];
    }];
    
    return job;
    
}

+(MNFJob*)recurringBudgetWithName:(NSString *)name
                     targetAmount:(NSNumber *)targetAmount
                        validFrom:(NSDate *)validFrom
                          validTo:(NSDate *)validTo
                      description:(NSString *)budgetDescription
              allCategoriesOfType:(NSString *)allCategoriesType
                      categoryIds:(NSArray *)categoryIds
                       accountIds:(NSArray *)accountIds
              numberOfRecurrences:(NSNumber *)numberOfRecurrences
                         interval:(NSNumber *)interval
                     intervalType:(NSString *)intervalType
                       completion:(MNFMultipleBudgetCompletionHandler)completion {
    
    [completion copy];
    
    NSMutableDictionary *jsonDict = [NSMutableDictionary dictionary];
    jsonDict[@"name"] = name;
    jsonDict[@"targetAmount"] = targetAmount;
    jsonDict[@"validFrom"] = [[MNFBasicDateValueTransformer transformer] reverseTransformedValue:validFrom];
    jsonDict[@"validTo"] = [[MNFBasicDateValueTransformer transformer] reverseTransformedValue:validTo];
    jsonDict[@"description"] = budgetDescription;
    jsonDict[@"allCategoriesOfType"] = allCategoriesType;
    jsonDict[@"categoryIds"] = categoryIds;
    jsonDict[@"accountIds"] = accountIds;
    jsonDict[@"numberOfRecurrences"] = numberOfRecurrences;
    jsonDict[@"interval"] = interval;
    jsonDict[@"intervalType"] = intervalType;
    
    __block MNFJob *job = [MNFObject apiRequestWithPath:kMNFBudgetRecurring pathQuery:nil jsonBody:[jsonDict copy] HTTPMethod:kMNFHTTPMethodPOST service:MNFServiceNameBudget completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
            
            if ([response.result isKindOfClass:[NSArray class]]) {
                
                NSArray *budgets = [self initWithServerResults:response.result];
                
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:budgets error:nil];
                
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

-(MNFJob*)saveWithCompletion:(MNFErrorOnlyCompletionHandler)completion {
    
    NSString *path = [NSString stringWithFormat:@"%@/%@",kMNFApiPathBudget,self.identifier];
    
    NSDictionary *jsonDict = [MNFJsonAdapter JSONDictFromObject:self option:kMNFAdapterOptionNoOption error:nil];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDict options:0 error:nil];
    
    __block MNFJob *job = [self updateWithApiPath:path pathQuery:nil jsonBody:jsonData httpMethod:kMNFHTTPMethodPUT service:MNFServiceNameBudget completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        [MNFObject executeOnMainThreadWithJob:job completion:completion error:response.error];
    }];
    
    return job;
}

-(MNFJob*)deleteWithCompletion:(MNFErrorOnlyCompletionHandler)completion {
    
    [completion copy];
    
    NSString *path = [NSString stringWithFormat:@"%@/%@",kMNFApiPathBudget,self.identifier];
    
    __block MNFJob *job = [self deleteWithApiPath:path pathQuery:nil jsonBody:nil service:MNFServiceNameBudget completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        [MNFObject executeOnMainThreadWithJob:job completion:completion error:response.error];
    }];
    
    return job;
}

-(MNFJob*)refreshWithCompletion:(MNFErrorOnlyCompletionHandler)completion {
    
    NSString *path = [NSString stringWithFormat:@"%@/%@",kMNFApiPathBudget,self.identifier];
    
    __block MNFJob *job = [MNFObject apiRequestWithPath:path pathQuery:nil jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameBudget completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil && response.result != nil) {
            
            if ([response.result isKindOfClass:[NSDictionary class]]) {
                
                [MNFJsonAdapter refreshObject:self withJsonDict:response.result option:kMNFAdapterOptionNoOption error:nil];
                [MNFObject executeOnMainThreadWithJob:job completion:completion error:nil];
                
            }
            else {
                
                [MNFObject executeOnMainThreadWithJob:job completion:completion error: [MNFErrorUtils errorForUnexpectedDataOfType:[response.result class] expected:[NSDictionary class]] ];
                
            }
        }
        else {
            [MNFObject executeOnMainThreadWithJob:job completion:completion error: response.error];
        }
    }];
    
    return job;
}

-(MNFJob*)fetchTransactionsWithCompletion:(MNFMultipleTransactionsCompletionHandler)completion {
    
    [completion copy];
    
    NSString *path = [NSString stringWithFormat:kMNFBudgetTransactions,self.identifier];
    
    __block MNFJob *job = [MNFObject apiRequestWithPath:path pathQuery:nil jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameBudget completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
            
            if ([response.result isKindOfClass:[NSArray class]]) {
                
                NSArray *transactions = [MNFTransaction initWithServerResults:response.result];
                
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:transactions error:nil];
                
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

#pragma mark - json delegate

-(NSDictionary*)jsonKeysMapToProperties {
    return @{@"identifier":@"id",
             @"budgetDescription":@"description"};
}

-(NSDictionary*)propertyKeysMapToJson {
    return @{@"identifier":@"id",
             @"budgetDescription":@"description"};
}

-(NSDictionary*)propertyValueTransformers {
    return @{@"validFrom":[MNFBasicDateValueTransformer transformer],
             @"validTo":[MNFBasicDateValueTransformer transformer],
             @"updatedAt":[MNFBasicDateValueTransformer transformer]};
}

-(NSSet *)propertiesToIgnoreJsonDeserialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

-(NSSet *)propertiesToIgnoreJsonSerialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

@end
