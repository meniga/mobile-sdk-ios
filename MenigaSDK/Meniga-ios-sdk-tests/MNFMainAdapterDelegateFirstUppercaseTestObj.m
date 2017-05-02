//
//  MNFMainAdapterDelegateFirstUppercaseTestObj.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 3/30/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFMainAdapterDelegateFirstUppercaseTestObj.h"
#import "MNFJsonAdapterSubclassedProperty.h"

@implementation MNFMainAdapterDelegateFirstUppercaseTestObj

+(instancetype)adapterDelegateFirstUppercaseTestObjWithTransactionId:(NSNumber *)theTransactionId transactionInfo:(NSString *)theTransactionInfo comment:(MNFAdapterSubDelegateFirstUppercaseTestObj *)theComment allComments:(NSArray *)allTheComments {
    
    MNFMainAdapterDelegateFirstUppercaseTestObj *instance = [[MNFMainAdapterDelegateFirstUppercaseTestObj alloc] init];
    instance.UglyTransactionId = theTransactionId;
    instance.UglyTransactionInfo = theTransactionInfo;
    instance.UglyComment = theComment;
    instance.AllUglyComments = allTheComments;
    
    return instance;
    
}

-(NSDictionary *)propertyKeysMapToJson {
    return @{ @"UglyTransactionInfo" : @"TransactionInfo", @"UglyTransactionId" : @"TransactionId", @"UglyComment" : @"Comment", @"AllUglyComments" : @"AllComments" };
}

-(NSDictionary *)jsonKeysMapToProperties {
    return @{ @"UglyTransactionInfo" : @"TransactionInfo", @"UglyTransactionId" : @"TransactionId", @"UglyComment" : @"Comment", @"AllUglyComments" : @"AllComments" };
}

-(NSDictionary*)subclassedProperties {
    return @{
             @"UglyComment" : [MNFJsonAdapterSubclassedProperty subclassedPropertyWithClass:[MNFAdapterSubDelegateFirstUppercaseTestObj class] delegate:[[MNFAdapterSubDelegateFirstUppercaseTestObj alloc] init] option:kMNFAdapterOptionFirstLetterLowercase],
              @"AllUglyComments" : [MNFJsonAdapterSubclassedProperty subclassedPropertyWithClass:[MNFAdapterSubDelegateFirstUppercaseTestObj class] delegate:[[MNFAdapterSubDelegateFirstUppercaseTestObj alloc] init] option:kMNFAdapterOptionFirstLetterLowercase]
              };
}

@end
