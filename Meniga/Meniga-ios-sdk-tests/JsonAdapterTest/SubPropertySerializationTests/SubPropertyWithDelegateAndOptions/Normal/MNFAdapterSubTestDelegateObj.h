//
//  MNFAdapterSubTestDelegateObj.h
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 3/30/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MNFJsonAdapterDelegate.h"

@interface MNFAdapterSubTestDelegateObj : NSObject <MNFJsonAdapterDelegate>

@property (nonatomic, strong) NSString *uglyCommentTitle;
@property (nonatomic, strong) NSNumber *uglyCommentId;

+ (instancetype)adapterSubTestDelegateObjWithCommentId:(NSNumber *)theCommentId
                                          commentTitle:(NSString *)theCommentTitle;

@end
