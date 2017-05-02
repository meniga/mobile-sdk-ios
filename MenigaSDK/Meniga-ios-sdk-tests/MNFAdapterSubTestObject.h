//
//  MNFAdapterSubTestObject.h
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 3/23/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MNFAdapterSubTestObject : NSObject

@property (nonatomic, strong) NSString *commentTitle;
@property (nonatomic, strong) NSNumber *commentId;

+(instancetype)adapterSubTestObjectWithCommentId:(NSNumber *)theCommentId commentTitle:(NSString *)theCommentTitle;

@end
