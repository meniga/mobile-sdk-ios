//
//  MNFIntegrationTestSetup.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 4/19/16.
//  Copyright © 2016 Meniga. All rights reserved.
//
#import "MNFIntegrationTestSetup.h"
#import "MNFDemoUser.h"
#import "MNFNetwork.h"
#import "Meniga.h"
#import "MNFIntegrationAuthProvider.h"
#import "MENIGAAuthentication.h"


@interface MNFIntegrationTestSetup ()

@end

@implementation MNFIntegrationTestSetup

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    [MNFNetwork initialize];
    
    

    [Meniga setApiURL:@"http://api.umw.test.meniga.net/user/v1"];
    [Meniga setApiURL:@"http://api.cashback.umw.test.meniga.net/user/v1" forService:MNFServiceNameOffers];
    [Meniga setLogLevel:kMNFLogLevelDebug];
    [MNFDemoUser setCreateDemoUrl:@"http://api.umw.test.meniga.net/"];
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    [MNFDemoUser createRandomUserAndLoginWithCompletion:^(NSError *error) {
        
        [Meniga setAuthenticationProvider:[[MNFIntegrationAuthProvider alloc] init]];
        
//        NSLog(@"setup error is: %@", error);
        
        dispatch_semaphore_signal(semaphore);
    }];
    
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
        
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);

    
    [MNFDemoUser deleteUserWithCompletion:^(NSError *error) {
//        NSLog(@"Deleted user");
        dispatch_semaphore_signal(semaphore);
        
    }];
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

}

@end
