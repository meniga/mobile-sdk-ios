//
//  MNFJsonAdapterCustomCreationTestObject.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 4/10/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFJsonAdapterCustomCreationTestObject.h"

@implementation MNFJsonAdapterCustomCreationTestObject

- (id)init {
    if (self = [super init]) {
        _userId = nil;
        _postId = nil;
        _body = nil;
        _title = nil;
    }

    return self;
}

+ (instancetype)initWithUserId:(NSNumber *)userId
                        postId:(NSNumber *)thePostId
                          body:(NSString *)theBody
                         title:(NSString *)theTitle {
    MNFJsonAdapterCustomCreationTestObject *instance = [[self alloc] init];

    instance.userId = userId;
    instance.postId = thePostId;
    instance.body = theBody;
    instance.title = theTitle;

    return instance;
}

+ (id)objectToPopulate {
    MNFJsonAdapterCustomCreationTestObject *object = [[MNFJsonAdapterCustomCreationTestObject alloc] init];
    object.propertySetAtCustomInitialization = @"Great Stuff!";
    return object;
}

@end
