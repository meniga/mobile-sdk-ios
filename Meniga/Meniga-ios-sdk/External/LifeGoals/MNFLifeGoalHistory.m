//
//  MNFLifeGoalHistory.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 15/03/2018.
//  Copyright © 2018 Meniga. All rights reserved.
//

#import "MNFLifeGoalHistory.h"
#import "MNFInternalImports.h"

@implementation MNFLifeGoalHistory

#pragma mark - json adaptor delegate methods
-(NSDictionary*)propertyValueTransformers {
    
    return @{@"processingDate":[MNFBasicDateValueTransformer transformer],
             @"targetDate":[MNFBasicDateValueTransformer transformer]};
}

@end
