//
//  MNFMainAdapterDelegateUppercaseTestObj.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 3/30/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFMainAdapterDelegateUppercaseTestObj.h"
#import "MNFJsonAdapterSubclassedProperty.h"

@implementation MNFMainAdapterDelegateUppercaseTestObj

+(instancetype)adapterDelegateUppercaseTestObjWithTransactionId:(NSNumber *)theTransactionId transactionInfo:(NSString *)theTransactionInfo comment:(MNFAdapterSubDelegateUppercaseTestObj *)theComment allComments:(NSArray *)allTheComments {
    
    MNFMainAdapterDelegateUppercaseTestObj *instance = [[MNFMainAdapterDelegateUppercaseTestObj alloc] init];
    instance.UGLYTRANSACTIONID = theTransactionId;
    instance.UGLYTRANSACTIONINFO = theTransactionInfo;
    instance.UGLYCOMMENT = theComment;
    instance.ALLUGLYCOMMENTS = allTheComments;
    
    return instance;
    
}

-(NSDictionary *)propertyKeysMapToJson {
    return @{ @"UGLYTRANSACTIONINFO" : @"TRANSACTIONINFO", @"UGLYTRANSACTIONID" : @"TRANSACTIONID", @"UGLYCOMMENT" : @"COMMENT", @"ALLUGLYCOMMENTS" : @"ALLCOMMENTS" };
}

-(NSDictionary *)jsonKeysMapToProperties {
    return @{ @"UGLYTRANSACTIONINFO" : @"TRANSACTIONINFO", @"UGLYTRANSACTIONID" : @"TRANSACTIONID", @"UGLYCOMMENT" : @"COMMENT", @"ALLUGLYCOMMENTS" : @"ALLCOMMENTS" };
}

-(NSDictionary*)subclassedProperties {
    return @{
             @"UGLYCOMMENT" : [MNFJsonAdapterSubclassedProperty subclassedPropertyWithClass:[MNFAdapterSubDelegateUppercaseTestObj class] delegate:[[MNFAdapterSubDelegateUppercaseTestObj alloc] init] option:kMNFAdapterOptionLowercase],
             @"ALLUGLYCOMMENTS" : [MNFJsonAdapterSubclassedProperty subclassedPropertyWithClass:[MNFAdapterSubDelegateUppercaseTestObj class] delegate:[[MNFAdapterSubDelegateUppercaseTestObj alloc] init] option:kMNFAdapterOptionLowercase]
             };
}

@end
