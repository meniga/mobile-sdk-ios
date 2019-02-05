//
//  MNFBudgetRuleRecurringPattern.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 29/11/2018.
//  Copyright © 2018 Meniga. All rights reserved.
//

#import "MNFBudgetRuleRecurringPattern.h"

@implementation MNFBudgetRuleRecurringPattern

#pragma mark - json delegate
-(NSSet *)propertiesToIgnoreJsonDeserialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

-(NSSet *)propertiesToIgnoreJsonSerialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

@end
