//
//  MNFFeedConcreteIntegrationTest.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 6/10/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNFIntegrationAuthProvider.h"
#import "MNFNetwork.h"
#import "MENIGAAuthentication.h"
#import "MNFDemoUser.h"
#import "Meniga.h"

@interface MNFFeedConcreteIntegrationTest : XCTestCase

@end

@implementation MNFFeedConcreteIntegrationTest

- (void)setUp {
    [super setUp];
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    [Meniga setApiURL:@"http://api.test.meniga.net/v1"];
    
    [MENIGAAuthentication loginWithUsername:@"ue@meniga.is" password:@"123456" withCompletion:^(NSDictionary *tokenDict, NSError *error) {
        
        [MNFDemoUser setTokenDict: [tokenDict objectForKey:@"data"] ];
        [Meniga setAuthenticationProvider: [[MNFIntegrationAuthProvider alloc] init] ];
        
        dispatch_semaphore_signal(semaphore);
        
    }];
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

-(void)testGetFeed {
    
    XCTestExpectation *expecation = [self expectationWithDescription: NSStringFromSelector(_cmd) ];
    
    [MNFFeed fetchFromDate: [NSDate dateWithTimeIntervalSinceNow:- 30 * 24 * 60 * 60] toDate: [NSDate date] skip:@0 take:@0 withCompletion:^(MNFFeed *feed, NSError *error) {
       
//        NSLog(@"the feed is: %@", feed);
        [expecation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:nil];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
