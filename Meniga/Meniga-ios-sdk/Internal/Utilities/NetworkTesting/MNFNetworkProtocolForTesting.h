//
//  MenigaNetworkProtocolForTesting.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 20/10/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MNFObjectTypes.h"

@interface MNFNetworkProtocolForTesting : NSURLProtocol

+ (void)setError:(NSError *)theError;

+ (void)setDelay;
+ (void)removeDelay;
+ (void)setObjectType:(MNFObjectType)type;
+ (void)setResponseData:(NSData *)data;

@end
