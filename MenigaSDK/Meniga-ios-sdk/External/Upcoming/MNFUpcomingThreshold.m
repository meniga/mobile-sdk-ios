//
//  MNFUpcomingThreshold.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 30/09/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFUpcomingThreshold.h"
#import "MNFInternalImports.h"

@implementation MNFUpcomingThreshold

+(MNFJob*)fetchWithId:(NSNumber *)identifier completion:(MNFThresholdCompletionHandler)completion {
    [completion copy];
    
    NSString *path = [NSString stringWithFormat:@"%@/%@",kMNFUpcomingThresholds,[identifier stringValue]];
    
    __block MNFJob *job = [MNFObject apiRequestWithPath:path pathQuery:nil jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameUpcoming completion:^(MNFResponse * _Nullable response) {
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
            if ([response.result isKindOfClass:[NSDictionary class]]) {
                
                MNFUpcomingThreshold *threshold = [MNFUpcomingThreshold initWithServerResult:response.result];
                
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:threshold error:nil];
                
            }
            else {
                
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error:[MNFErrorUtils errorForUnexpectedDataOfType:[response.result class] expected:[NSDictionary class]]];
            }
        }
        else {
            
            [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error:response.error];
        }
    }];
    
    return job;
}

+(MNFJob*)fetchThresholdsWithAccountIds:(NSString *)accountIds completion:(MNFMultipleThresholdsCompletionHandler)completion {
    [completion copy];
    
    NSMutableDictionary *jsonQuery = [NSMutableDictionary dictionary];
    jsonQuery[@"accountIds"] = accountIds;
    
    __block MNFJob *job = [MNFObject apiRequestWithPath:kMNFUpcomingThresholds pathQuery:[jsonQuery copy] jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameUpcoming completion:^(MNFResponse * _Nullable response) {
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
            if ([response.result isKindOfClass:[NSArray class]]) {
                
                NSArray *thresholds = [MNFUpcomingThreshold initWithServerResults:response.result];
                
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:thresholds error:nil];
                
            }
            else {
                
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error:[MNFErrorUtils errorForUnexpectedDataOfType:[response.result class] expected:[NSArray class]]];
            }
        }
        else {
            
            [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error:response.error];
        }
    }];
    
    return job;
}

+(MNFJob*)createThresholdWithValue:(NSNumber *)value isUpperLimit:(NSNumber *)isUpperLimit accountIds:(NSString *)accountIds completion:(MNFThresholdCompletionHandler)completion {
    [completion copy];
    
    NSMutableDictionary *jsonDict = [NSMutableDictionary dictionary];
    jsonDict[@"value"] = value;
    jsonDict[@"isUpperLimit"] = isUpperLimit;
    jsonDict[@"accountIds"] = accountIds;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[jsonDict copy] options:0 error:nil];
    
    __block MNFJob *job = [MNFObject apiRequestWithPath:kMNFUpcomingThresholds pathQuery:nil jsonBody:jsonData HTTPMethod:kMNFHTTPMethodPOST service:MNFServiceNameUpcoming completion:^(MNFResponse * _Nullable response) {
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
            if ([response.result isKindOfClass:[NSDictionary class]]) {
                
                MNFUpcomingThreshold *threshold = [MNFUpcomingThreshold initWithServerResult:response.result];
                
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:threshold error:nil];
                
            }
            else {
                
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error:[MNFErrorUtils errorForUnexpectedDataOfType:[response.result class] expected:[NSDictionary class]]];
            }
        }
        else {
            
            [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error:response.error];
        }
    }];
    
    return job;
}

-(MNFJob*)deleteThresholdWithCompletion:(MNFErrorOnlyCompletionHandler)completion {
    [completion copy];
    
    NSString *path = [NSString stringWithFormat:@"%@/%@",kMNFUpcomingThresholds,[self.identifier stringValue]];
    
    __block MNFJob *job = [self deleteWithApiPath:path pathQuery:nil jsonBody:nil service:MNFServiceNameUpcoming completion:^(MNFResponse * _Nullable response) {
        kObjectBlockDataDebugLog;
        
        [MNFObject executeOnMainThreadWithJob:job completion:completion error: response.error];
    }];
    
    return job;
}

-(MNFJob*)saveWithCompletion:(MNFErrorOnlyCompletionHandler)completion {
    [completion copy];
    
    NSString *path = [NSString stringWithFormat:@"%@/%@",kMNFUpcomingThresholds,[self.identifier stringValue]];
    
    NSDictionary *jsonDict = @{@"value":self.value,@"isUpperLimit":self.isUpperLimit};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDict options:0 error:nil];
    
    __block MNFJob *job = [self updateWithApiPath:path pathQuery:nil jsonBody:jsonData httpMethod:kMNFHTTPMethodPUT service:MNFServiceNameUpcoming completion:^(MNFResponse * _Nullable response) {
        kObjectBlockDataDebugLog;
        
        [MNFObject executeOnMainThreadWithJob:job completion:completion error: response.error];
    }];
    
    return job;
}

#pragma mark - json adaptor delegate

-(NSDictionary*)jsonKeysMapToProperties{
    return @{@"identifier":@"id"};
}
-(NSSet*)propertiesToIgnoreJsonSerialization {
    return [NSSet setWithArray:@[@"identifier", @"objectstate",@"description",@"debugDescription",@"superclass",@"mutableProperties"]];
}

-(NSSet*)propertiesToIgnoreJsonDeserialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

@end
