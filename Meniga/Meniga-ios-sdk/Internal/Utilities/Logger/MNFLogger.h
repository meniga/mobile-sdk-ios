//
//  MNFLogger.h
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 11/5/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <asl.h>
#import "MNFConstants.h"

#define MNFLogError(...) MNFLog(kMNFLogLevelError, __VA_ARGS__)
#define MNFLogInfo(...) MNFLog(kMNFLogLevelInfo, __VA_ARGS__)
#define MNFLogDebug(...) MNFLog(kMNFLogLevelDebug, __VA_ARGS__)
#define MNFLogWarning(...) MNFLog(kMNFLogLevelWarning, __VA_ARGS__)
#define MNFLogVerbose(...) MNFLog(kMNFLogLevelVerbose, __VA_ARGS__)

//Convenience macros

//Outputting a debug log with the returned data from a block based request.
#define kObjectBlockDataDebugLog \
    MNFLogDebug(@"[%@ %@] with result: %@", [self class], NSStringFromSelector(_cmd), response.result)
//Outputting a debug log with the returned data from a task based request.
#define kObjectTaskDataDebugLog \
    MNFLogDebug(@"[%@ %@] with result: %@", [self class], NSStringFromSelector(_cmd), result)

//Outputting an error log when unexpected class is returned from a block based request. Takes in the expected class.
#define kObjectBlockDataErrorLogWithExpectedClass(v)                                                 \
    MNFLogError([NSString stringWithFormat:@"Unexpected response data format. Expected: %@ Got: %@", \
                                           NSStringFromClass(v),                                     \
                                           NSStringFromClass([response.result class])])
//Outputting an error log when unexpected class is returned from a task based request. Takes in the expected class.
#define kObjectTaskDataErrorLogWithExpectedClass(v)                                                  \
    MNFLogError([NSString stringWithFormat:@"Unexpected response data format. Expected: %@ Got: %@", \
                                           NSStringFromClass(v),                                     \
                                           NSStringFromClass([task.result class])])
//Outputting a debug log when unexpected class is returned from a block based request. Takes in the expected class.
#define kObjectBlockDataDebugLogWithExpectedClass(v)                                                 \
    MNFLogDebug([NSString stringWithFormat:@"Unexpected response data format. Expected: %@ Got: %@", \
                                           NSStringFromClass(v),                                     \
                                           NSStringFromClass([response.result class])])
//Outputting an debug log when unexpected class is returned from a task based request. Takes in the expected class.
#define kObjectTaskDataDebugLogWithExpectedClass(v)                                                  \
    MNFLogDebug([NSString stringWithFormat:@"Unexpected response data format. Expected: %@ Got: %@", \
                                           NSStringFromClass(v),                                     \
                                           NSStringFromClass([task.result class])])

void MNFLog(int logLevel, NSString *format, ...);

@interface MNFLogger : NSObject

+ (void)setLogLevel:(MNFLogLevel)theLogLevel;

@end
