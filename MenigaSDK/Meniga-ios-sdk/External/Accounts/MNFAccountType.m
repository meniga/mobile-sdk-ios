//
//  MNFRealmAccountType.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 11/04/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFAccountType.h"

@implementation MNFAccountType

#pragma mark - json adapter delegates
-(NSDictionary*)jsonKeysMapToProperties {
    return @{@"identifier":@"id",
             @"accountDescription":@"description"};
}

-(NSSet *)propertiesToIgnoreJsonDeserialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

-(NSSet *)propertiesToIgnoreJsonSerialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

#pragma mark - Description
-(NSString*)description {
    return [NSString stringWithFormat:@"Realm account type %@ identifier: %@, accountDescription: %@, accountType: %@, name: %@",[super description],self.identifier,self.accountDescription,self.accountType,self.name];
}

@end
