//
//  MNFTransactionPage.m
//  Meniga-ios-sdk
//
//  Created by Aske Bendtsen on 24/11/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFTransactionPage.h"
#import "MNFInternalImports.h"
#import "MNFTransaction.h"
#import "MNFTransactionFilter.h"
#import "MNFTransactionGroup.h"
#import "MNFComment.h"
#import "MNFLogger.h"

@interface MNFTransactionPage () <MNFJsonAdapterDelegate>

@property (nonatomic, copy, readwrite)   NSArray *transactions;
@property (nonatomic, strong, readwrite) MNFTransactionFilter *filter;
@property (nonatomic, strong, readwrite) NSNumber *pageNumber;

@end

@implementation MNFTransactionPage {
    MNFGroupedBy _groupRule;
    NSArray *_transactionsGroupedByDate;
    NSArray *_transactionsGroupedByCategory;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _groupRule = MNFGroupedByUngrouped;
    }
    return self;
}

#pragma mark - fetching

+(MNFJob *)fetchWithTransactionFilter:(nonnull MNFTransactionFilter*)filter page:(nullable NSNumber*)page transactionsPerPage:(nullable NSNumber*)transactionsPerPage completion:(nullable MNFTransactionPageCompletionHandler)completion {
    
    [completion copy];
    
    if (page == nil || [page isEqual:@0]) {
        page = @1;
    }
    if (transactionsPerPage == nil) {
        transactionsPerPage = @25;
    }
    
    NSMutableDictionary *filterDict = [[MNFJsonAdapter JSONDictFromObject:filter option:kMNFAdapterOptionNoOption error:nil] mutableCopy];
    
    [filterDict setObject:transactionsPerPage forKey:@"take"];
    NSNumber *skip = [NSNumber numberWithInt:[transactionsPerPage intValue]*([page intValue]-1)];
    [filterDict setObject:skip forKey:@"skip"];
    
    NSLog(@"Filter dictionary: %@",filterDict);
    
    __block MNFJob *job = [self apiRequestWithPath:kMNFApiPathTransactions pathQuery:[filterDict copy] jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameTransactions completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
        
            if ([response.result isKindOfClass:[NSArray class]]) {
            
                NSArray *transactions = [MNFTransaction initWithServerResults:response.result];
                
                if (transactions == nil) {
                    
                    [self executeOnMainThreadWithJob:job completion:completion parameter:nil error: [MNFErrorUtils errorWithCode:kMNFErrorInvalidResponse message:@"Response is empty"] ];
                    
                    return;
                }
                
                NSDictionary *headerFields = response.allHeaderFields;
                int totalCount = 0;
                int numberOfPages = 0;
                
                if (headerFields != nil) {
                    totalCount = [[headerFields objectForKey:@"X-Total-Count"] intValue];
                    numberOfPages = (totalCount+[transactionsPerPage intValue]-1)/[transactionsPerPage intValue];
                }
                
                NSDictionary *transPageDict = @{@"pageNumber":page,
                                                @"numberOfPages":[NSNumber numberWithInt:numberOfPages],
                                                @"transactions":transactions,
                                                @"numberOfTransactions":[NSNumber numberWithInt:totalCount],
                                                @"transactionsPerPage":transactionsPerPage
                                                };
                
                MNFTransactionPage *transPage = [self initWithServerResult:transPageDict];
                transPage.filter = filter;
                
                [self executeOnMainThreadWithJob:job completion:completion parameter:transPage error:response.error];
                
            }
            else {
                
                [MNFObject executeOnMainThreadWithCompletion:completion withParameters:nil and:[MNFErrorUtils errorForUnexpectedDataOfType:[response.result class] expected:[NSArray class]]];
                
            }
        }
        else {
            
            [self executeOnMainThreadWithJob: job completion: completion parameter: nil error: response.error];
            
        }
        
    }];
    
    
    return job;
}

#pragma mark - changing page

-(MNFJob *)appendNextPageWithCompletion:(MNFErrorOnlyCompletionHandler)completion {
    
    [completion copy];
    
    if (_pageNumber >=_numberOfPages) {
        
        NSError *error = [MNFErrorUtils errorWithCode:kMNFErrorInvalidOperation message:@"Cannot append next page. The transaction page is on last page."];
        [MNFObject executeOnMainThreadWithCompletion:completion withParameter: error];
        
        return [MNFJob jobWithError: error];
    }
    
    NSMutableDictionary *filterDict = [[MNFJsonAdapter JSONDictFromObject:self.filter option:kMNFAdapterOptionNoOption error:nil] mutableCopy];
    [filterDict setObject:self.transactionsPerPage forKey:@"take"];
    NSNumber *skip = [NSNumber numberWithInt:[self.transactionsPerPage intValue]*[self.pageNumber intValue]];
    [filterDict setObject:skip forKey:@"skip"];
    
    __block MNFJob *job = [[self class] apiRequestWithPath:kMNFApiPathTransactions pathQuery:[filterDict copy] jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameTransactions completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
        
            if ([response.result isKindOfClass:[NSArray class]]) {
            
                
                NSArray *transactions = [MNFTransaction initWithServerResults:response.result];
                
                self.transactions = [self.transactions arrayByAddingObjectsFromArray:transactions];
                self.pageNumber = [NSNumber numberWithInt:[_pageNumber intValue]+1];
                
                
            }
            else {
                
                [MNFObject executeOnMainThreadWithJob:job completion:completion error: [MNFErrorUtils errorForUnexpectedDataOfType:[response.result class] expected:[NSArray class]] ];
                
                return;
                
            }
        }
        
        [MNFObject executeOnMainThreadWithJob:job completion:completion error:response.error];
        
    }];
    
    return job;
}

-(MNFJob *)nextPageWithCompletion:(MNFErrorOnlyCompletionHandler)completion {
    
    if (_pageNumber >= _numberOfPages) {
        
        NSError *error = [MNFErrorUtils errorWithCode:kMNFErrorInvalidOperation message:@"Cannot fetch next page. The transaction page is on last page."];
        [MNFObject executeOnMainThreadWithCompletion:completion withParameter:error];
        
        return [MNFJob jobWithError:error];
    }
    
    NSMutableDictionary *filterDict = [[MNFJsonAdapter JSONDictFromObject:self.filter option:kMNFAdapterOptionNoOption error:nil] mutableCopy];
    [filterDict setObject:self.transactionsPerPage forKey:@"take"];
    NSNumber *skip = [NSNumber numberWithInt:[self.transactionsPerPage intValue]*[self.pageNumber intValue]];
    [filterDict setObject:skip forKey:@"skip"];
    
    __block MNFJob *job = [[self class] apiRequestWithPath:kMNFApiPathTransactions pathQuery:[filterDict copy] jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameTransactions completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
        
            if ([response.result isKindOfClass:[NSArray class]]) {
            
                NSArray *transactions = [MNFTransaction initWithServerResults:response.result];
                
                _pageNumber = @([self.pageNumber intValue]+1);
                _transactions = transactions;
                
                
            }
            else {
                
                [MNFObject executeOnMainThreadWithJob:job completion:completion error: [MNFErrorUtils errorForUnexpectedDataOfType:[response.result class] expected:[NSArray class]] ];
                
                return;
                
            }
        }
        
        [MNFObject executeOnMainThreadWithJob:job completion:completion error:response.error];
        
    }];
    
    return job;
}

#pragma mark - refreshing

-(void)refreshTransactionListWithError:(NSError **)error{
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO];
    self.transactions = [_transactions sortedArrayUsingDescriptors:@[sortDescriptor]];
    
}

-(MNFJob *)refreshWithCompletion:(MNFErrorOnlyCompletionHandler)completion {
    
    [completion copy];
    
    NSMutableDictionary *filterDict = [[MNFJsonAdapter JSONDictFromObject:self.filter option:kMNFAdapterOptionNoOption error:nil] mutableCopy];
    
    [filterDict setObject:[NSNumber numberWithInt:[self.transactionsPerPage intValue]*[self.pageNumber intValue]] forKey:@"take"];
    
    NSNumber *skip = [NSNumber numberWithInt:[self.transactionsPerPage intValue]*[self.pageNumber intValue]-(int)[self.transactions count]];
    [filterDict setObject:skip forKey:@"skip"];
    
    __block MNFJob *job = [[self class] apiRequestWithPath:kMNFApiPathTransactions pathQuery:[filterDict copy] jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameTransactions completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        if ([response.result isKindOfClass:[NSArray class]]) {
        
            NSArray *transactions = [MNFTransaction initWithServerResults:response.result];
            self.transactions = transactions;
            
        }
        else {
            
            [MNFObject executeOnMainThreadWithJob:job completion:completion error: [MNFErrorUtils errorForUnexpectedDataOfType:[response.result class] expected:[NSArray class]] ];
            
            return;
        }
        
        [MNFObject executeOnMainThreadWithJob:job completion:completion error:response.error];
        
    }];
    
    return job;
}

-(void)groupByCategory {
    
    if (self.transactions == nil || [self.transactions count] == 0) {
        return ;
    }
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"categoryId" ascending:YES];
    NSArray *sortedArray = [self.transactions sortedArrayUsingDescriptors:@[sortDescriptor]];
    
    NSMutableArray *categoryArray = [NSMutableArray array];
    NSMutableArray *groupArray = [NSMutableArray array];
    MNFTransaction *first = [sortedArray objectAtIndex:0];
    NSNumber *categoryId = first.categoryId;
    
    for (MNFTransaction *transaction in sortedArray) {
        
        if([transaction.categoryId isEqualToNumber:categoryId]) {
            
            [categoryArray addObject:transaction];
        
        }
        else {
            
            MNFTransactionGroup *transactionGroup = [MNFTransactionGroup groupBy:MNFGroupedByCategory WithTransactions:[categoryArray copy]];
            [groupArray addObject:transactionGroup];
            [categoryArray removeAllObjects];
            [categoryArray addObject:transaction];
            
            categoryId = transaction.categoryId;
            
        }
        
    }
    
    MNFTransactionGroup *transactionGroup = [MNFTransactionGroup groupBy:MNFGroupedByCategory WithTransactions:[categoryArray copy]];
    [groupArray addObject:transactionGroup];
    
    _transactionsGroupedByCategory = groupArray;
}

-(NSArray <MNFTransactionGroup *> *)transactionsGroupedByCategory {
    
    if (_transactionsGroupedByCategory == nil && self.transactions.count != 0) {
        [self groupByCategory];
    }
    
    return _transactionsGroupedByCategory;
}

-(void)groupByDate {
    
    if (self.transactions == nil || [self.transactions count] == 0) {
        return ;
    }
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
    NSArray *sortedArray = [self.transactions sortedArrayUsingDescriptors:@[sortDescriptor]];
    
    NSMutableArray *dateArray = [NSMutableArray array];
    NSMutableArray *groupArray = [NSMutableArray array];
    MNFTransaction *first = [sortedArray objectAtIndex:0];
    NSDate *date = first.date;
    
    for (MNFTransaction *transaction in sortedArray) {
        
        // these are the components to be compared otherwise it will compare them all with
        // second and millisecond accuracy.
        
        if([NSDateUtils isDate:transaction.date equalToDayMonthAndYear:date] == YES) {
            
            [dateArray addObject:transaction];
        
        }
        else {
            
            MNFTransactionGroup *transactionGroup = [MNFTransactionGroup groupBy:MNFGroupedByDate WithTransactions:[dateArray copy]];
            [groupArray addObject:transactionGroup];
            
            [dateArray removeAllObjects];
            [dateArray addObject:transaction];
            
            date = transaction.date;
        }
    }
    
    MNFTransactionGroup *transactionGroup = [MNFTransactionGroup groupBy:MNFGroupedByDate WithTransactions:[dateArray copy]];
    [groupArray addObject:transactionGroup];
    
    _transactionsGroupedByDate = groupArray;
}


-(NSArray <MNFTransactionGroup *> *)transactionsGroupedByDate {
    
    [self groupByDate];
    
    return _transactionsGroupedByDate;
}

-(NSNumber*)sumOfTransactions {
    double sum = 0.0;
    
    if (_groupRule == MNFGroupedByUngrouped) {
        for (MNFTransaction *transaction in _transactions) {
            sum += [transaction.amount doubleValue];
        }
    }
    else {
        for (MNFTransactionGroup *group in _transactions) {
            sum += [group.sum doubleValue];
        }
    }
    
    return @(sum);
}

#pragma mark - Description
-(NSString*)description {
    
    return [NSString stringWithFormat:@"Transaction page %@ pageNumer: %@, numberOfPages: %@, transactions: %@, numberOfTransactions: %@, sumOfTransactions: %@, transactionsPerPage: %@",[super description],self.pageNumber,self.numberOfPages,self.transactions,self.numberOfTransactions,self.sumOfTransactions,self.transactionsPerPage];
}

#pragma mark - Json Adapter Delegate

-(NSSet *)propertiesToIgnoreJsonDeserialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

-(NSSet *)propertiesToIgnoreJsonSerialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

@end
