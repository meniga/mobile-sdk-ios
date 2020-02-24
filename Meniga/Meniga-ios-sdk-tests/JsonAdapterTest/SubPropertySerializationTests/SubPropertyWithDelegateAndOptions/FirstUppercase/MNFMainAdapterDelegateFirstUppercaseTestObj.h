//
//  MNFMainAdapterDelegateFirstUppercaseTestObj.h
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 3/30/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MNFAdapterSubDelegateFirstUppercaseTestObj.h"
#import "MNFJsonAdapterDelegate.h"

@interface MNFMainAdapterDelegateFirstUppercaseTestObj : NSObject <MNFJsonAdapterDelegate>

@property (nonatomic, strong) NSString *UglyTransactionInfo;
@property (nonatomic, strong) NSNumber *UglyTransactionId;
@property (nonatomic, strong) MNFAdapterSubDelegateFirstUppercaseTestObj *UglyComment;
@property (nonatomic, strong) NSArray *AllUglyComments;

+(instancetype)adapterDelegateFirstUppercaseTestObjWithTransactionId:(NSNumber *)theTransactionId transactionInfo:(NSString *)theTransactionInfo comment:(MNFAdapterSubDelegateFirstUppercaseTestObj *)theComment allComments:(NSArray *)allTheComments;

@end
