//
//  MenigaNetwork.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 30/09/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFNetwork.h"
#import "MNFErrorUtils.h"
#import "MNFKeychain.h"
#import "MNFLogger.h"
#import "MNFNetworkProtocolForTesting.h"
#import "MNFURLRequestConstants.h"
#import "Meniga.h"

@implementation MNFNetwork {
    NSURLSession *_sharedSession;
}

static MNFNetwork *MENIGASharedNetworkInstance;

+ (instancetype)sharedNetwork {
    if (MENIGASharedNetworkInstance == nil) {
        MENIGASharedNetworkInstance = [[MNFNetwork alloc] init];
    }

    return MENIGASharedNetworkInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        if ([Meniga requestTimeoutInterval] != 0) {
            sessionConfiguration.timeoutIntervalForRequest = [Meniga requestTimeoutInterval];
        }
        if ([Meniga resourceTimeoutInterval] != 0) {
            sessionConfiguration.timeoutIntervalForResource = [Meniga resourceTimeoutInterval];
        }
        if ([Meniga sessionConfiguration] != nil) {
            sessionConfiguration = [Meniga sessionConfiguration];
        }
        _sharedSession = [NSURLSession sessionWithConfiguration:sessionConfiguration
                                                       delegate:[Meniga sessionDelegate]
                                                  delegateQueue:nil];
    }
    return self;
}

- (void)initializeForTesting {
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    sessionConfiguration.protocolClasses = @ [[MNFNetworkProtocolForTesting class]];
    _sharedSession = [NSURLSession sessionWithConfiguration:sessionConfiguration];
}

- (void)flushForTesting {
    [_sharedSession invalidateAndCancel];
}

- (void)sendRequest:(NSURLRequest *)request withCompletion:(MenigaResponseBlock)block {
    [block copy];

    MNFLogInfo(@"Sending request to URL: %@", request.URL);

    NSDictionary *httpBody = nil;

    if (request.HTTPBody != nil) {
        httpBody = [NSJSONSerialization JSONObjectWithData:request.HTTPBody options:0 error:nil];
    }

    MNFLogDebug(@"Sending request to URL: %@, header fields: %@, HTTPMethod: %@, HTTPBody: %@",
                request.URL,
                request.allHTTPHeaderFields,
                request.HTTPMethod,
                httpBody);
    MNFLogVerbose(@"Sending request to URL: %@, header fields: %@, HTTPMethod: %@, HTTPBody: %@",
                  request.URL,
                  request.allHTTPHeaderFields,
                  request.HTTPMethod,
                  httpBody);

    NSURLSessionDataTask *dataTask = [_sharedSession
        dataTaskWithRequest:request
          completionHandler:^(NSData *data, NSURLResponse *urlResponse, NSError *error) {
              NSInteger statusCode;
              if ([[urlResponse class] isSubclassOfClass:[NSHTTPURLResponse class]]) {
                  statusCode = [(NSHTTPURLResponse *)urlResponse statusCode];

                  NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                  MNFLogInfo(@"Response received from URL: %@", urlResponse.URL);
                  if (string == nil || string.length == 0) {
                      MNFLogDebug(
                          @"Empty response received from URL: %@, status code: %@, header fields: %@, error: %@",
                          urlResponse.URL,
                          @(statusCode),
                          [(NSHTTPURLResponse *)urlResponse allHeaderFields],
                          error);
                  } else {
                      MNFLogDebug(@"Response received from URL: %@, status code: %@, header fields: %@, error: %@",
                                  urlResponse.URL,
                                  @(statusCode),
                                  [(NSHTTPURLResponse *)urlResponse allHeaderFields],
                                  error);
                  }
                  MNFLogVerbose(
                      @"Response received from URL: %@, status code: %@, header fields: %@, result: %@, error: %@",
                      urlResponse.URL,
                      @(statusCode),
                      [(NSHTTPURLResponse *)urlResponse allHeaderFields],
                      string,
                      error);
                  MNFResponse *response =
                      [MNFResponse responseWithData:data
                                              error:error
                                         statusCode:statusCode
                                       headerFields:[(NSHTTPURLResponse *)urlResponse allHeaderFields]];

                  block(response);
              } else {
                  //            NSError *unexpectedError = [MNFErrorUtils errorWithCode:kMNFErrorInvalidResponse message:[NSString stringWithFormat:@"Unexpected response type. Expected class: %@. Got class: %@ Error: %@",NSStringFromClass([NSHTTPURLResponse class]), NSStringFromClass([urlResponse class]), error]];
                  MNFResponse *response = [MNFResponse responseWithData:data
                                                                  error:error
                                                             statusCode:kMNFErrorInvalidResponse
                                                           headerFields:nil];

                  block(response);
              }
          }];
    [dataTask resume];
}
- (void)sendRequest:(NSURLRequest *)request overwrite:(BOOL *)overwrite withCompletion:(MenigaResponseBlock)block {
    [block copy];
    if (overwrite) {
        [self cancelRequest:request];
    }
    [self sendRequest:request withCompletion:block];
}
- (void)sendPriorityRequest:(NSURLRequest *)request withCompletion:(MenigaResponseBlock)block {
    [block copy];

    [self pauseAllRequestsWithCompletion:^{
        [self sendRequest:request
            withCompletion:^(MNFResponse *response) {
                [self resumeAllRequests];
                block(response);
            }];
    }];
}

- (void)sendDownloadRequest:(NSURLRequest *)request withCompletion:(MenigaResponseBlock)block {
    [block copy];

    NSURLSessionDownloadTask *downloadTask = [_sharedSession
        downloadTaskWithRequest:request
              completionHandler:^(
                  NSURL *_Nullable location, NSURLResponse *_Nullable urlResponse, NSError *_Nullable error) {
                  NSInteger statusCode = [(NSHTTPURLResponse *)urlResponse statusCode];
                  NSData *data = [NSData dataWithContentsOfURL:location];
                  MNFLogVerbose(@"Response received from URL: %@, status code: %@, header fields: %@, result: %@, "
                                @"error: %@, location: %@",
                                urlResponse.URL,
                                @(statusCode),
                                [(NSHTTPURLResponse *)urlResponse allHeaderFields],
                                data,
                                error,
                                location.absoluteString);
                  MNFResponse *response =
                      [MNFResponse downloadResponseWithRawData:data
                                                         error:error
                                                    statusCode:statusCode
                                                  headerFields:[(NSHTTPURLResponse *)urlResponse allHeaderFields]];
                  block(response);
              }];

    [downloadTask resume];
}

- (void)cancelRequest:(NSURLRequest *)request {
    [_sharedSession getTasksWithCompletionHandler:^(NSArray *dataTasks, NSArray *uploadTasks, NSArray *downloadTasks) {
        for (NSURLSessionDataTask *dataTask in dataTasks) {
            if (dataTask.originalRequest == request) [dataTask cancel];
        }
    }];
}
- (void)cancelRequest:(NSURLRequest *)request withCompletion:(void (^)(void))completionHandler {
    [_sharedSession getTasksWithCompletionHandler:^(NSArray *dataTasks, NSArray *uploadTasks, NSArray *downloadTasks) {
        for (NSURLSessionDataTask *dataTask in dataTasks) {
            if (dataTask.originalRequest == request) [dataTask cancel];
        }
        completionHandler();
    }];
}

- (void)pauseRequest:(NSURLRequest *)request {
    [_sharedSession getTasksWithCompletionHandler:^(NSArray *dataTasks, NSArray *uploadTasks, NSArray *downloadTasks) {
        for (NSURLSessionDataTask *dataTask in dataTasks) {
            if (dataTask.originalRequest == request) [dataTask suspend];
        }
    }];
}
- (void)pauseRequest:(NSURLRequest *)request withCompletion:(void (^)(void))completionHandler {
    [_sharedSession getTasksWithCompletionHandler:^(NSArray *dataTasks, NSArray *uploadTasks, NSArray *downloadTasks) {
        for (NSURLSessionDataTask *dataTask in dataTasks) {
            if (dataTask.originalRequest == request) [dataTask suspend];
        }
        completionHandler();
    }];
}
- (void)resumeRequest:(NSURLRequest *)request {
    [_sharedSession getTasksWithCompletionHandler:^(NSArray *dataTasks, NSArray *uploadTasks, NSArray *downloadTasks) {
        for (NSURLSessionDataTask *dataTask in dataTasks) {
            if (dataTask.originalRequest == request) {
                if (dataTask.state == NSURLSessionTaskStateSuspended) [dataTask resume];
            }
        }
    }];
}
- (void)resumeRequest:(NSURLRequest *)request withCompletion:(void (^)(void))completionHandler {
    [_sharedSession getTasksWithCompletionHandler:^(NSArray *dataTasks, NSArray *uploadTasks, NSArray *downloadTasks) {
        for (NSURLSessionDataTask *dataTask in dataTasks) {
            if (dataTask.originalRequest == request) {
                if (dataTask.state == NSURLSessionTaskStateSuspended) [dataTask resume];
            }
        }
        completionHandler();
    }];
}
- (void)cancelAllRequests {
    [_sharedSession getTasksWithCompletionHandler:^(NSArray *dataTasks, NSArray *uploadTasks, NSArray *downloadTasks) {
        for (NSURLSessionDataTask *task in dataTasks) {
            [task cancel];
        }
    }];
}
- (void)cancelAllRequestsWithCompletion:(void (^)(void))completionHandler {
    [_sharedSession getTasksWithCompletionHandler:^(NSArray *dataTasks, NSArray *uploadTasks, NSArray *downloadTasks) {
        for (NSURLSessionDataTask *task in dataTasks) {
            [task cancel];
        }
        completionHandler();
    }];
}
- (void)pauseAllRequests {
    [_sharedSession getTasksWithCompletionHandler:^(NSArray *dataTasks, NSArray *uploadTasks, NSArray *downloadTasks) {
        for (NSURLSessionDataTask *task in dataTasks) {
            [task suspend];
        }
    }];
}
- (void)pauseAllRequestsWithCompletion:(void (^)(void))completionHandler {
    [_sharedSession getTasksWithCompletionHandler:^(NSArray *dataTasks, NSArray *uploadTasks, NSArray *downloadTasks) {
        for (NSURLSessionDataTask *task in dataTasks) {
            [task suspend];
        }
        completionHandler();
    }];
}
- (void)resumeAllRequests {
    [_sharedSession getTasksWithCompletionHandler:^(NSArray *dataTasks, NSArray *uploadTasks, NSArray *downloadTasks) {
        for (NSURLSessionDataTask *task in dataTasks) {
            [task resume];
        }
    }];
}
- (void)resumeAllRequestsWithCompletion:(void (^)(void))completionHandler {
    [_sharedSession getTasksWithCompletionHandler:^(NSArray *dataTasks, NSArray *uploadTasks, NSArray *downloadTasks) {
        for (NSURLSessionDataTask *task in dataTasks) {
            [task resume];
        }
        completionHandler();
    }];
}

- (void)getAllTasks:(void (^)(NSArray<NSURLSessionDataTask *> *tasks))completion;
{
    [completion copy];
    [_sharedSession getTasksWithCompletionHandler:^(NSArray *dataTasks, NSArray *uploadTasks, NSArray *downloadTasks) {
        completion(dataTasks);
    }];
}
- (NSURLSession *)getSession {
    return _sharedSession;
}

@end
