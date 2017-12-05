//
//  MNFOfferTransaction.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 5/12/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFOfferTransaction.h"
#import "MNFBasicDateValueTransformer.h"

@interface MNFOfferTransaction () <MNFJsonAdapterDelegate>

@end

@implementation MNFOfferTransaction

-(NSDictionary *)propertyValueTransformers {
    return @{
             @"date" : [MNFBasicDateValueTransformer transformer],
             @"reimbursementDate" : [MNFBasicDateValueTransformer transformer],
             @"scheduledReimbursementDate" : [MNFBasicDateValueTransformer transformer]
             };
}

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
