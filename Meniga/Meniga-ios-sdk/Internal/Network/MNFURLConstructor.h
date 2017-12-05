//
//  MenigaURLConstructor.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 01/10/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MNFURLConstructor : NSObject

+(NSURL *)URLFromBaseUrl:(NSString *)baseURL path:(NSString *)path pathQuery:(nullable NSDictionary *)pathQuery;

+(NSURL *)URLFromBaseUrl:(NSString *)baseURL path:(NSString *)path pathQuery:(NSDictionary *)pathQuery percentageEncoded:(BOOL)percentageEncoded;

+(NSURL *)URLFromBaseUrl:(NSString *)baseURL path:(NSString *)path;

@end

NS_ASSUME_NONNULL_END
