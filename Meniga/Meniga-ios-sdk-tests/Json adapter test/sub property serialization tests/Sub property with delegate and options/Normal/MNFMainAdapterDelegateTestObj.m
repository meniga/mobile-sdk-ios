//
//  MNFMainAdapterDelegateTestObj.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 3/30/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFMainAdapterDelegateTestObj.h"
#import "MNFJsonAdapterSubclassedProperty.h"

@implementation MNFMainAdapterDelegateTestObj

+(instancetype)adapterDelegateTestObjWithTransactionId:(NSNumber *)theTransactionId transactionInfo:(NSString *)theTransactionInfo comment:(MNFAdapterSubTestDelegateObj *)theComment allComments:(NSArray *)allTheComments {
    
    MNFMainAdapterDelegateTestObj *instance = [[MNFMainAdapterDelegateTestObj alloc] init];
    instance.uglyTransactionId = theTransactionId;
    instance.uglyTransactionInfo = theTransactionInfo;
    instance.uglyComment = theComment;
    instance.allUglyComments = allTheComments;
    
    return instance;
    
}

-(NSDictionary *)propertyKeysMapToJson {
    return @{ @"uglyTransactionInfo" : @"transactionInfo", @"uglyTransactionId" : @"transactionId", @"uglyComment" : @"comment", @"allUglyComments" : @"allComments" };
}

-(NSDictionary *)jsonKeysMapToProperties {
    return @{ @"uglyTransactionInfo" : @"transactionInfo", @"uglyTransactionId" : @"transactionId", @"uglyComment" : @"comment", @"allUglyComments" : @"allComments" };
}

-(NSDictionary*)subclassedProperties {
    return @{ @"uglyComment" : [MNFJsonAdapterSubclassedProperty subclassedPropertyWithClass:[MNFAdapterSubTestDelegateObj class] delegate:[[MNFAdapterSubTestDelegateObj alloc] init] option:kMNFAdapterOptionNoOption], @"allUglyComments" : [MNFJsonAdapterSubclassedProperty subclassedPropertyWithClass:[MNFAdapterSubTestDelegateObj class] delegate:[[MNFAdapterSubTestDelegateObj alloc] init] option:kMNFAdapterOptionNoOption] };
}

@end
