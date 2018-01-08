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

@interface MNFBudget ()

@property (nonatomic,weak) MNFBudgetFilter *filter;

@end

@implementation MNFBudget

+(MNFJob*)fetchBudgetsWithIds:(NSString *)ids accountIds:(NSString *)accountIds type:(NSString *)type completion:(MNFMultipleBudgetCompletionHandler)completion {
    
    [completion copy];
    
    NSMutableDictionary *jsonDict = [NSMutableDictionary dictionary];
    jsonDict[@"ids"] = ids;
    jsonDict[@"accountIds"] = accountIds;
    jsonDict[@"type"] = type;
    
    __block MNFJob *job = [MNFObject apiRequestWithPath:kMNFApiPathBudget pathQuery:[jsonDict copy] jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameBudget completion:^(MNFResponse * _Nullable response) {
        
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

+(MNFJob*)fetchBudgetWithId:(NSNumber *)identifier filter:(nullable MNFBudgetFilter *)filter completion:(MNFBudgetCompletionHandler)completion {
    
    [completion copy];
    
    NSString *path = [NSString stringWithFormat:@"%@/%@",kMNFApiPathBudget,identifier];
    
    NSDictionary *jsonDict = [MNFJsonAdapter JSONDictFromObject:filter option:kMNFAdapterOptionNoOption error:nil];
    
    __block MNFJob *job = [MNFObject apiRequestWithPath:path pathQuery:jsonDict jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameBudget completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
            
            if ([response.result isKindOfClass:[NSDictionary class]]) {
                
                MNFBudget *budget = [self initWithServerResult:response.result];
                budget.filter = filter;
                
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
                    type:(nullable NSString *)type
             description:(nullable NSString *)budgetDescription
              accountIds:(nullable NSArray *)accountIds
                  period:(nullable NSString *)period
                  offset:(nullable NSNumber *)offset
              completion:(MNFBudgetCompletionHandler)completion {
    
    [completion copy];
    
    NSMutableDictionary *jsonDict = [NSMutableDictionary dictionary];
    jsonDict[@"name"] = name;
    jsonDict[@"type"] = type;
    jsonDict[@"description"] = budgetDescription;
    jsonDict[@"accountIds"] = accountIds;
    jsonDict[@"period"] = period;
    jsonDict[@"offset"] = offset;
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

-(MNFJob*)saveWithCompletion:(MNFErrorOnlyCompletionHandler)completion {
    [completion copy];
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
    [completion copy];
    NSString *path = [NSString stringWithFormat:@"%@/%@",kMNFApiPathBudget,self.identifier];
    
    NSDictionary *jsonDict = nil;
    if (self.filter != nil) {
        jsonDict = [MNFJsonAdapter JSONDictFromObject:self.filter option:kMNFAdapterOptionNoOption error:nil];
    }
    
    __block MNFJob *job = [MNFObject apiRequestWithPath:path pathQuery:jsonDict jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameBudget completion:^(MNFResponse * _Nullable response) {
        
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

-(MNFJob*)fetchBudgetEntriesWithFilter:(MNFBudgetFilter *)filter completion:(MNFMultipleBudgetEntriesCompletionHandler)completion {
    [completion copy];
    NSString *path = [NSString stringWithFormat:@"%@/%@/entries",kMNFApiPathBudget,self.identifier];
    
    NSDictionary *jsonDict = [MNFJsonAdapter JSONDictFromObject:filter option:kMNFAdapterOptionNoOption error:nil];
    
    __block MNFJob *job = [MNFObject apiRequestWithPath:path pathQuery:jsonDict jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameBudget completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
            
            if ([response.result isKindOfClass:[NSArray class]]) {
                
                NSArray *budgetEntries = [MNFBudgetEntry initWithServerResults:response.result];
                
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:budgetEntries error:nil];
                
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

-(MNFJob*)resetWithCompletion:(MNFErrorOnlyCompletionHandler)completion {
    [completion copy];
    NSString *path = [NSString stringWithFormat:@"%@/%@/reset",kMNFApiPathBudget,self.identifier];
    
    __block MNFJob *job = [MNFObject apiRequestWithPath:path pathQuery:nil jsonBody:nil HTTPMethod:kMNFHTTPMethodPOST service:MNFServiceNameBudget completion:^(MNFResponse * _Nullable response) {
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
            job = [self refreshWithCompletion:completion];
        }
        else {
            [MNFObject executeOnMainThreadWithJob:job completion:completion error:response.error];
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
    return @{@"created":[MNFBasicDateValueTransformer transformer]};
}

-(NSSet *)propertiesToIgnoreJsonDeserialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

-(NSSet *)propertiesToIgnoreJsonSerialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

-(NSDictionary*)subclassedProperties {
    return @{
             @"entries": [MNFJsonAdapterSubclassedProperty subclassedPropertyWithClass: [MNFBudgetEntry class] option: kMNFAdapterOptionNoOption]
             };
}

@end
