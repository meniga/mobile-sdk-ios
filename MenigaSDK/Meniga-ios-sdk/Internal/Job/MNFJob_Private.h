//
//  MNFJob_Private.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 07/07/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFJob.h"

@class MNFResponse;

typedef id (^MNFJobContinuationHandler)(MNFJob *continuationJob);

@interface MNFJob ()

@property (nonatomic,strong,readwrite) id result;
@property (nonatomic,strong,readwrite) id metaData;
@property (nonatomic,strong,readwrite) NSError *error;
@property (nonatomic,strong,readwrite) NSDictionary *headerFields;
@property (nonatomic,copy) NSURLRequest *request;

+(instancetype)jobWithRequest:(NSURLRequest*)request;
+(instancetype)jobWithResult:(id)result;
+(instancetype)jobWithMetaData:(id)metaData;
+(instancetype)jobWithError:(NSError*)error;
-(void)setResult:(id)result metaData:(id)metaData error:(NSError*)error;
-(void)setResult:(id)result metaData:(id)metaData;
-(void)setResponse:(MNFResponse*)response;
-(instancetype)continueWithCompletion:(MNFJobContinuationHandler)completion;

@end