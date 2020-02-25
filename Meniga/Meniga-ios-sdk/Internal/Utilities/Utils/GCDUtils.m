//
//  GCDUtils.m
//  Meniga-ios-sdk
//
//  Created by Aske Bendtsen on 18/10/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "GCDUtils.h"

@implementation GCDUtils

+ (void)dispatchAfterTime:(float)theTime completion:(void (^)(void))completion {
    [completion copy];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(theTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        completion();
    });
}

@end
