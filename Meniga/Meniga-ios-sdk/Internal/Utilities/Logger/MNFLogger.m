//
//  MNFLogger.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 11/5/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFLogger.h"
#include <asl.h>

static int classLogLevel = kMNFLogLevelInfo;
static aslclient defaultClient = nil;

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
            defaultClient = asl_open(NULL, "com.apple.console", ASL_OPT_STDERR);
        }

        const char *logString = [string UTF8String];
        int aslLogLevel = [MNFLogger appleLogLevelFromLogLevel:logLevel];

        asl_log(defaultClient, NULL, aslLogLevel, "%s", logString);
    }
}

@implementation MNFLogger

+ (void)setLogLevel:(MNFLogLevel)theLogLevel {
    classLogLevel = (int)theLogLevel;
}

+ (int)appleLogLevelFromLogLevel:(MNFLogLevel)theLogLevel {
    if (theLogLevel == kMNFLogLevelError) {
        return ASL_LEVEL_ERR;
    } else if (theLogLevel == kMNFLogLevelInfo) {
        return ASL_LEVEL_INFO;
    } else if (theLogLevel == kMNFLogLevelDebug) {
        return ASL_LEVEL_DEBUG;
    } else if (theLogLevel == kMNFLogLevelWarning) {
        return ASL_LEVEL_WARNING;
    } else if (theLogLevel == kMNFLogLevelVerbose) {
        return ASL_LEVEL_DEBUG;
    }

    return ASL_LEVEL_INFO;
}

@end
