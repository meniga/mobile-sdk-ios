//
//  MenigaCryptorTest.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 12/10/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNFCryptor.h"
#import "MNFKeychain.h"

@interface MNFCryptorTest : XCTestCase

@end

@implementation MNFCryptorTest

//-(void)testEncryptAndDecryptData {
//    NSString *string = @"Testing";
//    NSData *dataToEncrypt = [string dataUsingEncoding:NSUTF8StringEncoding];
//    NSData *encryptedData = [MNFCryptor encryptData:dataToEncrypt forKey:@"EncryptionTest"];
//    
//    XCTAssertNotNil(encryptedData);
//    
//    NSData *decryptedData = [MNFCryptor decryptData:encryptedData forKey:@"EncryptionTest"];
//    
//    XCTAssertNotNil(decryptedData);
//    XCTAssertEqualObjects(dataToEncrypt, decryptedData);
//}
//-(void)testEncryptAndDecryptCookie {
//    NSDictionary *cookieDict = @{@"Comment":@"cookieComment",
//                                 @"CommentURL":@"cookieURL",
//                                 @"Domain":@"cookieDomain",
//                                 @"ExpiresDate":@"cookieExpirationDate",
//                                 @"HTTPOnly":@"cookieHTTPOnly",
//                                 @"Secure":@"NO",
//                                 @"SessionOnly":@"NO",
//                                 @"Name":@"cookieName",
//                                 @"Path":@"cookiePath",
//                                 @"PortList":@"cookiePortList",
//                                 @"Value":@"cookieValue",
//                                 @"Version":@"cookieVersion"
//                                 };
//    
//    NSHTTPCookie *cookieToEncrypt = [NSHTTPCookie cookieWithProperties:cookieDict];
//    NSLog(@"Cookie to encrypt: %@",cookieToEncrypt);
//    
//    NSDictionary *encryptedCookie = [MNFCryptor encryptCookie:cookieToEncrypt];
//    
//    XCTAssertNotNil(encryptedCookie);
//    
//    NSHTTPCookie *decryptedCookie = [MNFCryptor decryptCookie:encryptedCookie];
//    
//    XCTAssertNotNil(decryptedCookie);
//    
//    XCTAssertEqualObjects(cookieToEncrypt.value, decryptedCookie.value);
//}

@end
