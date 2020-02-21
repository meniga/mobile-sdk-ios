//
//  MNFJsonAdapterTestObject.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 10/23/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFJsonAdapterTestObject.h"
#import "MNFJsonAdapter.h"

@implementation MNFJsonAdapterTestObject

-(id)init {
    if (self = [super init]) {
        _userId = nil;
        _postId = nil;
        _body = nil;
        _title = nil;
    }
    
    return self;
}

+(instancetype)initWithUserId:(NSNumber *)userId postId:(NSNumber *)thePostId body:(NSString *)theBody title:(NSString *)theTitle {
    
    MNFJsonAdapterTestObject *instance = [[self alloc] init];
    
    instance.userId = userId;
    instance.postId = thePostId;
    instance.body = theBody;
    instance.title = theTitle;
    
    return instance;
}

@end
