//
//  MenigaURLConstructorTest.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 01/10/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNFURLConstructor.h"

@interface MNFURLConstructorTest : XCTestCase

@end

@implementation MNFURLConstructorTest

-(void)testInit {
    XCTAssertNotNil([[MNFURLConstructor alloc] init]);
}

-(void)testURLConstructor {
    NSURL *testURL = [NSURL URLWithString:[NSString stringWithFormat:@"www.menigatest.is/api/someapicall/"]];
    NSURL *url = [MNFURLConstructor URLFromBaseUrl:@"www.menigatest.is" path:@"/api/someapicall/"]; 
    
    NSString *testURLstring = [NSString stringWithContentsOfURL:testURL encoding:NSUTF8StringEncoding error:nil];
    NSString *urlString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    
    XCTAssertNotNil(url);
    XCTAssertEqualObjects(url, testURL);
    XCTAssertEqualObjects(testURLstring, urlString);
}

@end
