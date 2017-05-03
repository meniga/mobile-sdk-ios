//
//  MNFSynchronization.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 10/12/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFSynchronization.h"
#import "MNFInternalImports.h"
#import "MNFRealmSyncResponse.h"

@interface MNFSynchronization ()
@property (nonatomic,strong) NSNumber *isSyncNeeded;
@end

@implementation MNFSynchronization

+(MNFJob *)synchronizeWithTimeout:(NSNumber *)timeout interval:(NSNumber *)interval completion:(MNFErrorOnlyCompletionHandler)completion {
    [completion copy];
    
    NSDate *syncStart = [NSDate date];
    
    __block MNFJob *job;
    
    MNFJob *startJob = [self startSynchronizationWithWaitTime:timeout completion:nil];
    [startJob handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        
        if (error != nil) {
            [self executeOnMainThreadWithJob:job completion:completion error:error];
        }
        else{
            MNFSynchronization *synchronization = (MNFSynchronization*)result;
            [self p_querySynchronizationWithSync:synchronization start:syncStart timeout:timeout interval:interval completion:^(NSError *error) {
                [self executeOnMainThreadWithJob:job completion:completion error:error];
            }];
        }

    }];
    
    return job;
}

+(void)p_querySynchronizationWithSync:(MNFSynchronization*)sync start:(NSDate*)syncStart timeout:(NSNumber*)timeout interval:(NSNumber*)interval completion:(void (^)(NSError *error))completion {
    [completion copy];
    
    NSTimeInterval timeoutInterval = [syncStart timeIntervalSinceNow];
    
    if (fabs(timeoutInterval) > [timeout doubleValue]/1000 && !sync.isSyncDone) {
        NSError *timeoutError = [MNFErrorUtils errorWithCode:kMNFErrorMethodExecution message:@"Synchronization timed out before synchronization was completed"];
        completion(timeoutError);
        return;
    }
    else if (sync.isSyncDone) {
        completion(nil);
        return;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, ([interval doubleValue]/1000)*NSEC_PER_SEC), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        MNFJob *syncJob = [sync refreshWithCompletion:nil];
        [syncJob handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
            if (error != nil) {
                completion(error);
            }
            else if (sync.isSyncDone) {
                completion(nil);
            }
            else {
                [self p_querySynchronizationWithSync:sync start:syncStart timeout:timeout interval:interval completion:completion];
            }
        }];
    });
}

+(MNFJob *)startSynchronizationWithWaitTime:(NSNumber *)waitTime completion:(MNFSynchronizationCompletionHandler)completion {
    
    [completion copy];
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:@{@"waitForCompleteMilliseconds":waitTime} options:0 error:nil];
    
    __block MNFJob *job = [self apiRequestWithPath:kMNFApiPathSynchronization pathQuery:nil jsonBody:data HTTPMethod:kMNFHTTPMethodPOST service:MNFServiceNameSync completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
        
            if ([response.result isKindOfClass:[NSDictionary class]]) {
                
                MNFSynchronization *sync = [self initWithServerResult:response.result];
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:sync error:nil];
                
            }
            else {
                
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error: [MNFErrorUtils errorForUnexpectedDataOfType:[response.result class] expected:[NSDictionary class]] ];

            }
        }
        else {
            
            [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error:response.error];
            
        }
        
    }];
    
    return job;
}

-(MNFJob *)refreshWithCompletion:(MNFErrorOnlyCompletionHandler)completion {
    
    [completion copy];
    
    NSString *path = [NSString stringWithFormat:@"%@/%@",kMNFApiPathSynchronization,self.syncHistoryId];
    
    __block MNFJob *job = [[self class] apiRequestWithPath:path pathQuery:nil jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameSync completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
        
            if ([response.result isKindOfClass:[NSDictionary class]]) {
            
                [MNFJsonAdapter refreshObject:self withJsonDict:response.result option:kMNFAdapterOptionNoOption error:nil];
                [MNFObject executeOnMainThreadWithJob:job completion:completion error: nil];
            
            }
            else {
            
                [MNFObject executeOnMainThreadWithJob:job completion:completion error: [MNFErrorUtils errorForUnexpectedDataOfType:[response.result class] expected:[NSDictionary class]] ];
                
            }
        }
        else {
            
            [MNFObject executeOnMainThreadWithJob:job completion:completion error:response.error];
        }
        
    }];
    
    return job;
}

+(MNFJob *)fetchCurrentSynchronizationStatusWithCompletion:(MNFSynchronizationCompletionHandler)completion {
    
    [completion copy];
    
    __block MNFJob *job = [self apiRequestWithPath:kMNFApiPathSynchronization pathQuery:nil jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameSync completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
        
            if ([response.result isKindOfClass:[NSDictionary class]]) {
            
                NSDictionary *syncStatus = [response.result objectForKey:@"synchronizationStatus"];
                MNFSynchronization *sync = [self initWithServerResult:syncStatus];
                
                if ([[response.result objectForKey:@"isSynchronizationNeeded"] isEqual:@"true"]) {
                
                    sync.isSyncNeeded = @(YES);
                    
                }
                else {
                    
                    sync.isSyncNeeded = @(NO);
                
                }
                
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:sync error:nil];
                
            }
            else {
                
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error: [MNFErrorUtils errorForUnexpectedDataOfType:[response.result class] expected:[NSDictionary class]] ];
                
            }
        }
        else {
            
            [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error: response.error];
            
        }
        
    }];
    
    return job;
}

-(BOOL)isSynchronizationNeeded {
    if (self.isSyncNeeded == nil) {
        MNFLogError(@"Unable to discern whether synchronization is needed. Please get current synchronization status to find out.");
        MNFLogInfo(@"Unable to discern whether synchronization is needed. Please get current synchronization status to find out.");
        MNFLogDebug(@"Unable to discern whether synchronization is needed. Please get current synchronization status to find out.");
        return NO;
    }
    else {
        return [self.isSyncNeeded boolValue];
    }
}

#pragma mark - Description
-(NSString*)description {
    return [NSString stringWithFormat:@"Synchronization %@ syncHistoryId: %@, isSyncDone: %@, syncSessionStartTime: %@, realmSyncResponses: %@",[super description],self.syncHistoryId,self.isSyncDone,self.syncSessionStartTime,self.realmSyncResponses];
}

#pragma mark - Json Adapter Delegate

-(NSDictionary*)propertyValueTransformers {
    
    return @{@"syncSessionStartTime":[MNFBasicDateValueTransformer transformer]};
}

-(NSSet *)propertiesToIgnoreJsonDeserialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

-(NSSet *)propertiesToIgnoreJsonSerialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

-(NSDictionary*)subclassedProperties {
    return @{
             @"realmSyncResponses": [MNFJsonAdapterSubclassedProperty subclassedPropertyWithClass: [MNFRealmSyncResponse class] option: kMNFAdapterOptionNoOption]
             };
}

@end
