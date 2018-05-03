//
//  MNFTransactionSeries.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 22/01/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFTransactionSeries.h"
#import "MNFInternalImports.h"
#import "MNFTransaction.h"
#import "MNFTransactionSeriesStatistics.h"
#import "MNFTransactionSeriesValue.h"
#import "MNFTransactionSeriesFilter.h"
#import "MNFComment.h"
#import "MNFComment_Private.h"
#import "MNFAccount.h"
#import "MNFMerchant.h"

@implementation MNFTransactionSeries

+(MNFJob *)fetchTransactionSeriesWithTransactionSeriesFilter:(MNFTransactionSeriesFilter *)seriesFilter withCompletion:(MNFTransactionSeriesCompletionHandler)completion {
    
    [completion copy];
    
    NSDictionary *transactionSeriesFilter = [MNFJsonAdapter JSONDictFromObject:seriesFilter option:kMNFAdapterOptionNoOption error:nil];
    
    NSString *path = [NSString stringWithFormat:@"%@/series",kMNFApiPathTransactions];
    
    NSMutableArray *modifiedSeriesSelector = [NSMutableArray array];
    
    for (MNFTransactionFilter *filter in seriesFilter.seriesSelectors) {
    
        NSDictionary *dict = @{@"filter":[MNFJsonAdapter JSONDictFromObject:filter option:kMNFAdapterOptionNoOption error:nil]};
        [modifiedSeriesSelector addObject:dict];
    
    }
    
    NSMutableDictionary *optionsDict = [NSMutableDictionary dictionary];
    optionsDict[@"timeResolution"] = transactionSeriesFilter[@"timeResolution"];
    optionsDict[@"overTime"] = transactionSeriesFilter[@"overTime"];
    optionsDict[@"includeTransactions"] = transactionSeriesFilter[@"includeTransactions"];
    optionsDict[@"includeTransactionIds"] = transactionSeriesFilter[@"includeTransactionIds"];
    
    NSDictionary *jsonDict = @{@"transactionFilter":[MNFJsonAdapter JSONDictFromObject:seriesFilter.transactionFilter==nil?[MNFTransactionFilter new]:seriesFilter.transactionFilter option:kMNFAdapterOptionNoOption error:nil],
                               @"options":[optionsDict copy],
                               @"seriesSelectors":[modifiedSeriesSelector copy]};
    
    NSData *jsonData = [MNFJsonAdapter JSONDataFromDictionary:jsonDict];
    
    __block MNFJob *job = [self apiRequestWithPath:path pathQuery:nil jsonBody:jsonData HTTPMethod:kMNFHTTPMethodPOST service:MNFServiceNameTransactions completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
            
            if ([response.result isKindOfClass:[NSArray class]]) {
        
                NSArray *transactionSeries = [self initWithServerResults:response.result];
                
                NSArray<MNFMerchant*> *includedMerchants;
                NSArray<MNFAccount*> *includedAccounts;
                
                if ([[response.includedObjects objectForKey:@"merchants"] isKindOfClass:[NSArray class]]) {
                    includedMerchants = [MNFJsonAdapter  objectsOfClass:[MNFMerchant class] jsonArray:[response.includedObjects objectForKey:@"merchants"] option:0 error:nil];
                }
                
                if ([[response.includedObjects objectForKey:@"accounts"] isKindOfClass:[NSArray class]]) {
                    includedAccounts = [MNFJsonAdapter  objectsOfClass:[MNFAccount class] jsonArray:[response.includedObjects objectForKey:@"accounts"] option:0 error:nil];
                }
                
                for (MNFTransactionSeries *series in transactionSeries) {
                    
                    for (MNFTransaction *transaction in series.transactions) {
                        
                        transaction.merchant = [[includedMerchants filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF.identifier == %@", transaction.merchantId]] firstObject];
                        transaction.account = [[includedAccounts filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF.identifier == %@", transaction.accountId]] firstObject];
                        
                        for (MNFComment *comment in transaction.comments) {
                            comment.transactionId = transaction.identifier;
                        }
                    }
                }
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:transactionSeries error:nil];
            
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

#pragma mark - Description 
-(NSString*)description {
    return [NSString stringWithFormat:@"Transaction series %@ timeResolution: %@, statistics: %@, values: %@, transactions: %@, transactionIds: %@",[super description],self.timeResolution,self.statistics,self.values,self.transactions,self.transactionIds];
}

#pragma mark - Json Adapter Delegate

-(NSSet *)propertiesToIgnoreJsonDeserialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

-(NSSet *)propertiesToIgnoreJsonSerialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

-(NSDictionary*)subclassedProperties {
    return @{
             @"transactions": [MNFJsonAdapterSubclassedProperty subclassedPropertyWithClass: [MNFTransaction class] option: kMNFAdapterOptionNoOption],
             @"statistics": [MNFJsonAdapterSubclassedProperty subclassedPropertyWithClass:[MNFTransactionSeriesStatistics class] option:kMNFAdapterOptionNoOption],
             @"values": [MNFJsonAdapterSubclassedProperty subclassedPropertyWithClass:[MNFTransactionSeriesValue class] option:kMNFAdapterOptionNoOption]
             };
}

@end
