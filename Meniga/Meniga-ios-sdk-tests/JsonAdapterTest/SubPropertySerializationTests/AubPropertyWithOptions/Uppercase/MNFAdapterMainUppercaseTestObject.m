//
//  MNFAdapterMainUppercaseTestOption.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 3/23/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFAdapterMainUppercaseTestObject.h"
#import "MNFJsonAdapterSubclassedProperty.h"

@implementation MNFAdapterMainUppercaseTestObject

+ (instancetype)adapterMainUppercaseTestObjWithTransactionId:(NSNumber *)theTransactionId
                                             transactionInfo:(NSString *)theTransactionInfo
                                                     comment:(MNFAdapterSubUppercaseTestObject *)theComment
                                                 allComments:(NSArray *)allTheComments {
    MNFAdapterMainUppercaseTestObject *instance = [[MNFAdapterMainUppercaseTestObject alloc] init];

    instance.TRANSACTIONID = theTransactionId;
    instance.TRANSACTIONINFO = theTransactionInfo;
    instance.COMMENT = theComment;
    instance.ALLCOMMENTS = allTheComments;

    return instance;
}

- (NSDictionary *)subclassedProperties {
    return @{
        @"COMMENT":
            [MNFJsonAdapterSubclassedProperty subclassedPropertyWithClass:[MNFAdapterSubUppercaseTestObject class]
                                                                 delegate:nil
                                                                   option:kMNFAdapterOptionLowercase],
        @"ALLCOMMENTS":
            [MNFJsonAdapterSubclassedProperty subclassedPropertyWithClass:[MNFAdapterSubUppercaseTestObject class]
                                                                 delegate:nil
                                                                   option:kMNFAdapterOptionLowercase]
    };
}

@end
