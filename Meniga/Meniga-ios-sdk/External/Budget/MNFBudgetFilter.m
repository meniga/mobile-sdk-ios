//
//  MNFBudgetFilter.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 21/11/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFBudgetFilter.h"
#import "MNFInternalImports.h"

@implementation MNFBudgetFilter

#pragma mark - Json Adapter Delegate

-(NSDictionary*)propertyKeysMapToJson {
    return @{@"budgetDescription" : @"description"};
}

-(NSDictionary*)jsonKeysMapToProperties {
    return @{@"budgetDescription" : @"description"};
}

-(NSDictionary*)propertyValueTransformers {
    return @{@"matchAllAccounts" : [MNFNumberToBoolValueTransformer transformer],
             @"mathAllCategories" : [MNFNumberToBoolValueTransformer transformer],
             @"allowOverlappingDates" : [MNFNumberToBoolValueTransformer transformer]};
}

-(NSSet *)propertiesToIgnoreJsonDeserialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

-(NSSet *)propertiesToIgnoreJsonSerialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

@end
