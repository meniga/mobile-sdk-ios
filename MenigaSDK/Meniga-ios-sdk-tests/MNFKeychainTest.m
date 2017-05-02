//
//  MNFKeychainTest.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 07/12/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNFKeychain.h"

@interface MNFKeychainTest : XCTestCase

@end

@implementation MNFKeychainTest

//-(void)testSaveAndLoadDataForKey {
//    NSString *string = @"Keychain test";
//    NSData *testData = [string dataUsingEncoding:NSUTF8StringEncoding];
//    [MNFKeychain saveData:testData forKey:@"KeychainUnitTest"];
//    
//    NSData *returnData = [MNFKeychain loadDataForKey:@"KeychainUnitTest"];
//    
//    XCTAssertNotNil(returnData);
//    XCTAssertEqualObjects(testData, returnData);
//}
//-(void)testSaveAndLoadPassword {
//    NSString *password = @"P4ssw0rd";
//    [MNFKeychain savePassword:password];
//    
//    NSString *returnPassword = [MNFKeychain loadPassword];
//    
//    XCTAssertNotNil(returnPassword);
//    XCTAssertEqualObjects(password, returnPassword);
//}
//-(void)testSaveAndLoadToken {
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
//    [MNFKeychain saveToken:cookieDict];
//    NSDictionary *returnDict = [MNFKeychain loadToken];
//    
//    XCTAssertNotNil(returnDict);
//    XCTAssertEqualObjects(cookieDict, returnDict);
//}

@end
