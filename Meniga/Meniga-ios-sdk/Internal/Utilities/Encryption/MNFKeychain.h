//
//  MNFKeychain.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 02/12/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>

@interface MNFKeychain : NSObject

//Encryption key storage
+(void)saveData:(NSData*)data forKey:(NSString*)key;
+(id)loadDataForKey:(NSString*)key;
+(void)deleteDataForKey:(NSString*)key;

//Password storage
+(void)savePassword:(NSString*)password;
+(NSString*)loadPassword;
+(void)deletePassword;

//Token storage
+(void)saveToken:(NSDictionary*)token;
+(NSDictionary*)loadToken;
+(void)deleteToken;

@end
