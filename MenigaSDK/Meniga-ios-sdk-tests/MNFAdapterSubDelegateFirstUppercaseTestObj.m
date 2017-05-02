//
//  MNFAdapterSubDelegateFirstUppercaseTestObj.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 3/30/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFAdapterSubDelegateFirstUppercaseTestObj.h"

@implementation MNFAdapterSubDelegateFirstUppercaseTestObj

+(instancetype)adapterSubDelegateFirstUppercaseTestObjWithCommentId:(NSNumber *)theCommentId commentTitle:(NSString *)theCommentTitle {
    
    MNFAdapterSubDelegateFirstUppercaseTestObj *instance = [[MNFAdapterSubDelegateFirstUppercaseTestObj alloc] init];
    instance.UglyCommentId = theCommentId;
    instance.UglyCommentTitle = theCommentTitle;
    
    return instance;
    
}

-(NSDictionary *)jsonKeysMapToProperties {
    return @{ @"UglyCommentTitle" : @"CommentTitle", @"UglyCommentId" : @"CommentId" };
}

-(NSDictionary*)propertyKeysMapToJson {
    return @{ @"UglyCommentTitle" : @"CommentTitle", @"UglyCommentId" : @"CommentId" };
}


@end
