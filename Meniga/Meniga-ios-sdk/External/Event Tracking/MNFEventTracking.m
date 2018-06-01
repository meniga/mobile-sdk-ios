//
//  MNFEventTracking.m
//  Meniga-ios-sdk
//
//  Created by Aske Bendtsen on 31/05/2018.
//  Copyright © 2018 Meniga. All rights reserved.
//

#import "MNFEventTracking.h"
#import "MNFInternalImports.h"

@implementation MNFEventTracking

+(MNFJob*)trackEventWithType:(NSString*)type state:(NSString*)state identifier:(NSNumber*)identifier media:(NSString*)media completion:(MNFErrorOnlyCompletionHandler)completion{
    
    NSMutableDictionary *jsonDict = [NSMutableDictionary new];
    jsonDict[@"trackingType"] = type;
    jsonDict[@"trackingState"] = state;
    jsonDict[@"trackerId"] = identifier;
    jsonDict[@"media"] = media;
    
    NSData *jsonDate = [MNFJsonAdapter JSONDataFromDictionary:jsonDict];
    
    __block MNFJob *job = [self apiRequestWithPath:kMNFApiPathEventTracking pathQuery:nil jsonBody:jsonDate HTTPMethod:kMNFHTTPMethodPOST service:MNFServiceNamePeerComparison completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        [MNFObject executeOnMainThreadWithJob:job completion:completion error:response.error];

    }];
    
    return job;
    
}

@end
