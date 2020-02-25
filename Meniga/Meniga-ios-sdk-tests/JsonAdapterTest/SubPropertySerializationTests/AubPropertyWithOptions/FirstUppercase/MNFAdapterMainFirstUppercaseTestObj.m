//
//  MNFAdapterMainFirstUppercaseTestObj.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 3/30/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFAdapterMainFirstUppercaseTestObj.h"
#import "MNFJsonAdapterSubclassedProperty.h"

@implementation MNFAdapterMainFirstUppercaseTestObj

+ (instancetype)adapterMainFirstUppercaseTestObjWithTransactionId:(NSNumber *)theTransacitonId
                                                  transactionInfo:(NSString *)theTransactionInfo
                                                          comment:(MNFAdapterSubFirstUppercaseTestObject *)theComment
                                                      allComments:(NSArray *)theComments {
    MNFAdapterMainFirstUppercaseTestObj *instance = [[MNFAdapterMainFirstUppercaseTestObj alloc] init];

    instance.TransactionId = theTransacitonId;
    instance.TransactionInfo = theTransactionInfo;
    instance.Comment = theComment;
    instance.AllComments = theComments;

    return instance;
}

- (NSDictionary *)subclassedProperties {
    return @{
        @"Comment":
            [MNFJsonAdapterSubclassedProperty subclassedPropertyWithClass:[MNFAdapterSubFirstUppercaseTestObject class]
                                                                 delegate:nil
                                                                   option:kMNFAdapterOptionFirstLetterLowercase],
        @"AllComments":
            [MNFJsonAdapterSubclassedProperty subclassedPropertyWithClass:[MNFAdapterSubFirstUppercaseTestObject class]
                                                                 delegate:nil
                                                                   option:kMNFAdapterOptionFirstLetterLowercase]
    };
}

@end
