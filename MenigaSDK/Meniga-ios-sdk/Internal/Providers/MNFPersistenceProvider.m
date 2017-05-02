//
//  MNFPersistenceProvider.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 23/10/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFPersistenceProvider.h"
#import "MNFURLRequestConstants.h"
#import "MNFConstants.h"
#import "MNFErrorUtils.h"

@implementation MNFPersistenceProvider {
    NSCache *_defaultCache;
    NSDateFormatter *_format;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _defaultCache = [[NSCache alloc] init];
        _format = [[NSDateFormatter alloc] init];
        [_format setDateFormat:@"yyyy.MM.dd HH:mm:ss"];
    }
    return self;
}

-(MNFJob*)fetchWithRequest:(MNFPersistenceRequest *)request {
    
    if ([request.request isEqualToString:@"GetAccount"]) {
        NSNumber *key = [request.data objectForKey:@"accountId"];
        NSLog(@"Account key is: %@",key);
        return [self fetchAccountWithId:key];
    }
    else if ([request.request isEqualToString:@"GetAccounts"]) {
        return [self fetchAccounts];
    }
    else if ([request.request isEqualToString:@"GetAccountCategoryTypes"]) {
        return [self fetchAccountCategoryTypes];
    }
    else if ([request.request isEqualToString:@"GetAccountAuthorizationTypes"]) {
        return [self fetchAccountAuthorizationTypes];
    }
    else if ([request.request isEqualToString:@"GetCategoryById"]) {
        return [self fetchCategoryWithId:request.key];
    }
    else if ([request.request isEqualToString:@"GetUserCategories"]) {
        return [self fetchUserCategories];
    }
    else if ([request.request isEqualToString:@"GetTopCategoryIds"]) {
        return [self fetchTopCategoryIds];
    }
    else if ([request.request isEqualToString:@"GetPublicCategoryTree"]) {
        return [self fetchPublicCategoryTree];
    }
    else if ([request.request isEqualToString:@"GetUserCategoryTree"]) {
        return [self fetchUserCategoryTree];
    }
    else if ([request.request isEqualToString:@"GetUserFeed"]) {
        NSDictionary *dict = [request.data objectForKey:@"request"];
        NSString *from = [dict objectForKey:@"DateFrom"];
        NSDate *dateFrom = [_format dateFromString:from];
        from = [NSString stringWithFormat:@"/Date(%d000+0000)",(int)[dateFrom timeIntervalSince1970]];
        NSString *to = [dict objectForKey:@"DateTo"];
        NSDate *dateTo = [_format dateFromString:to];
        to = [NSString stringWithFormat:@"/Date(%d000+0000)",(int)[dateTo timeIntervalSince1970]];
        return [self fetchFeedFromDate:from toDate:to];
    }
    else if ([request.request isEqualToString:@"GetOffer"]) {
        NSNumber *offerId = [request.data objectForKey:@"offerId"];
        return [self fetchOfferWithId:offerId];
    }
    else if ([request.request isEqualToString:@"GetOffers"]) {
        return [self fetchOffers];
    }
    else if ([request.request isEqualToString:@"GetTag"]) {
        return [self fetchTagWithId:request.key];
    }
    else if ([request.request isEqualToString:@"GetTags"]) {
        return [self fetchTags];
    }
    else if ([request.request isEqualToString:@"GetTransaction"]) {
        return [self fetchTransactionWithId:request.key];
    }
    else if ([request.request isEqualToString:@"GetTransactions"]) {
        NSDictionary *filter = [request.data objectForKey:@"filter"];
        return [self fetchTransactionsWithFilter:filter];
    }
    else if ([request.request isEqualToString:@"GetUserProfile"]) {
        return [self fetchProfile];
    }
    
    return nil;
}
-(MNFJob*)saveWithRequest:(MNFPersistenceRequest *)request {
    
    if ([request.request isEqualToString:@"SetAccountProperties"]) {
        NSDictionary *dict = [request.data objectForKey:@"account"];
        return [self saveAccount:dict];
    }
    else if ([request.request isEqualToString:@"DeleteAccount"]) {
        NSNumber *key = [request.data objectForKey:@"accountId"];
        return [self deleteAccount:key];
    }
    else if ([request.request isEqualToString:@"SaveAccounts"]) {
        MNF_BFTaskCompletionSource *cs = [MNF_BFTaskCompletionSource taskCompletionSource];
        [_defaultCache setObject:request.data forKey:@"Accounts"];
        [cs setResult:@"All accounts saved into local cache"];
        return [MNFJob jobWithCompletionSource:cs];
    }
    else if ([request.request isEqualToString:@"SaveUserCategories"]) {
        MNF_BFTaskCompletionSource *cs = [MNF_BFTaskCompletionSource taskCompletionSource];
        [_defaultCache setObject:request.data forKey:@"UserCategories"];
        [cs setResult:@"All user categories saved into local cache"];
        return [MNFJob jobWithCompletionSource:cs];
    }
    else if ([request.request isEqualToString:@"CreateUserCategory"]) {
        return [self saveUserCategory:request.data];
    }
    else if ([request.request isEqualToString:@"UpdateUserCategory"]) {
        return [self saveUserCategory:request.data];
    }
    else if ([request.request isEqualToString:@"DeleteUserCategory"]) {
        NSNumber *key = [request.data objectForKey:@"categoryId"];
        return [self deleteUserCategory:key];
    }
    else if ([request.request isEqualToString:@"SaveTopCategoryIds"]) {
        MNF_BFTaskCompletionSource *cs = [MNF_BFTaskCompletionSource taskCompletionSource];
        [_defaultCache setObject:request.data forKey:@"TopCategoryIds"];
        [cs setResult:@"Top category ids saved into local cache"];
        return [MNFJob jobWithCompletionSource:cs];
    }
    else if ([request.request isEqualToString:@"SavePublicCategoryTree"]) {
        MNF_BFTaskCompletionSource *cs = [MNF_BFTaskCompletionSource taskCompletionSource];
        [_defaultCache setObject:request.data forKey:@"PublicCategoryTree"];
        [cs setResult:@"Public category tree saved into local cache"];
        return [MNFJob jobWithCompletionSource:cs];
    }
    else if ([request.request isEqualToString:@"SaveUserCategoryTree"]) {
        MNF_BFTaskCompletionSource *cs = [MNF_BFTaskCompletionSource taskCompletionSource];
        [_defaultCache setObject:request.data forKey:@"UserCategoryTree"];
        [cs setResult:@"User category tree saved into local cache"];
        return [MNFJob jobWithCompletionSource:cs];
    }
    else if ([request.request isEqualToString:@"SaveOffers"]) {
        MNF_BFTaskCompletionSource *cs = [MNF_BFTaskCompletionSource taskCompletionSource];
        [_defaultCache setObject:request.data forKey:@"Offers"];
        [cs setResult:@"All offers saved into local cache"];
        return [MNFJob jobWithCompletionSource:cs];
    }
    else if ([request.request isEqualToString:@"SaveUserFeed"]) {
        MNF_BFTaskCompletionSource *cs = [MNF_BFTaskCompletionSource taskCompletionSource];
        [_defaultCache setObject:request.data forKey:@"Feed"];
        [cs setResult:@"Feed saved into local cache"];
        return [MNFJob jobWithCompletionSource:cs];
    }
    else if ([request.request isEqualToString:@"UpdateTag"]) {
        return [self saveTag:request.data];
    }
    else if ([request.request isEqualToString:@"SaveTags"]) {
        MNF_BFTaskCompletionSource *cs = [MNF_BFTaskCompletionSource taskCompletionSource];
        [_defaultCache setObject:request.data forKey:@"Tags"];
        [cs setResult:@"All tags saved into local cache"];
        return [MNFJob jobWithCompletionSource:cs];
    }
    else if ([request.request isEqualToString:@"DeleteTag"]) {
        NSNumber *key = [request.data objectForKey:@"tagId"];
        return [self deleteTag:key];
    }
    else if ([request.request isEqualToString:@"UpdateTransaction"]) {
        return [self saveTransaction:request.data];
    }
    else if ([request.request isEqualToString:@"SaveTransactions"]) {
        MNF_BFTaskCompletionSource *cs = [MNF_BFTaskCompletionSource taskCompletionSource];
        [_defaultCache setObject:request.data forKey:@"Transactions"];
        [cs setResult:@"All transactions saved into local cache"];
        return [MNFJob jobWithCompletionSource:cs];
    }
    else if ([request.request isEqualToString:@"DeleteTransaction"]) {
        NSNumber *key = [request.data objectForKey:@"transactionId"];
        return [self deleteTransaction:key];
    }
    else if ([request.request isEqualToString:@"DeleteTransactions"]) {
        MNF_BFTaskCompletionSource *cs = [MNF_BFTaskCompletionSource taskCompletionSource];
        [_defaultCache removeObjectForKey:@"Transactions"];
        [cs setResult:@"All transactions deleted from local cache"];
        return [MNFJob jobWithCompletionSource:cs];
    }
    else if ([request.request isEqualToString:@"SaveUserProfile"]) {
        return [self saveProfile:request.data];
    }
    else if ([request.request isEqualToString:@"UpdateUserProfile"]) {
        return [self saveProfile:request.data];
    }
    
    return nil;
}
-(BOOL)hasKey:(MNFPersistenceRequest *)request {
    if (request.key == nil) {
        return YES;
    }
    NSPredicate *predicate =[NSPredicate predicateWithFormat:@"SELF.Id == %@",request.key];
    NSArray *array = [[_defaultCache objectForKey:@"Accounts"] filteredArrayUsingPredicate:predicate];
    if ([array count] != 0) return YES;
    array = [[_defaultCache objectForKey:@"Transactions"] filteredArrayUsingPredicate:predicate];
    if ([array count] != 0) return YES;
    array = [[_defaultCache objectForKey:@"UserCategories"] filteredArrayUsingPredicate:predicate];
    if ([array count] != 0) return YES;
    array = [[_defaultCache objectForKey:@"Feed"] filteredArrayUsingPredicate:predicate];
    if ([array count] != 0) return YES;
    array = [[_defaultCache objectForKey:@"Offers"] filteredArrayUsingPredicate:predicate];
    if ([array count] != 0) return YES;
    array = [[_defaultCache objectForKey:@"Tags"] filteredArrayUsingPredicate:predicate];
    if ([array count] != 0) return YES;
    
    return NO;
}

-(MNFJob*)fetchAccountWithId:(NSNumber *)accountId {
    NSLog(@"Fetching account with id");
    MNF_BFTaskCompletionSource *cs = [MNF_BFTaskCompletionSource taskCompletionSource];
    NSArray *accounts = [_defaultCache objectForKey:@"Accounts"];
    NSArray *account = [accounts filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"Id = %@",accountId]];
    if (account != nil && [account count] > 0) {
        [cs setResult:[account objectAtIndex:0]];
    }
    else {
        NSError *error = [MNFErrorUtils errorWithCode:kMNFErrorObjectNotFound message:@"Account not found in local cache"];
        [cs setError:error];
    }
    return [MNFJob jobWithCompletionSource:cs];
}
-(MNFJob*)fetchAccounts {
    MNF_BFTaskCompletionSource *cs = [MNF_BFTaskCompletionSource taskCompletionSource];
    NSArray *accounts = [_defaultCache objectForKey:@"Accounts"];
    if (accounts != nil) {
        [cs setResult:accounts];
    }
    else {
        NSError *error = [MNFErrorUtils errorWithCode:kMNFErrorObjectNotFound message:@"No accounts found in local cache"];
        [cs setError:error];
    }
    return [MNFJob jobWithCompletionSource:cs];
}
-(MNFJob*)fetchAccountCategoryTypes {
    MNF_BFTaskCompletionSource *cs = [MNF_BFTaskCompletionSource taskCompletionSource];
    NSArray *accountCategoryTypes = [_defaultCache objectForKey:@"AccountCategoryTypes"];
    if (accountCategoryTypes != nil) {
        [cs setResult:accountCategoryTypes];
    }
    else {
        NSError *error = [MNFErrorUtils errorWithCode:kMNFErrorObjectNotFound message:@"No account category types found in local cache"];
        [cs setError:error];
    }
    return [MNFJob jobWithCompletionSource:cs];
}
-(MNFJob*)fetchAccountAuthorizationTypes {
    MNF_BFTaskCompletionSource *cs = [MNF_BFTaskCompletionSource taskCompletionSource];
    NSArray *accountCategoryTypes = [_defaultCache objectForKey:@"AccountAuthorizationTypes"];
    if (accountCategoryTypes != nil) {
        [cs setResult:accountCategoryTypes];
    }
    else {
        NSError *error = [MNFErrorUtils errorWithCode:kMNFErrorObjectNotFound message:@"No account authorization types found in local cache"];
        [cs setError:error];
    }
    return [MNFJob jobWithCompletionSource:cs];
}
-(MNFJob*)saveAccount:(NSDictionary*)account {
    MNF_BFTaskCompletionSource *cs = [MNF_BFTaskCompletionSource taskCompletionSource];
    NSArray *accounts = [_defaultCache objectForKey:@"Accounts"];
    NSMutableArray *newAccounts = [accounts mutableCopy];
    if (accounts != nil) {
        BOOL found = NO;
        for (NSDictionary *acc in accounts) {
            if ([[account objectForKey:@"id"] isEqual:[acc objectForKey:@"Id"]] || [[account objectForKey:@"Id"] isEqual:[acc objectForKey:@"Id"]]) {
                NSMutableDictionary *newAccount = [acc mutableCopy];
                [newAccount setObject:[account objectForKey:@"Name"] forKey:@"Name"];
                [newAccount setObject:[account objectForKey:@"IsHidden"] forKey:@"IsHidden"];
                [newAccounts replaceObjectAtIndex:[accounts indexOfObject:acc] withObject:account];
                found = YES;
                [cs setResult:@"Account saved"];
                break;
            }
        }
        if (!found) {
            [newAccounts addObject:account];
            [cs setResult:@"New account created"];
        }
    }
    else {
        newAccounts = [NSMutableArray new];
        [newAccounts addObject:account];
        [cs setResult:@"New account created"];
    }
    [_defaultCache setObject:[newAccounts copy] forKey:@"Accounts"];
    return [MNFJob jobWithCompletionSource:cs];
}
-(MNFJob*)deleteAccount:(NSNumber *)accountId {
    MNF_BFTaskCompletionSource *cs = [MNF_BFTaskCompletionSource taskCompletionSource];
    NSArray *accounts = [_defaultCache objectForKey:@"Accounts"];
    NSMutableArray *newAccounts = [accounts mutableCopy];
    if (accounts != nil) {
        BOOL found = NO;
        for (NSDictionary *acc in accounts) {
            if ([accountId isEqual:[acc objectForKey:@"Id"]]) {
                [newAccounts removeObject:acc];
                found = YES;
                [cs setResult:@"Account deleted"];
            }
        }
        if (!found) {
            NSError *error = [MNFErrorUtils errorWithCode:kMNFErrorObjectNotFound message:@"Account not found in local cache"];
            [cs setError:error];
        }
        [_defaultCache setObject:[newAccounts copy] forKey:@"Accounts"];
    }
    else {
        NSError *error = [MNFErrorUtils errorWithCode:kMNFErrorObjectNotFound message:@"No accounts found in local cache"];
        [cs setError:error];
    }
    return [MNFJob jobWithCompletionSource:cs];
}

-(MNFJob*)fetchCategoryWithId:(NSNumber *)categoryId {
    MNF_BFTaskCompletionSource *cs = [MNF_BFTaskCompletionSource taskCompletionSource];
    NSArray *categories = [_defaultCache objectForKey:@"UserCategories"];
    NSArray *category = [categories filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"Id = %@",categoryId]];
    if (category != nil && [category count] > 0) {
        [cs setResult:[category objectAtIndex:0]];
    }
    else {
        NSError *error = [MNFErrorUtils errorWithCode:kMNFErrorObjectNotFound message:@"Category not found in local cache"];
        [cs setError:error];
    }
    return [MNFJob jobWithCompletionSource:cs];
}
-(MNFJob*)fetchTopCategoryIds {
    MNF_BFTaskCompletionSource *cs = [MNF_BFTaskCompletionSource taskCompletionSource];
    NSArray *topCategoryIds = [_defaultCache objectForKey:@"TopCategoryIds"];
    if (topCategoryIds != nil) {
        [cs setResult:topCategoryIds];
    }
    else {
        NSError *error = [MNFErrorUtils errorWithCode:kMNFErrorObjectNotFound message:@"Top category ids not found in local cache"];
        [cs setError:error];
    }
    return [MNFJob jobWithCompletionSource:cs];
}
-(MNFJob*)fetchPublicCategoryTree {
    MNF_BFTaskCompletionSource *cs = [MNF_BFTaskCompletionSource taskCompletionSource];
    NSArray *publicCategoryTree = [_defaultCache objectForKey:@"PublicCategoryTree"];
    if (publicCategoryTree != nil) {
        [cs setResult:publicCategoryTree];
    }
    else {
        NSError *error = [MNFErrorUtils errorWithCode:kMNFErrorObjectNotFound message:@"Public category tree not found in local cache"];
        [cs setError:error];
    }
    return [MNFJob jobWithCompletionSource:cs];
}

-(MNFJob*)fetchUserCategories {
    MNF_BFTaskCompletionSource *cs = [MNF_BFTaskCompletionSource taskCompletionSource];
    NSArray *userCategories = [_defaultCache objectForKey:@"UserCategories"];
    if (userCategories != nil) {
        [cs setResult:userCategories];
    }
    else {
        NSError *error = [MNFErrorUtils errorWithCode:kMNFErrorObjectNotFound message:@"User categories not found in local cache"];
        [cs setError:error];
    }
    return [MNFJob jobWithCompletionSource:cs];
}
-(MNFJob*)fetchUserCategoryTree {
    MNF_BFTaskCompletionSource *cs = [MNF_BFTaskCompletionSource taskCompletionSource];
    NSArray *userCategoryTree = [_defaultCache objectForKey:@"UserCategoryTree"];
    if (userCategoryTree != nil) {
        [cs setResult:userCategoryTree];
    }
    else {
        NSError *error = [MNFErrorUtils errorWithCode:kMNFErrorObjectNotFound message:@"User category tree not found in local cache"];
        [cs setError:error];
    }
    return [MNFJob jobWithCompletionSource:cs];
}
-(MNFJob*)saveUserCategory:(NSDictionary*)category {
    MNF_BFTaskCompletionSource *cs = [MNF_BFTaskCompletionSource taskCompletionSource];
    NSArray *userCategories = [_defaultCache objectForKey:@"UserCategories"];
    NSMutableArray *newUserCategories = [userCategories mutableCopy];
    if (userCategories != nil) {
        BOOL found = NO;
        for (NSDictionary *cat in userCategories) {
            if ([[category objectForKey:@"Id"] isEqual:[cat objectForKey:@"Id"]]) {
                [newUserCategories replaceObjectAtIndex:[userCategories indexOfObject:cat] withObject:category];
                found = YES;
                [cs setResult:@"Category saved"];
            }
        }
        if (!found) {
            [newUserCategories addObject:category];
            [cs setResult:@"New category created"];
        }
    }
    else {
        newUserCategories = [NSMutableArray new];
        [newUserCategories addObject:category];
        [cs setResult:@"New category created"];
    }
    [_defaultCache setObject:[newUserCategories copy] forKey:@"UserCategories"];
    return [MNFJob jobWithCompletionSource:cs];
}
-(MNFJob*)deleteUserCategory:(NSNumber*)categoryId {
    MNF_BFTaskCompletionSource *cs = [MNF_BFTaskCompletionSource taskCompletionSource];
    NSArray *userCategories = [_defaultCache objectForKey:@"UserCategories"];
    NSMutableArray *newUserCategories = [userCategories mutableCopy];
    if (userCategories != nil) {
        BOOL found = NO;
        for (NSDictionary *cat in userCategories) {
            if ([categoryId isEqual:[cat objectForKey:@"Id"]]) {
                [newUserCategories removeObject:cat];
                found = YES;
                [cs setResult:@"Category deleted"];
            }
        }
        if (!found) {
            NSError *error = [MNFErrorUtils errorWithCode:kMNFErrorObjectNotFound message:@"Category not found in local cache"];
            [cs setError:error];
        }
        [_defaultCache setObject:[newUserCategories copy] forKey:@"UserCategories"];
    }
    else {
        NSError *error = [MNFErrorUtils errorWithCode:kMNFErrorObjectNotFound message:@"No categories found in local cache"];
        [cs setError:error];
    }
    return [MNFJob jobWithCompletionSource:cs];
}

-(MNFJob*)fetchFeedFromDate:(NSString *)from toDate:(NSString *)to {
    MNF_BFTaskCompletionSource *cs = [MNF_BFTaskCompletionSource taskCompletionSource];
    NSMutableDictionary *feed = [[_defaultCache objectForKey:@"Feed"] mutableCopy];
    if (feed != nil) {
        NSMutableArray *feedItems = [NSMutableArray new];
        for (NSDictionary *feedItem in [feed objectForKey:@"FeedListItem"]) {
            if(([[feedItem objectForKey:@"Date"] compare:to] == NSOrderedAscending || [[feedItem objectForKey:@"Date"] compare:to] == NSOrderedSame) && ([[feedItem objectForKey:@"Date"] compare:from] == NSOrderedDescending || [[feedItem objectForKey:@"Date"] compare:from] == NSOrderedSame)) {
                [feedItems addObject:feedItem];
                NSLog(@"Adding feed item");
            }
        }
        [feed setObject:[feedItems copy] forKey:@"FeedListItem"];
        [cs setResult:[feed copy]];
    }
    else {
        NSError *error = [MNFErrorUtils errorWithCode:kMNFErrorObjectNotFound message:@"No feed found in local cache"];
        [cs setError:error];
    }
    return [MNFJob jobWithCompletionSource:cs];
}

-(MNFJob*)fetchOfferWithId:(NSNumber *)offerId {
    MNF_BFTaskCompletionSource *cs = [MNF_BFTaskCompletionSource taskCompletionSource];
    NSArray *offers = [_defaultCache objectForKey:@"Offers"];
    NSArray *offer = [offers filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"Id = %@",offerId]];
    if (offer != nil && [offer count] > 0) {
        [cs setResult:[offer objectAtIndex:0]];
    }
    else {
        NSError *error = [MNFErrorUtils errorWithCode:kMNFErrorObjectNotFound message:@"Offer not found in local cache"];
        [cs setError:error];
    }
    return [MNFJob jobWithCompletionSource:cs];
}
-(MNFJob*)fetchOffers {
    MNF_BFTaskCompletionSource *cs = [MNF_BFTaskCompletionSource taskCompletionSource];
    NSArray *offers = [_defaultCache objectForKey:@"Offers"];
    if (offers != nil) {
        [cs setResult:offers];
    }
    else {
        NSError *error = [MNFErrorUtils errorWithCode:kMNFErrorObjectNotFound message:@"No offers found in local cache"];
        [cs setError:error];
    }
    return [MNFJob jobWithCompletionSource:cs];
}

-(MNFJob*)fetchTagWithId:(NSNumber *)tagId {
    MNF_BFTaskCompletionSource *cs = [MNF_BFTaskCompletionSource taskCompletionSource];
    NSArray *tags = [_defaultCache objectForKey:@"Tags"];
    NSArray *tag = [tags filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"Id = %@",tagId]];
    if (tag != nil && [tag count] > 0) {
        [cs setResult:[tag objectAtIndex:0]];
    }
    else {
        NSError *error = [MNFErrorUtils errorWithCode:kMNFErrorObjectNotFound message:@"Tag not found in local cache"];
        [cs setError:error];
    }
    return [MNFJob jobWithCompletionSource:cs];
}
-(MNFJob*)fetchTags {
    MNF_BFTaskCompletionSource *cs = [MNF_BFTaskCompletionSource taskCompletionSource];
    NSArray *tags = [_defaultCache objectForKey:@"Tags"];
    if (tags != nil) {
        [cs setResult:tags];
    }
    else {
        NSError *error = [MNFErrorUtils errorWithCode:kMNFErrorObjectNotFound message:@"No tags found in local cache"];
        [cs setError:error];
    }
    return [MNFJob jobWithCompletionSource:cs];
}
-(MNFJob*)saveTag:(NSDictionary *)tag {
    MNF_BFTaskCompletionSource *cs = [MNF_BFTaskCompletionSource taskCompletionSource];
    NSArray *tags = [[_defaultCache objectForKey:@"Tags"] mutableCopy];
    NSMutableArray *newTags = [tags mutableCopy];
    if (tags != nil) {
        BOOL found = NO;
        for (NSDictionary *tagDict in tags) {
            if ([[tag objectForKey:@"tagId"] isEqual:[tagDict objectForKey:@"Id"]]) {
                NSMutableDictionary *newTag = [tag mutableCopy];
                [newTag setObject:[tag objectForKey:@"tagId"] forKey:@"Id"];
                [newTag removeObjectForKey:@"tagId"];
                [newTags replaceObjectAtIndex:[tags indexOfObject:tagDict] withObject:newTag];
                found = YES;
                [cs setResult:@"Tag saved"];
            }
            if ([[tag objectForKey:@"Id"] isEqual:[tagDict objectForKey:@"Id"]]) {
                [newTags replaceObjectAtIndex:[tags indexOfObject:tagDict] withObject:tag];
                found = YES;
                [cs setResult:@"Tag saved"];
            }
        }
        if (!found) {
            [newTags addObject:tag];
            [cs setResult:@"New tag created"];
        }
    }
    else {
        newTags = [NSMutableArray new];
        [newTags addObject:tag];
        [cs setResult:@"New tag created"];
    }
    [_defaultCache setObject:[newTags copy] forKey:@"Tags"];
    return [MNFJob jobWithCompletionSource:cs];
}
-(MNFJob*)deleteTag:(NSNumber *)tagId {
    MNF_BFTaskCompletionSource *cs = [MNF_BFTaskCompletionSource taskCompletionSource];
    NSArray *tags = [[_defaultCache objectForKey:@"Tags"] mutableCopy];
    NSMutableArray *newTags = [tags mutableCopy];
    if (tags != nil) {
        BOOL found = NO;
        for (NSDictionary *tagDict in tags) {
            if ([tagId isEqual:[tagDict objectForKey:@"Id"]]) {
                [newTags removeObject:tagDict];
                found = YES;
                [cs setResult:@"Tag deleted"];
            }
        }
        if (!found) {
            NSError *error = [MNFErrorUtils errorWithCode:kMNFErrorObjectNotFound message:@"Tag not found in local cache"];
            [cs setError:error];
        }
        [_defaultCache setObject:[newTags copy] forKey:@"Tags"];
    }
    else {
        NSError *error = [MNFErrorUtils errorWithCode:kMNFErrorObjectNotFound message:@"No tags found in local cache"];
        [cs setError:error];
    }
    
    return [MNFJob jobWithCompletionSource:cs];
}

-(MNFJob*)fetchTransactionWithId:(NSNumber *)transactionId {
    MNF_BFTaskCompletionSource *cs = [MNF_BFTaskCompletionSource taskCompletionSource];
    NSArray *transactions = [_defaultCache objectForKey:@"Transactions"];
    NSArray *transaction = [transactions filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"Id = %@",transactionId]];
    if (transaction != nil && [transaction count] > 0) {
        [cs setResult:[transaction objectAtIndex:0]];
    }
    else {
        NSError *error = [MNFErrorUtils errorWithCode:kMNFErrorObjectNotFound message:@"Transaction not found in local cache"];
        [cs setError:error];
    }
    return [MNFJob jobWithCompletionSource:cs];
}
-(MNFJob*)fetchTransactionsWithFilter:(NSDictionary*)transactionFilter {
    MNF_BFTaskCompletionSource *cs = [MNF_BFTaskCompletionSource taskCompletionSource];
    NSArray *transactions = [_defaultCache objectForKey:@"Transactions"];
    if (transactions != nil) {
        NSPredicate *predicate = [self predicateFromTransactionFilter:transactionFilter];
        transactions = [transactions filteredArrayUsingPredicate:predicate];
        [cs setResult:transactions];
    }
    else {
        NSError *error = [MNFErrorUtils errorWithCode:kMNFErrorObjectNotFound message:@"No transactions found in local cache"];
        [cs setError:error];
    }
    return [MNFJob jobWithCompletionSource:cs];
}
-(MNFJob*)saveTransaction:(NSDictionary *)transaction {
    MNF_BFTaskCompletionSource *cs = [MNF_BFTaskCompletionSource taskCompletionSource];
    NSArray *transactions = [[_defaultCache objectForKey:@"Transactions"] mutableCopy];
    NSMutableArray *newTransactions = [transactions mutableCopy];
    if (transactions != nil) {
        BOOL found = NO;
        for (NSDictionary *trans in transactions) {
            if ([[transaction objectForKey:@"transactionId"] isEqual:[trans objectForKey:@"Id"]]) {
                NSMutableDictionary *newTransaction = [transaction mutableCopy];
                [newTransaction setObject:[transaction objectForKey:@"transactionId"] forKey:@"Id"];
                [newTransaction removeObjectForKey:@"transactionId"];
                [newTransactions replaceObjectAtIndex:[transactions indexOfObject:trans] withObject:[newTransaction copy]];
                found = YES;
                [cs setResult:@"Transaction saved"];
            }
            if ([[transaction objectForKey:@"Id"] isEqual:[trans objectForKey:@"Id"]]) {
                [newTransactions replaceObjectAtIndex:[transactions indexOfObject:trans] withObject:[transaction copy]];
                found = YES;
                [cs setResult:@"Transaction saved"];
            }
        }
        if (!found) {
            NSMutableDictionary *newTransaction = [transaction mutableCopy];
            [newTransaction setObject:[transaction objectForKey:@"transactionId"] forKey:@"Id"];
            [newTransaction removeObjectForKey:@"transactionId"];
            [newTransactions addObject:[newTransaction copy]];
            [cs setResult:@"New transaction created"];
        }

    }
    else {
        newTransactions = [NSMutableArray array];
        [newTransactions addObject:transaction];
        [cs setResult:@"New transaction created"];
    }
    [_defaultCache setObject:[newTransactions copy] forKey:@"Transactions"];
    return [MNFJob jobWithCompletionSource:cs];
}
-(MNFJob*)deleteTransaction:(NSNumber *)transactionId {
    MNF_BFTaskCompletionSource *cs = [MNF_BFTaskCompletionSource taskCompletionSource];
    NSArray *transactions = [[_defaultCache objectForKey:@"Transactions"] mutableCopy];
    NSMutableArray *newTransactions = [transactions mutableCopy];
    if (transactions != nil) {
        BOOL found = NO;
        for (NSDictionary *trans in transactions) {
            if ([transactionId isEqual:[trans objectForKey:@"Id"]]) {
                [newTransactions removeObject:trans];
                found = YES;
                [cs setResult:@"Transaction deleted"];
            }
        }
        if (!found) {
            NSError *error = [MNFErrorUtils errorWithCode:kMNFErrorObjectNotFound message:@"Transaction not found in local cache"];
            [cs setError:error];
        }
        [_defaultCache setObject:[newTransactions copy] forKey:@"Transactions"];
    }
    else {
        NSError *error = [MNFErrorUtils errorWithCode:kMNFErrorObjectNotFound message:@"No transactions found in local cache"];
        [cs setError:error];
    }
    
    return [MNFJob jobWithCompletionSource:cs];
}

-(MNFJob*)fetchProfile {
    MNF_BFTaskCompletionSource *cs = [MNF_BFTaskCompletionSource taskCompletionSource];
    NSDictionary *profile = [_defaultCache objectForKey:@"UserProfile"];
    if (profile != nil) {
        [cs setResult:profile];
    }
    else {
        NSError *error = [MNFErrorUtils errorWithCode:kMNFErrorObjectNotFound message:@"User profile not found in local cache"];
        [cs setError:error];
    }
    return [MNFJob jobWithCompletionSource:cs];
}
-(MNFJob*)saveProfile:(NSDictionary *)profile {
    MNF_BFTaskCompletionSource *cs = [MNF_BFTaskCompletionSource taskCompletionSource];
    [_defaultCache setObject:profile forKey:@"UserProfile"];
    [cs setResult:@"User profile saved"];
    return [MNFJob jobWithCompletionSource:cs];
}

#pragma mark - Helpers
-(NSPredicate*)predicateFromTransactionFilter:(NSDictionary*)transactionFilter {
    NSPredicate *predicate = [NSPredicate new];
    if ([[transactionFilter objectForKey:@"UseAndSearchForTags"]  isEqual: @1]) {
        predicate = [NSPredicate predicateWithFormat:@"(AccountId IN %@) AND (CategoryId IN %@) AND NOT(IsRead == 1 AND %@ == 1) AND NOT(IsFlagged < %@) AND NOT(HasUncertainCategorization < %@)  OR ((%@ == %@) AND (IsFlagged == %@ OR HasUncertainCategorization == %@)) AND (InsertTime <[c] %@) AND (Date >[c] %@) AND (Date <[c] %@) AND (OriginalDate >[c] %@) AND (OriginalDate <[c] %@) AND (Amount > %@) AND (Amount < %@) AND ((Currency ==[c] %@) OR (Data ==[c] %@) OR (OriginalText ==[c] %@) OR (ParentIdentifier ==[c] %@) OR (UserData ==[c] %@) OR (Comment ==[c] %@) OR (%@ IN Tags)) AND (BankId == %@) AND (Currency == %@) AND (Comment == %@) AND (ANY Tags IN %@) AND (MerchantId IN %@) AND (NOT(MerchantId IN %@) AND %lu != 0) AND (%@ IN ParsedData)",[transactionFilter objectForKey:@"AccountIds"],[transactionFilter objectForKey:@"CategoryIds"],[transactionFilter objectForKey:@"OnlyUnread"],[transactionFilter objectForKey:@"OnlyFlagged"],[transactionFilter objectForKey:@"OnlyUncertain"],[transactionFilter objectForKey:@"UncertainOrFlagged"],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[transactionFilter objectForKey:@"InsertedBefore"],[transactionFilter objectForKey:@"PeriodFrom"],[transactionFilter objectForKey:@"PeriodTo"],[transactionFilter objectForKey:@"OriginalPeriodFrom"],[transactionFilter objectForKey:@"OriginalPeriodTo"],[transactionFilter objectForKey:@"AmountFrom"],[transactionFilter objectForKey:@"AmountTo"],[transactionFilter objectForKey:@"SearchText"],[transactionFilter objectForKey:@"SearchText"],[transactionFilter objectForKey:@"SearchText"],[transactionFilter objectForKey:@"SearchText"],[transactionFilter objectForKey:@"SearchText"],[transactionFilter objectForKey:@"SearchText"],[transactionFilter objectForKey:@"SearchText"],[transactionFilter objectForKey:@"BankId"],[transactionFilter objectForKey:@"Currency"],[transactionFilter objectForKey:@"Comment"],[transactionFilter objectForKey:@"Tags"],[transactionFilter objectForKey:@"MerchantIds"],[transactionFilter objectForKey:@"ExcludeMerchantIds"],[[transactionFilter objectForKey:@"ExcludeMerchantIds"] count],[transactionFilter objectForKey:@"ParsedData"]];
    }
    else {
        predicate = [NSPredicate predicateWithFormat:@"(AccountId IN %@) OR (AccountIdentifier IN %@) OR (CounterpartyAccountIdentifier IN %@) OR (CategoryId IN %@) OR NOT(IsRead == 1 AND %@ == 1) OR NOT(IsFlagged < %@) OR NOT(HasUncertainCategorization < %@) OR ((%@ == %@) AND (IsFlagged == %@ OR HasUncertainCategorization == %@)) OR (InsertTime <[c] %@) OR (Date >[c] %@) OR (Date <[c] %@) OR (OriginalDate >[c] %@) OR (OriginalDate <[c] %@) OR (Amount > %@) OR (Amount < %@) OR ((Currency ==[c] %@) OR (Data ==[c] %@) OR (OriginalText ==[c] %@) OR (ParentIdentifier ==[c] %@) OR (UserData ==[c] %@) OR (Comment ==[c] %@) OR (%@ IN Tags)) OR (BankId == %@) OR (Currency == %@) OR (Comment == %@) OR (ANY Tags IN %@) OR (MerchantId IN %@) OR (NOT(MerchantId IN %@) AND %lu != 0) OR (%@ IN ParsedData)",[transactionFilter objectForKey:@"AccountIds"],[transactionFilter objectForKey:@"AccountIdentifiers"],[transactionFilter objectForKey:@"CounterpartyAccountIdentifiers"],[transactionFilter objectForKey:@"CategoryIds"],[transactionFilter objectForKey:@"OnlyUnread"],[transactionFilter objectForKey:@"OnlyFlagged"],[transactionFilter objectForKey:@"OnlyUncertain"],[transactionFilter objectForKey:@"UncertainOrFlagged"],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[transactionFilter objectForKey:@"InsertedBefore"],[transactionFilter objectForKey:@"PeriodFrom"],[transactionFilter objectForKey:@"PeriodTo"],[transactionFilter objectForKey:@"OriginalPeriodFrom"],[transactionFilter objectForKey:@"OriginalPeriodTo"],[transactionFilter objectForKey:@"AmountFrom"],[transactionFilter objectForKey:@"AmountTo"],[transactionFilter objectForKey:@"SearchText"],[transactionFilter objectForKey:@"SearchText"],[transactionFilter objectForKey:@"SearchText"],[transactionFilter objectForKey:@"SearchText"],[transactionFilter objectForKey:@"SearchText"],[transactionFilter objectForKey:@"SearchText"],[transactionFilter objectForKey:@"SearchText"],[transactionFilter objectForKey:@"BankId"],[transactionFilter objectForKey:@"Currency"],[transactionFilter objectForKey:@"Comment"],[transactionFilter objectForKey:@"Tags"],[transactionFilter objectForKey:@"MerchantIds"],[transactionFilter objectForKey:@"ExcludeMerchantIds"],[[transactionFilter objectForKey:@"ExcludeMerchantIds"] count],[transactionFilter objectForKey:@"ParsedData"]];
    }
    
    NSLog(@"Predicate: %@",predicate);
    
    return predicate;
}

@end
