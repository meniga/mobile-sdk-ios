//
//  MNFTransactionGroup.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 14/12/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFTransactionGroup.h"
#import "MNFTransaction.h"

@interface MNFTransactionGroup ()

@property (nonatomic, copy, readwrite) NSArray *transactions;
@property (nonatomic, strong, readwrite) NSNumber *sum;
@property (nonatomic, readwrite) MNFGroupedBy groupedBy;
@property (nonatomic, strong, readwrite) id groupId;

@end

@implementation MNFTransactionGroup

+ (instancetype)groupBy:(MNFGroupedBy)groupedBy WithTransactions:(NSArray *)transactions {
    MNFTransactionGroup *transactionGroup = [[MNFTransactionGroup alloc] init];
    transactionGroup.transactions = transactions;
    transactionGroup.sum = [transactions valueForKeyPath:@"@sum.amount"];
    transactionGroup.groupedBy = groupedBy;
    if ([transactions count] > 0) {
        if (groupedBy == MNFGroupedByCategory) {
            MNFTransaction *transaction = [transactions objectAtIndex:0];
            transactionGroup.groupId = transaction.categoryId;
        } else {
            MNFTransaction *transaction = [transactions objectAtIndex:0];
            transactionGroup.groupId = transaction.date;
        }
    }

    return transactionGroup;
}

#pragma mark - Description
- (NSString *)description {
    return [NSString stringWithFormat:@"Transaction group %@ transactions: %@, sum: %@, groupedBy: %ld, groupId: %@",
                                      [super description],
                                      self.transactions,
                                      self.sum,
                                      (long)self.groupedBy,
                                      self.groupId];
}

#pragma mark - Json Adapter Delegate

- (NSSet *)propertiesToIgnoreJsonDeserialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

- (NSSet *)propertiesToIgnoreJsonSerialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

@end
