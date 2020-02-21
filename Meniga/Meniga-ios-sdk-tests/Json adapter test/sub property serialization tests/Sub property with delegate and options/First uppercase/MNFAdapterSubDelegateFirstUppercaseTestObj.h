//
//  MNFAdapterSubDelegateFirstUppercaseTestObj.h
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 3/30/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MNFJsonAdapterDelegate.h"

@interface MNFAdapterSubDelegateFirstUppercaseTestObj : NSObject <MNFJsonAdapterDelegate>

@property (nonatomic, strong) NSString *UglyCommentTitle;
@property (nonatomic, strong) NSNumber *UglyCommentId;

+(instancetype)adapterSubDelegateFirstUppercaseTestObjWithCommentId:(NSNumber *)theCommentId commentTitle:(NSString *)theCommentTitle;

@end
