//
//  MNFRepaymentAccountTest.m
//  Meniga-ios-sdk
//
//  Created by Aske Bendtsen on 01/12/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNFRepaymentAccount.h"
#import "MNFNetwork.h"
#import "MNFNetworkProtocolForTesting.h"
#import "MNFJsonAdapter.h"
#import "Meniga.h"
#import "MNFObject_Private.h"


@interface MNFRepaymentAccountTest : XCTestCase

@end

@implementation MNFRepaymentAccountTest {
    MNFRepaymentAccount *_sut;
}

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    [MNFNetwork initializeForTesting];
    [MNFNetworkProtocolForTesting removeDelay];
    NSArray *accountData = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"repaymentAccountResponse" ofType:@"json"]] options:0 error:nil];
    _sut = [MNFJsonAdapter objectOfClass:[MNFRepaymentAccount class] jsonDict:[accountData firstObject] option:kMNFAdapterOptionFirstLetterUppercase error:nil];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [MNFNetwork flushForTesting];
    _sut = nil;
    [super tearDown];
}

- (void)testFetchPopulatesProperties{
    
    [MNFNetworkProtocolForTesting setResponseData:[self repaymentAccountResponse]];
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [MNFRepaymentAccount fetchRepaymentAccountWithCompletion:^(MNFRepaymentAccount * _Nullable account, NSError * _Nullable error) {
        XCTAssertNotNil(account.identifier);
        XCTAssertNotNil(account.name);
        XCTAssertNotNil(account.accountInfo);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:nil];
}

- (void)testFetchWithTaskPopulatesProperties{
    
    [MNFNetworkProtocolForTesting setResponseData:[self repaymentAccountResponse]];
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [[MNFRepaymentAccount fetchRepaymentAccount].task continueWithBlock:^id(MNF_BFTask *task) {
        MNFRepaymentAccount *account = (MNFRepaymentAccount*)task.result;
        
        XCTAssertNotNil(account.identifier);
        XCTAssertNotNil(account.name);
        XCTAssertNotNil(account.accountInfo);
        [expectation fulfill];
        return nil;
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:nil];
}

- (void)testFetchPopulatesAccountInfoDictionary{
    
    [MNFNetworkProtocolForTesting setResponseData:[self repaymentAccountResponse]];
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    
    [MNFRepaymentAccount fetchRepaymentAccountWithCompletion:^(MNFRepaymentAccount * _Nullable account, NSError * _Nullable error) {
        XCTAssertNotNil([account.accountInfo objectForKey:kMNFRepaymentAccountInfoBankNumberKey]);
        XCTAssertNotNil([account.accountInfo objectForKey:kMNFRepaymentAccountInfoBankAccountNumberKey]);
        XCTAssertNotNil([account.accountInfo objectForKey:kMNFRepaymentAccountInfoLedgerKey]);
        XCTAssertNotNil([account.accountInfo objectForKey:kMNFRepaymentAccountInfoSocialSecurityNumberKey]);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:nil];
}

- (void)testFetchWithTaskPopulatesAccountInfoDictionary{
    
    [MNFNetworkProtocolForTesting setResponseData:[self repaymentAccountResponse]];
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [[MNFRepaymentAccount fetchRepaymentAccount].task continueWithBlock:^id(MNF_BFTask *task) {
        MNFRepaymentAccount *account = (MNFRepaymentAccount*)task.result;
        XCTAssertNotNil([account.accountInfo objectForKey:kMNFRepaymentAccountInfoBankNumberKey]);
        XCTAssertNotNil([account.accountInfo objectForKey:kMNFRepaymentAccountInfoBankAccountNumberKey]);
        XCTAssertNotNil([account.accountInfo objectForKey:kMNFRepaymentAccountInfoLedgerKey]);
        XCTAssertNotNil([account.accountInfo objectForKey:kMNFRepaymentAccountInfoSocialSecurityNumberKey]);
        [expectation fulfill];
        return nil;
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:nil];
}

- (void)testFetchSetsIsNewToFalse{
    
    [MNFNetworkProtocolForTesting setResponseData:[self repaymentAccountResponse]];
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [MNFRepaymentAccount fetchRepaymentAccountWithCompletion:^(MNFRepaymentAccount * _Nullable account, NSError * _Nullable error) {
        XCTAssertFalse(account.isNew);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:nil];
}

- (void)testFetchWithTaskSetsIsNewToFalse{
    
    [MNFNetworkProtocolForTesting setResponseData:[self repaymentAccountResponse]];
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [[MNFRepaymentAccount fetchRepaymentAccount].task continueWithBlock:^id(MNF_BFTask *task) {
        MNFRepaymentAccount *account = (MNFRepaymentAccount*)task.result;
        XCTAssertFalse(account.isNew);
        [expectation fulfill];
        return nil;
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:nil];
}

-(void)testRefreshUpdatesProperties{

    [MNFNetworkProtocolForTesting setResponseData:[self repaymentAccountResponse]];
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    NSArray *repaymentAccArray = [MNFJsonAdapter objectFromJSONData:[self repaymentAccountResponse]];

    MNFRepaymentAccount *account = [MNFJsonAdapter objectOfClass:[MNFRepaymentAccount class] jsonDict:[repaymentAccArray firstObject] option:kMNFAdapterOptionFirstLetterUppercase error:nil];
    NSString *oldNAme = account.name;
    
    account.name = @"NewCrazyTestName";
    
    [account refreshWithCompletion:^(NSError * _Nullable error) {
        XCTAssertEqualObjects(account.name, oldNAme);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:nil];
    
}

-(void)testRefreshWithTaskUpdatesProperties{
    
    [MNFNetworkProtocolForTesting setResponseData:[self repaymentAccountResponse]];
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    NSArray *repaymentAccArray = [MNFJsonAdapter objectFromJSONData:[self repaymentAccountResponse]];
    
    MNFRepaymentAccount *account = [MNFJsonAdapter objectOfClass:[MNFRepaymentAccount class] jsonDict:[repaymentAccArray firstObject] option:kMNFAdapterOptionFirstLetterUppercase error:nil];
    NSString *oldNAme = account.name;
    
    account.name = @"NewCrazyTestName";
    
    [[account refresh].task continueWithBlock:^id(MNF_BFTask *task) {
        XCTAssertEqualObjects(account.name, oldNAme);
        [expectation fulfill];
        return nil;
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:nil];
    
}
-(void)testSaveWithCompletion {
    [MNFNetworkProtocolForTesting setResponseData:[NSKeyedArchiver archivedDataWithRootObject:@[]]];
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    _sut.isNew = NO;
    [_sut saveWithCompletion:^(id  _Nullable result, NSError * _Nullable error) {
        XCTAssertNil(result);
        XCTAssertNil(error);
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}
-(void)testSaveWithJob {
    [MNFNetworkProtocolForTesting setResponseData:[NSKeyedArchiver archivedDataWithRootObject:@[]]];
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    _sut.isNew = NO;
    [[_sut save].task continueWithBlock:^id(MNF_BFTask *task) {
        XCTAssertNil(task.result);
        XCTAssertNil(task.error);
        [expectation fulfill];
        return nil;
    }];
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}
-(void)testCreateWithCompletion {
    [MNFNetworkProtocolForTesting setResponseData:[NSKeyedArchiver archivedDataWithRootObject:@[]]];
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    _sut.isNew = YES;
    [_sut saveWithCompletion:^(id  _Nullable result, NSError * _Nullable error) {
        XCTAssertNil(result);
        XCTAssertNil(error);
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}
-(void)testCreateWithJob {
    [MNFNetworkProtocolForTesting setResponseData:[NSKeyedArchiver archivedDataWithRootObject:@[]]];
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    _sut.isNew = YES;
    [[_sut save].task continueWithBlock:^id(MNF_BFTask *task) {
        XCTAssertNotNil(task.result);
        XCTAssertNil(task.error);
        [expectation fulfill];
        return nil;
    }];
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}
-(void)testDeleteWithCompletion {
    [MNFNetworkProtocolForTesting setResponseData:[NSKeyedArchiver archivedDataWithRootObject:@[]]];
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    [_sut deleteWithCompletion:^(NSError * _Nullable error) {
        XCTAssertNil(error);
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}
-(void)testDeleteWithJob {
    [MNFNetworkProtocolForTesting setResponseData:[NSKeyedArchiver archivedDataWithRootObject:@[]]];
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    [[_sut delete].task continueWithBlock:^id(MNF_BFTask *task) {
        XCTAssertNil(task.error);
        [expectation fulfill];
        return nil;
    }];
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

#pragma mark - helpers

-(NSData*)repaymentAccountResponse{
    return [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"repaymentAccountResponse" ofType:@"json"]];
}

@end