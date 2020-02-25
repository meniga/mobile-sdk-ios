//
//  MNFJsonAdapterTestDelegateConformingObject.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 10/23/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFJsonAdapterTestDelegateConformingObject.h"

@implementation MNFJsonAdapterTestDelegateConformingObject

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
    MNFJsonAdapterTestDelegateConformingObject *instance = [[self alloc] init];

    instance.userId = userId;
    instance.postId = thePostId;
    instance.body = theBody;
    instance.title = theTitle;

    return instance;
}

- (NSDictionary *)jsonKeysMapToProperties {
    return @{ @"postId": @"id" };
}

- (NSSet *)propertiesToIgnoreJsonDeserialization {
    return [NSSet setWithObjects:@"body", nil];
}

- (NSSet *)propertiesToIgnoreJsonSerialization {
    return [NSSet setWithObject:@"userId"];
}

- (NSDictionary *)propertyKeysMapToJson {
    return @{ @"postId": @"id" };
}

@end
