//
//  MNFAdapterSubDelegateUppercaseTestObj.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 3/30/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFAdapterSubDelegateUppercaseTestObj.h"

@implementation MNFAdapterSubDelegateUppercaseTestObj

+(instancetype)adapterSubDelegateUppercaseTestObjWithCommentId:(NSNumber *)theCommentId commentTitle:(NSString *)theCommentTitle {
    
    MNFAdapterSubDelegateUppercaseTestObj *instance = [[MNFAdapterSubDelegateUppercaseTestObj alloc] init];
    instance.UGLYCOMMENTID = theCommentId;
    instance.UGLYCOMMENTTITLE = theCommentTitle;
    
    return instance;
    
}

-(NSDictionary *)jsonKeysMapToProperties {
    return @{ @"UGLYCOMMENTTITLE" : @"COMMENTTITLE", @"UGLYCOMMENTID" : @"COMMENTID" };
}

-(NSDictionary*)propertyKeysMapToJson {
    return @{ @"UGLYCOMMENTTITLE" : @"COMMENTTITLE", @"UGLYCOMMENTID" : @"COMMENTID" };
}

@end
