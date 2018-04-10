//
//  MNFTransactionSuggestion.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 15/03/2018.
//  Copyright © 2018 Meniga. All rights reserved.
//

#import "MNFObject.h"
#import "MNFTransactionFilter.h"

NS_ASSUME_NONNULL_BEGIN

@interface MNFTransactionSuggestion : MNFObject

/**
 The text or name of the search suggestion.
 */
@property (nonatomic,copy,readonly) NSString *text;

/**
 The additional value (if applicable) of the search suggestion.
 */
@property (nonatomic,copy,readonly) NSString *value;

/**
 The type of the search suggestion. 'Category', 'Merchant', 'Tag', 'Comment', Currency' or 'Description'
 */
@property (nonatomic,copy,readonly) NSString *category;

/**
 The type of the search suggestion "Category", "Merchant", "Tag", "Comment", "Currency", "Description", "ParsedDataField"
 */
@property (nonatomic,copy,readonly) NSString *type;

+(MNFJob*)fetchTransactionSuggestionsWithText:(NSString*)text
                              suggestionTypes:(nullable NSString*)suggestionTypes
              onlyShowResultsWithTransactions:(nullable NSNumber*)onlyShowResultsWithTransactions
                                         take:(nullable NSNumber*)take
                                         sort:(nullable NSString*)sort
                                       filter:(nullable MNFTransactionFilter*)filter
                                   completion:(nullable MNFTransactionSuggestionsCompletionHandler)completion;

@end

NS_ASSUME_NONNULL_END
