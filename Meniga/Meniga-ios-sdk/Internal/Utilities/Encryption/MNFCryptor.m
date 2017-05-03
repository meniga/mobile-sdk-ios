//
//  MenigaCryptor.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 12/10/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFCryptor.h"
#import "Meniga.h"
#import "MNFKeychain.h"
#import "MNFLogger.h"

@implementation MNFCryptor

#pragma mark - Public
+(NSData*)encryptData:(nullable NSData *)dataToEncrypt forKey:(nullable NSString *)key {
    
    NSData *salt = [MNFKeychain loadDataForKey:key];
    if (salt == nil) {
        MNFLogDebug(@"Unable to find key, creating new one");
        MNFLogVerbose(@"Unable to find key, creating new one");
        salt = [self randomDataOfLength:8];
        [MNFKeychain saveData:salt forKey:key];
    }
    NSString *password = @"p4ssw0rd";
    NSData *AESkey = [self AESkeyForKey:password salt:salt];
    NSData *iv = [self randomDataOfLength:kCCBlockSizeAES128];
    NSMutableData *cipher = [NSMutableData dataWithLength:dataToEncrypt.length+kCCBlockSizeAES128];
    size_t cipherLength;
    
    CCCryptorStatus status = CCCrypt(kCCEncrypt,
                                     kCCAlgorithmAES128,
                                     kCCOptionPKCS7Padding,
                                     AESkey.bytes,
                                     AESkey.length,
                                     iv.bytes,
                                     dataToEncrypt.bytes,
                                     dataToEncrypt.length,
                                     cipher.mutableBytes,
                                     cipher.length,
                                     &cipherLength);
    
    if (status == kCCSuccess) cipher.length = cipherLength;
    else return nil;
    
    [cipher appendData:iv];
    
    return [cipher copy];
}

+(NSData*)decryptData:(nullable NSData *)dataToDecrypt forKey:(nullable NSString *)key {
    NSData *salt = [MNFKeychain loadDataForKey:key];
    
    if (salt == nil) {
        MNFLogDebug(@"Unable to decrypt data. Encryption key is missing");
        MNFLogVerbose(@"Unable to decrypt data. Encryption key is missing");
        return nil;
    }
    NSString *password = @"p4ssw0rd";
    NSData *AESkey = [self AESkeyForKey:password salt:salt];
    NSData *encryptedCipher = [dataToDecrypt subdataWithRange:NSMakeRange(0, [dataToDecrypt length] - kCCBlockSizeAES128)];
    NSData *iv = [dataToDecrypt subdataWithRange:NSMakeRange([dataToDecrypt length] - kCCBlockSizeAES128, kCCBlockSizeAES128)];
    NSMutableData *cipher = [NSMutableData dataWithLength:encryptedCipher.length+kCCBlockSizeAES128];
    size_t cipherLength;
    
    CCCryptorStatus status = CCCrypt(kCCDecrypt,
                                     kCCAlgorithmAES128,
                                     kCCOptionPKCS7Padding,
                                     AESkey.bytes,
                                     AESkey.length,
                                     iv.bytes,
                                     encryptedCipher.bytes,
                                     encryptedCipher.length,
                                     cipher.mutableBytes,
                                     cipher.length,
                                     &cipherLength);
    
    if (status == kCCSuccess)   cipher.length = cipherLength;
    else return nil;
    
    return [cipher copy];
}

+(NSDictionary*)encryptCookie:(nullable NSHTTPCookie *)cookieToEncrypt {
    NSMutableDictionary *cookieDict = [[cookieToEncrypt properties] mutableCopy];
    NSString *value = [cookieDict objectForKey:@"Value"];
    NSData *valueData = [value dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encryptedValueData = [self encryptData:valueData forKey:@"Cookie"];
    [cookieDict setObject:encryptedValueData forKey:@"Value"];
    
    return [cookieDict copy];
}
+(NSHTTPCookie*)decryptCookie:(nullable NSDictionary *)cookieToDecrypt {
    NSMutableDictionary *cookieDict = [cookieToDecrypt mutableCopy];
    NSData *valueData = [cookieDict objectForKey:@"Value"];
    NSData *decryptedValueData = [self decryptData:valueData forKey:@"Cookie"];
    NSString *decryptedValueString = [[NSString alloc] initWithData:decryptedValueData encoding:NSUTF8StringEncoding];
    [cookieDict setObject:decryptedValueString forKey:@"Value"];
    
    NSHTTPCookie *newCookie = [NSHTTPCookie cookieWithProperties:[cookieDict copy]];
    
    return newCookie;
}

#pragma mark - Private

+(NSData*)AESkeyForKey:(NSString*)key salt:(NSData*)salt {
    NSMutableData *AESkey = [NSMutableData dataWithLength:kCCKeySizeAES128];
    
    CCKeyDerivationPBKDF(kCCPBKDF2,
                         key.UTF8String,
                         [key lengthOfBytesUsingEncoding:NSUTF8StringEncoding],
                         salt.bytes,
                         salt.length,
                         kCCPRFHmacAlgSHA1,
                         kCCBlockSizeAES128,
                         AESkey.mutableBytes,
                         AESkey.length);
    return [AESkey copy];
}

+(NSString*)generateRandomKey {
    static NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity:arc4random_uniform(100)];
    for (int i=0;i<[randomString length];i++) {
        [randomString appendFormat:@"%c",[letters characterAtIndex:arc4random()%[letters length]]];
    }
    
    return [randomString copy];
}
+(NSData*)randomDataOfLength:(size_t)length {
    NSMutableData *data = [NSMutableData dataWithLength:length];
    int result = SecRandomCopyBytes(kSecRandomDefault, length, data.mutableBytes);
    if (result != 0) {
        MNFLogError(@"error creating random crypto bytes: %d", errno);
        MNFLogVerbose(@"error creating random crypto bytes: %d", errno);
    }
    return [data copy];
}

@end
