//
//  MNFJsonAdapterTestObjectsDelegateSpecificProperties.h
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 10/30/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MNFJsonAdapter.h"

@interface MNFJsonAdapterTestObjectsDelegateSpecificProperties : NSObject <MNFJsonAdapterDelegate>

@property (nonatomic, strong) NSNumber *userId;
@property (nonatomic, strong) NSNumber *postId;
@property (nonatomic, strong) NSString *body;
@property (nonatomic, strong) NSString *title;

+ (instancetype)initWithUserId:(NSNumber *)userId
                        postId:(NSNumber *)thePostId
                          body:(NSString *)theBody
                         title:(NSString *)theTitle;

@end
