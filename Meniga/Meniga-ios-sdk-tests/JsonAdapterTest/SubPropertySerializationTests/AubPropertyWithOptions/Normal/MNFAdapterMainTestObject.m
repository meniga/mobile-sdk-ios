//
//  MNFAdapterMainTestObject.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 3/23/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFAdapterMainTestObject.h"
#import "MNFJsonAdapterSubclassedProperty.h"

@implementation MNFAdapterMainTestObject

+ (instancetype)adapterMainTestObjectWithTransactionId:(NSNumber *)theTransactionId
                                       transactionInfo:(NSString *)theTransactionInfo
                                               comment:(MNFAdapterSubTestObject *)theComment
                                           allComments:(NSArray<MNFAdapterSubTestObject *> *)theComments {
    MNFAdapterMainTestObject *mainObj = [[MNFAdapterMainTestObject alloc] init];

    mainObj.transactionId = theTransactionId;
    mainObj.transactionInfo = theTransactionInfo;
    mainObj.comment = theComment;
    mainObj.allComments = theComments;

    return mainObj;
}

- (NSDictionary *)subclassedProperties {
    return @{
        @"comment": [MNFJsonAdapterSubclassedProperty subclassedPropertyWithClass:[MNFAdapterSubTestObject class]
                                                                         delegate:nil
                                                                           option:kMNFAdapterOptionNoOption],
        @"allComments": [MNFJsonAdapterSubclassedProperty subclassedPropertyWithClass:[MNFAdapterSubTestObject class]
                                                                             delegate:nil
                                                                               option:kMNFAdapterOptionNoOption]
    };
}

@end
