//
//  MNFAdapterSubTestObject.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 3/23/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFAdapterSubTestObject.h"

@implementation MNFAdapterSubTestObject

+ (instancetype)adapterSubTestObjectWithCommentId:(NSNumber *)theCommentId commentTitle:(NSString *)theCommentTitle {
    MNFAdapterSubTestObject *subObj = [[MNFAdapterSubTestObject alloc] init];

    subObj.commentId = theCommentId;
    subObj.commentTitle = theCommentTitle;

    return subObj;
}

@end
