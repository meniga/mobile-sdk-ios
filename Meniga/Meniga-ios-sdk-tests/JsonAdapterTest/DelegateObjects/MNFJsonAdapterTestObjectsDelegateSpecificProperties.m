//
//  MNFJsonAdapterTestObjectsDelegateSpecificProperties.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 10/30/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFJsonAdapterTestObjectsDelegateSpecificProperties.h"

@implementation MNFJsonAdapterTestObjectsDelegateSpecificProperties

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
    MNFJsonAdapterTestObjectsDelegateSpecificProperties *instance = [[self alloc] init];

    instance.userId = userId;
    instance.postId = thePostId;
    instance.body = theBody;
    instance.title = theTitle;

    return instance;
}

- (NSSet *)propertiesToDeserialize {
    return [NSSet setWithObjects:@"postId", @"userId", nil];
}

- (NSSet *)propertiesToSerialize {
    return [NSSet setWithObjects:@"userId", @"postId", nil];
}

- (NSDictionary *)jsonKeysMapToProperties {
    return @{ @"postId": @"id" };
}

- (NSDictionary *)propertyKeysMapToJson {
    return @{ @"postId": @"id" };
}

@end
