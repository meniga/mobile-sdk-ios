//
//  MNFCategoryType.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 4/11/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFCategoryType.h"
#import "MNFNumberToStringValueTransformer.h"

@implementation MNFCategoryType

-(NSDictionary *)jsonKeysMapToProperties {
    return @{ @"identifier" : @"id" };
}

-(NSDictionary *)propertyKeysMapToJson {
    return @{ @"identifier" : @"id" };
}

-(NSDictionary *)propertyValueTransformers {
    return @{ @"identifier" : [MNFNumberToStringValueTransformer transformer] };
}

-(NSSet *)propertiesToIgnoreJsonDeserialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

-(NSSet *)propertiesToIgnoreJsonSerialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

#pragma mark - Description
-(NSString*)description {
    return [NSString stringWithFormat:@"Category type %@ identifier: %@, name: %@",[super description],self.identifier,self.name];
}

@end
