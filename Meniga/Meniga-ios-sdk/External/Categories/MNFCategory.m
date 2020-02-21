//
//  MNFCategory.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 23/10/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFCategory.h"
#import "MNFCategoryType.h"
#import "MNFInternalImports.h"


@interface MNFCategory () <MNFJsonAdapterDelegate>
@property (nonatomic,strong,readwrite) NSArray *children;
@property (nonatomic, strong, readwrite) NSString *culture;

@property (nonatomic, strong) NSNumber *categoryTypeNumber;

@end


@implementation MNFCategory

#pragma mark - Public Fetch Methods

+(MNFJob *)fetchWithId:(NSNumber *)identifier culture:(NSString *)theCulture completion:(nullable MNFCategoryCompletionHandler)completion {
    
    NSString *path = [NSString stringWithFormat:@"%@/%@",kMNFApiPathCategories,[identifier stringValue]];
    
    NSMutableDictionary *pathQuery = [NSMutableDictionary dictionary];
    pathQuery[@"culture"] = theCulture;
    
    __block MNFJob *job = [self apiRequestWithPath:path pathQuery:pathQuery jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameCategories completion:^(MNFResponse * _Nullable response) {
        kObjectBlockDataDebugLog;
                
        if (response.error == nil) {
            if ([response.result isKindOfClass:[NSDictionary class]]) {
                MNFCategory *category = [MNFCategory initWithServerResult:response.result];
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:category error:nil];
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

+(MNFJob*)fetchUserCreatedCategoriesWithCulture:(NSString *)theCulture completion:(MNFMultipleCategoriesCompletionHandler)completion {
    
    __block MNFJob *job = [self p_fetchCategoriesWithExcludedUserCreatedCategories:nil culture:theCulture skip:nil take:nil completion:^(NSArray *categories, NSError *error) {
        
        if (categories != nil) {
            categories = [self p_filterCategoryIsSystemCategory:[NSNumber numberWithBool:NO] forCategories:categories];
            [self p_populateChildrenForCategories:categories];
        }
        
        [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:categories error:error];
        
    }];
    
    return job;
    
}

+(MNFJob *)fetchSystemCategoriesWithCulture:(NSString *)theCulture completion:(MNFMultipleCategoriesCompletionHandler)completion {
    
    __block MNFJob *job = [self p_fetchCategoriesWithExcludedUserCreatedCategories:nil culture:theCulture skip:nil take:nil completion:^(NSArray *categories, NSError *error) {
        
        if (categories != nil) {
            categories = [self p_filterCategoryIsSystemCategory:[NSNumber numberWithBool:YES] forCategories:categories];
            [self p_populateChildrenForCategories:categories];
        }
        
        [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:categories error:error];
        
    }];
    
    return job;
}

+(MNFJob *)fetchCategoriesWithCulture:(NSString *)theCulture completion:(MNFMultipleCategoriesCompletionHandler)completion {
    
    __block MNFJob *job = [self p_fetchCategoriesWithExcludedUserCreatedCategories:[NSNumber numberWithBool:NO] culture:theCulture skip:nil take:nil completion:^(NSArray *categories, NSError *error) {
        
        [self p_populateChildrenForCategories:categories];
        
        [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:categories error:error];
        
    }];
    
    return job;
}

+(MNFJob *)fetchCategoryTreeWithCulture:(NSString *)theCulture completion:(MNFMultipleCategoriesCompletionHandler)completion {
    
    
    __block MNFJob *job = [self p_fetchCategoriesWithExcludedUserCreatedCategories:nil culture:theCulture skip:nil take:nil completion:^(NSArray *categories, NSError *error) {
        
        if (categories != nil && error == nil) {
            [self p_populateChildrenForCategories:categories];
            
            NSMutableArray *parentCategories = [NSMutableArray array];
            
            for (MNFCategory *category in categories) {
                if (category.parentCategoryId == nil) {
                    [parentCategories addObject:category];
                }
            }
            
            [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:parentCategories error:nil];
            
        } else {
            
            [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error:error];

        }
        
    }];
    
    return job;
}

#pragma mark - Private Fetch Designated Helper method


+(MNFJob *)p_fetchCategoriesWithExcludedUserCreatedCategories:(NSNumber *)excludeUserCreatedCategories culture:(NSString *)theCulture skip:(NSNumber *)theNumToSkip take:(NSNumber *)theLimit completion:(MNFMultipleCategoriesCompletionHandler _Nullable)completion {
    
    NSString *path = [NSString stringWithFormat:@"%@", kMNFApiPathCategories];
    
    NSMutableDictionary *pathQuery = [NSMutableDictionary dictionary];
    
    NSString *isPublicString = [[MNFNumberToBoolValueTransformer transformer] reverseTransformedValue:excludeUserCreatedCategories];
    pathQuery[@"isPublic"] = isPublicString;
    pathQuery[@"culture"] = theCulture;
    pathQuery[@"skip"] = theNumToSkip;
    
    // setting the limit to -1 fetches everything
    
    if (excludeUserCreatedCategories == nil) {
        pathQuery[@"isPublic"] = @"false";
    }
    
    // we do not want to parse the job here as the result can only be set once and this is a helper method, other methods that use it are responsible for creating and returning the data so we only use the completion block.
    MNFJob *job = [self apiRequestWithPath:path pathQuery:pathQuery jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameCategories completion:^(MNFResponse *response) {
        kObjectBlockDataDebugLog;
        if (response.error == nil) {
            if ([response.result isKindOfClass:[NSArray class]]) {
                NSArray <MNFCategory *> *categories = [MNFCategory initWithServerResults:response.result];
                [MNFObject executeOnMainThreadWithCompletion:completion withParameters:categories and:nil];
            }
            else {
                [MNFObject executeOnMainThreadWithCompletion:completion withParameters:nil and: [MNFErrorUtils errorForUnexpectedDataOfType:[response.result class] expected:[NSArray class]] ];
            }
        }
        else {
            [MNFObject executeOnMainThreadWithCompletion:completion withParameters:nil and:response.error];
        }
    }];
    
    return job;
}

#pragma mark - Other fetch methods

+(MNFJob *)fetchCategoryTypesWithCompletion:(MNFMultipleCategoryTypesCompletionHandler)completion {
    
    NSString *path = [NSString stringWithFormat:@"%@/types", kMNFApiPathCategories];
    
    __block MNFJob *job = [self apiRequestWithPath:path pathQuery:nil jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameCategories completion:^(MNFResponse *response) {
        kObjectBlockDataDebugLog;
        if (response.error == nil) {
            
            if ([response.result isKindOfClass:[NSArray class]]) {
                NSArray *categoryTypes = [MNFCategoryType initWithServerResults:response.result];
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:categoryTypes error:nil];
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

#pragma mark - Create Parent Category

+(MNFJob*)createUserParentCategoryWithName:(NSString *)theName isFixedExpense:(NSNumber *)isFixedExpense categoryType:(MNFCategoryTypeId)theCategoryType completion:(MNFCategoryCompletionHandler)completion {
    [completion copy];
    
    return [self p_createUserCategoryWithName:theName isFixedExpense:isFixedExpense categoryType:theCategoryType parentCategoryId:nil completion:completion];
    
}

#pragma mark - Create Child Category

+(MNFJob*)createUserChildCategoryWithName:(NSString *)theName isFixedExpense:(NSNumber *)isFixedExpense parentCategoryType:(MNFCategoryTypeId)theParentCategoryType parentCategoryId:(NSNumber *)theParentCategoryId completion:(MNFCategoryCompletionHandler)completion {
    [completion copy];
    
    // the category type is actually ignored we just have to populate it with something, on the backend it will actually take the category type of its parent
    return [self p_createUserCategoryWithName:theName isFixedExpense:isFixedExpense categoryType:theParentCategoryType parentCategoryId:theParentCategoryId completion:completion];
    
}

#pragma mark - Private create user category

+(MNFJob *)p_createUserCategoryWithName:(NSString *)theName isFixedExpense:(NSNumber *)isFixedExpense categoryType:(MNFCategoryTypeId)theCategoryType parentCategoryId:(NSNumber *)theParentCategoryId completion:(MNFCategoryCompletionHandler)completion {
    
    if (theName == nil) {
        
        [MNFObject executeOnMainThreadWithCompletion:completion withParameters:nil and:[MNFErrorUtils errorWithCode:-223 message:@"A null parameter was sent to a parameter that must not be non null in create a user category."]];
        
        MNFJob *job = [MNFJob jobWithError:[MNFErrorUtils errorWithCode:-223 message:@"A null parameter was sent to a parameter that must not be non null in create a user category."]];
        return job;
    }
    
    NSString *path = [NSString stringWithFormat:@"%@", kMNFApiPathCategories];
    
    if (isFixedExpense == nil) {
        isFixedExpense = [NSNumber numberWithBool:NO];
    }
    
    NSMutableDictionary *jsonDict = [NSMutableDictionary dictionary];
    jsonDict[@"name"] = theName;
    jsonDict[@"isFixedExpenses"] = isFixedExpense;
    jsonDict[@"categoryType"] = [NSNumber numberWithInt:(int)theCategoryType];
    jsonDict[@"parentId"] = theParentCategoryId;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDict options:0 error:nil];
    
    __block MNFJob *job = [self apiRequestWithPath:path pathQuery:nil jsonBody:jsonData HTTPMethod:kMNFHTTPMethodPOST service:MNFServiceNameCategories completion:^(MNFResponse *response) {
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
            if ([response.result isKindOfClass:[NSDictionary class]]) {
                MNFCategory *category = [MNFCategory initWithServerResult:response.result];
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:category error:nil];
            }
            else {
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error: [MNFErrorUtils errorForUnexpectedDataOfType:[response.result class] expected:[NSDictionary class]] ];
            }
        }
        else {
            [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error:response.error];
        }
    }];
    
    
    return job;
}

-(MNFJob *)saveWithCompletion:(MNFErrorOnlyCompletionHandler)completion {
    
    if ([self.isSystemCategory boolValue] == YES) {
        
        [MNFObject executeOnMainThreadWithCompletion:completion withParameter:[MNFErrorUtils errorWithCode:-199 message:@"Cannot save a system category."]];
        
        return [MNFJob jobWithError: [MNFErrorUtils errorWithCode:-199 message:@"Cannot save a system category."]];
    }
    
    NSString *path = [NSString stringWithFormat:@"%@/%@", kMNFApiPathCategories, [self.identifier stringValue]];
    
    
    NSMutableDictionary *mutableCategoryDict = [NSMutableDictionary dictionaryWithDictionary:[MNFJsonAdapter JSONDictFromObject:self option:kMNFAdapterOptionNoOption error:nil]];
    mutableCategoryDict[@"categoryType"] = [NSNumber numberWithInt:(int)self.categoryTypeId];
    
    NSData *categoryData = nil;
    if (mutableCategoryDict != nil) {
        categoryData = [NSJSONSerialization dataWithJSONObject:mutableCategoryDict options:0 error:nil];
    }
    
    __block MNFJob *job = [self updateWithApiPath:path pathQuery:nil jsonBody:categoryData httpMethod:kMNFHTTPMethodPUT service:MNFServiceNameCategories completion:^(MNFResponse *response) {
        kObjectBlockDataDebugLog;
        [MNFObject executeOnMainThreadWithJob:job completion:completion error:response.error];
        
    }];
    
    return job;
}

-(MNFJob *)refreshWithCompletion:(MNFErrorOnlyCompletionHandler)completion {
    [completion copy];
    
    NSString *path = [NSString stringWithFormat:@"%@/%@",kMNFApiPathCategories,[self.identifier stringValue]];
    
    __block MNFJob *job = [[self class] apiRequestWithPath:path pathQuery:nil jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameCategories completion:^(MNFResponse * _Nullable response) {
        kObjectBlockDataDebugLog;
        if (response.error == nil) {
            if ([response.result isKindOfClass:[NSDictionary class]]) {
                [MNFJsonAdapter refreshObject:self withJsonDict:response.result option:kMNFAdapterOptionNoOption error:nil];
                [MNFObject executeOnMainThreadWithJob:job completion:completion error:nil];
            }
            else {
                [MNFObject executeOnMainThreadWithJob:job completion:completion error: [MNFErrorUtils errorForUnexpectedDataOfType:[response.result class] expected:[NSDictionary class]] ];
            }
        }
        else {
            [MNFObject executeOnMainThreadWithJob: job completion: completion error: response.error];
        }
        
    }];
    
    return job;
}


-(MNFJob*)deleteCategoryWithConnectedRules:(NSNumber *)deleteConnectedRules moveTransactionsToNewCategoryId:(NSNumber *)theNewCategoryId completion:(MNFErrorOnlyCompletionHandler)completion {
    [completion copy];
    
    NSString *path = [NSString stringWithFormat:@"%@/%@", kMNFApiPathCategories, [self.identifier stringValue]];
    
    NSMutableDictionary *pathQuery = [NSMutableDictionary dictionary];
    
    NSString *deleteConnectedRulesBoolean = [[MNFNumberToBoolValueTransformer transformer] reverseTransformedValue:deleteConnectedRules];
    pathQuery[@"deleteConnectedRules"] = deleteConnectedRulesBoolean;
    pathQuery[@"newCategoryId"] = theNewCategoryId;
    
    __block MNFJob *job = [self deleteWithApiPath:path pathQuery:pathQuery jsonBody:nil service:MNFServiceNameCategories completion:^(MNFResponse *response) {
        kObjectBlockDataDebugLog;
        [MNFObject executeOnMainThreadWithJob:job completion:completion error:response.error];
    }];
    
    return job;
}

+ (NSArray <MNFCategory *> *)categoryTreeFromCategories:(NSArray<MNFCategory *> *)categories {
    
    if (categories == nil) {
        return nil;
    }
    
    [self p_populateChildrenForCategories:categories];
    
    NSMutableArray *parentCategories = [NSMutableArray array];
    
    for (MNFCategory *category in categories) {
        if (category.parentCategoryId == nil) {
            [parentCategories addObject:category];
        }
    }
    
    return [parentCategories copy];
}

+ (NSArray <MNFCategory *> *)categoriesFromCategoryTree:(NSArray<MNFCategory *> *)categoryTree {
    
    if (categoryTree == nil) {
        return nil;
    }
    
    NSMutableArray *categories = [NSMutableArray array];
    
    for (MNFCategory *parent in categoryTree) {
        [categories addObject:parent];
        for (MNFCategory *child in parent.children) {
            [categories addObject:child];
        }
    }
    
    return [categories copy];
}


#pragma mark - accessors

-(void)setChildren:(NSArray *)children {
    _children = children;
}

#pragma mark - Mutable Setters

-(void)setName:(NSString *)name {
    
    if ([self.isSystemCategory boolValue] == NO) {
        _name = name;
    }
    else {
        MNFLogError(@"Trying to set name on a system category.");
    }
    
}

-(void)setParentCategoryId:(NSNumber *)parentCategoryId {
    
    if ([self.isSystemCategory boolValue] == NO) {
        _parentCategoryId = parentCategoryId;
    }
    else {
        MNFLogError(@"Trying to set parentCategoryId on a system category.");
    }
}

-(void)setIsFixedExpenses:(NSNumber *)isFixedExpenses {
    
    if ([self.isSystemCategory boolValue] == NO) {
        _isFixedExpenses = isFixedExpenses;
    }
    else {
        MNFLogError(@"Trying to set isFixedExpenses on a a system category.");
    }
    
}

-(void)setCategoryTypeId:(MNFCategoryTypeId)categoryType {
    
    if ([self.isSystemCategory boolValue] == NO) {
        _categoryTypeNumber = [NSNumber numberWithInt:(int)categoryType];
    }
    else {
        MNFLogError(@"Trying to set categoryType on a system category.");
    }
    
}

-(MNFCategoryTypeId)categoryTypeId {
    return [_categoryTypeNumber intValue];
}

-(void)setCategoryTypeNumber:(NSNumber *)categoryTypeNumber {
    _categoryTypeNumber = categoryTypeNumber;
}

#pragma mark - Helpers

+(void)p_populateChildrenForCategories:(NSArray*)theCategories {
    
    for (MNFCategory *category in theCategories) {
        [category p_populateChildArrayWithCategories:theCategories];
    }
    
}

-(void)p_populateChildArrayWithCategories:(NSArray*)theCategories {
    
    NSMutableArray *array = [NSMutableArray array];
    for (MNFCategory *category in theCategories) {
        
        // we do not want to add the category itself to its children
        if (category.parentCategoryId != nil) {
            
            if ([self.identifier isEqualToNumber:category.identifier] == NO && [self.identifier isEqualToNumber:category.parentCategoryId] == YES) {
                
                [array addObject:category];
                
                
            }
        }

    }
    
    self.children = array;
    
}

+(NSArray <MNFCategory *> *)p_filterCategoryIsSystemCategory:(NSNumber*)isSystemCategory forCategories:(NSArray <MNFCategory *> *)theCategories {
    
    NSMutableArray *filteredArray = [NSMutableArray array];
    
    for (MNFCategory *category in theCategories) {
        if ([category.isSystemCategory isEqualToNumber:isSystemCategory]) {
            [filteredArray addObject:category];
        }
    }
    
    return filteredArray;
}

#pragma mark - Description
-(NSString*)description {
    return [NSString stringWithFormat:@"Category %@ identifier: %@, name: %@, otherCategoryName: %@, parentCategoryId: %@, isSystemCategory: %@, isFixedExpenses: %@, categoryType: %d, categoryRank: %@, budgetGenerationType: %@, children: %@, categoryContextId: %@, orderId: %@, displayData: %@",[super description],self.identifier,self.name,self.otherCategoryName,self.parentCategoryId,self.isSystemCategory,self.isFixedExpenses,(int)self.categoryTypeId,self.categoryRank,self.budgetGenerationType,self.children,self.categoryContextId,self.orderId,self.displayData];
}

#pragma mark - Json Adapter

-(NSDictionary *)jsonKeysMapToProperties {
    return @{@"identifier":@"id", @"isSystemCategory" : @"isPublic", @"categoryTypeNumber" : @"categoryType"};
}
-(NSDictionary *)propertyKeysMapToJson {
    return @{@"identifier":@"id", @"isSystemCategory" : @"isPublic", @"categoryTypeNumber" : @"categoryType"};
}

-(NSDictionary *)propertyValueTransformers {
    return @{ @"categoryTypeNumber" : [MNFCategoryTypeEnumTransformer transformer] };
}

-(NSSet*)propertiesToSerialize {
    return [NSSet setWithObjects:@"name", @"isFixedExpenses", @"parentCategoryId", @"categoryTypeNumber", nil];
}

-(NSSet*)propertiesToIgnoreJsonDeserialization {
    return [NSSet setWithObjects:@"children", @"objectstate", @"categoryTypeId", nil];
}

-(NSSet*)propertiesToIgnoreJsonSerialization {
    return [NSSet setWithObjects:@"children", @"objectstate", @"categoryTypeId", nil];
}

@end
