//
//  MNFObject+private.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 26/10/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFObject.h"
#import "MNFErrorUtils.h"
#import "MNFJsonAdapter.h"
#import "MNFHTTPMethods.h"
#import "MNFURLRequestConstants.h"
#import "MNFResponse.h"
#import "MNFJsonAdapterSubclassedProperty.h"
#import "MNFLogger.h"

NS_ASSUME_NONNULL_BEGIN

@interface MNFObject()<MNFJsonAdapterDelegate>

+(MNFJob *)apiRequestWithPath:(NSString *)path pathQuery:(nullable NSDictionary*)pathQuery jsonBody:(nullable NSData*)postData HTTPMethod:(NSString*)httpMethod service:(MNFServiceName)service completion:(MNFCompletionHandler)completion;

+(void)executeOnMainThreadWithCompletion:(void (^)(id))completion withParameter:(nullable id)parameter;
+(void)executeOnMainThreadWithCompletion:(void (^)(id,id))completion withParameters:(nullable id)firstParameter and:(nullable id)secondParameter;
+(void)executeOnMainThreadWithCompletion:(void (^)(id _Nullable, id _Nullable, id _Nullable))completion withParameters:(nullable id)firstParameter andSecondParam:(nullable id)secondParameter andThirdParam:(nullable id)thirdParameter;

+(void)executeOnMainThreadWithJob:(MNFJob *)theJob completion:(void (^)(id _Nonnull))completion parameter:(id)parameter;
/**
 @abstract used to combine bolts return type with completion in order to combine the networking under one method.
 */
+(void)executeOnMainThreadWithJob:(MNFJob *)theJob completion:(void (^)(id))completion error:(nullable NSError *)theError;
/**
 @abstract used to combine bolts return type with completion in order to combine the networking under one method. We have to specify which parameter is the error for bolts.
 */
+(void)executeOnMainThreadWithJob:(MNFJob *)theJob completion:(void (^)(id, NSError *))completion parameter:(nullable id)parameter error:(nullable NSError *)theError;
+(void)executeOnMainThreadWithJob:(MNFJob *)theJob completion:(void (^)(id _Nonnull, NSError * _Nullable))completion parameter:(id)parameter metaData:(id)metaData error:(NSError *)theError;
+(void)executeOnMainThreadWithJob:(MNFJob *)theJob completion:(nonnull void (^)(id _Nonnull, id _Nonnull, NSError * _Nonnull))completion resultParameter:(nullable id)theResultParam metaDataParm:(nullable id)theMetaDataParam error:(nullable NSError *)theError;

-(instancetype)initNeutral;

-(MNFJob*)updateWithApiPath:(NSString*)path pathQuery:(nullable NSDictionary*)pathQuery jsonBody:(nullable NSData*)data httpMethod:(NSString*)httpMethod service:(MNFServiceName)service completion:(MNFCompletionHandler)completion;

-(MNFJob *)deleteWithApiPath:(NSString*)path pathQuery:(nullable NSDictionary*)pathQuery jsonBody:(nullable NSData*)data service:(MNFServiceName)service completion:(MNFCompletionHandler)completion;

-(void)setIsNew:(BOOL)isNew;
-(void)setIdentifier:(NSNumber *)identifier;
-(void)makeDeleted;

//Private constructors
+(instancetype)initWithServerResult:(NSDictionary *)dictionary;
+(NSArray*)initWithServerResults:(NSArray *)array;

//Used for test
-(MNFObjectState*)objectState;
@end

NS_ASSUME_NONNULL_END
