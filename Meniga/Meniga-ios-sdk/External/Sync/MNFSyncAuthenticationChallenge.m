//
//  MNFSyncAuthenticationChallenge.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 20/04/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFSyncAuthenticationChallenge.h"
#import "MNFSyncAuthRequiredParameter.h"
#import "MNFJsonAdapter.h"
#import "MNFJsonAdapterSubclassedProperty.h"

@implementation MNFSyncAuthenticationChallenge

#pragma mark - json delegates
-(NSDictionary  *)subclassedProperties {
    return @{
             @"requiredParameters": [MNFJsonAdapterSubclassedProperty subclassedPropertyWithClass: [MNFSyncAuthRequiredParameter class] option: kMNFAdapterOptionNoOption]
             };
}

@end
