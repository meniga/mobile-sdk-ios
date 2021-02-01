#import "MNFFeedItemsFactory.h"
#import "MNFAccount.h"
#import "MNFComment.h"
#import "MNFComment_Private.h"
#import "MNFFeed.h"
#import "MNFFeedItem.h"
#import "MNFFeedItem_Private.h"
#import "MNFMerchant.h"
#import "MNFObject_Private.h"
#import "MNFOffer.h"
#import "MNFScheduledEvent.h"
#import "MNFUserEvent.h"

@implementation MNFFeedItemsFactory

+ (NSArray *)createFeedItemsWithModelFromResponse:(MNFResponse *)response {
    NSMutableArray *feedItems = [NSMutableArray array];
    for (NSDictionary *result in response.result) {
        MNFFeedItem *feedItem = [MNFFeedItem initWithServerResult:result];
        if ([feedItem.typeName isEqualToString:@"TransactionFeedItemModel"] == YES) {
            feedItem.model = [self createTransactionWithResponse:response andResultDictionary:result];

        } else if ([feedItem.typeName isEqualToString:@"UserEventFeedItemModel"] == YES) {
            MNFUserEvent *userEvent = [MNFUserEvent initWithServerResult:result];
            feedItem.model = userEvent;

        } else if ([feedItem.typeName isEqualToString:@"ScheduledFeedItemModel"] == YES) {
            MNFScheduledEvent *scheduledEvent = [MNFScheduledEvent initWithServerResult:result];
            feedItem.model = scheduledEvent;

        } else if ([feedItem.typeName isEqualToString:@"OfferFeedItem"] == YES) {
            NSMutableDictionary *mutableDict = [result mutableCopy];
            [mutableDict setObject:feedItem.topicId forKey:@"id"];
            MNFOffer *offer = [MNFOffer initWithServerResult:mutableDict];
            feedItem.model = offer;
        }

        [feedItems addObject:feedItem];
    }
    return feedItems;
}

+ (MNFTransaction *)createTransactionWithResponse:(MNFResponse *)response andResultDictionary:(NSDictionary *)result {
    MNFTransaction *transaction = [MNFTransaction initWithServerResult:result];

    NSArray<MNFMerchant *> *includedMerchants;
    NSArray<MNFAccount *> *includedAccounts;

    NSString *merchantsKey = @"merchants";
    NSString *accountsKey = @"accounts";

    if ([[response.includedObjects objectForKey:merchantsKey] isKindOfClass:[NSArray class]]) {
        includedMerchants = [MNFJsonAdapter objectsOfClass:[MNFMerchant class]
                                                 jsonArray:[response.includedObjects objectForKey:merchantsKey]
                                                    option:0
                                                     error:nil];
    }
    if ([[response.includedObjects objectForKey:accountsKey] isKindOfClass:[NSArray class]]) {
        includedAccounts = [MNFJsonAdapter objectsOfClass:[MNFAccount class]
                                                jsonArray:[response.includedObjects objectForKey:accountsKey]
                                                   option:0
                                                    error:nil];
    }

    for (MNFComment *comment in transaction.comments) {
        comment.transactionId = transaction.identifier;
    }
    transaction.merchant = [[includedMerchants
        filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF.identifier == %@", transaction.merchantId]]
        firstObject];
    transaction.account = [[includedAccounts
        filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF.identifier == %@", transaction.accountId]]
        firstObject];

    return transaction;
}

@end
