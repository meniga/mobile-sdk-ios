//
//  MNFAccountHistoryEntry.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 11/04/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFAccountHistoryEntry.h"
#import "MNFInternalImports.h"

@implementation MNFAccountHistoryEntry

#pragma mark - json delegates
-(NSDictionary*)jsonKeysMapToProperties {
    return @{@"identifier":@"id"};
}

-(NSDictionary*)propertyValueTransformers {
    return @{@"balanceDate":[MNFBasicDateValueTransformer transformer]};
}

-(NSSet *)propertiesToIgnoreJsonDeserialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

-(NSSet *)propertiesToIgnoreJsonSerialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

#pragma mark - Description
-(NSString*)description {
    return [NSString stringWithFormat:@"Account history entry %@ identifier: %@, accountId: %@, balance: %@, balanceDate: %@, isDefault: %@",[super description],self.identifier,self.accountId,self.balance,self.balanceDate,self.isDefault];
}
@end
