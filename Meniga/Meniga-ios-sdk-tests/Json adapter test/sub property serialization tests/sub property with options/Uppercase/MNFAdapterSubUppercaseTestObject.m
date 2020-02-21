//
//  MNFAdapterSubUppercaseTestObject.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 3/23/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFAdapterSubUppercaseTestObject.h"

@implementation MNFAdapterSubUppercaseTestObject

+(instancetype)adapterSubUppercaseTestObjectWithCommentId:(NSNumber *)theCommentId commentTitle:(NSString *)theCommentTitle {
    
    MNFAdapterSubUppercaseTestObject *instance = [[MNFAdapterSubUppercaseTestObject alloc] init];
    instance.COMMENTID = theCommentId;
    instance.COMMENTTITLE = theCommentTitle;
    
    return instance;
    
}

@end
