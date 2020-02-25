//
//  MNFIntegrationAuthProvider.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 4/19/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFIntegrationAuthProvider.h"
#import "MNFDemoUser.h"

@implementation MNFIntegrationAuthProvider

- (NSDictionary *)getHeaders {
    NSString *authString =
        [NSString stringWithFormat:@"Bearer %@", [[MNFDemoUser tokenDictionary] objectForKey:@"accessToken"]];
    return @{ @"X-XSRF-Header": @"true", @"Content-type": @"application/json", @"Authorization": authString };
}
- (NSArray<NSHTTPCookie *> *)getCookies {
    return nil;
}

@end
