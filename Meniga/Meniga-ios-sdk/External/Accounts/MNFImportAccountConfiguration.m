//
//  MNFImportAccountConfiguration.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 30/01/2018.
//  Copyright © 2018 Meniga. All rights reserved.
//

#import "MNFImportAccountConfiguration.h"

@implementation MNFImportAccountConfiguration

#pragma mark - json delegate

-(NSDictionary *)jsonKeysMapToProperties {
    return @{@"identifier":@"id"
             };
}
-(NSDictionary *)propertyKeysMapToJson {
    return @{@"identifier":@"id"
             };
}

@end
