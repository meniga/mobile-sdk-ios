//
//  MNFUpcoming.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 30/09/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFUpcoming.h"
#import "MNFUpcomingComment.h"
#import "MNFUpcomingDetails.h"
#import "MNFUpcomingReconcileScore.h"
#import "MNFUpcomingRecurringPattern.h"
#import "MNFInternalImports.h"

@interface MNFUpcoming ()

@property (nonatomic,copy,readwrite) NSArray *comments;

@end

@implementation MNFUpcoming

+(MNFJob*)fetchUpcomingWithId:(NSNumber *)upcomingId completion:(MNFUpcomingCompletionHandler)completion {
    
    NSString *path = [NSString stringWithFormat:@"%@/%@", kMNFApiPathUpcoming, [upcomingId stringValue]];
    
    __block MNFJob *job = [self apiRequestWithPath:path pathQuery:nil jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameAccounts completion:^(MNFResponse*  _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
            if ([response.result isKindOfClass:[NSDictionary class]]) {
                
                MNFUpcoming *account = [MNFUpcoming initWithServerResult:response.result];
                
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:account error:nil];
                
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

+(MNFJob*)fetchUpcomingFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate completion:(MNFMultipleUpcomingCompletionHandler)completion {
    [completion copy];
    
    return [self fetchUpcomingFromDate:fromDate toDate:toDate accountIds:nil includeDetails:YES watchedOnly:NO recurringPatternId:nil paymentStatus:MNFUpcomingPaymentStatusNone completion:completion];
}

+(MNFJob*)fetchUpcomingFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate accountIds:(NSArray<NSNumber *> *)accountIds includeDetails:(BOOL)includeDetails watchedOnly:(BOOL)watchedOnly recurringPatternId:(NSNumber *)recurringPatternId paymentStatus:(MNFUpcomingPaymentStatus)paymentStatus completion:(MNFMultipleUpcomingCompletionHandler)completion {
    [completion copy];
    
    MNFBasicDateValueTransformer *transformer = [MNFBasicDateValueTransformer transformer];
    NSMutableDictionary *jsonQuery = [NSMutableDictionary dictionary];
    jsonQuery[@"dateFrom"] = [transformer reverseTransformedValue:fromDate];
    jsonQuery[@"dateTo"] = [transformer reverseTransformedValue:toDate];
    jsonQuery[@"accountIds"] = accountIds;
    jsonQuery[@"includeDetails"] = includeDetails?@"true":@"false";
    jsonQuery[@"watchedOnly"] = watchedOnly?@"true":@"false";
    jsonQuery[@"recurringPatternId"] = recurringPatternId;
    
    switch (paymentStatus) {
        case MNFUpcomingPaymentStatusOpen:
            [jsonQuery setObject:@"Open" forKey:@"paymentStatus"];
            break;
        case MNFUpcomingPaymentStatusOnHold:
            [jsonQuery setObject:@"OnHold" forKey:@"paymentStatus"];
            break;
        case MNFUpcomingPaymentStatusPaid:
            [jsonQuery setObject:@"Paid" forKey:@"paymentStatus"];
            break;
        default:
            break;
    }
    
    __block MNFJob *job = [MNFObject apiRequestWithPath:kMNFApiPathUpcoming pathQuery:[jsonQuery copy] jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameUpcoming completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
            if ([response.result isKindOfClass:[NSArray class]]) {
                
                NSArray *upcomings = [MNFUpcoming initWithServerResults:response.result];
                
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:upcomings error:nil];
                
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

+(MNFJob*)createUpcomingWithText:(NSString *)text amountInCurrency:(NSNumber *)amountInCurrency currencyCode:(NSString *)currencyCode date:(NSDate *)date accountId:(NSNumber *)accountId categoryId:(NSNumber *)categoryId isFlagged:(NSNumber *)isFlagged isWatched:(NSNumber *)isWatched recurringPattern:(MNFUpcomingRecurringPattern *)recurringPattern completion:(MNFMultipleUpcomingCompletionHandler)completion {
    [completion copy];
    
    MNFBasicDateValueTransformer *transformer = [MNFBasicDateValueTransformer transformer];
    NSMutableDictionary *jsonDict = [NSMutableDictionary dictionary];
    jsonDict[@"text"] = text;
    jsonDict[@"amountInCurrency"] = amountInCurrency;
    jsonDict[@"currencyCode"] = currencyCode;
    jsonDict[@"date"] = [transformer reverseTransformedValue:date];
    jsonDict[@"accountId"] = accountId;
    jsonDict[@"categoryId"] = categoryId;
    if ([isFlagged boolValue]) {
        jsonDict[@"isFlagged"] = @"true";
    }
    else if (isFlagged != nil) {
        jsonDict[@"isFlagged"] = @"false";
    }
    if ([isWatched boolValue]) {
        jsonDict[@"isWatched"] = @"true";
    }
    else if (isWatched != nil) {
        jsonDict[@"isWatched"] = @"false";
    }
    if (recurringPattern != nil) {
        NSDictionary *dictionary = [MNFJsonAdapter JSONDictFromObject:recurringPattern option:kMNFAdapterOptionNoOption error:nil];
        [jsonDict setObject:dictionary forKey:@"recurringPattern"];
    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDict options:0 error:nil];
    
    __block MNFJob *job = [MNFObject apiRequestWithPath:kMNFApiPathUpcoming pathQuery:nil jsonBody:jsonData HTTPMethod:kMNFHTTPMethodPOST service:MNFServiceNameUpcoming completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
            if ([response.result isKindOfClass:[NSArray class]]) {
                
                NSArray *upcomings = [MNFUpcoming initWithServerResults:response.result];
                
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:upcomings error:nil];
                
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
-(MNFJob*)deleteUpcomingWithCompletion:(MNFErrorOnlyCompletionHandler)completion {
    [completion copy];
    
    NSString *path = [NSString stringWithFormat:@"%@/%@", kMNFApiPathUpcoming, [self.identifier stringValue]];
    
    __block MNFJob *job = [self deleteWithApiPath:path pathQuery:nil jsonBody:nil service:MNFServiceNameUpcoming completion:^(MNFResponse * _Nullable response) {
        kObjectBlockDataDebugLog;
        
        [MNFObject executeOnMainThreadWithJob:job completion:completion error: response.error];
    }];
    
    return job;
}

-(MNFJob*)saveAllInSeries:(BOOL)allInSeries withCompletion:(MNFErrorOnlyCompletionHandler)completion {
    [completion copy];
    
    NSString *path = [NSString stringWithFormat:@"%@/%@", kMNFApiPathUpcoming, [self.identifier stringValue]];
    
    NSDictionary *jsonQuery;
    if (self.recurringPattern != nil && allInSeries) {
        jsonQuery = @{@"recurringPatternId":self.recurringPattern.identifier};
    }
    NSDictionary *jsonDict = [MNFJsonAdapter JSONDictFromObject:self option:kMNFAdapterOptionNoOption error:nil];
    if (!allInSeries) {
        NSMutableDictionary *dict = [jsonDict mutableCopy];
        [dict removeObjectForKey:@"recurringPattern"];
        jsonDict = [dict copy];
    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDict options:0 error:nil];
    
    __block MNFJob *job = [self updateWithApiPath:path pathQuery:jsonQuery jsonBody:jsonData httpMethod:kMNFHTTPMethodPUT service:MNFServiceNameUpcoming completion:^(MNFResponse * _Nullable response) {
        kObjectBlockDataDebugLog;
        
        [MNFObject executeOnMainThreadWithJob:job completion:completion error: response.error];
    }];
    
    return nil;
}

-(MNFJob*)postComment:(NSString *)comment withCompletion:(MNFErrorOnlyCompletionHandler)completion {
    [completion copy];
    
    if (self.isDeleted) {
        
        [MNFObject executeOnMainThreadWithCompletion:completion withParameter:[MNFErrorUtils errorForDeletedObject:self]];
        
        return [MNFJob jobWithError: [MNFErrorUtils errorForDeletedObject:self] ];
    }
    
    NSString *path = [NSString stringWithFormat:@"%@/%@/%@",kMNFApiPathUpcoming,[self.identifier stringValue],@"comments"];
    NSDictionary *jsonQuery = @{@"comment":comment};
    
    __block MNFJob *job = [[self class] apiRequestWithPath:path pathQuery:jsonQuery jsonBody:nil HTTPMethod:kMNFHTTPMethodPOST service:MNFServiceNameUpcoming completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
            
            if ([response.result isKindOfClass:[NSDictionary class]]) {
                
                MNFUpcomingComment *comment = [MNFUpcomingComment initWithServerResult:response.result];
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

+(MNFJob*)fetchDefaultAccountIdWithCompletion:(MNFDefaultAccountIdCompletionHandler)completion {
    [completion copy];
    
    __block MNFJob *job = [MNFObject apiRequestWithPath:kMNFUpcomingAccountsDefault pathQuery:nil jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameUpcoming completion:^(MNFResponse * _Nullable response) {
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
            if ([response.result isKindOfClass:[NSDictionary class]]) {
                
                NSNumber *accountId = [response.result objectForKey:@"accountId"];
                
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:accountId error:nil];
                
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

+(MNFJob*)setDefaultAccountId:(NSNumber *)accountId withCompletion:(MNFErrorOnlyCompletionHandler)completion {
    [completion copy];
    
    NSString *path = [NSString stringWithFormat:@"%@/%@",kMNFUpcomingAccountsDefault,[accountId stringValue]];

    __block MNFJob *job = [MNFObject apiRequestWithPath:path pathQuery:nil jsonBody:nil HTTPMethod:kMNFHTTPMethodPOST service:MNFServiceNameUpcoming completion:^(MNFResponse * _Nullable response) {
        kObjectBlockDataDebugLog;
        
        [MNFObject executeOnMainThreadWithJob:job completion:completion error: response.error];
    }];
    
    return job;
}

+(MNFJob*)fetchIncludedAccountIdsWithCompletion:(MNFMultipleAccountIdsCompletionHandler)completion {
    [completion copy];
    
    __block MNFJob *job = [MNFObject apiRequestWithPath:kMNFUpcomingAccountsIncluded pathQuery:nil jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameUpcoming completion:^(MNFResponse * _Nullable response) {
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
            if ([response.result isKindOfClass:[NSArray class]]) {
                NSMutableArray *accountIds = [NSMutableArray array];
                for (NSDictionary *dict in response.result) {
                    NSNumber *number = [dict objectForKey:@"accountId"];
                    [accountIds addObject:number];
                }
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:[accountIds copy] error:nil];
                
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

+(MNFJob*)setIncludedAccountIds:(NSString *)accountIds withCompletion:(MNFErrorOnlyCompletionHandler)completion {
    [completion copy];
    
    NSDictionary *jsonQuery = @{@"accountIds":accountIds};
    __block MNFJob *job = [MNFObject apiRequestWithPath:kMNFUpcomingAccountsIncluded pathQuery:jsonQuery jsonBody:nil HTTPMethod:kMNFHTTPMethodPUT service:MNFServiceNameUpcoming completion:^(MNFResponse * _Nullable response) {
        kObjectBlockDataDebugLog;
        
        [MNFObject executeOnMainThreadWithJob:job completion:completion error: response.error];
    }];
    
    return job;
}

#pragma mark - json adaptor delegate

-(NSDictionary*)jsonKeysMapToProperties{
    return @{@"identifier":@"id"};
}

-(NSDictionary*)propertyValueTransformers {
    
    return @{@"date":[MNFBasicDateValueTransformer transformer]};
}
-(NSSet*)propertiesToIgnoreJsonSerialization {
    return [NSSet setWithArray:@[@"identifier",@"bankReference",@"amount",@"comments",@"invoiceId",@"scheduledPaymentId",@"reconcileScores",@"details",@"objectstate",@"description",@"debugDescription",@"superclass",@"mutableProperties",@"keyValueStore",@"dirty",@"deleted",@"isNew"]];
}

-(NSSet*)propertiesToIgnoreJsonDeserialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

-(NSDictionary*)subclassedProperties {
    return @{
             @"recurringPattern":[MNFJsonAdapterSubclassedProperty subclassedPropertyWithClass:[MNFUpcomingRecurringPattern class] option: kMNFAdapterOptionNoOption],
             @"comments": [MNFJsonAdapterSubclassedProperty subclassedPropertyWithClass: [MNFUpcomingComment class] option: kMNFAdapterOptionNoOption],
             @"reconcileScores": [MNFJsonAdapterSubclassedProperty subclassedPropertyWithClass:[MNFUpcomingReconcileScore class] option:kMNFAdapterOptionNoOption],
             @"details": [MNFJsonAdapterSubclassedProperty subclassedPropertyWithClass:[MNFUpcomingDetails class] option: kMNFAdapterOptionNoOption]
             };
}

@end
