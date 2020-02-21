//
//  MNFJsonAdapterCustomCreationTestObject.h
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 4/10/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MNFJsonAdapter.h"

@interface MNFJsonAdapterCustomCreationTestObject : NSObject <MNFJsonAdapterDelegate>

@property (nonatomic, strong) NSNumber *userId;
@property (nonatomic, strong) NSNumber *postId;
@property (nonatomic, strong) NSString *body;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *propertySetAtCustomInitialization;

+(instancetype)initWithUserId:(NSNumber *)userId postId:(NSNumber *)thePostId body:(NSString *)theBody title:(NSString *)theTitle;

@end
