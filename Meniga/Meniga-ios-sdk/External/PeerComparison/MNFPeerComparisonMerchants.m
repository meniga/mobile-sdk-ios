//
//  MNFPeerComparisonMerchants.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 15/03/2018.
//  Copyright © 2018 Meniga. All rights reserved.
//

#import "MNFPeerComparisonMerchants.h"

@implementation MNFPeerComparisonMerchants

#pragma mark - json adaptor delegate methods

-(NSDictionary*)jsonKeysMapToProperties{
    return @{@"merchantIdentifier":@"id"};
}

-(NSDictionary*)propertyKeysMapToJson{
    return @{@"merchantIdentifier":@"id"};
}

@end
