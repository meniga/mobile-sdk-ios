//
//  MNFFeedItemGroup.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 02/05/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFFeedItemGroup.h"
#import "MNFTransaction.h"

@interface MNFFeedItemGroup ()

@property (nonatomic, copy, readwrite) NSArray<MNFFeedItem *> *_Nullable feedItems;
@property (nonatomic, strong, readwrite) NSNumber *_Nullable sum;
@property (nonatomic, readwrite) MNFGroupedBy groupedBy;
@property (nonatomic, strong, readwrite) NSDate *_Nullable date;

@end

@implementation MNFFeedItemGroup

+ (instancetype)groupBy:(MNFGroupedBy)groupedBy withFeedItems:(NSArray *)feedItems {
    MNFFeedItemGroup *feedItemGroup = [[MNFFeedItemGroup alloc] init];
    feedItemGroup.feedItems = feedItems;
    feedItemGroup.groupedBy = groupedBy;
    if (feedItems.count > 0) {
        if (groupedBy == MNFGroupedByDate) {
            MNFFeedItem *feedItem = [feedItems firstObject];
            feedItemGroup.date = feedItem.date;
        }
    }

    double sum = 0.0;
    for (MNFFeedItem *feedItem in feedItems) {
        if ([feedItem.typeName isEqualToString:@"TransactionFeedItemModel"]) {
            MNFTransaction *transaction = (MNFTransaction *)feedItem.model;
            sum += [transaction.amount doubleValue];
        }
    }
    feedItemGroup.sum = @(sum);

    return feedItemGroup;
}

@end
