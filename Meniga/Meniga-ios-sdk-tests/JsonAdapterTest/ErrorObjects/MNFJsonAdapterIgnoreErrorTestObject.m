//
//  MNFJsonAdapterErrorTestObject.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 1/7/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFJsonAdapterIgnoreErrorTestObject.h"

@implementation MNFJsonAdapterIgnoreErrorTestObject

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
    MNFJsonAdapterIgnoreErrorTestObject *instance = [[self alloc] init];

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
    return [NSSet setWithObjects:@"newBody", nil];
}

- (NSSet *)propertiesToIgnoreJsonSerialization {
    return [NSSet setWithObject:@"newUserId"];
}

- (NSDictionary *)propertyKeysMapToJson {
    return @{ @"postId": @"id" };
}

@end
