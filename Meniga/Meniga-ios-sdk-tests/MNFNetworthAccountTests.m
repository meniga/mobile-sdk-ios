//
//  MNFNetworthAccountTests.m
//  Meniga-ios-sdk
//
//  Created by Aske Bendtsen on 08/04/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNFNetwork.h"
#import "MNFNetworkProtocolForTesting.h"
#import "MNFNetworthAccount.h"
#import "MNFNetworthBalanceHistory.h"
#import "MNFJsonAdapter.h"

@interface MNFNetworthAccountTests : XCTestCase

@end

@implementation MNFNetworthAccountTests{

    MNFNetworthAccount *_sut;
}

- (void)setUp {
    [super setUp];
    [MNFNetwork initializeForTesting];
    
    NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:[self networthResponse] options:0 error:nil];
    
    _sut = [MNFJsonAdapter objectOfClass:[MNFNetworthAccount class] jsonDict:dataDict[@"data"][0] option:0 error:nil];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    [MNFNetwork flushForTesting];
}


- (void)testFetchWithStartAndEndWillReturnArrayOfNetworth {
    [MNFNetworkProtocolForTesting setResponseData:[self networthResponse]];
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFJob *job = [MNFNetworthAccount fetchWithStartDate:[NSDate dateWithTimeIntervalSinceNow:-1000000] endDate:[NSDate date] interPolation:NO completion:^(NSArray * _Nullable result, NSError * _Nullable error) {
        
        XCTAssertEqualObjects([result[0] class], [MNFNetworthAccount class]);
        XCTAssertEqualObjects([result[1] class], [MNFNetworthAccount class]);
        XCTAssertEqualObjects([result[2] class], [MNFNetworthAccount class]);
        XCTAssertEqualObjects([result[3] class], [MNFNetworthAccount class]);
        
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:nil];
    
}

- (void)testFetchWithStartAndEndWillPopulateProperties {
    [MNFNetworkProtocolForTesting setResponseData:[self networthResponse]];
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFJob *job = [MNFNetworthAccount fetchWithStartDate:[NSDate dateWithTimeIntervalSinceNow:-1000000] endDate:[NSDate date] interPolation:NO completion:^(NSArray * _Nullable result, NSError * _Nullable error) {
        
        MNFNetworthAccount *networthAccount = (MNFNetworthAccount*)result[0];
        
        XCTAssertNotNil(networthAccount.accountId);
        XCTAssertNotNil(networthAccount.accountName);
        XCTAssertNotNil(networthAccount.accountTypeId);
        XCTAssertNotNil(networthAccount.isImport);
        XCTAssertNotNil(networthAccount.isManual);
        XCTAssertNotNil(networthAccount.isExcluded);
        XCTAssertNotNil(networthAccount.netWorthType);
        XCTAssertNotNil(networthAccount.currentBalance);
        XCTAssertNotNil(networthAccount.history);
        XCTAssertNotNil(networthAccount.accountType);
        XCTAssertTrue(networthAccount.isNew == NO);
        
        [expectation fulfill];
        
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:nil];
    
}

- (void)testFetchWithStartAndEndWillConstructSubobjects{

    [MNFNetworkProtocolForTesting setResponseData:[self networthResponse]];
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFJob *job = [MNFNetworthAccount fetchWithStartDate:[NSDate dateWithTimeIntervalSinceNow:-1000000] endDate:[NSDate date] interPolation:NO completion:^(NSArray * _Nullable result, NSError * _Nullable error) {
        
        MNFNetworthAccount *networthAccount = (MNFNetworthAccount*)result[0];
        
        XCTAssertEqualObjects([networthAccount.history[0] class], [MNFNetworthBalanceHistory class]);
        
        [expectation fulfill];
        
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:nil];
    
}


-(void)testChangePropertyMarksObjectDirty{

    _sut.accountName = @"testAccountName";
    
    XCTAssertTrue(_sut.isDirty == YES);

}

-(void)testUpdatingDeletedAccountResultsInError{
    
    [MNFNetworkProtocolForTesting setResponseData:[MNFJsonAdapter JSONDataFromDictionary:@{}]];
    
    [_sut setValue:@YES forKey:@"isManual"];
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    
    [_sut deleteAccountWithCompletion:^(NSError * _Nullable error) {
        
        if (error == nil) {
            
            [_sut saveWithCompletion:^(NSError * _Nullable error) {
                
                XCTAssertNotNil(error);
                
                [expectation fulfill];
            }];
            
        }
        
    }];
    
    
    [self waitForExpectationsWithTimeout:10 handler:nil];
}

-(void)testUpdatingNonManualAccountResultsInError{

    [_sut setValue:@NO forKey:@"isManual"];
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [_sut saveWithCompletion:^(NSError * _Nullable error) {
        
        XCTAssertNotNil(error);
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:nil];
}

#pragma mark - helpers

-(NSData*)networthResponse{
    return [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"networthResponse" ofType:@"json"]];
}

@end
