//
//  MNFJsonAdapterTestObjectPropertiesFirstUppercaseDelegate.h
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 10/30/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MNFJsonAdapter.h"

@interface MNFJsonAdapterTestObjectPropertiesFirstUppercaseDelegate : NSObject <MNFJsonAdapterDelegate>

@property (nonatomic, strong) NSNumber *UserId;
@property (nonatomic, strong) NSNumber *PostId;
@property (nonatomic, strong) NSString *Body;
@property (nonatomic, strong) NSString *Title;

+(instancetype)initWithUserId:(NSNumber *)userId postId:(NSNumber *)thePostId body:(NSString *)theBody title:(NSString *)theTitle;

@end
