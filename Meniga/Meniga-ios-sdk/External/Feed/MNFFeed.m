//
//  MNFFeed.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 11/11/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFFeed.h"
#import "MNFInternalImports.h"
#import "MNFFeedItem.h"
#import "MNFFeedItem_Private.h"
#import "MNFFeedItemGroup.h"
#import "MNFUserEvent.h"
#import "MNFScheduledEvent.h"
#import "MNFObject_Private.h"
#import "MNFConstants.h"

@interface MNFFeed () <MNFJsonAdapterDelegate>
@property (nonatomic,strong,readwrite) NSArray *feedItems;
@property (nonatomic,readwrite) BOOL hasMoreData;
@property (nonatomic,strong,readwrite) NSDate *from;
@property (nonatomic,strong,readwrite) NSDate *to;
@property (nonatomic,strong,readwrite) NSDate *actualEndDate;
@property (nonatomic,readwrite) BOOL hasMorePages;
@property (nonatomic, strong, readwrite) NSNumber *skip;
@property (nonatomic, strong, readwrite) NSNumber *take;
@end

@implementation MNFFeed {
    MNFGroupedBy _groupRule;
}

+(MNFJob *)fetchFromDate:(NSDate *)from toDate:(NSDate *)to skip:(NSNumber *)skip take:(NSNumber *)take withCompletion:(MNFFeedCompletionHandler)completion {
    [completion copy];
    
    MNFBasicDateValueTransformer *transformer = [MNFBasicDateValueTransformer transformer];
    
    NSMutableDictionary *jsonQuery = [NSMutableDictionary dictionary];
    [jsonQuery setObject:[transformer reverseTransformedValue:from] forKey:@"dateFrom"];
    [jsonQuery setObject:[transformer reverseTransformedValue:to] forKey:@"dateTo"];
    
    if (skip != nil) {
        [jsonQuery setObject:skip forKey:@"skip"];
    }
    if (take != nil) {
        [jsonQuery setObject:take forKey:@"take"];
    }
    
    NSLog(@"json query: %@", jsonQuery);
    
    __block MNFJob *job = [self apiRequestWithPath:kMNFApiPathFeed pathQuery:[jsonQuery copy] jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameFeed completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
            
            
            if ([response.result isKindOfClass:[NSArray class]]) {
                
                NSMutableArray *array = [NSMutableArray array];
                
                for (NSDictionary *dict in response.result) {
                
                    MNFFeedItem *feedItem = [MNFFeedItem initWithServerResult:dict];
                    
                    if ( [feedItem.typeName isEqualToString:@"TransactionFeedItemModel"] == YES) {
                    
                        MNFTransaction *transaction = [MNFTransaction initWithServerResult:dict];
                        feedItem.model = transaction;
                    
                    }
                    else if ( [feedItem.typeName isEqualToString:@"UserEventFeedItemModel"] == YES) {
                    
                        MNFUserEvent *userEvent = [MNFUserEvent initWithServerResult:dict];
                        feedItem.model = userEvent;
                    
                    }
                    else if ([feedItem.typeName isEqualToString:@"ScheduledFeedItemModel"] == YES) {
                        
                        MNFScheduledEvent *scheduledEvent = [MNFScheduledEvent initWithServerResult:dict];
                        feedItem.model = scheduledEvent;
                        
                    }
                    
                    [array addObject:feedItem];
                
                }
                
                MNFFeed *feed = [[MNFFeed alloc] initNeutral];
                feed.from = from;
                feed.to = to;
                feed.feedItems = [array copy];
                feed.take = take;
                feed.skip = skip;

                [self p_updateMetaDataInFeed:feed withResponse:response];
                
                
//                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:feed error:response.error ];
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:feed metaData:response.metaData error:response.error];
            }
            else {
                
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error: [MNFErrorUtils errorForUnexpectedDataOfType:[response.result class] expected:[NSArray class]] ];
            
            }
        
        }
        else {
            [MNFObject executeOnMainThreadWithJob:job completion:completion parameter: nil error: response.error ];
        }
    }];
    
    return job;
}

-(MNFJob *)appendDays:(NSNumber *)days withCompletion:(MNFFeedItemsCompletionHandler)completion {
    [completion copy];
    
    NSDate *toDate = self.from;
    NSDate *fromDate = [NSDate dateWithTimeInterval:-24*60*60*[days intValue] sinceDate:self.from];
    
    MNFBasicDateValueTransformer *transformer = [MNFBasicDateValueTransformer transformer];
    NSDictionary *jsonQuery = @{@"dateFrom":[transformer reverseTransformedValue:fromDate],@"dateTo":[transformer reverseTransformedValue:toDate]};
    
    __block MNFJob *job = [[self class] apiRequestWithPath:kMNFApiPathFeed pathQuery:jsonQuery jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameFeed completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
        
            if ([response.result isKindOfClass:[NSArray class]]) {
            
                NSMutableArray *newItems = [NSMutableArray array];
                
                for (NSDictionary *dict in response.result) {
                
                    MNFFeedItem *feedItem = [MNFFeedItem initWithServerResult:dict];
                    
                    if ([feedItem.typeName isEqualToString:@"TransactionFeedItemModel"] == YES) {
                    
                        MNFTransaction *transaction = [MNFTransaction initWithServerResult:dict];
                        feedItem.model = transaction;
                    
                    }
                    else if ([feedItem.typeName isEqualToString:@"UserEventFeedItemModel"] == YES) {
                    
                        MNFUserEvent *userEvent = [MNFUserEvent initWithServerResult:dict];
                        feedItem.model = userEvent;
                    
                    }
                    else if([feedItem.typeName isEqualToString:@"ScheduledFeedItemModel"] == YES) {
                        
                        MNFScheduledEvent *scheduledEvent = [MNFScheduledEvent initWithServerResult:dict];
                        feedItem.model = scheduledEvent;
                        
                    }
                    
                    [newItems addObject:feedItem];
                
                }
                
                [self updateFromDateWithNewDate: fromDate];
                NSArray <MNFFeedItem *> *uniqueItems = [self appendObjects:newItems toDate: toDate fromDate: fromDate];
                
                [[self class] p_updateMetaDataInFeed:self withResponse:response];
                
                [MNFObject executeOnMainThreadWithJob: job completion: completion parameter: uniqueItems error: nil];
            
            }
            else {
                
                [MNFObject executeOnMainThreadWithJob: job completion: completion parameter: nil error: [MNFErrorUtils errorForUnexpectedDataOfType:[response.result class] expected:[NSArray class]] ];
                
            }
        
        }
        else {
         
            [MNFObject executeOnMainThreadWithJob: job completion: completion parameter: nil error: response.error];
        
        }
    }];
    
    return job;
}

#pragma mark - pagination

-(MNFJob*)appendPageWithCompletion:(MNFFeedItemsCompletionHandler)completion{
    
    if ([_take integerValue] == 0) {
        MNFJob *job = [MNFJob new];
        [MNFObject executeOnMainThreadWithJob:job completion: completion parameter: nil error: [MNFErrorUtils errorWithCode:kMNFErrorInvalidOperation message:@"Cannot append page without 'take' specified to greater than zero."]];
    }
    
    if (!self.hasMorePages) {
        MNFJob *job = [MNFJob new];
        [MNFObject executeOnMainThreadWithJob:job completion: completion parameter: nil error: [MNFErrorUtils errorWithCode:kMNFErrorInvalidOperation message:@"No more pages in feed for current time range. Request cancelled"]];
    }
    
    __block MNFJob *job = [MNFJob jobWithRequest:nil];
    
    [[self class] fetchFromDate:_from toDate:_to skip:@([_skip integerValue]+[_take integerValue]) take:_take withCompletion:^(MNFFeed * _Nullable feed, NSError * _Nullable error) {
        
        if (error == nil) {
            
            NSArray *newItems = [self appendObjects: feed.feedItems toDate: _to fromDate: _from];
            
            self.skip = @([_skip integerValue]+[_take integerValue]);
            
            [MNFObject executeOnMainThreadWithJob: job completion: completion parameter: newItems error: nil];
            
        }
        else{
            [job setError:error];
            [MNFObject executeOnMainThreadWithJob:job completion:completion parameter: nil error:error];
        }
        
        
    }];
    
    return job;

}

-(MNFJob*)nextPageWithCompletion:(void (^)(NSError *))completion{

    if ([_take integerValue] == 0) {
        MNFJob *job = [MNFJob new];
        [MNFObject executeOnMainThreadWithJob:job completion: completion error: [MNFErrorUtils errorWithCode:kMNFErrorInvalidOperation message:@"Cannot append page without 'take' specified to greater than zero."]];
    }
    
    if (!self.hasMorePages) {
        MNFJob *job = [MNFJob new];
        [MNFObject executeOnMainThreadWithJob:job completion: completion error: [MNFErrorUtils errorWithCode:kMNFErrorInvalidOperation message:@"No more pages in feed for current time range. Request cancelled"]];
    }
    
    __block MNFJob *job = [MNFJob jobWithRequest:nil];
    
    [[self class] fetchFromDate:_from toDate:_to skip:@([_skip integerValue]+[_take integerValue]) take:_take withCompletion:^(MNFFeed * _Nullable feed, NSError * _Nullable error) {
        
        if (error == nil) {
            
            self.feedItems = feed.feedItems;
            self.skip = @([_skip integerValue]+[_take integerValue]);
            
        }
        else{
            completion(error);
        }
        
        [job setError:error];
        [MNFObject executeOnMainThreadWithJob:job completion:completion error:error];
        
    }];
    
    return job;
}

-(MNFJob*)prevPageWithCompletion:(void (^)(NSError *))completion{

    if ([_take integerValue] == 0) {
        MNFJob *job = [MNFJob new];
        [MNFObject executeOnMainThreadWithJob:job completion: completion error: [MNFErrorUtils errorWithCode:kMNFErrorInvalidOperation message:@"Cannot prepend page without 'take' specified to greater than zero."]];
    }
    
    if (!self.hasMorePages) {
        MNFJob *job = [MNFJob new];
        [MNFObject executeOnMainThreadWithJob:job completion: completion error: [MNFErrorUtils errorWithCode:kMNFErrorInvalidOperation message:@"No more pages in feed for current time range. Request cancelled."]];
    }
    
    if ([_skip integerValue] == 0 || [_skip integerValue]<[_take integerValue]) {
        MNFJob *job = [MNFJob new];
        [MNFObject executeOnMainThreadWithJob:job completion: completion error: [MNFErrorUtils errorWithCode:kMNFErrorInvalidOperation message:@"No more previous pages within time range."]];
    }
    
    __block MNFJob *job = [MNFJob jobWithRequest:nil];
    
    [[self class] fetchFromDate:_from toDate:_to skip:@([_skip integerValue]-[_take integerValue]) take:_take withCompletion:^(MNFFeed * _Nullable feed, NSError * _Nullable error) {
        
        if (error == nil) {
            
            self.feedItems = feed.feedItems;
            self.skip = @([_skip integerValue]-[_take integerValue]);
            
        }
        else{
            completion(error);
        }
        
        [job setError:error];
        [MNFObject executeOnMainThreadWithJob:job completion:completion error:error];
        
    }];
    
    return job;
}

-(MNFJob*)refreshFromServerFromDate:(NSDate *)from toDate:(NSDate *)to withCompletion:(nullable void (^)(NSArray <MNFFeedItem *> *newItems, NSArray <MNFFeedItem *> *itemsToReplace, NSError *error))completion {
    [completion copy];
    
    __block MNFJob *job = [MNFJob jobWithRequest:nil];
    [[self class] fetchFromDate:from toDate:to skip:nil take:nil withCompletion:^(MNFFeed *feed, NSError *error) {
        
        if (error == nil) {
            
            NSArray <MNFFeedItem *> *itemsToReplace = [self filterFeedItems: self.feedItems fromDate: from toDate: to];
            NSArray <MNFFeedItem *> *newItems = [self refreshObjects: feed.feedItems itemsToReplace: itemsToReplace toDate: to fromDate: from];
            itemsToReplace = [self feedItemsToDisplay: itemsToReplace];
            newItems = [self feedItemsToDisplay: newItems];
            
            [self updateFromDateWithNewDate: from];
            [self updateToDateWithNewDate: to];
            
            [job setResult: @[newItems, itemsToReplace] metaData:nil error:error];
            [MNFObject executeOnMainThreadWithCompletion: completion withParameters: newItems andSecondParam: itemsToReplace andThirdParam: error];
            
        }
        else {
            
            [job setResult: @[] metaData:nil error:error];
            [MNFObject executeOnMainThreadWithCompletion: completion withParameters: nil andSecondParam: nil andThirdParam: error];
        }

    }];
    
    return job;
}

+(MNFJob *)fetchFeedTypesWithCompletion:(MNFFeedTypesCompletionHandler)completion {
    [completion copy];
    
    __block MNFJob *job = [self apiRequestWithPath:kMNFFeedTypes pathQuery:nil jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameFeed completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
            
            if ([response.result isKindOfClass:[NSArray class]]) {
                
                [MNFObject executeOnMainThreadWithJob: job completion: completion parameter: response.result error: nil];
                
            }
            else {
                
                [MNFObject executeOnMainThreadWithJob: job completion: completion parameter: response.result error: [MNFErrorUtils errorForUnexpectedDataOfType:[response.result class] expected:[NSArray class]] ];
                
            }
            
        }
        else {
            
            [MNFObject executeOnMainThreadWithJob: job completion: completion parameter: nil error: response.error];
            
        }
    }];
    
    return job;
}


#pragma mark - Updating Feed Items and dates

-(void)updateToDateWithNewDate:(NSDate *)toDate {
    
    if (self.to == nil) {
        self.to = toDate;
        return ;
    }
    
    NSComparisonResult comparison = [self.to compare: toDate];
    if (comparison == NSOrderedAscending) {
        self.to = toDate;
    }
    
}

-(void)updateFromDateWithNewDate:(NSDate *)fromDate {
    
    if (self.from == nil) {
        self.from = fromDate;
        return ;
    }
    
    NSComparisonResult comparison = [self.from compare: fromDate];
    if (comparison == NSOrderedDescending) {
        self.from = fromDate;
    }
    
}

-(NSArray <MNFFeedItem *> *)refreshObjects:(NSArray <MNFFeedItem *> *)refreshObjects itemsToReplace:(NSArray <MNFFeedItem *> *)itemsToReplace toDate:(NSDate *)toDate fromDate:(NSDate *)fromDate {
    
    NSMutableArray <MNFFeedItem *> *currentFeedItems = [self.feedItems mutableCopy];
    
    [currentFeedItems removeObjectsInArray: itemsToReplace];
    [currentFeedItems addObjectsFromArray: refreshObjects];
    
    self.feedItems = currentFeedItems;
    
    return refreshObjects;
}

/**
 @description Removes all duplicates and then returns only the new items from the append and appends all of the new items to the feedItems.
 */
-(NSArray <MNFFeedItem *> *)appendObjects:(NSArray <MNFFeedItem *> *)appendObjects toDate:(NSDate *)toDate fromDate:(NSDate *)fromDate {
    
    
    NSMutableArray *currentFeedItems = [self.feedItems mutableCopy];
    NSArray <MNFFeedItem *> *itemsInSamePeriod = [self filterFeedItems: currentFeedItems fromDate: fromDate toDate: toDate];
    
    NSArray *newItems = [self removeFeedItems: itemsInSamePeriod fromFeedItems: appendObjects];
    [currentFeedItems addObjectsFromArray: newItems];
    
    self.feedItems = [currentFeedItems copy];
    
    return newItems;
    
}

-(NSArray *)removeFeedItems:(NSArray <MNFFeedItem *> *)itemsToRemove fromFeedItems:(NSArray <MNFFeedItem *> *)feedItems {
    
    NSMutableArray *array = [NSMutableArray arrayWithArray: feedItems];
    
    for (MNFFeedItem *currentItemToRemove in itemsToRemove) {
        
        for (MNFFeedItem *currentFeedItem in feedItems) {
            
            if ([currentItemToRemove.model isKindOfClass:[MNFObject class]] == YES && [currentFeedItem.model isKindOfClass:[MNFObject class]] == YES) {
                
                if ([[(MNFObject *)currentItemToRemove.model identifier] isEqualToNumber: [(MNFObject *)currentFeedItem.model identifier]] == YES) {
                    [array removeObject: currentFeedItem];
                    break;
                }
                
            }
            
        }
        
    }
    
    return array;
}

-(NSArray <MNFFeedItem *> *)filterFeedItems:(NSArray<MNFFeedItem *> *)feedItems fromDate:(NSDate *)fromDate toDate:(NSDate *)toDate {
    
    NSMutableArray *filteredFeedItems = [NSMutableArray array];
    
    for (MNFFeedItem *feedItem in feedItems) {
        
        if ([self p_isItem: feedItem equalOrLaterThanFromDate: fromDate] == YES && [self p_isItem: feedItem earlierThanToDate: toDate] == YES) {
            [filteredFeedItems addObject: feedItem];
        }
        
    }
    
    return filteredFeedItems;
}


#pragma mark - Getters 

-(NSArray <MNFFeedItem *> *)feedItems {
    
    if (self.topicNamesToDisplay != nil) {
        
        return [self feedItemsToDisplay: _feedItems];
        
    }
    
    return _feedItems;
}

-(NSArray <MNFFeedItem *> *)feedItemsToDisplay:(NSArray <MNFFeedItem *> *)feedItems {
    
    if (self.topicNamesToDisplay != nil) {
     
        NSMutableArray <MNFFeedItem *> *array = [NSMutableArray array];
        
        for (MNFFeedItem *currentItem in feedItems) {
            
            if ([self shouldDisplayFeedItem: currentItem topicNamesToDisplay: self.topicNamesToDisplay] == YES) {
                [array addObject: currentItem];
            }
            
        }
        
        return array;
    }
    
    return feedItems;
}

-(BOOL)shouldDisplayFeedItem:(MNFFeedItem *)feedItem topicNamesToDisplay:(NSArray <NSString *> *)topicNames {
    
    for (NSString *currentTopicName in topicNames) {
        
        if ([feedItem.topicName isEqualToString: currentTopicName] == YES) {
            
            return true;
        }
        
    }
    
    return false;
}


#pragma mark - Helper Functions For Filtering feed ITems

-(BOOL)p_isItem:(MNFFeedItem *)feedItem equalOrLaterThanFromDate:(NSDate *)fromDate {
    
    NSComparisonResult comparisonResult = [feedItem.date compare: fromDate];
    if (comparisonResult == NSOrderedSame || comparisonResult == NSOrderedDescending) {
        
        return YES;
    }
    
    return NO;
}

-(BOOL)p_isItem:(MNFFeedItem *)feedItem earlierThanToDate:(NSDate *)toDate {
    
    NSComparisonResult comparisonResult = [feedItem.date compare: toDate];
    if (comparisonResult == NSOrderedAscending) {
        
        return YES;
    }
    
    return NO;
}


#pragma mark - Grouping
//TODO: refactor like transaction page
-(void)groupByDate {
    
    if (self.feedItems == nil || [self.feedItems count] == 0) {
        return;
    }
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
    NSArray *sortedArray = [self.feedItems sortedArrayUsingDescriptors:@[sortDescriptor]];
    
    NSMutableArray *dateArray = [NSMutableArray array];
    NSMutableArray *groupArray = [NSMutableArray array];
    MNFFeedItem *first = [sortedArray objectAtIndex:0];
    NSDate *date = first.date;
    for (MNFFeedItem *feedItem in sortedArray) {
        if ([feedItem.date isEqualToDate:date]) {
            [dateArray addObject:feedItem];
        }
        else {
            MNFFeedItemGroup *feedItemGroup = [MNFFeedItemGroup groupBy:MNFGroupedByDate withFeedItems:[dateArray copy]];
            [groupArray addObject:feedItemGroup];
            [dateArray removeAllObjects];
            [dateArray addObject:feedItem];
            date = feedItem.date;
        }
    }
    MNFFeedItemGroup *feedItemGroup = [MNFFeedItemGroup groupBy:MNFGroupedByDate withFeedItems:[dateArray copy]];
    [groupArray addObject:feedItemGroup];
    self.feedItems = [groupArray copy];
    _groupRule = MNFGroupedByDate;
}

-(void)ungroup {
    
    if (self.feedItems == nil || [self.feedItems count] == 0) {
        return;
    }
    
    NSMutableArray *feedItemArray = [NSMutableArray array];
    
    for (MNFFeedItemGroup *feedItemGroup in self.feedItems) {
        for (MNFFeedItem *feedItem in feedItemGroup.feedItems) {
            [feedItemArray addObject:feedItem];
        }
    }
    
    self.feedItems = [feedItemArray copy];
    _groupRule = MNFGroupedByUngrouped;
}

#pragma mark - helpers

+(void)p_updateMetaDataInFeed:(MNFFeed*)feed withResponse:(MNFResponse*)response{

    if (response.metaData != nil) {
        MNFBasicDateValueTransformer *baseDateFormatte = [MNFBasicDateValueTransformer transformer];
        
        feed.actualEndDate = [baseDateFormatte transformedValue:[response.metaData objectForKey:@"actualEndDate"]];
        feed.hasMorePages = feed.actualEndDate != nil;
        if ([response.metaData objectForKey:@"hasMoreData"] != nil) {
            feed.hasMoreData = [[response.metaData objectForKey:@"hasMoreData"] boolValue];
        }
        
    }

}

@end
