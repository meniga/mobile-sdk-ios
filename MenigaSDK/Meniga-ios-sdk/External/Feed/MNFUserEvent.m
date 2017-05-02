//
//  MNFUserEvent.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 23/10/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFUserEvent.h"
#import "MNFInternalImports.h"
#import "MNFBasicDateValueTransformer.h"

@interface MNFUserEvent () <MNFJsonAdapterDelegate>

@end

@implementation MNFUserEvent

-(NSDictionary*)jsonKeysMapToProperties {
    return @{ @"identifier" : @"id" };
}
-(NSDictionary*)propertyKeysMapToJson {
    return @{ @"id" : @"identifier" };
}
-(NSSet*)propertiesToIgnoreJsonDeserialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

-(NSDictionary *)propertyValueTransformers {
    
    return @{ @"date" :  [MNFBasicDateValueTransformer transformer] };
    
}

@end
