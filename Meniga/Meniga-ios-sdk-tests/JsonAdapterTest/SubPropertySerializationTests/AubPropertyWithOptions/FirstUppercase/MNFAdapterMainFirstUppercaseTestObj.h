//
//  MNFAdapterMainFirstUppercaseTestObj.h
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 3/30/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MNFAdapterSubFirstUppercaseTestObject.h"
#import "MNFJsonAdapterDelegate.h"

@interface MNFAdapterMainFirstUppercaseTestObj : NSObject <MNFJsonAdapterDelegate>

@property (nonatomic, strong) NSString *TransactionInfo;
@property (nonatomic, strong) NSNumber *TransactionId;
@property (nonatomic, strong) MNFAdapterSubFirstUppercaseTestObject *Comment;
@property (nonatomic, strong) NSArray *AllComments;

+ (instancetype)adapterMainFirstUppercaseTestObjWithTransactionId:(NSNumber *)theTransacitonId
                                                  transactionInfo:(NSString *)theTransactionInfo
                                                          comment:(MNFAdapterSubFirstUppercaseTestObject *)theComment
                                                      allComments:(NSArray *)theComments;

@end
