//
//  MNFAdapterSubFirstUppercaseTestObject.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 3/30/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFAdapterSubFirstUppercaseTestObject.h"

@implementation MNFAdapterSubFirstUppercaseTestObject

+ (instancetype)adapterSubFirstUppercaseTestObjWithCommentId:(NSNumber *)theCommentId
                                                commentTitle:(NSString *)theCommentTitle {
    MNFAdapterSubFirstUppercaseTestObject *instance = [[MNFAdapterSubFirstUppercaseTestObject alloc] init];
    instance.CommentId = theCommentId;
    instance.CommentTitle = theCommentTitle;

    return instance;
}

@end
