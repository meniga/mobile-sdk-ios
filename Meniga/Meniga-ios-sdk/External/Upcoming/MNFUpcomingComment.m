//
//  MNFUpcomingComment.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 30/09/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFUpcomingComment.h"
#import "MNFInternalImports.h"

@implementation MNFUpcomingComment

#pragma mark - json adaptor delegate

- (NSDictionary *)jsonKeysMapToProperties {
    return @{ @"identifier": @"id" };
}
- (NSDictionary *)propertyValueTransformers {
    return @{
        @"created": [MNFBasicDateValueTransformer transformer],
        @"modified": [MNFBasicDateValueTransformer transformer]
    };
}

@end
