//
//  MenigaResponseTest.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 30/09/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNFResponse.h"

@interface MNFResponseTest : XCTestCase

@end

@implementation MNFResponseTest

-(void)testInit {
    XCTAssertNotNil([[MNFResponse alloc] init]);
}

-(void)testResponseWithErrorParameter {
    
    NSDictionary *transaction = @{ @"data" : @{ @"id":@"1000",@"amount":@"2000",@"merchant":@"Bonus" } };
    NSData *data = [NSJSONSerialization dataWithJSONObject:transaction options:0 error:nil];
    NSError *error = [NSError errorWithDomain:@"Error" code:401 userInfo:[NSDictionary dictionaryWithObject:@"Object" forKey:@"Key"]];

    MNFResponse *response = [MNFResponse responseWithData:data error:error statusCode:401 headerFields:nil];
    
    XCTAssertNotNil(response);
    XCTAssertNotNil(response.error);
    XCTAssertEqualObjects(response.error.domain, @"Error");
    XCTAssertEqual(response.error.code, 401);
    XCTAssertEqualObjects([response.error.userInfo objectForKey:@"Key"],@"Object");
    XCTAssertEqualObjects([response error], error);
    XCTAssertTrue(response.statusCode == 401);
    
}

-(void)testResponseWithParameter {
    
    NSDictionary *transaction = @{ @"data" : @{ @"id" : @"1000", @"amount" : @"2000", @"merchant" : @"Bonus"}};
    NSData *data = [NSJSONSerialization dataWithJSONObject:transaction options:0 error:nil];
    MNFResponse *response = [MNFResponse responseWithData:data error:nil statusCode:200 headerFields:nil];
    
    XCTAssertNotNil(response.result);
    XCTAssertNotNil([response result]);
    
    XCTAssertEqualObjects(response.result, [transaction objectForKey:@"data"]);
    XCTAssertEqualObjects([response result], [transaction objectForKey:@"data"]);
    
}

@end
