//
//  MNFKeychainTest.m
//  Meniga-ios-sdk-tests
//
//  Created by Szymon Kowalski on 17/07/2024.
//  Copyright © 2024 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNFKeychain.h"

@interface MNFKeychainTest : XCTestCase

@end

@implementation MNFKeychainTest

- (void)setUp {
    [super setUp];
    [MNFKeychain deleteDataForKey:@"testKey"];
    [MNFKeychain deletePassword];
    [MNFKeychain deleteToken];
}

- (void)tearDown {
    [MNFKeychain deleteDataForKey:@"testKey"];
    [MNFKeychain deletePassword];
    [MNFKeychain deleteToken];
    [super tearDown];
}


- (void)testSaveAndLoadDataForKey {
    NSString *key = @"testKey";
    NSData *data = [@"testData" dataUsingEncoding:NSUTF8StringEncoding];

    [MNFKeychain saveData:data forKey:key];

    NSData *retrievedData = [MNFKeychain loadDataForKey:key];
    XCTAssertNotNil(retrievedData, @"Data should not be nil");
    XCTAssertEqualObjects(data, retrievedData, @"Retrieved data should be equal to saved data");
}

- (void)testLoadDataForNonexistentKey {
    NSString *key = @"nonExistentKey";
    NSData *loadedData = [MNFKeychain loadDataForKey:key];
    XCTAssertNil(loadedData, @"Data should be nil for nonexistent key");
}


- (void)testDeleteData {
    NSString *key = @"testKey";
    NSData *data = [@"testData" dataUsingEncoding:NSUTF8StringEncoding];
    
    [MNFKeychain saveData:data forKey:key];
    
    NSData *retrievedData = [MNFKeychain loadDataForKey:key];
    XCTAssertEqualObjects(data, retrievedData, @"Retrieved data should be equal to saved data");
    
    [MNFKeychain deleteDataForKey:key];
    
    NSData *loadedData = [MNFKeychain loadDataForKey:key];
    XCTAssertNil(loadedData, @"Data should be nil after deletion");
}


- (void)testSaveAndLoadPassword {
    NSString *password = @"testPassword";

    [MNFKeychain savePassword:password];

    NSString *retrievedPassword = [MNFKeychain loadPassword];
    XCTAssertNotNil(retrievedPassword, @"Data should not be nil");
    XCTAssertTrue([password isEqualToString:retrievedPassword],  @"Retrieved password should be equal to saved password");
}

- (void)testLoadNonExistingPassword {
    [MNFKeychain deletePassword];
    NSString *loadedPassword = [MNFKeychain loadPassword];
    XCTAssertNil(loadedPassword, @"Data should be nil for nonexistent key");
}

- (void)testDeletePassword {
    NSString *password = @"testPassword";

    [MNFKeychain savePassword:password];

    NSString *retrievedPassword = [MNFKeychain loadPassword];
    XCTAssertNotNil(retrievedPassword, @"Password should not be nil");
    XCTAssertTrue([password isEqualToString:retrievedPassword],  @"Retrieved password should be equal to saved password");
    
    [MNFKeychain deletePassword];
    NSString *loadedPassword = [MNFKeychain loadPassword];
    XCTAssertNil(loadedPassword, @"Password should be nil for nonexistent key");
}


- (void)testSaveAndLoadToken {
    NSDictionary *tokenDictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"value1", @"key1", nil];

    [MNFKeychain saveToken:tokenDictionary];

    NSDictionary *retrievedToken = [MNFKeychain loadToken];
    XCTAssertNotNil(retrievedToken, @"Data should not be nil");
    
    XCTAssertTrue([[tokenDictionary objectForKey:@"key1"]
                   isEqualToString:[retrievedToken objectForKey: @"key1"]],
                  @"Retrieved token should be equal to saved token");
}

- (void)testLoadNonExistingToken{
    [MNFKeychain deleteToken];
    NSDictionary *loadedPassword = [MNFKeychain loadToken];
    XCTAssertNil(loadedPassword, @"Data should be nil for nonexistent key");
}

- (void)testDeleteToken {
    NSDictionary *tokenDictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"value1", @"key1", nil];

    [MNFKeychain saveToken:tokenDictionary];

    NSDictionary *retrievedToken = [MNFKeychain loadToken];
    XCTAssertNotNil(retrievedToken, @"Data should not be nil");
    XCTAssertTrue([[tokenDictionary objectForKey:@"key1"]
                   isEqualToString:[retrievedToken objectForKey: @"key1"]],
                  @"Retrieved token should be equal to saved token");
    
    [MNFKeychain deleteToken];
    NSDictionary *loadedPassword = [MNFKeychain loadToken];
    XCTAssertNil(loadedPassword, @"Data should be nil for nonexistent key");
}




@end
