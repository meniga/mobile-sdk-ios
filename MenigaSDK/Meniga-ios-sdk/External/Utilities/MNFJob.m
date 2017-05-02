//
//  MenigaJob.m
//  Meniga-ios-sdk
//
//  Created by Aske Bendtsen on 21/10/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFJob.h"
#import "MNFJob_Private.h"
#import "MNFNetwork.h"
#import "MNFLogger.h"
#import "MNFResponse.h"

@interface MNFJob ()


@property (nonatomic,strong) NSObject *lock;

@end

@implementation MNFJob {
    BOOL _cancellationRequested;
    BOOL _cancelled;
    BOOL _completed;
    BOOL _paused;
    BOOL _resumed;
    
    NSMutableArray *_continuations;
    NSMutableArray *_completions;
    NSMutableArray *_mainThreadCompletions;
}

- (instancetype)init {
    MNFLogError(@"MNFJob cannot be directly initialized");
    MNFLogInfo(@"MNFJob cannot be directly initialized");
    MNFLogDebug(@"MNFJob cannot be directly initialized");
    MNFLogVerbose(@"MNFJob cannot be directly initialized");
    
    return nil;
}

-(instancetype)initWithRequest:(NSURLRequest *)request {
    self = [super init];
    if (self) {
        _continuations = [NSMutableArray array];
        _completions = [NSMutableArray array];
        _mainThreadCompletions = [NSMutableArray array];
        _request = request;
    }
    
    return self;
}

+(instancetype)jobWithRequest:(NSURLRequest *)request {
    MNFJob *job = [[MNFJob alloc] initWithRequest:request];
    
    return job;
}
+(instancetype)jobWithResult:(id)result {
    MNFJob *job = [[MNFJob alloc] initWithRequest:nil];
    job.completed = YES;
    job.result = result;
    
    return job;
}
+(instancetype)jobWithMetaData:(id)metaData {
    MNFJob *job = [[MNFJob alloc] initWithRequest:nil];
    job.completed = YES;
    job.metaData = metaData;
    
    return job;
}
+(instancetype)jobWithError:(NSError *)error {
    MNFJob *job = [[MNFJob alloc] initWithRequest:nil];
    job.completed = YES;
    job.error = error;
    
    return job;
}

-(void)setResult:(id)result metaData:(id)metaData error:(NSError *)error {
    @synchronized (self.lock) {
        _result = result;
        _metaData = metaData;
        _error = error;
        if (!self.completed) {
            self.completed = YES;
            [self p_runCompletions];
        }
    }
}
-(void)setResult:(id)result metaData:(id)metaData {
    @synchronized (self.lock) {
        _result = result;
        _metaData = metaData;
        if (!self.completed) {
            self.completed = YES;
            [self p_runCompletions];
        }
    }
}
-(void)setResponse:(MNFResponse *)response {
    @synchronized (self.lock) {
        _result = response.result;
        _metaData = response.metaData;
        _error = response.error;
        [self p_runContinuations];
    }
}

-(void)setResult:(id)result {
    @synchronized (self.lock) {
        _result = result;
        if (!self.isCompleted) {
            self.completed = YES;
            [self p_runCompletions];
        }
    }
}
-(void)setMetaData:(id)metaData {
    @synchronized (self.lock) {
        _metaData = metaData;
        if (!self.isCompleted) {
            self.completed = YES;
            [self p_runCompletions];
        }
    }
}
-(void)setError:(NSError *)error {
    @synchronized (self.lock) {
        _error = error;
        if (!self.isCompleted) {
            self.completed = YES;
            [self p_runCompletions];
        }
    }
}

-(void)p_runContinuations {
    if ([_continuations count] > 0) {
        for (void (^continuation)() in _continuations) {
            continuation();
        }
        [_continuations removeAllObjects];
    }
}

-(void)p_runCompletions {
    
    if ([_delegate respondsToSelector:@selector(job:didCompleteWithResult:metaData:error:)]) {
        [_delegate job:self didCompleteWithResult:_result metaData:_metaData error:_error];
    }
    if ([_completions count] > 0) {
        for (MNFJobCompletionHandler completion in _completions) {
            completion(_result,_metaData,_error);
        }
        [_completions removeAllObjects];
    }
    
    if ([NSThread isMainThread] == YES) {
        if ([_delegate respondsToSelector:@selector(job:didCompleteOnMainThreadWithResult:metaData:error:)]) {
            [_delegate job:self didCompleteOnMainThreadWithResult:_result metaData:_metaData error:_error];
        }
        if ([_mainThreadCompletions count] > 0) {
            for (MNFJobCompletionHandler mainThreadCompletion in _mainThreadCompletions) {
                mainThreadCompletion(_result,_metaData,_error);
            }
            [_mainThreadCompletions removeAllObjects];
        }
    }
    else {
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([_delegate respondsToSelector:@selector(job:didCompleteOnMainThreadWithResult:metaData:error:)]) {
                [_delegate job:self didCompleteOnMainThreadWithResult:_result metaData:_metaData error:_error];
            }
            if ([_mainThreadCompletions count] > 0) {
                for (MNFJobCompletionHandler mainThreadCompletion in _mainThreadCompletions) {
                    mainThreadCompletion(_result,_metaData,_error);
                }
                [_mainThreadCompletions removeAllObjects];
            }
        });
    }
}

-(BOOL)isCancelled {
    @synchronized (self.lock) {
        return _cancelled;
    }
}
-(void)setCancelled:(BOOL)cancelled {
    @synchronized (self.lock) {
        _cancelled = cancelled;
    }
}
-(BOOL)isCompleted {
    @synchronized (self.lock) {
        return _completed;
    }
}
-(void)setCompleted:(BOOL)completed {
    @synchronized (self.lock) {
        _completed = completed;
    }
}
-(BOOL)isPaused {
    @synchronized (self.lock) {
        return _paused;
    }
}
-(void)setPaused:(BOOL)paused {
    @synchronized (self.lock) {
        _paused = paused;
    }
}
-(BOOL)isResumed {
    @synchronized (self.lock) {
        return _resumed;
    }
}
-(void)setResumed:(BOOL)resumed {
    @synchronized (self.lock) {
        _resumed = resumed;
    }
}

-(void)handleCompletion:(MNFJobCompletionHandler)completion {
        
    @synchronized (self.lock) {
        if (!self.completed) {
            [_completions addObject:[completion copy]];
        }
        else if (_error != nil) {
            completion(nil,nil,_error);
        }
    }
}
-(void)handleMainThreadCompletion:(MNFJobCompletionHandler)completion {
    
    @synchronized (self.lock ) {
        if (!self.completed) {
            [_mainThreadCompletions addObject:[completion copy]];
        }
    }
}

-(void)cancelWithCompletion:(void (^)(void))completion {
    [completion copy];
    
    _cancellationRequested = YES;
    
    if(_request != nil) [MNFNetwork cancelRequest:_request withCompletion:^{
        self.cancelled = YES;
        if (completion != nil) {
            __block typeof (completion) subCompletion = completion;
            subCompletion();
            subCompletion = nil;
        }
    }];
}

-(void)pauseWithCompletion:(void (^)(void))completion {
    [completion copy];
    
    if (self.cancelled) {
        completion();
    }
    
    if (_request != nil) [MNFNetwork pauseRequest:_request withCompletion:^{
        self.paused = YES;
        if (completion != nil) {
            __block typeof (completion) subCompletion = completion;
            subCompletion();
            subCompletion = nil;
        }
    }];
}
-(void)resumeWithCompletion:(void (^)(void))completion {
    [completion copy];
    
    if (self.cancelled) {
        completion();
    }
    
    if (_request != nil) [MNFNetwork resumeRequest:_request withCompletion:^{
        self.resumed = YES;
        if (completion != nil) {
            __block typeof (completion) subCompletion = completion;
            subCompletion();
            subCompletion = nil;
        }
    }];
}

-(instancetype)continueWithCompletion:(MNFJobContinuationHandler)completion {
    
    MNFJob *completedJob = [MNFJob jobWithRequest:_request];
    
    void (^wrappedBlock)() = ^() {
        if (_cancellationRequested) {
            completedJob.cancelled = YES;
            return;
        }
        
        id result = nil;
        @try {
            result = completion(self);
        } @catch (NSException *exception) {
            NSLog(@"Exception");
            return;
        }
        
        if ([result isKindOfClass:[MNFJob class]]) {
            
            id (^setupWithJob) (MNFJob *) = ^id(MNFJob *job) {
                if (_cancellationRequested || _cancelled) {
                    return nil;
                }
                else if (job.error) {
                    completedJob.error = job.error;
                }
                else {
                    completedJob.result = job.result;
                }
                
                return nil;
            };
            
            MNFJob *resultJob = (MNFJob *)result;
            
            if (resultJob.completed) {
                setupWithJob(resultJob);
            } else {
                [resultJob continueWithCompletion:setupWithJob];
            }
        }
        else {
            completedJob.result = result;
        }
    };
    
    BOOL completed;
    @synchronized (self.lock) {
        completed = self.completed;
        if (!completed) {
            [_continuations addObject:[wrappedBlock copy]];
        }
    }
    if (completed) {
        wrappedBlock();
    }
    
    return completedJob;
}

@end
