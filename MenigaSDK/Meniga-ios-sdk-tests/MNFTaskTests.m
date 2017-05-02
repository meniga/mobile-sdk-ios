//
//  MNFTaskTests.m
//  Meniga-ios-sdk
//
//  Created by Aske Bendtsen on 26/10/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNFTask.h"
#import "MNFTask+creation.h"

#define HC_SHORTHAND
#import <OCHamcrestIOS/OCHamcrestIOS.h>

#define MOCKITO_SHORTHAND
#import <OCMockitoIOS/OCMockitoIOS.h>

#import "MNF_BFTask.h"
#import "MNF_BFTaskCompletionSource.h"

@interface MNFTaskTests : XCTestCase

@end

@implementation MNFTaskTests{

}

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    //[_sut cancelTask];
    //_sut = nil;
}


-(void)testThatThisShitWorks{
    
    MNF_BFTaskCompletionSource *tcs = [MNF_BFTaskCompletionSource taskCompletionSource];
    [tcs.task continueWithBlock:^id(MNF_BFTask *task) {
        XCTAssertEqualObjects(@"bar", task.result);
        return nil;
    }];
    [[MNF_BFTask taskWithDelay:0] continueWithBlock:^id(MNF_BFTask *task) {
        tcs.result = @"bar";
        return nil;
    }];
    
    //[task waitUntilFinished];
    
}

- (void)testStartNewTaskWillReturnTaskInstance{
    MNFTask *mnfTask = [MNFTask startNewTask];
    assertThat([mnfTask class], equalTo([MNFTask class]));
}

- (void)testInitWillReturnNil{
    MNFTask *mnfTask = [[MNFTask alloc]init];
    assertThat(mnfTask, nilValue());
}

-(void)testStartNewTaskCompleteWithResult{
    
    NSString *result = @"this is the result";
    
    MNFTask *mnfTask = [MNFTask startNewTask];
    
    [mnfTask completeWithBlock:^(MNFTask *task) {
        XCTAssertEqualObjects(task.result, result);
    }];
    
    [mnfTask setRunningTaskResult:result];
}

-(void)testStartNewTaskCompleteWithSuccessWithResult{
    
    MNFTask *mnfTask = [MNFTask startNewTask];
    
    NSString *result = @"this is the result";
    
    [mnfTask completeWithSuccessBlock:^(MNFTask *task) {
        XCTAssertEqualObjects(task.result, result);
    }];
    
    [mnfTask setRunningTaskResult:result];
}

-(void)testStartNewTaskCompleteWithError{
    
    MNFTask *mnfTask = [MNFTask startNewTask];
    
    NSError *error = [NSError errorWithDomain:@"is.meniga" code:200 userInfo:@{NSLocalizedDescriptionKey:@"testing an error"}];
    
    [mnfTask completeWithBlock:^(MNFTask *task) {
        XCTAssertEqualObjects(task.error, error);
    }];
    
    [mnfTask setRunningTaskError:error];
    
}

-(void)testStartNewTaskCompleteWithResultWhenAlreadyFinished{
    
    MNFTask *mnfTask = [MNFTask startNewTask];
    
    NSString *result = @"this is the result";
    
    [mnfTask setRunningTaskResult:result];
    
    [mnfTask completeWithBlock:^(MNFTask *task) {
        XCTAssertEqualObjects(task.result, result);
    }];
}


-(void)testStartNewTaskCompleteWithErrorWhenAlreadyFinished{
    
    MNFTask *mnfTask = [MNFTask startNewTask];
    
    NSError *error = [NSError errorWithDomain:@"is.meniga" code:200 userInfo:@{NSLocalizedDescriptionKey:@"testing an error"}];
    
    [mnfTask setRunningTaskError:error];
    
    [mnfTask completeWithBlock:^(MNFTask *task) {
        XCTAssertEqualObjects(task.error, error);
    }];
}


@end
