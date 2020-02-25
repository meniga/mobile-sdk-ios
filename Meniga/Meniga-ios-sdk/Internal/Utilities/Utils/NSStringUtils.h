//
//  NSStringUtils.h
//  Meniga-ios-sdk
//
//  Created by Aske Bendtsen on 18/10/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MNFJsonAdapter.h"

@interface NSStringUtils : NSObject

+ (NSString *)stringWithOption:(MNFAdapterOption)adapterOption fromString:(NSString *)string;
+ (NSString *)randomStringWithLength:(int)len;
+ (NSNumber *)createCategoryTypeIdFromString:(NSString *)string;

@end
