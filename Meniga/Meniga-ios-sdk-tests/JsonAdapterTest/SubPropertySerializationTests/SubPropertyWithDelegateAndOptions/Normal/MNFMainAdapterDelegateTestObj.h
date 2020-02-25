//
//  MNFMainAdapterDelegateTestObj.h
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 3/30/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MNFAdapterSubTestDelegateObj.h"
#import "MNFJsonAdapterDelegate.h"

@interface MNFMainAdapterDelegateTestObj : NSObject <MNFJsonAdapterDelegate>

@property (nonatomic, strong) NSString *uglyTransactionInfo;
@property (nonatomic, strong) NSNumber *uglyTransactionId;
@property (nonatomic, strong) MNFAdapterSubTestDelegateObj *uglyComment;
@property (nonatomic, strong) NSArray *allUglyComments;

+ (instancetype)adapterDelegateTestObjWithTransactionId:(NSNumber *)theTransactionId
                                        transactionInfo:(NSString *)theTransactionInfo
                                                comment:(MNFAdapterSubTestDelegateObj *)theComment
                                            allComments:(NSArray *)allTheComments;

@end
