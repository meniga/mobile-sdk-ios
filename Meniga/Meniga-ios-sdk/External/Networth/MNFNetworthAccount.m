//
//  MNFNetworth.m
//  Meniga-ios-sdk
//
//  Created by Aske Bendtsen on 30/03/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFNetworthAccount.h"
#import "MNFInternalImports.h"
#import "MNFNetworthBalanceHistory.h"
#import "MNFNetworthAccount.h"
#import "MNFAccountType.h"

@implementation MNFNetworthAccount


#pragma mark - fetching

+(MNFJob*)fetchWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate interPolation:(BOOL)useInterpolation completion:(MNFMultipleNetworthAccountsCompletionHandler)completion{

    return [self fetchWithStartDate:startDate endDate:endDate interPolation:useInterpolation skip:nil take:nil completion:completion];
}

+(MNFJob*)fetchWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate interPolation:(BOOL)useInterpolation skip:(NSNumber *)skip take:(NSNumber *)take completion:(MNFMultipleNetworthAccountsCompletionHandler)completion {
    [completion copy];
    
    NSString *boolString = useInterpolation ? @"true" : @"false";
    
    MNFBasicDateValueTransformer *transformer = [MNFBasicDateValueTransformer transformer];
    NSMutableDictionary *jsonQuery = [NSMutableDictionary dictionary];
    jsonQuery[@"startDate"] = [transformer reverseTransformedValue:startDate];
    jsonQuery[@"endDate"] = [transformer reverseTransformedValue:endDate];
    jsonQuery[@"userInterpolation"] = boolString;
    jsonQuery[@"skip"] = skip;
    jsonQuery[@"take"] = take;
    
    __block MNFJob *job = [self apiRequestWithPath:kMNFAPIPathNetworth pathQuery:[jsonQuery copy] jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameNetWorth completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
            if ([response.result isKindOfClass:[NSArray class]]) {
                
                NSArray *resultArray = [MNFJsonAdapter objectsOfClass:[self class] jsonArray:response.result option:kMNFAdapterOptionNoOption error:nil];
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:resultArray error:nil];
            }
            else{
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error:[MNFErrorUtils errorForUnexpectedDataOfType:[response.result class] expected:[NSArray class]]];
            }
        }
        else{
            [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error:response.error];
        }
    }];
    
    
    return job;
}

+(MNFJob*)fetchWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate intervalGrouping:(NSString *)intervalGrouping skip:(NSNumber *)skip take:(NSNumber *)take completion:(MNFMultipleNetworthAccountsCompletionHandler)completion {
    [completion copy];
    
    MNFBasicDateValueTransformer *transformer = [MNFBasicDateValueTransformer transformer];
    NSMutableDictionary *jsonQuery = [NSMutableDictionary dictionary];
    jsonQuery[@"startDate"] = [transformer reverseTransformedValue:startDate];
    jsonQuery[@"endDate"] = [transformer reverseTransformedValue:endDate];
    jsonQuery[@"intervalGrouping"] = intervalGrouping;
    jsonQuery[@"skip"] = skip;
    jsonQuery[@"take"] = take;
    
    __block MNFJob *job = [self apiRequestWithPath:kMNFAPIPathNetworth pathQuery:[jsonQuery copy] jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameNetWorth completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
            if ([response.result isKindOfClass:[NSArray class]]) {
                
                NSArray *resultArray = [MNFJsonAdapter objectsOfClass:[self class] jsonArray:response.result option:kMNFAdapterOptionNoOption error:nil];
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:resultArray error:nil];
            }
            else{
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error:[MNFErrorUtils errorForUnexpectedDataOfType:[response.result class] expected:[NSArray class]]];
            }
        }
        else{
            [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error:response.error];
        }
    }];
    
    
    return job;
}

+(MNFJob*)fetchWithId:(NSNumber*)identifier completion:(MNFSingleNetworthAccountsCompletionHandler)completion{

    NSString *path = [NSString stringWithFormat:@"%@/%@", kMNFNetworthAccounts, identifier];
    
    __block MNFJob *job = [self apiRequestWithPath:path pathQuery:nil jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameNetWorth completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
            if ([response.result isKindOfClass:[NSDictionary class]]) {
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:[self initWithServerResult:response.result] error:nil];
                
            }
            else{
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error:[MNFErrorUtils errorForUnexpectedDataOfType:[response.result class] expected:[NSDictionary class]]];
            }
        }
        else{
            [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error:response.error];
        }
        
    }];
    
    return job;
}

#pragma mark - first entry date

+(MNFJob*)firstEntrydateWithExcludedAccounts:(BOOL)excludedAccounts completion:(MNFSingleNetworthBalanceHistoryCompletionHandler)completion{

    MNFNumberToBoolValueTransformer *transformer = [MNFNumberToBoolValueTransformer transformer];
    
    NSDictionary *queryDict = @{@"excludeAccountsExcludedFromNetWorth":[transformer reverseTransformedValue:@(excludedAccounts)]};
    

    __block MNFJob *job = [self apiRequestWithPath:kMNFNetworthFirstEntryDate pathQuery:queryDict jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameNetWorth completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
            if ([response.result isKindOfClass:[NSDictionary class]]) {
                
                
                MNFNetworthBalanceHistory *firstHistory = [MNFJsonAdapter objectOfClass:[MNFNetworthBalanceHistory class] jsonDict:response.result option:0 error:nil];
                
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:firstHistory error:nil];
                
            }
            else{
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error:[MNFErrorUtils errorForUnexpectedDataOfType:[response.result class] expected:[NSDictionary class]]];
            }
        }
        else{
            [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error:response.error];
        }
    }];
    
    return job;
}

#pragma mark - networth types

+(MNFJob*)fetchNetworthTypesWithCompletion:(MNFMultipleAccountTypesCompletionHandler)completion{
    

    __block MNFJob *job = [self apiRequestWithPath:kMNFNetworthAccountTypes pathQuery:nil jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameNetWorth completion:^(MNFResponse * _Nullable response) {

        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
            
            if ([response.result isKindOfClass:[NSArray class]]) {
                
                NSArray *returnArray = [MNFJsonAdapter objectsOfClass:[MNFAccountType class] jsonArray:response.result option:kMNFAdapterOptionNoOption error:nil];
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:returnArray error:nil];
            }
            else{
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error:[MNFErrorUtils errorForUnexpectedDataOfType:[response.result class] expected:[NSArray class]]];
            }
            
        }
        else{
            [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error:response.error];
        }
        
    }];
    
    return job;
}

#pragma mark - refreshing
-(MNFJob*)refreshWithCompletion:(MNFErrorOnlyCompletionHandler)completion {
    [completion copy];
    
    NSString *path = [NSString stringWithFormat:@"%@/%@", kMNFNetworthAccounts, [self.identifier stringValue]];
    
    __block MNFJob *job = [[self class] apiRequestWithPath:path pathQuery:nil jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameNetWorth completion:^(MNFResponse*  _Nullable response) {
        
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

#pragma mark - saving

-(MNFJob*)saveWithCompletion:(MNFErrorOnlyCompletionHandler)completion{
    
    if (![self.isManual boolValue]) {
        MNFJob *manualJob;
        [MNFObject executeOnMainThreadWithJob:manualJob completion:completion error:[MNFErrorUtils errorWithCode:kMNFErrorInvalidOperation message:@"Only manually created networth accounts can be updated"]];
        return manualJob;
    }

    NSString *path = [NSString stringWithFormat:@"%@/%@", kMNFNetworthAccounts, self.accountId];
    
    NSData *jsonBody = [MNFJsonAdapter JSONDataFromDictionary:@{@"isExcluded":self.isExcluded, @"accountName":self.accountName}];
    
    __block MNFJob *job = [self updateWithApiPath:path pathQuery:nil jsonBody:jsonBody httpMethod:kMNFHTTPMethodPUT service:MNFServiceNameNetWorth completion:^(MNFResponse * _Nullable response) {
        kObjectBlockDataDebugLog;
        [MNFObject executeOnMainThreadWithJob:job completion:completion error:response.error];
    }];
    
    return job;
}

#pragma mark - creating

+(MNFJob*)createWithInitialBalance:(NSNumber *)initialBalance balance:(NSNumber *)balance accountIdentifier:(NSString *)accountIdentifier displayName:(NSString *)displayName networthType:(NSString *)networthType initialBalanceDate:(NSDate *)initialBalanceDate completion:(MNFSingleNetworthAccountsCompletionHandler)completion{

    [completion copy];
    
    NSData *jsonData = [MNFJsonAdapter JSONDataFromDictionary:@{@"initialBalance": initialBalance, @"balance": balance, @"accountIdentifier": accountIdentifier, @"displayName": displayName, @"netWorthType": networthType, @"initialBalanceDate": [[NSDateUtils dateFormatter] stringFromDate:initialBalanceDate]}];
    
    __block MNFJob *job = [self apiRequestWithPath:kMNFNetworthAccounts pathQuery:nil jsonBody:jsonData HTTPMethod:kMNFHTTPMethodPOST service:MNFServiceNameNetWorth completion:^(MNFResponse * _Nullable response) {

        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
            
            if ([response.result isKindOfClass:[NSDictionary class]]) {
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:[self initWithServerResult:response.result] error:response.error];
                
            }
            else{
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error:[MNFErrorUtils errorForUnexpectedDataOfType:[response.result class] expected:[NSArray class]]];
            }
            
        }
        else{
            [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error:response.error];
        }
        
    }];
    
    return job;
}

#pragma mark - deleting

-(MNFJob*)deleteAccountWithCompletion:(MNFErrorOnlyCompletionHandler)completion{
    
    if (![self.isManual boolValue]) {
        MNFJob *errorJob = [MNFJob jobWithError:[MNFErrorUtils errorWithCode:kMNFErrorInvalidOperation message:@"Only manually created networth accounts can be deleted"]];
        [MNFObject executeOnMainThreadWithCompletion:completion withParameter:[MNFErrorUtils errorWithCode:kMNFErrorInvalidOperation message:@"Only manually created networth accounts can be deleted"]];
        return errorJob;
    }
    
    NSString *path = [NSString stringWithFormat:@"%@/%@", kMNFNetworthAccounts, self.accountId];
    
    __block MNFJob *job = [self deleteWithApiPath:path pathQuery:nil jsonBody:nil service:MNFServiceNameNetWorth completion:^(MNFResponse * _Nullable response) {
        kObjectBlockDataDebugLog;
        [MNFObject executeOnMainThreadWithJob:job completion:completion error:response.error];
    }];
    
    return job;
}

#pragma mark - add balance history

-(MNFJob*)addBalanceHistory:(MNFNetworthBalanceHistory*)balanceHistory completion:(MNFErrorOnlyCompletionHandler)completion{
    
    NSString *path = [NSString stringWithFormat:@"%@/%@%@", kMNFNetworthAccounts, self.accountId, kMNFNetworthBalanceHistoryExtension];
    
    NSLog(@"path is: %@", path);
    
    NSData *jsonBody = [MNFJsonAdapter JSONDataFromObject:balanceHistory option:kMNFAdapterOptionNoOption error:nil];
    
    __block MNFJob *job = [self updateWithApiPath:path pathQuery:nil jsonBody:jsonBody httpMethod:kMNFHTTPMethodPOST service:MNFServiceNameNetWorth completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
            if ([response.result isKindOfClass:[NSDictionary class]]) {
                [MNFJsonAdapter refreshObject:balanceHistory withJsonDict:response.result option:kMNFAdapterOptionNoOption error:nil];
            }
            else {
                [MNFObject executeOnMainThreadWithJob:job completion:completion error:[MNFErrorUtils errorForUnexpectedDataOfType:[response.result class] expected:[NSDictionary class]]];
                return;
            }
            
            if ([self.history filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"identifier == %@", balanceHistory.identifier]].count == 0) {
                _history = [self.history arrayByAddingObject:balanceHistory];
            }
            
        }
        [MNFObject executeOnMainThreadWithJob:job completion:completion error:response.error];
        
    }];
    
    return job;
}

#pragma mark - Description
-(NSString*)description {
    return [NSString stringWithFormat:@"Networth account %@ accountId: %@, realmAccountTypeId: %@, accountName: %@, isImport: %@, isManual: %@, isExcluded: %@, netWorthType: %@, currentBalance: %@, history: %@, accountType: %@",[super description],self.accountId,self.accountTypeId,self.accountName,self.isImport,self.isManual,self.isExcluded,self.netWorthType,self.currentBalance,self.history,self.accountType];
}

#pragma mark - json delegate

-(NSDictionary <NSString *, MNFJsonAdapterSubclassedProperty *> *)subclassedProperties{

    return @{
             @"history": [MNFJsonAdapterSubclassedProperty subclassedPropertyWithClass: [MNFNetworthBalanceHistory class] option:kMNFAdapterOptionNoOption],
             @"accountType": [MNFJsonAdapterSubclassedProperty subclassedPropertyWithClass: [MNFAccountType class] option:kMNFAdapterOptionNoOption],
             @"accountTypeCategory":[MNFJsonAdapterSubclassedProperty subclassedPropertyWithClass:[MNFAccountCategory class] option:kMNFAdapterOptionNoOption]
             };
}

-(NSSet *)propertiesToIgnoreJsonDeserialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

-(NSSet *)propertiesToIgnoreJsonSerialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

@end
