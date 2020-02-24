//
//  MNFOfferFilter.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 4/27/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFOfferFilter.h"
#import "MNFInternalImports.h"

@implementation MNFOfferFilter

-(id)init {
    
    if (self = [super init]) {
        
        self.expiredWithRedemptionsOnly = [NSNumber numberWithBool:NO];
        self.offerIds = nil;
        self.offerStates = nil;
        
    }
    
    return self;
}

-(NSDictionary *)propertyKeysMapToJson {
    return @{ @"expiredWithCashbackOnly" : @"filter.expiredWithCashbackOnly", @"offerIds" : @"filter.offerIds", @"offerStates" : @"filter.states", @"expiredWithRedemptionsOnly" : @"filter.expiredWithRedemptionsOnly"};
}

-(NSDictionary *)propertyValueTransformers {
    return @{ @"expiredWithCashbackOnly" : [MNFNumberToBoolValueTransformer transformer], @"skipMeta" : [MNFNumberToBoolValueTransformer transformer],
              @"expiredWithRedemptionsOnly" : [MNFNumberToBoolValueTransformer transformer]
              };
}


@end
