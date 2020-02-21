//
//  MNFAdapterMainTestObject.h
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 3/23/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MNFAdapterSubTestObject.h"
#import "MNFJsonAdapterDelegate.h"

@interface MNFAdapterMainTestObject : NSObject <MNFJsonAdapterDelegate>

@property (nonatomic, strong) NSString *transactionInfo;
@property (nonatomic, strong) NSNumber *transactionId;
@property (nonatomic, strong) MNFAdapterSubTestObject *comment;
@property (nonatomic, strong) NSArray *allComments;

+(instancetype)adapterMainTestObjectWithTransactionId:(NSNumber*)theTransactionId transactionInfo:(NSString *)theTransactionInfo comment:(MNFAdapterSubTestObject *)theComment allComments:(NSArray <MNFAdapterSubTestObject *> *)theComments;

@end
