//
//  MNFJsonAdapterTestObjectPropertiesFirstUppercaseDelegate.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 10/30/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFJsonAdapterTestObjectPropertiesFirstUppercaseDelegate.h"

@implementation MNFJsonAdapterTestObjectPropertiesFirstUppercaseDelegate

-(id)init {
    if (self = [super init]) {
        _UserId = nil;
        _PostId = nil;
        _Body = nil;
        _Title = nil;
    }
    
    return self;
}

+(instancetype)initWithUserId:(NSNumber *)userId postId:(NSNumber *)thePostId body:(NSString *)theBody title:(NSString *)theTitle {
    
    MNFJsonAdapterTestObjectPropertiesFirstUppercaseDelegate *instance = [[self alloc] init];
    
    instance.UserId = userId;
    instance.PostId = thePostId;
    instance.Body = theBody;
    instance.Title = theTitle;
    
    return instance;
}

-(NSDictionary *)jsonKeysMapToProperties {
    return @{ @"PostId" : @"Id"
              };
}

-(NSSet *)propertiesToIgnoreJsonDeserialization {
    return [NSSet setWithObjects:@"Body", nil];
}


-(NSSet *)propertiesToIgnoreJsonSerialization {
    return  [NSSet setWithObject:@"UserId"];
}

-(NSDictionary *)propertyKeysMapToJson {
    return @{ @"PostId" : @"Id" };
}

@end
