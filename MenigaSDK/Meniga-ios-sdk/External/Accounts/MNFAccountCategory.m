//
//  MNFNetworthType.m
//  Meniga-ios-sdk
//
//  Created by Aske Bendtsen on 31/03/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFAccountCategory.h"
#import "MNFInternalImports.h"


@implementation MNFAccountCategory

#pragma mark - json delegate

-(NSDictionary*)propertyKeysMapToJson{
    return @{@"identifier":@"id"};
}

-(NSDictionary*)jsonKeysMapToProperties{
    return @{@"identifier":@"id"};
}

-(NSSet *)propertiesToIgnoreJsonDeserialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

-(NSSet *)propertiesToIgnoreJsonSerialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

#pragma mark - Description
-(NSString*)description {
    return [NSString stringWithFormat:@"Account type %@ identifier: %@, name: %@",[super description],self.identifier,self.name];
}
@end
