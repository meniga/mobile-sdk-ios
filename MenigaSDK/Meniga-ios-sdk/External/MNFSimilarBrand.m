//
//  MNFSimilarBrand.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 5/17/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFSimilarBrand.h"
#import "MNFBasicDateValueTransformer.h"

@interface MNFSimilarBrandMetaData () <MNFJsonAdapterDelegate>

@end

@implementation MNFSimilarBrandMetaData

-(NSDictionary *)propertyValueTransformers {
    return @{ @"startDate" : [MNFBasicDateValueTransformer transformer], @"endDate" : [MNFBasicDateValueTransformer transformer] };
}

@end

@interface MNFSimilarBrand () <MNFJsonAdapterDelegate>


@end

@implementation MNFSimilarBrand

-(NSDictionary *)propertyKeysMapToJson {
    
    return @{
             @"identifier" : @"id"
             };
    
}

-(NSDictionary *)jsonKeysMapToProperties {
    return @{
             @"identifier" : @"id"
             };
}

@end
