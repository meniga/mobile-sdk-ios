//
//  MNFAdapterSubFirstUppercaseTestObject.h
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 3/30/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MNFAdapterSubFirstUppercaseTestObject : NSObject

@property (nonatomic, strong) NSString *CommentTitle;
@property (nonatomic, strong) NSNumber *CommentId;

+(instancetype)adapterSubFirstUppercaseTestObjWithCommentId:(NSNumber *)theCommentId commentTitle:(NSString *)theCommentTitle;

@end
