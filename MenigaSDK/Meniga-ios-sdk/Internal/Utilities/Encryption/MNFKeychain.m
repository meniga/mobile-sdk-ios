//
//  MNFKeychain.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 02/12/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFKeychain.h"
#import "MNFLogger.h"

@implementation MNFKeychain

+(void)saveData:(NSData *)data forKey:(NSString*)key{
    NSDictionary *dataDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[NSKeyedArchiver archivedDataWithRootObject:data],(__bridge id)kSecValueData, nil];
    NSMutableDictionary *keyChainItem = [[self p_fetchEncryptionKeychainItemForKey:key] mutableCopy];
    OSStatus error = SecItemUpdate((__bridge CFDictionaryRef)keyChainItem, (__bridge CFDictionaryRef)dataDictionary);
    
    if (error != noErr) {
        MNFLogDebug(@"Encryption key not found in keychain, creating new one");
        MNFLogVerbose(@"Encryption key not found in keychain, creating new one");
        [keyChainItem setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(__bridge id)kSecValueData];
        error = SecItemAdd((__bridge CFDictionaryRef)keyChainItem, NULL);
        if (error != noErr) {
            MNFLogError(@"Saving encryption key to keychain failed. Error: %@",error);
            MNFLogVerbose(@"Saving encryption key to keychain failed. Error: %@",error);
        }
    }
}
+(id)loadDataForKey:(NSString*)key {
    NSMutableDictionary *keychainItem = [[self p_fetchEncryptionKeychainItemForKey:key] mutableCopy];
    [keychainItem setObject:(id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
    [keychainItem setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    id returnValue = nil;
    
    OSStatus error = SecItemCopyMatching((__bridge CFDictionaryRef)keychainItem, (CFTypeRef *)&keyData);
    if (error == noErr) {
        @try {
            returnValue = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge id)keyData];
        }
        @catch (NSException *exception) {
            MNFLogDebug(@"Unarchiving encryption key failed. Exception: %@",exception);
        }
        @finally {}
    }
    if (keyData) CFRelease(keyData);
    
    return returnValue;
}
+(void)deleteDataForKey:(NSString*)key {
    NSDictionary *keychainItem = [self p_fetchEncryptionKeychainItemForKey:key];
    OSStatus error = SecItemDelete((__bridge CFDictionaryRef)keychainItem);
    if (error != noErr) {
        MNFLogError(@"Deleting encryption key from keychain failed. Error: %@",error);
        MNFLogVerbose(@"Deleting encryption key from keychain failed. Error: %@",error);
    }
}

+(void)savePassword:(NSString *)password {
    NSDictionary *dataDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[NSKeyedArchiver archivedDataWithRootObject:password],(__bridge id)kSecValueData, nil];
    NSMutableDictionary *keyChainItem = [[self p_fetchPasswordKeychainItem] mutableCopy];
    OSStatus error = SecItemUpdate((__bridge CFDictionaryRef)keyChainItem, (__bridge CFDictionaryRef)dataDictionary);
    
    if (error != noErr) {
        MNFLogError(@"Password key not found in keychain, creating new one");
        MNFLogVerbose(@"Password key not found in keychain, creating new one");
        [keyChainItem setObject:[NSKeyedArchiver archivedDataWithRootObject:password] forKey:(__bridge id)kSecValueData];
        error = SecItemAdd((__bridge CFDictionaryRef)keyChainItem, NULL);
        if (error != noErr) {
            MNFLogError(@"Saving password key to keychain failed. Error: %@",error);
            MNFLogVerbose(@"Saving password key to keychain failed. Error: %@",error);
        }
    }
}
+(NSString*)loadPassword {
    NSMutableDictionary *keychainItem = [[self p_fetchPasswordKeychainItem] mutableCopy];
    [keychainItem setObject:(id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
    [keychainItem setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    id returnValue = nil;
    
    OSStatus error = SecItemCopyMatching((__bridge CFDictionaryRef)keychainItem, (CFTypeRef *)&keyData);
    if (error == noErr) {
        @try {
            returnValue = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge id)keyData];
        }
        @catch (NSException *exception) {
            MNFLogDebug(@"Unarchiving password key failed. Exception: %@",exception);
        }
        @finally {}
    }
    if (keyData) CFRelease(keyData);
    
    return returnValue;
}
+(void)deletePassword {
    NSDictionary *keychainItem = [self p_fetchPasswordKeychainItem];
    OSStatus error = SecItemDelete((__bridge CFDictionaryRef)keychainItem);
    if (error != noErr) {
        MNFLogDebug(@"Deleting password key from keychain failed. Error: %@",error);
    }
}

+(void)saveToken:(NSDictionary *)token {
    NSDictionary *dataDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[NSKeyedArchiver archivedDataWithRootObject:token],(__bridge id)kSecValueData, nil];
    NSMutableDictionary *keyChainItem = [[self p_fetchEncryptionKeychainItemForKey:@"RefreshToken"] mutableCopy];
    OSStatus error = SecItemUpdate((__bridge CFDictionaryRef)keyChainItem, (__bridge CFDictionaryRef)dataDictionary);
    
    if (error != noErr) {
        MNFLogDebug(@"Token key not found in keychain, creating new one");
        [keyChainItem setObject:[NSKeyedArchiver archivedDataWithRootObject:token] forKey:(__bridge id)kSecValueData];
        error = SecItemAdd((__bridge CFDictionaryRef)keyChainItem, NULL);
        if (error != noErr) {
            MNFLogDebug(@"Saving token key to keychain failed. Error: %@",error);
        }
    }
}
+(NSDictionary*)loadToken {
    NSMutableDictionary *keychainItem = [[self p_fetchEncryptionKeychainItemForKey:@"RefreshToken"] mutableCopy];
    [keychainItem setObject:(id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
    [keychainItem setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    id returnValue = nil;
    
    OSStatus error = SecItemCopyMatching((__bridge CFDictionaryRef)keychainItem, (CFTypeRef *)&keyData);
    if (error == noErr) {
        @try {
            returnValue = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge id)keyData];
        }
        @catch (NSException *exception) {
            MNFLogDebug(@"Unarchiving token key failed. Exception: %@",exception);
        }
        @finally {}
    }
    if (keyData) CFRelease(keyData);
    
    return returnValue;
}
+(void)deleteToken {
    NSDictionary *keychainItem = [self p_fetchEncryptionKeychainItemForKey:@"RefreshToken"];
    OSStatus error = SecItemDelete((__bridge CFDictionaryRef)keychainItem);
    if (error != noErr) {
        MNFLogDebug(@"Deleting token key from keychain failed. Error: %@",error);
    }
}

#pragma mark - Private methods
+(NSDictionary*)p_fetchEncryptionKeychainItemForKey:(NSString*)key {

    return [NSDictionary dictionaryWithObjectsAndKeys:
                                        (__bridge id)kSecClassKey,(__bridge id)kSecClass,
                                        (__bridge id)kSecAttrAccessibleWhenUnlocked,(__bridge id)kSecAttrAccessible,
                                        @"meniga.sdk",(__bridge id)kSecAttrApplicationLabel,
                                        key,(__bridge id)kSecAttrApplicationTag,
                                        kSecAttrKeyTypeRSA,kSecAttrKeyType,
                                        @128,kSecAttrKeySizeInBits,
                                        @"128",kSecAttrEffectiveKeySize,
                                        nil];
}

+(NSDictionary*)p_fetchPasswordKeychainItem {
    
    return [NSDictionary dictionaryWithObjectsAndKeys:
                                        (__bridge id)kSecClassGenericPassword,(__bridge id)kSecClass,
                                        (__bridge id)kSecAttrAccessibleWhenUnlocked,(__bridge id)kSecAttrAccessible,
                                        @"meniga.sdk",(__bridge id)kSecAttrAccount,
                                        @"meniga.sdk",(__bridge id)kSecAttrService,
                                        nil];
}

@end
