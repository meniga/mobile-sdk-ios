//
//  MNFRouterTest.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 25/11/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNFRouter.h"
#import "Meniga.h"
#import "MNFNetwork.h"
#import "MNFNetworkProtocolForTesting.h"

@interface MNFRouterTest : XCTestCase

@end

@implementation MNFRouterTest

- (void)setUp {
    [super setUp];
    [MNFNetwork initializeForTesting];
    [Meniga setApiURL:@"www.example.com"];
}

- (void)tearDown {
    [MNFNetwork flushForTesting];

    [super tearDown];
}

@end
