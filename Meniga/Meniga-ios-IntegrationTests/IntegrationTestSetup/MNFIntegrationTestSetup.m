//
//  MNFIntegrationTestSetup.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 4/19/16.
//  Copyright © 2016 Meniga. All rights reserved.
//
#import "MNFIntegrationTestSetup.h"
#import "MENIGAAuthentication.h"
#import "MNFDemoUser.h"
#import "MNFIntegrationAuthProvider.h"
#import "MNFNetwork.h"
#import "Meniga.h"

@interface MNFIntegrationTestSetup ()

@end

@implementation MNFIntegrationTestSetup

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    [MNFNetwork sharedNetwork];

    [Meniga setApiURL:@"http://api.umw.meniga.net/user/v1"];
    [Meniga setApiURL:@"http://cashbackapi.umw.meniga.net/user/v1" forService:MNFServiceNameOffers];
    [Meniga setLogLevel:kMNFLogLevelDebug];
    [MNFDemoUser setCreateDemoUrl:@"http://api.umw.meniga.net/"];

    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);

    [MNFDemoUser createRandomUserAndLoginWithCompletion:^(NSError *error) {
        [Meniga setAuthenticationProvider:[[MNFIntegrationAuthProvider alloc] init]];

        dispatch_semaphore_signal(semaphore);
    }];

    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];

    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);

    [MNFDemoUser deleteUserWithCompletion:^(NSError *error) {
        dispatch_semaphore_signal(semaphore);
    }];

    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
}

@end
