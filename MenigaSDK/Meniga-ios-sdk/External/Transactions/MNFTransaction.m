//
//  MNFTransaction.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 23/10/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFTransaction.h"
#import "MNFInternalImports.h"
#import "MNFTransactionFilter.h"
#import "MNFComment.h"
#import "MNFComment_Private.h"
#import "MNFNumberToBoolValueTransformer.h"
#import "MNFTag.h"

@interface MNFTransaction ()

@end

@implementation MNFTransaction

#pragma mark - fetching

+(MNFJob *)fetchWithId:(NSNumber *)identifier completion:(MNFTransactionCompletionHandler)completion {
    
    [completion copy];
    
    NSString *path = [NSString stringWithFormat:@"%@/%@",kMNFApiPathTransactions,[identifier stringValue]];
    
    __block MNFJob *job = [self apiRequestWithPath:path pathQuery:nil jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameTransactions completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
        
            if ([response.result isKindOfClass:[NSDictionary class]]) {
                
                NSMutableDictionary *dict = [response.result mutableCopy];
                
                MNFTransaction *transaction = [self initWithServerResult:[dict copy]];
                
                for (MNFComment *comment in transaction.comments) {
                    comment.transactionId = transaction.identifier;
                }
                
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:transaction error:nil];
                
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

+(MNFJob *)fetchWithTransactionFilter:(MNFTransactionFilter<MNFJsonAdapterDelegate>*)filter completion:(MNFMultipleTransactionsCompletionHandler)completion {
    
    [completion copy];
    
    NSDictionary *filterDict = [MNFJsonAdapter JSONDictFromObject:filter option:0 error:nil];
    
    __block MNFJob *job = [self apiRequestWithPath:kMNFApiPathTransactions pathQuery:filterDict jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameTransactions completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
            
            if ([response.result isKindOfClass:[NSArray class]]) {
                
                NSArray *transactions = [self initWithServerResults:response.result];
                
                for (MNFTransaction *transaction in transactions) {
                    
                    for (MNFComment *comment in transaction.comments) {
                        comment.transactionId = transaction.identifier;
                    }
                    
                }
                
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

-(MNFJob *)fetchSplitWithCompletion:(MNFMultipleTransactionsCompletionHandler)completion {
    
    [completion copy];
    
    NSString *path = [NSString stringWithFormat:@"%@/%@/split",kMNFApiPathTransactions,[self.identifier stringValue]];
    
    __block MNFJob *job = [[self class] apiRequestWithPath:path pathQuery:nil jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameTransactions completion:^(MNFResponse * _Nullable response) {
        
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
            
            [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error:response.error];
            
        }
    }];
    
    return job;
}

#pragma mark - saving

-(MNFJob *)saveWithCompletion:(MNFErrorOnlyCompletionHandler)completion {
    
    [completion copy];
    
    NSString *path = [NSString stringWithFormat:@"%@/%@",kMNFApiPathTransactions,[self.identifier stringValue]];
    NSDictionary *updateDict = [MNFJsonAdapter JSONDictFromObject:self option:kMNFAdapterOptionNoOption error:nil];
    NSLog(@"Update dictionary: %@",updateDict);
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:updateDict options:0 error:nil];
    
    
    NSMutableDictionary *mutableQueryDict = [NSMutableDictionary dictionary];
    
    if (self.isFlagged != nil) {
        [mutableQueryDict setObject:self.isFlagged forKey:@"isFlagged"];
    }
    if(self.isRead != nil) {
        [mutableQueryDict setObject:self.isRead forKey:@"isRead"];
    }
    if (self.userData != nil) {
        [mutableQueryDict setObject:self.userData forKey:@"userData"];
    }
    
    __block MNFJob *job = [self updateWithApiPath:path pathQuery:mutableQueryDict jsonBody:jsonData httpMethod:kMNFHTTPMethodPUT service:MNFServiceNameTransactions completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        [MNFObject executeOnMainThreadWithJob:job completion:completion error:response.error];
        
    }];
    
    
    return job;
}

#pragma mark - splitting

-(MNFJob *)splitTransactionWithAmount:(NSNumber*)amount
                           categoryId:(NSNumber*)categoryId
                                 text:(NSString*)text
                            isFlagged:(BOOL)flagged
                           completion:(MNFTransactionCompletionHandler)completion {
    
    [completion copy];
    if ([self p_isValidSplitAmount:amount] == NO) {
        
        MNFLogError(@"Split amount cannot be higher than current amount of the parent transaction.");
        
        NSError *error = [MNFErrorUtils errorWithCode:kMNFErrorInvalidParameter message:@"Split amount cannot be higher than current amount of the parent transaction."];
        [MNFObject executeOnMainThreadWithCompletion:completion withParameters:nil and: error];
        
        return [MNFJob jobWithError: error];
    }
    
    if ([self.isSplitChild boolValue] == YES) {
        
        MNFLogError(@"Cannot split a split child again");
        
        NSError *error = [MNFErrorUtils errorWithCode:kMNFErrorInvalidParameter message:@"Cannot split a split child again."];
        [MNFObject executeOnMainThreadWithCompletion:completion withParameters:nil and: error];
        
        return [MNFJob jobWithError: error];
    }
    
    amount = [self p_normalizeSplitAmount:amount];
    
    NSString *path = [NSString stringWithFormat:@"%@/%@/split",kMNFApiPathTransactions,[self.identifier stringValue]];
    
    MNFNumberToBoolValueTransformer *transformer = [MNFNumberToBoolValueTransformer transformer];
   
    NSDictionary *jsonDict = @{@"amount":amount,@"categoryId":categoryId,@"text":text,@"isFlagged":[transformer reverseTransformedValue:@(flagged)]};
    NSData *jsonData = [MNFJsonAdapter JSONDataFromDictionary:jsonDict];
    
    __block MNFJob *job = [[self class] apiRequestWithPath:path pathQuery:nil jsonBody:jsonData HTTPMethod:kMNFHTTPMethodPOST service:MNFServiceNameTransactions completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
        
            if ([response.result isKindOfClass:[NSArray class]]) {
                
                [MNFJsonAdapter refreshObject:self withJsonDict:[response.result firstObject] option:kMNFAdapterOptionNoOption error:nil];
                MNFTransaction *splitChild = [[self class] initWithServerResult:[response.result lastObject]];
            
                if (splitChild != nil) {
                
                    [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:splitChild error:nil];
                
                }
                else {
                
                    // MARK: We should maybe send some kind error here???
                    [MNFObject executeOnMainThreadWithJob:job completion:completion parameter: response.result error: response.error];
                
                }
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

+(MNFJob*)createTransactionWithDate:(NSDate *)date
                               text:(NSString *)text
                             amount:(NSNumber *)amount
                         categoryId:(NSNumber *)categoryId
                          setAsRead:(NSNumber *)setAsRead
                         completion:(MNFTransactionCompletionHandler)completion {
    
    [completion copy];
    
    NSValueTransformer *transformer = [MNFBasicDateValueTransformer transformer];
    NSString *stringDate = [transformer reverseTransformedValue:date];
    NSValueTransformer *boolTransformer = [MNFNumberToBoolValueTransformer transformer];
    NSString *read = [boolTransformer reverseTransformedValue:setAsRead];
    NSDictionary *jsonBody = @{@"date":stringDate,@"text":text,@"amount":amount,@"categoryId":categoryId,@"setAsRead":read};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonBody options:0 error:nil];
    
    __block MNFJob *job = [self apiRequestWithPath:kMNFApiPathTransactions pathQuery:nil jsonBody:jsonData HTTPMethod:kMNFHTTPMethodPOST service:MNFServiceNameTransactions completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
            
            if ([response.result isKindOfClass:[NSDictionary class]]) {
                
                NSMutableDictionary *dict = [response.result mutableCopy];
                
                MNFTransaction *transaction = [self initWithServerResult:[dict copy]];
                
                for (MNFComment *comment in transaction.comments) {
                    comment.transactionId = transaction.identifier;
                }
                
                
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:transaction error: nil];
                
            }
            else {
               
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error: [MNFErrorUtils errorForUnexpectedDataOfType:[response.result class] expected:[NSDictionary class]] ];
                
            }
        }
        else {
            
            [MNFObject executeOnMainThreadWithJob:job completion:completion parameter: nil error:response.error];
            
        }
    }];
    
    return job;
}

#pragma mark - deleting

-(MNFJob *)deleteTransactionWithCompletion:(MNFErrorOnlyCompletionHandler)completion {
    
    NSString *path = [NSString stringWithFormat:@"%@/%@",kMNFApiPathTransactions,[self.identifier stringValue]];
    
    __block MNFJob *job = [self deleteWithApiPath:path pathQuery:nil jsonBody:nil service:MNFServiceNameTransactions completion:^(MNFResponse *response) {
        
        kObjectBlockDataDebugLog;
        
        [MNFObject executeOnMainThreadWithJob:job completion:completion error:response.error];
    
    }];
    
    
    return job;
}

+(MNFJob *)deleteTransactions:(NSArray <MNFTransaction *> *)transactions withCompletion:(MNFErrorOnlyCompletionHandler)completion {
    
    [completion copy];
    
    if (transactions.count == 0) {
        
        NSError *error = [MNFErrorUtils errorWithCode:kMNFErrorInvalidParameter message:@"The list of transactions to be deleted must not be empty"];
        [MNFObject executeOnMainThreadWithCompletion:completion withParameter: error];
        
        return [MNFJob jobWithError: error];
    }
    
    NSMutableArray *transactionIds = [NSMutableArray array];
    for (MNFTransaction *transaction in transactions) {
        [transactionIds addObject:transaction.identifier];
    }
    
    __block MNFJob *job = [self apiRequestWithPath:kMNFApiPathTransactions pathQuery:@{@"transactionIds":[transactionIds copy]} jsonBody:nil HTTPMethod:kMNFHTTPMethodDELETE service:MNFServiceNameTransactions completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
        
            for (MNFTransaction *transaction in transactions) {
            
                [transaction makeDeleted];
            
            }
        }
        
        [MNFObject executeOnMainThreadWithJob:job completion:completion error:response.error];
    }];
    
    return job;
}

#pragma mark - refreshing

-(MNFJob *)refreshWithCompletion:(MNFErrorOnlyCompletionHandler)completion {
    
    [completion copy];
    
    NSString *path = [NSString stringWithFormat:@"%@/%@",kMNFApiPathTransactions,[self.identifier stringValue]];
    
    __block MNFJob *job = [self updateWithApiPath:path pathQuery:nil jsonBody:nil httpMethod:kMNFHTTPMethodGET service:MNFServiceNameTransactions completion:^(MNFResponse * _Nullable response) {
        
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

#pragma mark - comment

-(MNFJob *)postComment:(NSString *)comment withCompletion:(MNFErrorOnlyCompletionHandler)completion {
    
    [completion copy];
    
    if (self.isDeleted) {
        
        [MNFObject executeOnMainThreadWithCompletion:completion withParameter:[MNFErrorUtils errorForDeletedObject:self]];
        
        return [MNFJob jobWithError: [MNFErrorUtils errorForDeletedObject:self] ];
    }
    
    NSString *path = [NSString stringWithFormat:@"%@/%@/%@",kMNFApiPathTransactions,[self.identifier stringValue],kMNFTransactionsComments];
    NSDictionary *jsonDict = @{@"comment":comment};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDict options:0 error:nil];
    
    __block MNFJob *job = [[self class] apiRequestWithPath:path pathQuery:nil jsonBody:jsonData HTTPMethod:kMNFHTTPMethodPOST service:MNFServiceNameTransactions completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
        
            if ([response.result isKindOfClass:[NSDictionary class]]) {
            
                MNFComment *comment = [MNFComment initWithServerResult:response.result];
                comment.transactionId = self.identifier;
                NSMutableArray *array = [self.comments mutableCopy];
                [array addObject:comment];
                self.comments = [array copy];
                
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

#pragma mark - recategorize

+(MNFJob *)recategorizeWithTexts:(NSArray<NSString *> *)texts
                        unreadOnly:(BOOL)unreadOnly
                        useSubText:(BOOL)useSubText
                        markAsRead:(BOOL)markAsRead
                        categoryId:(NSNumber *)categoryId
                        completion:(MNFErrorOnlyCompletionHandler)completion {
    
    [completion copy];
    
    NSDictionary *jsonBody = @{@"transactionTexts":texts,
                               @"recategorizeUnreadOnly":unreadOnly?@"true":@"false",
                               @"useSubTextInRecat":useSubText?@"true":@"false",
                               @"markAsRead":markAsRead?@"true":@"false",
                               @"categoryId":categoryId};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonBody options:0 error:nil];
    
    __block MNFJob *job = [self apiRequestWithPath:KMNFTransactionsRecategorize pathQuery:nil jsonBody:jsonData HTTPMethod:kMNFHTTPMethodPOST service:MNFServiceNameTransactions completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        [MNFObject executeOnMainThreadWithJob:job completion:completion error:response.error];
    
    }];
    
    return job;
}

#pragma mark - Description

-(NSString*)description {
    return [NSString stringWithFormat:@"Transaction %@ identifier: %@, parentIdentifier: %@, amount: %@, tags: %@, comments: %@, categoryId: %@, date: %@, text: %@, originalDate: %@, data: %@, originalText: %@, originalAmount: %@, isRead: %@, isFlagged: %@, hasUncertainCategorization: %@, accountId: %@, mcc: %@, detectedCategories: %@, currency: %@, amountInCurrency: %@, dataFormat: %@, merchantId: %@, parsedData: %@, bankId: %@, insertTime: %@, hasUserClearedCategoryUncertainty: %@, isMerchant: %@, isOwnAccountTransfer: %@, isUncleared: %@≤ isSplitChild: %@, balance: %@, categoryChangedTime: %@, changedByRule: %@, changedByRuleTime: %@, counterpartyAccountIdentifier: %@, dueDate: %@, lastModifiedTime: %@, timestamp: %@, metaData: %@, userData: %@",[super description],self.identifier, self.parentIdentifier,self.amount,self.tags,self.comments,self.categoryId,self.date,self.text,self.originalDate,self.data,self.originalText,self.originalAmount,self.isRead,self.isFlagged,self.hasUncertainCategorization,self.accountId,self.mcc,self.detectedCategories,self.currency,self.amountInCurrency,self.dataFormat,self.merchantId,self.parsedData,self.bankId,self.insertTime,self.hasUserClearedCategoryUncertainty,self.isMerchant,self.isOwnAccountTransfer,self.isUncleared,self.isSplitChild,self.balance,self.categoryChangedTime,self.changedByRule,self.changedByRuleTime,self.counterpartyAccountIdentifier,self.dueDate,self.lastModifiedTime,self.timestamp,self.metaData,self.userData];
}

#pragma mark - json adaptor delegate methods

-(NSDictionary*)jsonKeysMapToProperties{
    return @{@"identifier":@"id"};
}

-(NSDictionary*)propertyKeysMapToJson{
    return @{@"identifier":@"id"};
}

-(NSDictionary*)propertyValueTransformers {

    return @{@"categoryChangedTime":[MNFBasicDateValueTransformer transformer],
             @"changedByRuleTime":[MNFBasicDateValueTransformer transformer],
             @"dueDate":[MNFBasicDateValueTransformer transformer],
             @"insertTime":[MNFBasicDateValueTransformer transformer],
             @"lastModifiedTime":[MNFBasicDateValueTransformer transformer],
             @"originalDate":[MNFBasicDateValueTransformer transformer],
             @"timestamp":[MNFBasicDateValueTransformer transformer],
             @"date":[MNFBasicDateValueTransformer transformer]};
}

-(NSSet*)propertiesToIgnoreJsonSerialization {
    return [NSSet setWithArray:@[@"objectstate"]];
}

-(NSSet*)propertiesToIgnoreJsonDeserialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

-(NSDictionary*)subclassedProperties {
    return @{
             @"comments": [MNFJsonAdapterSubclassedProperty subclassedPropertyWithClass: [MNFComment class] option: kMNFAdapterOptionNoOption]
             };
}

#pragma - mark private helpers

-(NSNumber*)p_normalizeSplitAmount:(NSNumber*)splitAmount{
    
    double thisAmountPrimitiveValue = self.amount.doubleValue;
    double splitAmountPrimitiveValue = splitAmount.doubleValue;
    
    if (thisAmountPrimitiveValue>0) {
        return @(fabs(splitAmountPrimitiveValue));
    }
    else if(thisAmountPrimitiveValue<0){
        return @(-fabs(splitAmountPrimitiveValue));
    }
    
    return splitAmount;
}

-(BOOL)p_isValidSplitAmount:(NSNumber*)splitAmount{
    
    double thisAmountInPrimitive = self.amount.doubleValue;
    double splitAmountInPrimitive = splitAmount.doubleValue;
    
    if (fabs(splitAmountInPrimitive)>fabs(thisAmountInPrimitive)) {
        return NO;
    }
    
    return YES;
}

@end
