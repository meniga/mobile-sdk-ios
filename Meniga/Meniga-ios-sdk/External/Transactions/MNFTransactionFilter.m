//
//  MNFTransactionFilter.m
//  Meniga-ios-sdk
//
//  Created by Aske Bendtsen on 28/10/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFTransactionFilter.h"
#import "MNFInternalImports.h"

@interface MNFTransactionFilter ()

@end

@implementation MNFTransactionFilter

- (instancetype)init
{
    self = [super init];
    if (self) {
        //Defaults to required fields
        self.ascendingOrder = @NO;
        self.hideExcluded = @NO;
        self.onlyFlagged = @NO;
        self.onlyUncategorized = @NO;
        self.onlyUncertain = @NO;
        self.onlyUnread = @NO;
        self.orderBy = @"ByDate";
        self.uncertainOrFlagged = @NO;
        self.useAbsoluteAmountSearch = @NO;
        self.useAccentInsensitiveSearch = @NO;
        self.useAmountInCurrencySearch = @NO;
        self.useAndSearchForTags = @NO;
        self.useEqualsSearchForBankId = @NO;
        self.useExactDescription = @NO;
        self.useExactMerchantTexts = @NO;
        self.useParentMerchantIds = @NO;
    }
    return self;
}

#pragma mark - Description
-(NSString*)description {
    return [NSString stringWithFormat:@"Transaction filter %@ accountIds: %@, accountIdentifiers: %@, counterpartyAccountIdentifiers: %@, categoryIds: %@, categoryTypes: %@, onlyUnread: %@, onlyFlagged: %@, onlyUncertain: %@, onlyUncategorized: %@, uncertainOrFlagged: %@, hideExcluded: %@, insertedBefore: %@, periodFrom: %@, periodTo: %@, originalPeriodFrom: %@, originalPeriodTo: %@, amountFrom: %@, amountTo: %@, searchText: %@, transactionDescription: %@, currency: %@, comment: %@, tags: %@, orderBy: %@, parsedDataNameToOrderBy: %@, ascendingOrder: %@, useAbsoluteAmountSearch: %@, useAndSearchForTags: %@, useEqualsSearchForBankId: %@, useAmountInCurrencySearch: %@, useExactDescription: %@, useExactMerchantTexts: %@, useAccentInsensitiveSearch: %@, merchantIds: %@, excludeMerchantIds: %@, merchantTexts: %@, parsedData: %@, parsedDataExactKeys: %@, useParentMerchantIds: %@, excludeMerchantTexts: %@, bankIds: %@, ids: %@, fields: %@",[super description],self.accountIds,self.accountIdentifiers,self.counterpartyAccountIdentifiers,self.categoryIds,self.categoryTypes,self.onlyUnread,self.onlyFlagged,self.onlyUncertain,self.onlyUncategorized,self.uncertainOrFlagged,self.hideExcluded,self.insertedBefore,self.periodFrom,self.periodTo,self.originalPeriodFrom,self.originalPeriodTo,self.amountFrom,self.amountTo,self.searchText,self.transactionDescription,self.currency,self.comment,self.tags,self.orderBy,self.parsedDataNameToOrderBy,self.ascendingOrder,self.useAbsoluteAmountSearch,self.useAndSearchForTags,self.useEqualsSearchForBankId,self.useAmountInCurrencySearch,self.useExactDescription,self.useExactMerchantTexts,self.useAccentInsensitiveSearch,self.merchantIds,self.excludeMerchantIds,self.merchantTexts,self.parsedData,self.parsedDataExactKeys,self.useParentMerchantIds,self.excludeMerchantIds,self.bankIds,self.ids,self.fields];
}

#pragma mark - Json Adapter Delegate

-(NSDictionary*)propertyKeysMapToJson{
    return @{@"transactionDescription" : @"description"
             };
}

-(NSDictionary *)jsonKeysMapToProperties {
    
    return @{ @"transactionDescription" : @"description" };
}

-(NSDictionary*)propertyValueTransformers {
    return @{@"ascendingOrder":[MNFNumberToBoolValueTransformer transformer],
             @"hideExcluded":[MNFNumberToBoolValueTransformer transformer],
             @"onlyFlagged":[MNFNumberToBoolValueTransformer transformer],
             @"onlyUncategorized":[MNFNumberToBoolValueTransformer transformer],
             @"onlyUncertain":[MNFNumberToBoolValueTransformer transformer],
             @"onlyUnread":[MNFNumberToBoolValueTransformer transformer],
             @"uncertainOrFlagged":[MNFNumberToBoolValueTransformer transformer],
             @"useAbsoluteAmountSearch":[MNFNumberToBoolValueTransformer transformer],
             @"useAccentInsensitiveSearch":[MNFNumberToBoolValueTransformer transformer],
             @"useAmountInCurrencySearch":[MNFNumberToBoolValueTransformer transformer],
             @"useAndSearchForTags":[MNFNumberToBoolValueTransformer transformer],
             @"useEqualsSearchForBankId":[MNFNumberToBoolValueTransformer transformer],
             @"useExactDescription":[MNFNumberToBoolValueTransformer transformer],
             @"useExactMerchantTexts":[MNFNumberToBoolValueTransformer transformer],
             @"useParentMerchantIds":[MNFNumberToBoolValueTransformer transformer],
             @"periodFrom":[MNFBasicDateValueTransformer transformer],
             @"periodTo":[MNFBasicDateValueTransformer transformer]
             };
}


-(NSSet *)propertiesToIgnoreJsonDeserialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

-(NSSet *)propertiesToIgnoreJsonSerialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

@end
