//
//  MenigaCryptor.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 12/10/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>
#import <Security/Security.h>

NS_ASSUME_NONNULL_BEGIN

@class Meniga;

@interface MNFCryptor : NSObject

+(NSData*)encryptData:(nullable NSData*)dataToEncrypt forKey:(nullable NSString*)key;
+(NSData*)decryptData:(nullable NSData*)dataToDecrypt forKey:(nullable NSString*)key;

+(NSDictionary*)encryptCookie:(nullable NSHTTPCookie*)cookieToEncrypt;
+(NSHTTPCookie*)decryptCookie:(nullable NSDictionary*)cookieToDecrypt;

@end

NS_ASSUME_NONNULL_END