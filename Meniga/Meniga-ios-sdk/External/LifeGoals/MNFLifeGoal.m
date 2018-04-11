//
//  MNFLifeGoal.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 14/03/2018.
//  Copyright © 2018 Meniga. All rights reserved.
//

#import "MNFLifeGoal.h"
#import "MNFInternalImports.h"
#import "MNFLifeGoalHistory.h"
#import "MNFLifeGoalAccountInfo.h"

@implementation MNFLifeGoal

+(MNFJob*)fetchWithId:(NSNumber *)identifier completion:(MNFLifeGoalCompletionHandler)completion {
    [completion copy];
    
    NSString *path = [NSString stringWithFormat:@"%@/%@",kMNFApiPathLifeGoals,[identifier stringValue]];
    
    __block MNFJob *job = [self apiRequestWithPath:path pathQuery:nil jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameLifeGoals completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
            if ([response.result isKindOfClass:[NSDictionary class]]) {
                
                MNFLifeGoal *lifeGoal = [MNFLifeGoal initWithServerResult:response.result];
                
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:lifeGoal error:nil];
                
            }
            else {
                
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error:[MNFErrorUtils errorForUnexpectedDataOfType:[response.result class] expected:[NSDictionary class]]];
            }
        }
        else {
            
            [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error:response.error];
        }
    }];
    
    return job;
}

+(MNFJob*)fetchLifeGoalsWithCompletion:(MNFMultipleLifeGoalsCompletionHandler)completion {
    [completion copy];
    
    __block MNFJob *job = [self apiRequestWithPath:kMNFApiPathLifeGoals pathQuery:nil jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameLifeGoals completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
            if ([response.result isKindOfClass:[NSArray class]]) {
                
                NSArray *lifeGoals = [MNFLifeGoal initWithServerResults:response.result];
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:lifeGoals error:nil];
                
            }
            else {
                
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error:[MNFErrorUtils errorForUnexpectedDataOfType:[response.result class] expected:[NSArray class]]];
                
            }
        }
        else {
            [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error:response.error];
        }
    }];
    
    return job;
}

+(MNFJob*)fetchLifeGoalsAccountInfoWithAccountIds:(NSString *)accountIds completion:(MNFLifeGoalAccountInfoCompletionHandler)completion {
    [completion copy];
    
    NSMutableDictionary *jsonQuery = [NSMutableDictionary dictionary];
    jsonQuery[@"accountIds"] = accountIds;
    
    __block MNFJob *job = [self apiRequestWithPath:kMNFLifeGoalsAccountInfo pathQuery:[jsonQuery copy] jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameLifeGoals completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
            if ([response.result isKindOfClass:[NSArray class]]) {
                
                NSArray *accountInfo = [MNFLifeGoalAccountInfo initWithServerResults:response.result];
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:accountInfo error:nil];
                
            }
            else {
                
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error:[MNFErrorUtils errorForUnexpectedDataOfType:[response.result class] expected:[NSArray class]]];
                
            }
        }
        else {
            [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error:response.error];
        }
    }];
    
    return job;
}

+(MNFJob*)lifeGoalWithName:(NSString *)name accountId:(NSNumber *)accountId targetAmount:(NSNumber *)targetAmount recurringAmount:(NSNumber *)recurringAmount initialAmount:(NSNumber *)initialAmount targetDate:(NSDate *)targetDate categoryId:(NSNumber *)categoryId metadata:(NSString *)metadata recurrenceIntervalType:(NSString *)recurrenceIntervalType completion:(MNFLifeGoalCompletionHandler)completion {
    [completion copy];
    
    MNFBasicDateValueTransformer *transformer = [MNFBasicDateValueTransformer transformer];
    
    NSMutableDictionary *jsonDict = [NSMutableDictionary dictionary];
    jsonDict[@"name"] = name;
    jsonDict[@"accountId"] = accountId;
    jsonDict[@"targetAmount"] = targetAmount;
    jsonDict[@"recurringAmount"] = recurringAmount;
    jsonDict[@"initialAmount"] = initialAmount;
    jsonDict[@"targetDate"] = [transformer reverseTransformedValue:targetDate];
    jsonDict[@"categoryId"] = categoryId;
    jsonDict[@"metadata"] = metadata;
    jsonDict[@"recurrenceIntervalType"] = recurrenceIntervalType;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[jsonDict copy] options:0 error:nil];
    
    __block MNFJob *job = [self apiRequestWithPath:kMNFApiPathLifeGoals pathQuery:nil jsonBody:jsonData HTTPMethod:kMNFHTTPMethodPOST service:MNFServiceNameLifeGoals completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
            if ([response.result isKindOfClass:[NSDictionary class]]) {
                
                MNFLifeGoal *lifeGoal = [MNFLifeGoal initWithServerResult:response.result];
                
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:lifeGoal error:nil];
                
            }
            else {
                
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error:[MNFErrorUtils errorForUnexpectedDataOfType:[response.result class] expected:[NSDictionary class]]];
            }
        }
        else {
            
            [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error:response.error];
        }
    }];
    
    return job;
}

-(MNFJob*)refreshWithCompletion:(MNFErrorOnlyCompletionHandler)completion {
    [completion copy];
    
    NSString *path = [NSString stringWithFormat:@"%@/%@", kMNFApiPathLifeGoals, [self.identifier stringValue]];
    
    __block MNFJob *job = [[self class] apiRequestWithPath:path pathQuery:nil jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameLifeGoals completion:^(MNFResponse*  _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
            
            if ([response.result isKindOfClass:[NSDictionary class]]) {
                
                [MNFJsonAdapter refreshObject:self withJsonDict:response.result option:kMNFAdapterOptionNoOption error:nil];
                [MNFObject executeOnMainThreadWithJob:job completion:completion error: nil];
                
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

-(MNFJob*)saveWithCompletion:(MNFErrorOnlyCompletionHandler)completion {
    [completion copy];
    
    NSMutableDictionary *jsonDict = [NSMutableDictionary dictionary];
    MNFNumberToBoolValueTransformer *transformer = [MNFNumberToBoolValueTransformer transformer];
    MNFBasicDateValueTransformer *dateTransformer = [MNFBasicDateValueTransformer transformer];
    jsonDict[@"name"] = self.name;
    jsonDict[@"targetAmount"] = self.targetAmount;
    jsonDict[@"currentAmount"] = self.currentAmount;
    jsonDict[@"recurringAmount"] = self.recurringAmount;
    jsonDict[@"targetDate"] = [dateTransformer   reverseTransformedValue:self.targetDate];
    jsonDict[@"categoryId"] = self.categoryId;
    jsonDict[@"metadata"] = self.metadata;
    jsonDict[@"markAsReached"] = [transformer reverseTransformedValue:self.markAsReached];
    jsonDict[@"recurrenceIntervalType"] = self.recurrenceIntervalType;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[jsonDict copy] options:0 error:nil];
    
    NSString *path = [NSString stringWithFormat:@"%@/%@", kMNFApiPathLifeGoals, [self.identifier stringValue]];
    
    __block MNFJob *job = [self updateWithApiPath:path pathQuery:nil jsonBody:jsonData httpMethod:kMNFHTTPMethodPUT service:MNFServiceNameLifeGoals completion:^(MNFResponse*  _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        [MNFObject executeOnMainThreadWithJob:job completion:completion error: response.error];
        
    }];
    
    return job;
}

-(MNFJob*)deleteWithCompletion:(MNFErrorOnlyCompletionHandler)completion {
    [completion copy];
    
    NSString *path = [NSString stringWithFormat:@"%@/%@", kMNFApiPathLifeGoals, [self.identifier stringValue]];
    
    __block MNFJob *job = [self deleteWithApiPath:path pathQuery:nil jsonBody:nil service:MNFServiceNameLifeGoals completion:^(MNFResponse*  _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        [MNFObject executeOnMainThreadWithJob:job completion:completion error: response.error];
    }];
    
    return job;
}

-(MNFJob*)fetchHistoryWithCompletion:(MNFLifeGoalHistoryCompletionHandler)completion {
    [completion copy];
    
    NSString *path = [NSString stringWithFormat:kMNFLifeGoalsHistory,[self.identifier stringValue]];
    
    __block MNFJob *job = [[self class] apiRequestWithPath:path pathQuery:nil jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameLifeGoals completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
            if ([response.result isKindOfClass:[NSArray class]]) {
                
                NSArray *lifeGoals = [MNFLifeGoalHistory initWithServerResults:response.result];
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:lifeGoals error:nil];
                
            }
            else {
                
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error:[MNFErrorUtils errorForUnexpectedDataOfType:[response.result class] expected:[NSArray class]]];
                
            }
        }
        else {
            [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error:response.error];
        }
    }];
    
    return job;
}

#pragma mark - json adaptor delegate methods

-(NSDictionary*)jsonKeysMapToProperties{
    return @{@"identifier":@"id"};
}

-(NSDictionary*)propertyKeysMapToJson{
    return @{@"identifier":@"id"};
}

-(NSDictionary*)propertyValueTransformers {
    
    return @{@"expectedTargetDate":[MNFBasicDateValueTransformer transformer],
             @"startDate":[MNFBasicDateValueTransformer transformer],
             @"achievedDate":[MNFBasicDateValueTransformer transformer],
             @"targetDate":[MNFBasicDateValueTransformer transformer]};
}

@end
