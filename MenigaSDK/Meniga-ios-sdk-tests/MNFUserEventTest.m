//
//  MNFUserEventTest.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 04/11/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNFUserEvent.h"
#import "MNFJsonAdapter.h"
#import "NSObject+MNFObjectCreation.h"

@interface MNFUserEventTest : XCTestCase

@end

@implementation MNFUserEventTest

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

-(void)testSerializationOfUserEvents {
    NSString *jsonPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"userEventResponse" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    MNFUserEvent *userEvent = [MNFUserEvent initWithServerResult:jsonDict];
    XCTAssertEqualObjects(userEvent.userEventId, @10);
    XCTAssertEqualObjects(userEvent.parentTypeIdentifier, @"ptidentifier");
    XCTAssertEqualObjects(userEvent.messageBody, @"msgbody");
    XCTAssertEqualObjects(userEvent.messageTitle, @"msgtitle");
    XCTAssertEqualObjects(userEvent.userActionText, @"uatext");
    XCTAssertEqualObjects(userEvent.messageData, @"msgdata");
    XCTAssertEqualObjects(userEvent.displayIconIdentifier, @"diidentifier");
    XCTAssertEqualObjects(userEvent.displayColor, @"dispcolor");
    XCTAssertEqualObjects([userEvent.topicIds objectAtIndex:0], @2);
    XCTAssertEqualObjects([userEvent.topicIds objectAtIndex:1], @42);
}

@end
