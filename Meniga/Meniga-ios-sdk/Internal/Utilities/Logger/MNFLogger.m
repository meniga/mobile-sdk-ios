//
//  MNFLogger.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 11/5/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFLogger.h"
#import "OSLog/OSLog.h"

static int classLogLevel = kMNFLogLevelInfo;
static os_log_t defaultClient = nil;

@interface MNFLogger () {
}

+ (int)appleLogLevelFromLogLevel:(MNFLogLevel)theLogLevel;

@end

void MNFLog(int logLevel, NSString *format, ...) {
    if (logLevel == classLogLevel) {
        va_list args;

        va_start(args, format);
        NSString *string = [[NSString alloc] initWithFormat:format arguments:args];
        va_end(args);

        if (defaultClient == nil) {
        NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
        defaultClient = os_log_create([bundleIdentifier UTF8String] , "");
        }
     
        int osLogLevel = [MNFLogger appleLogLevelFromLogLevel:logLevel];
        
        os_log_with_type(defaultClient, osLogLevel, "%@", string);
    }
}

@implementation MNFLogger

+ (void)setLogLevel:(MNFLogLevel)theLogLevel {
    classLogLevel = (int)theLogLevel;
}

+ (int)appleLogLevelFromLogLevel:(MNFLogLevel)theLogLevel {
    if (theLogLevel == kMNFLogLevelError) {
        return OS_LOG_TYPE_ERROR;
    } else if (theLogLevel == kMNFLogLevelInfo) {
        return OS_LOG_TYPE_INFO;
    } else if (theLogLevel == kMNFLogLevelDebug) {
        return OS_LOG_TYPE_DEBUG;
    } else if (theLogLevel == kMNFLogLevelWarning) {
        return OS_LOG_TYPE_FAULT;
    } else if (theLogLevel == kMNFLogLevelVerbose) {
        return OS_LOG_TYPE_DEFAULT;
    }

    return OS_LOG_TYPE_DEFAULT;
}

@end
