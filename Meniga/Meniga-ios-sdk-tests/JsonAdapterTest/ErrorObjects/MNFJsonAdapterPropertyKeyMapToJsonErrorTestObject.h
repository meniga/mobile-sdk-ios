//
//  MNFJsonAdapterPropertyKeyMapToJsonErrorTestObject.h
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 1/7/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MNFJsonAdapter.h"

@interface MNFJsonAdapterPropertyKeyMapToJsonErrorTestObject : NSObject <MNFJsonAdapterDelegate>

@property (nonatomic, strong) NSNumber *userId;
@property (nonatomic, strong) NSNumber *postId;
@property (nonatomic, strong) NSString *body;
@property (nonatomic, strong) NSString *title;

+ (instancetype)initWithUserId:(NSNumber *)userId
                        postId:(NSNumber *)thePostId
                          body:(NSString *)theBody
                         title:(NSString *)theTitle;

@end
