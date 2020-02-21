//
//  MNFAdapterSubDelegateUppercaseTestObj.h
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 3/30/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MNFJsonAdapterDelegate.h"

@interface MNFAdapterSubDelegateUppercaseTestObj : NSObject <MNFJsonAdapterDelegate>

@property (nonatomic, strong) NSString *UGLYCOMMENTTITLE;
@property (nonatomic, strong) NSNumber *UGLYCOMMENTID;

+(instancetype)adapterSubDelegateUppercaseTestObjWithCommentId:(NSNumber *)theCommentId commentTitle:(NSString *)theCommentTitle;

@end
