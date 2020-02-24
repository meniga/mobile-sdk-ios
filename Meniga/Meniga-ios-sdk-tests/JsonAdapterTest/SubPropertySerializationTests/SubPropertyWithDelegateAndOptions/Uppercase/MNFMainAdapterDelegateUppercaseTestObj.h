//
//  MNFMainAdapterDelegateUppercaseTestObj.h
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 3/30/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MNFAdapterSubDelegateUppercaseTestObj.h"
#import "MNFJsonAdapterDelegate.h"

@interface MNFMainAdapterDelegateUppercaseTestObj : NSObject <MNFJsonAdapterDelegate>

@property (nonatomic, strong) NSString *UGLYTRANSACTIONINFO;
@property (nonatomic, strong) NSNumber *UGLYTRANSACTIONID;
@property (nonatomic, strong) MNFAdapterSubDelegateUppercaseTestObj *UGLYCOMMENT;
@property (nonatomic, strong) NSArray *ALLUGLYCOMMENTS;

+(instancetype)adapterDelegateUppercaseTestObjWithTransactionId:(NSNumber *)theTransactionId transactionInfo:(NSString *)theTransactionInfo comment:(MNFAdapterSubDelegateUppercaseTestObj *)theComment allComments:(NSArray *)allTheComments;

@end
