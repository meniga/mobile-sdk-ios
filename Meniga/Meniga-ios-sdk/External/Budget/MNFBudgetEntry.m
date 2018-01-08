//
//  MNFBudgetEntry.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 18/12/2017.
//  Copyright © 2017 Meniga. All rights reserved.
//

#import "MNFBudgetEntry.h"
#import "MNFInternalImports.h"

@implementation MNFBudgetEntry

-(MNFJob*)saveWithCompletion:(MNFErrorOnlyCompletionHandler)completion {
    [completion copy];
    NSString *path = [NSString stringWithFormat:@"%@/%@/entries/%@",kMNFApiPathBudget,self.budgetId,self.identifier];
    
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
    
    NSString *path = [NSString stringWithFormat:@"%@/%@/entries/%@",kMNFApiPathBudget,self.budgetId,self.identifier];
    
    __block MNFJob *job = [self deleteWithApiPath:path pathQuery:nil jsonBody:nil service:MNFServiceNameBudget completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        [MNFObject executeOnMainThreadWithJob:job completion:completion error:response.error];
    }];
    
    return job;
}

-(MNFJob*)refreshWithCompletion:(MNFErrorOnlyCompletionHandler)completion {
    [completion copy];
    NSString *path = [NSString stringWithFormat:@"%@/%@/entries/%@",kMNFApiPathBudget,self.budgetId,self.identifier];
    
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
