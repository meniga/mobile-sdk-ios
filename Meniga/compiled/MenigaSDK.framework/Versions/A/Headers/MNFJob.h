//
//  MenigaJob.h
//  Meniga-ios-sdk
//
//  Created by Aske Bendtsen on 21/10/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 A completion handler for jobs.
 
 @param result The result from the request, can return many different objects and needs to be cast to the expected object.
 @param metaData The metadata returned from the request.
 @param error The error of the request.
 */
typedef void(^MNFJobCompletionHandler)(id _Nullable result, id _Nullable metaData, NSError * _Nullable error);

@class MNFJob;

/**
 A protocol for a job that can be used to access the jobs completion with a delegate.
 */
@protocol MNFJobDelegate <NSObject>

@optional
/**
 @abstract A method for handling a job completion.
 @discussion Requests are performed using NSURLSession which normally uses a background thread to perform it's requests. Therefore this method is performed on the current thread the request is performed on.
 @param result The result of the request.
 @param metaData The metaData of the request.
 @param error The error of the request.
 */
-(void)job:(MNFJob*)job didCompleteWithResult:(id _Nullable)result metaData:(id _Nullable)metaData error:(NSError* _Nullable)error;
/**
 @abstract A method for handling a job completion on the main thread.
 @discussion Requests are performed using NSURLSession which normally uses a background thread to perform it's requests. This method forces the execution of completion to be performed on the main thread and is useful when handling ui action upon completion.
 @param result The result of the request.
 @param metaData The metaData of the request.
 @param error The error of the request.
 */
-(void)job:(MNFJob*)job didCompleteOnMainThreadWithResult:(id _Nullable)result metaData:(id _Nullable)metaData error:(NSError* _Nullable)error;
/**
 @abstract A method for handling a job cancellation.
 */
-(void)jobDidCancel:(MNFJob*)job;
/**
 @abstract A method for handling a job pausing.
 */
-(void)jobDidPause:(MNFJob*)job;
/**
 @abstract A method for handling a job resuming.
 */
-(void)jobDidResume:(MNFJob*)job;
//CHECK: did cancel
@end

/**
 The MNFJob class acts as a wrapper for the Bolts framework developed by Facebook.
 
 A job contains a Bolts task and a task completion source both of which can be used to initialize a job.
 Additionally a job contains a reference to the URL request used to carry out server requests from the MNF framework.
 Therefore a server request can be cancelled if it has not completed by cancelling the job.
 
 A job should not be directly initialized but should rather use a Bolts task tompletion source to initialize with.
 */
@interface MNFJob : NSObject

/**
 @abstract A delegate for the job to call MNFJobDelegate protocol methods on. All methods in the protocol are optional.
 */
@property (nonatomic,strong) id <MNFJobDelegate> delegate;
/**
 @abstract The result of the jobs request.
 */
@property (nonatomic,strong,readonly) id result;
/**
 @abstract Any metadata returned by the jobs request.
 */
@property (nonatomic,strong,readonly) id metaData;
/**
 @abstract The error returned by the jobs request.
 */
@property (nonatomic,strong,readonly) NSError *error;
/**
 @abstract Whether the job has been cancelled.
 */
@property (nonatomic, assign, readonly, getter=isCancelled) BOOL cancelled;
/**
 @abstract Whether the job has been completed.
 */
@property (nonatomic, assign, readonly, getter=isCompleted) BOOL completed;
/**
 @abstract Whether the job has been paused.
 */
@property (nonatomic, assign, readonly, getter=isPaused) BOOL paused;
/**
 @abstract Whether the job has been resumed.
 */
@property (nonatomic, assign, readonly, getter=isResumed) BOOL resumed;

/**
 @abstract A method for handling a job completion.
 @discussion Requests are performed using NSURLSession which normally uses a background thread to perform it's requests. Therefore this method is performed on the current thread the request is performed on.
 @param completion A completion block returning a result, metadata and an error.
 */
-(void)handleCompletion:(MNFJobCompletionHandler)completion;
/**
 @abstract A method for handling a job completion on the main thread.
 @discussion Requests are performed using NSURLSession which normally uses a background thread to perform it's requests. This method forces the execution of completion to be performed on the main thread and is useful when handling ui action upon completion.
 @param completion A completion block returning a reuslt, metadata and an error.
 */
-(void)handleMainThreadCompletion:(MNFJobCompletionHandler)completion;
/**
 @abstract A method for handling a job cancellation.
 @param completion A completion block which fires when the url session has finished cancelling the request.
 */
-(void)cancelWithCompletion:(void (^)(void))completion;
/**
 @abstract A method for handling a job pausing.
 @param completion A completion block which fires when the url session has finished pausing the request.
 */
-(void)pauseWithCompletion:(void (^)(void))completion;
/**
 @abstract A method for handling a job resuming.
 @param completion A completion block which fires when the url session has finished resuming the request.
 */
-(void)resumeWithCompletion:(void (^)(void))completion;

@end

NS_ASSUME_NONNULL_END
