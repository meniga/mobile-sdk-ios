//
//  MNFAdapterSubPropertyMappingDelegateFirstUppercaseDelegate.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 4/13/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFAdapterSubPropertyMappingDelegateFirstUppercaseDelegate.h"
#import "MNFAdapterSubTestDelegateObj.h"
#import "MNFJsonAdapterSubclassedProperty.h"

@implementation MNFAdapterSubPropertyMappingDelegateFirstUppercaseDelegate

- (NSDictionary *)propertyKeysMapToJson {
    return @{
        @"uglyTransactionInfo": @"transactionInfo",
        @"uglyTransactionId": @"transactionId",
        @"uglyComment": @"comment",
        @"allUglyComments": @"allComments"
    };
}

- (NSDictionary *)jsonKeysMapToProperties {
    return @{
        @"uglyTransactionInfo": @"transactionInfo",
        @"uglyTransactionId": @"transactionId",
        @"uglyComment": @"comment",
        @"allUglyComments": @"allComments"
    };
}

- (NSDictionary *)subclassedProperties {
    return @{
        @"uglyComment":
            [MNFJsonAdapterSubclassedProperty subclassedPropertyWithClass:[MNFAdapterSubTestDelegateObj class]
                                                                 delegate:[[MNFAdapterSubTestDelegateObj alloc] init]
                                                                   option:kMNFAdapterOptionFirstLetterUppercase],
        @"allUglyComments":
            [MNFJsonAdapterSubclassedProperty subclassedPropertyWithClass:[MNFAdapterSubTestDelegateObj class]
                                                                 delegate:[[MNFAdapterSubTestDelegateObj alloc] init]
                                                                   option:kMNFAdapterOptionFirstLetterUppercase]
    };
}
@end
