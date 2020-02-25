//
//  MenigaRequest.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 30/09/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MNFRequest : NSObject

+ (NSURLRequest *)urlRequestWithURL:(NSURL *)url
                         httpMethod:(NSString *)httpMethod
                        httpHeaders:(nullable NSDictionary<NSString *, NSString *> *)httpHeaders
                         parameters:(nullable NSData *)parameters;

@end

NS_ASSUME_NONNULL_END