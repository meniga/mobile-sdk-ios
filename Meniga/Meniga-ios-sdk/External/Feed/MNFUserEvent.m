//
//  MNFUserEvent.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 23/10/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFUserEvent.h"
#import "MNFInternalImports.h"
#import "MNFBasicDateValueTransformer.h"

@interface MNFUserEvent () <MNFJsonAdapterDelegate>

@end

@implementation MNFUserEvent

+ (MNFJob *)subscribeToUserEvents:(NSArray<NSString *> *)userEventTypeIdentifiers onChannel:(NSString *)channelName withCompletion:(MNFErrorOnlyCompletionHandler)completion {
    
    [completion copy];
    
    NSMutableDictionary *jsonDict = [NSMutableDictionary dictionary];
    jsonDict[@"isSubscribed"] = @"true";
    jsonDict[@"channelName"] = channelName;
    jsonDict[@"userEventTypeIdentifiers"] = userEventTypeIdentifiers;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[jsonDict copy] options:0 error:nil];
    
    __block MNFJob *job = [self apiRequestWithPath:kMNFUserEventsSubscription pathQuery:nil jsonBody:jsonData HTTPMethod:kMNFHTTPMethodPUT service:MNFServiceNameUserEvents completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        [MNFObject executeOnMainThreadWithJob:job completion:completion error:response.error];
    }];
    
    return job;
}

+ (MNFJob *)unsubscribeFromUserEvents:(NSArray<NSString *> *)userEventTypeIdentifiers onChannel:(NSString *)channelName withReason:(NSString *)unsubscriptionReason completion:(MNFErrorOnlyCompletionHandler)completion {
    
    [completion copy];
    
    NSMutableDictionary *jsonDict = [NSMutableDictionary dictionary];
    jsonDict[@"isSubscribed"] = @"false";
    jsonDict[@"channelName"] = channelName;
    jsonDict[@"userEventTypeIdentifiers"] = userEventTypeIdentifiers;
    jsonDict[@"unsubscriptionReason"] = unsubscriptionReason;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[jsonDict copy] options:0 error:nil];
    
    __block MNFJob *job = [self apiRequestWithPath:kMNFUserEventsSubscription pathQuery:nil jsonBody:jsonData HTTPMethod:kMNFHTTPMethodPUT service:MNFServiceNameUserEvents completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        [MNFObject executeOnMainThreadWithJob:job completion:completion error:response.error];
    }];
    
    return job;
}

+ (MNFJob *)fetchEventTypesWithCompletion:(void (^)(NSArray<NSString *> * _Nullable, NSError * _Nullable))completion {
    
    [completion copy];
    
    __block MNFJob *job = [self apiRequestWithPath:kMNFUserEventTypes pathQuery:nil jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameUserEvents completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
            
            if ([response.result isKindOfClass:[NSArray class]]) {
                
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:response.result error:nil];
                
            }
            else {
                
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error: [MNFErrorUtils errorForUnexpectedDataOfType:[response.result class] expected:[NSArray class]] ];
                
            }
        }
        else {
            
            [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error:response.error];
            
        }
    }];
    
    
    return job;
}

-(NSDictionary*)jsonKeysMapToProperties {
    return @{ @"identifier" : @"id" };
}
-(NSDictionary*)propertyKeysMapToJson {
    return @{ @"id" : @"identifier" };
}
-(NSSet*)propertiesToIgnoreJsonDeserialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

-(NSDictionary *)propertyValueTransformers {
    
    return @{ @"date" :  [MNFBasicDateValueTransformer transformer] };
    
}

@end
