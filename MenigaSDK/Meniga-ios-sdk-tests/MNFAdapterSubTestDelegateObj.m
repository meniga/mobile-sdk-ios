//
//  MNFAdapterSubTestDelegateObj.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 3/30/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFAdapterSubTestDelegateObj.h"

@implementation MNFAdapterSubTestDelegateObj

+(instancetype)adapterSubTestDelegateObjWithCommentId:(NSNumber *)theCommentId commentTitle:(NSString *)theCommentTitle {
    
    MNFAdapterSubTestDelegateObj *instance = [[MNFAdapterSubTestDelegateObj alloc] init];
    instance.uglyCommentId = theCommentId;
    instance.uglyCommentTitle = theCommentTitle;
    
    return instance;
    
}

-(NSDictionary *)jsonKeysMapToProperties {
    return @{ @"uglyCommentTitle" : @"commentTitle", @"uglyCommentId" : @"commentId" };
}

-(NSDictionary*)propertyKeysMapToJson {
    return @{ @"uglyCommentTitle" : @"commentTitle", @"uglyCommentId" : @"commentId" };
}



@end
