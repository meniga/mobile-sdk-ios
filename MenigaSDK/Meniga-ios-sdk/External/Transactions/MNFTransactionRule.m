//
//  MNFTransactionRule.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 31/03/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFTransactionRule.h"
#import "MNFInternalImports.h"
#import "MNFTransactionSplitAction.h"

@implementation MNFTransactionRule

#pragma mark - fetching

+(MNFJob *)fetchRuleWithId:(NSNumber *)identifier completion:(MNFTransactionRuleCompletionHandler)completion {
    
    [completion copy];
    
    NSString *path = [NSString stringWithFormat:@"%@/%@",kMNFTransactionsRule,[identifier stringValue]];
    
    __block MNFJob *job = [self apiRequestWithPath:path pathQuery:nil jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameTransactions completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
        
            if ([response.result isKindOfClass:[NSDictionary class]]) {
            
                MNFTransactionRule *rule = [MNFTransactionRule initWithServerResult:response.result];
                
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:rule error:nil];
            
            }
            else {
            
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error: [MNFErrorUtils errorForUnexpectedDataOfType:[response.result class] expected:[NSDictionary class]] ];
            
            }
        }
        else {
            
            [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error:response.error];
        
        }
    }];
    
    return job;
}

+(MNFJob *)fetchRulesWithCompletion:(MNFMultipleTransactionRulesCompleitonHandler)completion {
    
    [completion copy];
    
    __block MNFJob *job = [self apiRequestWithPath:kMNFTransactionsRule pathQuery:nil jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameTransactions completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
        
            if ([response.result isKindOfClass:[NSArray class]]) {
            
                NSArray *rules = [MNFTransactionRule initWithServerResults:response.result];
                
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:rules error:response.error];
            
            }
            else {
            
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error: [MNFErrorUtils errorForUnexpectedDataOfType:[response.result class] expected:[NSArray class]] ];
            
            }
        }
        else {
            
            [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error:response.error];
        
        }
    }];
    
    return job;
}

#pragma mark - creating

+(MNFJob *)createRuleWithName:(NSString *)ruleName textCriteria:(NSString *)textCriteria textCriteriaOperatorType:(NSNumber *)operatorType dateMatchTypeCriteria:(NSNumber *)dateMatchTypeCriteria daysLimitCriteria:(NSNumber *)daysLimitCriteria amountLimitTypeCriteria:(NSNumber *)amountLimitTypeCriteria amountLimitSignCriteria:(NSNumber *)amountLimitSignCriteria amountCriteria:(NSNumber *)amountCritera accountCategoryCriteria:(NSString *)accountCategoryCriteria acceptAction:(NSNumber *)acceptAction monthShiftAction:(NSNumber *)monthShiftAction removeAction:(NSNumber *)removeAction textAction:(NSString *)textAction commentAction:(NSString *)commentAction categoryIdAction:(NSNumber *)categoryIdAction splitActions:(NSArray *)splitActions flagAction:(NSNumber *)flagAction applyOnExisting:(NSNumber *)applyOnExisting completion:(MNFTransactionRuleCompletionHandler)completion {
    
    NSDictionary *queryDict = @{ @"applyOnExisting" : [[MNFNumberToBoolValueTransformer transformer] reverseTransformedValue: applyOnExisting] };
    
    NSMutableDictionary *bodyDict = [NSMutableDictionary dictionary];
    
    bodyDict[@"name"] = ruleName;
    bodyDict[@"textCriteria"] = textCriteria;
    bodyDict[@"textCriteriaOperatorType"] = operatorType;
    bodyDict[@"dateMatchTypeCriteria"] = dateMatchTypeCriteria;
    bodyDict[@"daysLimitCriteria"] = daysLimitCriteria;
    bodyDict[@"amountLimitTypeCriteria"] = amountLimitTypeCriteria;
    bodyDict[@"amountLimitSignCriteria"] = amountLimitSignCriteria;
    bodyDict[@"amountCriteria"] = amountCritera;
    bodyDict[@"accountCategoryCriteria"] = accountCategoryCriteria;
    bodyDict[@"acceptAction"] = acceptAction;
    bodyDict[@"monthShiftAction"] = monthShiftAction;
    bodyDict[@"removeAction"] = removeAction;
    bodyDict[@"textAction"] = textAction;
    bodyDict[@"commentAction"] = commentAction;
    bodyDict[@"categoryIdAction"] = categoryIdAction;
    bodyDict[@"flagAction"] = flagAction;
    
    
    NSArray *serializedSplitActions = @[];
    
    if (splitActions != nil) {
        serializedSplitActions = [MNFJsonAdapter JSONArrayFromArray:splitActions option:kMNFAdapterOptionNoOption error:nil];
    }
    
    bodyDict[@"splitActions"] = serializedSplitActions;
    
    NSLog(@"body dict: %@", bodyDict);
    
    NSData *bodyData = [NSJSONSerialization dataWithJSONObject:bodyDict options:0 error:nil];
    
    __block MNFJob *job = [self apiRequestWithPath:kMNFTransactionsRule pathQuery:queryDict jsonBody:bodyData HTTPMethod:kMNFHTTPMethodPOST service:MNFServiceNameTransactions completion:^(MNFResponse *response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
            
            if ([response.result isKindOfClass:[NSDictionary class]] == YES) {
                
                MNFTransactionRule *rule = [MNFTransactionRule initWithServerResult:response.result];
                
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:rule error:nil];
                
            }
            else {
                
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error: [MNFErrorUtils errorForUnexpectedDataOfType:[response.result class] expected:[NSDictionary class]]];
                
            }
            
        }
        else {
            
            [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error:response.error];
            
        }
        
    }];
    
    return job;
}

#pragma mark - deleting

-(MNFJob *)deleteRuleWithCompletion:(nullable MNFErrorOnlyCompletionHandler)completion {
    
    [completion copy];
    
    NSString *path = [NSString stringWithFormat:@"%@/%@",kMNFTransactionsRule,[self.identifier stringValue]];
    
    __block MNFJob *job = [self deleteWithApiPath:path pathQuery:nil jsonBody:nil service:MNFServiceNameTransactions completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        [MNFObject executeOnMainThreadWithJob:job completion:completion error:response.error];
    
    }];
    
    return job;
}

#pragma mark - saving

-(MNFJob *)saveAndApplyOnExisting:(NSNumber *)applyOnExisting completion:(MNFErrorOnlyCompletionHandler)completion {
    [completion copy];
    
    if (self.isDeleted) {
        
        [MNFObject executeOnMainThreadWithCompletion:completion withParameter:[MNFErrorUtils errorForDeletedObject:self]];
        
        return [MNFJob jobWithError: [MNFErrorUtils errorForDeletedObject:self] ];
        
    }
    
    NSMutableDictionary *jsonQuery = [NSMutableDictionary dictionary];
    
    
    [jsonQuery setObject:[[MNFNumberToBoolValueTransformer transformer] reverseTransformedValue: applyOnExisting] forKey:@"applyOnExisting"];
    
    NSDictionary *jsonDict = [MNFJsonAdapter JSONDictFromObject:self option:0 error:nil];
    NSLog(@"the json dict is: %@", jsonDict);
    
    NSData *jsonData = [MNFJsonAdapter JSONDataFromObject:self option:kMNFAdapterOptionNoOption error:nil];
    
    NSString *path = [kMNFTransactionsRule stringByAppendingString:[NSString stringWithFormat:@"/%@",[self.identifier stringValue]]];
    
    __block MNFJob *job = [self updateWithApiPath:path pathQuery:jsonQuery jsonBody:jsonData httpMethod:kMNFHTTPMethodPUT service:MNFServiceNameTransactions completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        [MNFObject executeOnMainThreadWithJob:job completion:completion error:response.error];
        
    }];
    
    
    return job;
}

#pragma mark - refreshing

-(MNFJob *)refreshWithCompletion:(MNFErrorOnlyCompletionHandler)completion {
    
    [completion copy];
    
    if (self.isDeleted) {
        
        NSError *error = [MNFErrorUtils errorForDeletedObject:self];
        [MNFObject executeOnMainThreadWithCompletion:completion withParameter: error];
        
        return [MNFJob jobWithError: error];
        
    }
    
    NSString *path = [NSString stringWithFormat:@"%@/%@",kMNFTransactionsRule,[self.identifier stringValue]];
    
    __block MNFJob *job = [[self class] apiRequestWithPath:path pathQuery:nil jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameTransactions completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
        
            if ([response.result isKindOfClass:[NSDictionary class]]) {
            
                [MNFJsonAdapter refreshObject:self withJsonDict:response.result option:kMNFAdapterOptionNoOption error:nil];
                
                
                [MNFObject executeOnMainThreadWithJob:job completion:completion error:nil];
            
            }
            else {
            
                
                [MNFObject executeOnMainThreadWithJob:job completion:completion error: [MNFErrorUtils errorForUnexpectedDataOfType:[response.result class] expected:[NSDictionary class]] ];
                
            
            }
        }
        else {
        
            [MNFObject executeOnMainThreadWithJob:job completion:completion error:response.error];
            
        }
        
        
    }];
    
    return job;
}

#pragma mark - Description
-(NSString*)description {
    return [NSString stringWithFormat:@"Transaction rule %@ identifier: %@, userId: %@, name: %@, createdDate: %@, modifiedDate: %@, textCriteria: %@, textCriteriaOperatorType: %@, dateMatchTypeCriteria: %@, daysLimitCriteria: %@, amountLimitTypeCriteria: %@, amountLimitSignCriteria: %@, amountCriteria: %@, accountCategoryCriteria: %@, acceptAction: %@, monthShiftAction: %@, removeAction: %@, textAction: %@, commentAction: %@, tagAction: %@, categoryIdAction: %@, splitActions: %@, flagAction: %@",[super description],self.identifier,self.userId,self.name,self.createdDate,self.modifiedDate,self.textCriteria,self.textCriteriaOperatorType,self.dateMatchTypeCriteria,self.daysLimitCriteria,self.amountLimitTypeCriteria,self.amountLimitSignCriteria,self.amountCriteria,self.accountCategoryCriteria,self.acceptAction,self.monthShiftAction,self.removeAction,self.textAction,self.commentAction,self.tagAction,self.categoryIdAction,self.splitActions,self.flagAction];
}

#pragma mark - json adapter delegates
-(NSDictionary*)jsonKeysMapToProperties {
    return @{@"identifier":@"id"};
}
-(NSDictionary*)propertyKeysMapToJson {
    return @{@"identifier":@"id"};
}
-(NSDictionary*)propertyValueTransformers {
    return @{@"createdDate":[MNFBasicDateValueTransformer transformer],
             @"modifiedDate":[MNFBasicDateValueTransformer transformer],};
}

-(NSDictionary <NSString *, MNFJsonAdapterSubclassedProperty *> *)subclassedProperties {
    
    return @{
             @"splitActions" : [MNFJsonAdapterSubclassedProperty subclassedPropertyWithClass:[MNFTransactionSplitAction class] option:kMNFAdapterOptionNoOption]
             };
    
}

-(NSSet *)propertiesToIgnoreJsonDeserialization {
    return [NSSet setWithObjects:@"objectstate",@"mutableProperties",@"keyValueStore",@"isNew",@"deleted",@"dirty",@"applyOnExisting", nil];
}

-(NSSet *)propertiesToIgnoreJsonSerialization {
    return [NSSet setWithObjects:@"objectstate",@"mutableProperties",@"keyValueStore",@"isNew",@"deleted",@"dirty",@"applyOnExisting",@"description",@"debugDescription",@"superclass", nil];
}

@end
