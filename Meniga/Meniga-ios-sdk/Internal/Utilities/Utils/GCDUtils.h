//
//  GCDUtils.h
//  Meniga-ios-sdk
//
//  Created by Aske Bendtsen on 18/10/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCDUtils : NSObject

+ (void)dispatchAfterTime:(float)theTime completion:(void (^)(void))completion;

@end
