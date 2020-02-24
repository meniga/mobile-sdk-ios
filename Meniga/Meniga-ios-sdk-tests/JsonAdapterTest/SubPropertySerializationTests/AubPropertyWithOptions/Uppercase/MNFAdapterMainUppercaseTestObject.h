//
//  MNFAdapterMainUppercaseTestOption.h
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 3/23/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MNFAdapterSubUppercaseTestObject.h"
#import "MNFJsonAdapterDelegate.h"

@interface MNFAdapterMainUppercaseTestObject : NSObject <MNFJsonAdapterDelegate>

@property (nonatomic, strong) NSNumber *TRANSACTIONID;
@property (nonatomic, strong) NSString *TRANSACTIONINFO;
@property (nonatomic, strong) MNFAdapterSubUppercaseTestObject *COMMENT;
@property (nonatomic, strong) NSArray *ALLCOMMENTS;

+(instancetype)adapterMainUppercaseTestObjWithTransactionId:(NSNumber *)theTransactionId transactionInfo:(NSString *)theTransactionInfo comment:(MNFAdapterSubUppercaseTestObject *)theComment allComments:(NSArray *)allTheComments;

@end
