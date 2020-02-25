//
//  MNFAdapterSubUppercaseTestObject.h
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 3/23/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MNFAdapterSubUppercaseTestObject : NSObject

@property (nonatomic, strong) NSNumber *COMMENTID;
@property (nonatomic, strong) NSString *COMMENTTITLE;

+ (instancetype)adapterSubUppercaseTestObjectWithCommentId:(NSNumber *)theCommentId
                                              commentTitle:(NSString *)theCommentTitle;

@end
