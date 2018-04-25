//
//  MNFAccountSyncStatus.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 20/04/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFAccountSyncStatus.h"
#import "MNFInternalImports.h"

@implementation MNFAccountSyncStatus

#pragma mark - Json Adapter Delegate

-(NSDictionary*)propertyValueTransformers {
    
    return @{@"startDate":[MNFBasicDateValueTransformer transformer],
             @"endDate":[MNFBasicDateValueTransformer transformer]
             };
}

@end
