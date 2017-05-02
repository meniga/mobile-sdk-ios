//
//  MNFAccountTest.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 03/11/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Meniga.h"
#import "MNFAccount.h"
#import "MNFNetwork.h"
#import "MNFNetworkProtocolForTesting.h"
#import "MNFObjectTypes.h"
#import "MNFJsonAdapter.h"
#import "NSDateUtils.h"
#import "GCDUtils.h"
#import "MNFAccountType.h"
#import "MNFAccountCategory.h"
#import "MNFAccountAuthorizationType.h"
#import "MNFAccountHistoryEntry.h"

@interface MNFAccountTest : XCTestCase

@end

@implementation MNFAccountTest {
    MNFAccount *_sut;
}

- (void)setUp {
    [super setUp];
    [MNFNetwork initializeForTesting];
    [Meniga setLogLevel:kMNFLogLevelDebug];
    
    NSDictionary *accountResponse = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"accountResponseSecond" ofType:@"json"]] options:0 error:nil];
    NSDictionary *accountData = [accountResponse objectForKey:@"data"];
    
    _sut = [MNFJsonAdapter objectOfClass:[MNFAccount class] jsonDict:accountData option:kMNFAdapterOptionNoOption error:nil];
    
}

- (void)tearDown {
    [MNFNetwork flushForTesting];
    _sut = nil;
    [super tearDown];
}

-(void)testSut {
    
    XCTAssertNotNil(_sut);
    XCTAssertEqualObjects(_sut.identifier, @10295);
    XCTAssertEqualObjects(_sut.accountIdentifier, @"23");
    XCTAssertEqualObjects(_sut.accountTypeId, @40);
    XCTAssertEqualObjects(_sut.name, @"My New Credit Card");
    XCTAssertEqualObjects(_sut.balance, @1000);
    XCTAssertEqualObjects(_sut.limit, @2000);
    XCTAssertEqualObjects(_sut.accountClass, @"CoolClass");
    XCTAssertEqualObjects(_sut.organizationIdentifier, @"meniisre");
    XCTAssertEqualObjects(_sut.realmCredentialsId, @2416);
    XCTAssertEqualObjects(_sut.accountAuthorizationType, @"Test");
    XCTAssertEqualObjects(_sut.orderId, @0);
    XCTAssertEqualObjects(_sut.isImportAccount, @0);
    XCTAssertEqualObjects(_sut.personId, @2400);
    XCTAssertEqualObjects(_sut.userEmail, @"joe@meniga.is");
    XCTAssertEqualObjects(_sut.emergencyFundBalanceLimit, @3000);
    XCTAssertEqualObjects(_sut.inactive, @0);
    XCTAssertEqualObjects(_sut.synchronizationIsPaused, @1);
    XCTAssertEqualObjects(_sut.hasInactiveBudget, @1);
    XCTAssertEqualObjects(_sut.hasInactiveTransactions, @1);
    XCTAssertEqualObjects(_sut.isHidden, @1);
    XCTAssertTrue(_sut.isNew == NO);
    
    XCTAssertTrue([NSDateUtils isDate:_sut.lastUpdate equalToDateWithAllComponents:[NSDate dateWithTimeIntervalSince1970:1453555622]] == YES);
    XCTAssertTrue([NSDateUtils isDate:_sut.createDate equalToDateWithAllComponents:[NSDate dateWithTimeIntervalSince1970:1425821215]]== YES);
    XCTAssertTrue([NSDateUtils isDate:_sut.attachedToUserDate equalToDateWithAllComponents:[NSDate dateWithTimeIntervalSince1970:180]] == YES);
    
}

-(void)testCreateAccount {
    
    MNFAccount *createAccount = [[MNFAccount alloc] init];
    
    XCTAssertTrue(createAccount.isNew == YES);
    
}

- (void)testFetchAccountWithId {
    [MNFNetworkProtocolForTesting setObjectType:MNFAccountObject];
    
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    MNFJob *job = [MNFAccount fetchWithId:@10 completion:^(MNFAccount *account, NSError *error) {

        XCTAssertEqualObjects(account.identifier, @10294);
        XCTAssertEqualObjects(account.accountClass, @"euro");
        XCTAssertEqualObjects(account.accountIdentifier, @"21");
        XCTAssertEqualObjects(account.accountTypeId, @37);
        XCTAssertTrue([NSDateUtils isDate:_sut.attachedToUserDate equalToDateWithAllComponents:[NSDate dateWithTimeIntervalSince1970:180]] == YES);
        XCTAssertTrue([NSDateUtils isDate:_sut.createDate equalToDateWithAllComponents:[NSDate dateWithTimeIntervalSince1970:1425821215]] == YES);
        XCTAssertEqualObjects(account.balance, @4500);
        XCTAssertNil(account.emergencyFundBalanceLimit);
        XCTAssertEqualObjects(account.hasInactiveBudget, @0);
        XCTAssertEqualObjects(account.hasInactiveTransactions, @0);
        XCTAssertEqualObjects(account.inactive, @0);
        XCTAssertEqualObjects(account.isHidden, @0);
        XCTAssertEqualObjects(account.isImportAccount, @0);
        XCTAssertTrue([NSDateUtils isDate:_sut.lastUpdate equalToDateWithAllComponents:[NSDate dateWithTimeIntervalSince1970:1453555622]] == YES);
        XCTAssertEqualObjects(account.limit, @2000);
        XCTAssertEqualObjects(account.name, @"My Creditcard");
        XCTAssertEqualObjects(account.orderId, @0);
        XCTAssertEqualObjects(account.organizationIdentifier, @"meniisre");
        XCTAssertEqualObjects(account.personId, @2499);
        XCTAssertEqualObjects(account.realmCredentialsId, @2416);
        XCTAssertEqualObjects(account.realmIdentifier, @"Demo");
        XCTAssertEqualObjects(account.synchronizationIsPaused, @0);
        XCTAssertEqualObjects(account.userEmail, @"mathieu@meniga.is");
        XCTAssertTrue(account.isNew == NO);
        
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:nil];
}

-(void)testFetchAccountsWithCompletion {
    [MNFNetworkProtocolForTesting setResponseData:[NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"accountsResponse" ofType:@"json"]]];
    
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    // MARK: Should check the contents of these objects, at least their ids that they conform to the json
    MNFJob *job = [MNFAccount fetchAccountsWithCompletion:^(NSArray *accounts, NSError *error) {
        
        XCTAssertNotNil(accounts);
        XCTAssertTrue(accounts.count == 4);
        
        MNFAccount *firstAccount = [accounts objectAtIndex:0];
        XCTAssertNotNil(firstAccount);
        XCTAssertEqualObjects(firstAccount.identifier, @10293);
        XCTAssertEqualObjects(firstAccount.accountTypeId, @1);
        XCTAssertEqualObjects(firstAccount.accountIdentifier, @"0");
        XCTAssertEqualObjects(firstAccount.realmIdentifier, @"oneRealmIdentifier");
        XCTAssertEqualObjects(firstAccount.name, @"Wallet");
        XCTAssertEqualObjects(firstAccount.balance, @333);
        XCTAssertEqualObjects(firstAccount.limit, @700);
        XCTAssertEqualObjects(firstAccount.accountClass, @"wallet");
        XCTAssertEqualObjects(firstAccount.organizationIdentifier, @"meniisre");
        XCTAssertEqualObjects(firstAccount.realmCredentialsId, @(-1));
        XCTAssertEqualObjects(firstAccount.accountAuthorizationType, @"None");
        XCTAssertEqualObjects(firstAccount.orderId, @0);
        XCTAssertEqualObjects(firstAccount.isImportAccount, @0);
        XCTAssertNil(firstAccount.lastUpdate);
        XCTAssertNil(firstAccount.personId);
        XCTAssertNil(firstAccount.userEmail);
        XCTAssertTrue([NSDateUtils isDate:firstAccount.createDate equalToDateWithAllComponents:[NSDate dateWithTimeIntervalSince1970:1457443615]] == YES);
        XCTAssertNil(firstAccount.attachedToUserDate);
        XCTAssertEqualObjects(firstAccount.isHidden, @0);
        XCTAssertTrue(firstAccount.isNew == NO);
        
        
        MNFAccount *secondAccount = [accounts objectAtIndex:1];
        XCTAssertNotNil(secondAccount);
        XCTAssertEqualObjects(secondAccount.identifier, @10294);
        XCTAssertEqualObjects(secondAccount.accountTypeId, @37);
        XCTAssertEqualObjects(secondAccount.accountIdentifier, @"21");
        XCTAssertEqualObjects(secondAccount.realmIdentifier, @"Demo");
        XCTAssertEqualObjects(secondAccount.name, @"My Creditcard");
        XCTAssertEqualObjects(secondAccount.balance, @(-960));
        XCTAssertEqualObjects(secondAccount.limit, @2000);
        XCTAssertEqualObjects(secondAccount.accountClass, @"euro");
        XCTAssertEqualObjects(secondAccount.organizationIdentifier, @"meniisre");
        XCTAssertEqualObjects(secondAccount.realmCredentialsId, @2416);
        XCTAssertEqualObjects(secondAccount.accountAuthorizationType, @"External");
        XCTAssertEqualObjects(secondAccount.orderId, @0);
        XCTAssertEqualObjects(secondAccount.isImportAccount, @0);
        XCTAssertTrue([NSDateUtils isDate:secondAccount.lastUpdate equalToDateWithAllComponents:[NSDate dateWithTimeIntervalSince1970:1452259622]] == YES);
        XCTAssertEqualObjects(secondAccount.personId, @2499);
        XCTAssertTrue([NSDateUtils isDate:secondAccount.createDate equalToDateWithAllComponents:[NSDate dateWithTimeIntervalSince1970:1456838815]] == YES);
        XCTAssertNil(secondAccount.emergencyFundBalanceLimit);
        XCTAssertEqualObjects(secondAccount.inactive, @0);
        XCTAssertNil(secondAccount.attachedToUserDate);
        XCTAssertEqualObjects(secondAccount.isHidden, @0);
        XCTAssertTrue(secondAccount.isNew == NO);
        
        
        MNFAccount *thirdAccount = [accounts objectAtIndex:2];
        XCTAssertNotNil(thirdAccount);
        XCTAssertEqualObjects(thirdAccount.identifier, @10295);
        XCTAssertEqualObjects(thirdAccount.accountTypeId, @39);
        XCTAssertEqualObjects(thirdAccount.accountIdentifier, @"22");
        XCTAssertEqualObjects(thirdAccount.realmIdentifier, @"Demooo");
        XCTAssertEqualObjects(thirdAccount.accountTypeId, @39);
        XCTAssertEqualObjects(thirdAccount.name, @"My Bank Account");
        XCTAssertEqualObjects(thirdAccount.balance, @459);
        XCTAssertEqualObjects(thirdAccount.limit, @1000);
        XCTAssertEqualObjects(thirdAccount.accountClass, @"meniga");
        XCTAssertEqualObjects(thirdAccount.organizationIdentifier, @"menigaisre");
        XCTAssertEqualObjects(thirdAccount.realmCredentialsId, @2313);
        XCTAssertEqualObjects(thirdAccount.accountAuthorizationType, @"NotExternal");
        XCTAssertEqualObjects(thirdAccount.orderId, @0);
        XCTAssertEqualObjects(thirdAccount.isImportAccount, @0);
        XCTAssertTrue([NSDateUtils isDate:thirdAccount.lastUpdate equalToDateWithAllComponents:[NSDate dateWithTimeIntervalSince1970:1457443623]] == YES);
        XCTAssertEqualObjects(thirdAccount.personId, @137);
        XCTAssertEqualObjects(thirdAccount.userEmail, @"mathieu@meniga.is");
        XCTAssertTrue([NSDateUtils isDate:thirdAccount.createDate equalToDateWithAllComponents:[NSDate dateWithTimeIntervalSince1970:1457436415]] == YES);
        XCTAssertNil(thirdAccount.emergencyFundBalanceLimit);
        XCTAssertEqualObjects(thirdAccount.inactive, @0);
        XCTAssertEqualObjects(thirdAccount.attachedToUserDate, nil);
        XCTAssertEqualObjects(thirdAccount.isHidden, @0);
        XCTAssertTrue(thirdAccount.isNew == NO);
        
        
        MNFAccount *fourthAccount = [accounts objectAtIndex:3];
        XCTAssertNotNil(fourthAccount);
        XCTAssertEqualObjects(fourthAccount.accountIdentifier, @"23");
        XCTAssertEqualObjects(fourthAccount.realmIdentifier, @"AnotherDemo");
        XCTAssertEqualObjects(fourthAccount.accountTypeId, @41);
        XCTAssertEqualObjects(fourthAccount.name, @"My Savings Account");
        XCTAssertEqualObjects(fourthAccount.balance, @1246);
        XCTAssertEqualObjects(fourthAccount.limit, @0);
        XCTAssertEqualObjects(fourthAccount.accountClass, @"meniga");
        XCTAssertEqualObjects(fourthAccount.organizationIdentifier, @"meniisre");
        XCTAssertEqualObjects(fourthAccount.realmCredentialsId, @2416);
        XCTAssertEqualObjects(fourthAccount.accountAuthorizationType, @"External");
        XCTAssertEqualObjects(fourthAccount.orderId, @0);
        XCTAssertEqualObjects(fourthAccount.isImportAccount, @0);
        XCTAssertTrue([NSDateUtils isDate:fourthAccount.lastUpdate equalToDateWithAllComponents:[NSDate dateWithTimeIntervalSince1970:1457443623]] == YES);
        XCTAssertEqualObjects(fourthAccount.personId, @2499);
        XCTAssertTrue([NSDateUtils isDate:fourthAccount.createDate equalToDateWithAllComponents:[NSDate dateWithTimeIntervalSince1970:1457443615]] == YES);
        XCTAssertEqualObjects(fourthAccount.emergencyFundBalanceLimit, nil);
        XCTAssertEqualObjects(fourthAccount.inactive, @0);
        XCTAssertEqualObjects(fourthAccount.attachedToUserDate, nil);
        XCTAssertEqualObjects(fourthAccount.isHidden, @0);
        XCTAssertTrue(fourthAccount.isNew == NO);
        
        
        XCTAssertNil(error);
        
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:nil];
}

-(void)testFetchAccountCategoryTypesWithCompletion {
    [MNFNetworkProtocolForTesting setResponseData:[NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"accountCategoryTypesResponse" ofType:@"json"]]];
    
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFJob *job = [MNFAccount fetchAccountTypesWithCompletion:^(NSArray *accountCategoryTypes, NSError *error) {
        
        XCTAssertNotNil(accountCategoryTypes);
        XCTAssertNotNil([accountCategoryTypes objectAtIndex:0]);
        XCTAssertNotNil([accountCategoryTypes objectAtIndex:1]);
        MNFAccountType *accountType = [accountCategoryTypes firstObject];
        XCTAssertNotNil(accountType.identifier);
        XCTAssertNotNil(accountType.name);
        XCTAssertTrue(accountType.isNew == NO);
        
        XCTAssertNil(error);
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:nil];
}
-(void)testFetchAccountAuthorizationTypesWithCompletion {
    [MNFNetworkProtocolForTesting setResponseData:[NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"accountCategoryTypesResponse" ofType:@"json"]]];
    
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFJob *job = [MNFAccount fetchAccountAuthorizationTypesWithCompletion:^(NSArray *accountAuthorizationTypes, NSError *error) {
        XCTAssertNotNil(accountAuthorizationTypes);
        XCTAssertNotNil([accountAuthorizationTypes objectAtIndex:0]);
        XCTAssertNotNil([accountAuthorizationTypes objectAtIndex:1]);
        MNFAccountAuthorizationType *authType = [accountAuthorizationTypes firstObject];
        XCTAssertNotNil(authType.identifier);
        XCTAssertNotNil(authType.name);
        XCTAssertTrue(authType.isNew == NO);
        
        XCTAssertNil(error);
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:nil];
}
-(void)testFetchRealmAccountTypes {
    [MNFNetworkProtocolForTesting setResponseData:[self realmAccountTypesResponse]];
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFJob *job = [MNFAccount fetchAccountTypesWithCompletion:^(NSArray * _Nullable result, NSError * _Nullable error) {
        XCTAssertNil(error);
        XCTAssertNotNil(result);
        XCTAssertTrue(result.count == 7);
        
        MNFAccountType *accountType = [result firstObject];
        XCTAssertNotNil(accountType.identifier);
        XCTAssertNotNil(accountType.name);
        XCTAssertNotNil(accountType.accountDescription);
        XCTAssertNotNil(accountType.accountType);
        XCTAssertTrue(accountType.isNew == NO);
        
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

-(void)testSetMetadata {
    [MNFNetworkProtocolForTesting setResponseData:[self metadataResponse]];
    
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    __weak id weakSelf = self;
    
    MNFJob *job = [_sut setMetadataValue:@"data" forKey:@"meta" completion:^(NSError * _Nullable error) {
        //XCTAssertNil(error);
        id self = weakSelf;
        XCTAssertEqualObjects(error, nil);
        
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

-(void)testFetchMetadata {
    [MNFNetworkProtocolForTesting setResponseData:[self metadataResponse]];
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFJob *job = [_sut fetchMetadataWithCompletion:^(id  _Nullable result, NSError * _Nullable error) {
        XCTAssertNil(error);
        XCTAssertNotNil(result);
        NSArray *array = result;
        XCTAssertTrue(array.count == 1);
        NSDictionary *dict = [array firstObject];
        XCTAssertEqualObjects([dict objectForKey:@"key"], @"meta");
        XCTAssertEqualObjects([dict objectForKey:@"value"], @"data");
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

-(void)testSaveAccountWithCompletion {
    [MNFNetworkProtocolForTesting setResponseData:[self emptyResponse]];
    
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFJob *job = [_sut saveWithCompletion:^(NSError * _Nullable error) {
        
        XCTAssertNil(error);
        
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:nil];
}

-(void)testSaveAccountWithNilCompletion {
    
    [MNFNetworkProtocolForTesting setResponseData:[self emptyResponse]];
    
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [_sut saveWithCompletion:nil];
    
    [expectation fulfill];
    [self waitForExpectationsWithTimeout:10 handler:nil];
    
}

-(void)testDeleteAccountWithCompletion {
    [MNFNetworkProtocolForTesting setResponseData:[self emptyResponse]];
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    MNFJob *job = [_sut deleteAccountWithCompletion:^(NSError * _Nullable error) {
        
        XCTAssertNil(error);
        
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

-(void)testDeleteAccountWithNilCompletion {
    
    [MNFNetworkProtocolForTesting setResponseData:[self emptyResponse]];
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [_sut deleteAccountWithCompletion:nil];
    
    [GCDUtils dispatchAfterTime:2.0 completion:^{
        XCTAssertTrue(_sut.isDeleted == YES);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

-(void)testRefreshAccountWithCompletion {
    [MNFNetworkProtocolForTesting setObjectType:MNFAccountObject];
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    // the format before refresh
    XCTAssertNotNil(_sut);
    XCTAssertEqualObjects(_sut.identifier, @10295);
    XCTAssertEqualObjects(_sut.accountIdentifier, @"23");
    XCTAssertEqualObjects(_sut.accountTypeId, @40);
    XCTAssertEqualObjects(_sut.name, @"My New Credit Card");
    XCTAssertEqualObjects(_sut.balance, @1000);
    XCTAssertEqualObjects(_sut.limit, @2000);
    XCTAssertEqualObjects(_sut.accountClass, @"CoolClass");
    XCTAssertEqualObjects(_sut.organizationIdentifier, @"meniisre");
    XCTAssertEqualObjects(_sut.realmCredentialsId, @2416);
    XCTAssertEqualObjects(_sut.accountAuthorizationType, @"Test");
    XCTAssertEqualObjects(_sut.orderId, @0);
    XCTAssertEqualObjects(_sut.isImportAccount, @0);
    XCTAssertEqualObjects(_sut.personId, @2400);
    XCTAssertEqualObjects(_sut.userEmail, @"joe@meniga.is");
    XCTAssertEqualObjects(_sut.emergencyFundBalanceLimit, @3000);
    XCTAssertEqualObjects(_sut.inactive, @0);
    XCTAssertEqualObjects(_sut.synchronizationIsPaused, @1);
    XCTAssertEqualObjects(_sut.hasInactiveBudget, @1);
    XCTAssertEqualObjects(_sut.hasInactiveTransactions, @1);
    XCTAssertEqualObjects(_sut.isHidden, @1);
    XCTAssertTrue(_sut.isNew == NO);
    
    XCTAssertTrue([NSDateUtils isDate:_sut.lastUpdate equalToDateWithAllComponents:[NSDate dateWithTimeIntervalSince1970:1453555622]] == YES);
    XCTAssertTrue([NSDateUtils isDate:_sut.createDate equalToDateWithAllComponents:[NSDate dateWithTimeIntervalSince1970:1425821215]] == YES);
    XCTAssertTrue([NSDateUtils isDate:_sut.attachedToUserDate equalToDateWithAllComponents:[NSDate dateWithTimeIntervalSince1970:180]] == YES);
    
    MNFJob *job = [_sut refreshWithCompletion:^(NSError * _Nullable error) {
        
        XCTAssertNil(error);
        
        XCTAssertEqualObjects(_sut.identifier, @10294);
        XCTAssertEqualObjects(_sut.accountClass, @"euro");
        XCTAssertEqualObjects(_sut.accountIdentifier, @"21");
        XCTAssertEqualObjects(_sut.accountTypeId, @37);
        XCTAssertEqualObjects(_sut.attachedToUserDate, [NSDate dateWithTimeIntervalSince1970:1.0]);
        XCTAssertEqualObjects(_sut.balance, @4500);
        XCTAssertEqualObjects(_sut.emergencyFundBalanceLimit, @3000);
        XCTAssertEqualObjects(_sut.hasInactiveBudget, @0);
        XCTAssertEqualObjects(_sut.hasInactiveTransactions, @0);
        XCTAssertEqualObjects(_sut.inactive, @0);
        XCTAssertEqualObjects(_sut.isHidden, @0);
        XCTAssertEqualObjects(_sut.isImportAccount, @0);
        XCTAssertEqualObjects(_sut.limit, @2000);
        XCTAssertEqualObjects(_sut.name, @"My Creditcard");
        XCTAssertEqualObjects(_sut.orderId, @0);
        XCTAssertEqualObjects(_sut.organizationIdentifier, @"meniisre");
        XCTAssertEqualObjects(_sut.personId, @2499);
        XCTAssertEqualObjects(_sut.realmCredentialsId, @2416);
        XCTAssertEqualObjects(_sut.realmIdentifier, @"Demo");
        XCTAssertEqualObjects(_sut.synchronizationIsPaused, @0);
        XCTAssertEqualObjects(_sut.userEmail, @"mathieu@meniga.is");
        XCTAssertTrue(_sut.isNew == NO);
        
        XCTAssertTrue([NSDateUtils isDate:_sut.attachedToUserDate equalToDateWithAllComponents:[NSDate dateWithTimeIntervalSince1970:1.0]] == YES);
        XCTAssertTrue([NSDateUtils isDate:_sut.createDate equalToDateWithAllComponents:[NSDate dateWithTimeIntervalSince1970:1457443615]] == YES);
        XCTAssertTrue([NSDateUtils isDate:_sut.lastUpdate equalToDateWithAllComponents:[NSDate dateWithTimeIntervalSince1970:1457443622]] == YES);
        
        [expectation fulfill];
        
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

-(void)testRefreshAccountWithNilCompletion {
    
    [MNFNetworkProtocolForTesting setObjectType:MNFAccountObject];
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [_sut refreshWithCompletion:nil];
    
    [GCDUtils dispatchAfterTime:0.1 completion:^{
        
        XCTAssertEqualObjects(_sut.identifier, @10294);
        XCTAssertEqualObjects(_sut.accountClass, @"euro");
        XCTAssertEqualObjects(_sut.accountIdentifier, @"21");
        XCTAssertEqualObjects(_sut.accountTypeId, @37);
        XCTAssertEqualObjects(_sut.attachedToUserDate, [NSDate dateWithTimeIntervalSince1970:1.0]);
        XCTAssertEqualObjects(_sut.balance, @4500);
        XCTAssertEqualObjects(_sut.emergencyFundBalanceLimit, @3000);
        XCTAssertEqualObjects(_sut.hasInactiveBudget, @0);
        XCTAssertEqualObjects(_sut.hasInactiveTransactions, @0);
        XCTAssertEqualObjects(_sut.inactive, @0);
        XCTAssertEqualObjects(_sut.isHidden, @0);
        XCTAssertEqualObjects(_sut.isImportAccount, @0);
        XCTAssertEqualObjects(_sut.limit, @2000);
        XCTAssertEqualObjects(_sut.name, @"My Creditcard");
        XCTAssertEqualObjects(_sut.orderId, @0);
        XCTAssertEqualObjects(_sut.organizationIdentifier, @"meniisre");
        XCTAssertEqualObjects(_sut.personId, @2499);
        XCTAssertEqualObjects(_sut.realmCredentialsId, @2416);
        XCTAssertEqualObjects(_sut.realmIdentifier, @"Demo");
        XCTAssertEqualObjects(_sut.synchronizationIsPaused, @0);
        XCTAssertEqualObjects(_sut.userEmail, @"mathieu@meniga.is");
        XCTAssertTrue(_sut.isNew == NO);
        
        XCTAssertTrue([NSDateUtils isDate:_sut.attachedToUserDate equalToDateWithAllComponents:[NSDate dateWithTimeIntervalSince1970:1.0]] == YES);
        XCTAssertTrue([NSDateUtils isDate:_sut.createDate equalToDateWithAllComponents:[NSDate dateWithTimeIntervalSince1970:1457443615]] == YES);
        XCTAssertTrue([NSDateUtils isDate:_sut.lastUpdate equalToDateWithAllComponents:[NSDate dateWithTimeIntervalSince1970:1457443622]] == YES);
        
        [expectation fulfill];
        
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
    
}

-(void)testFetchAccountHistory {
    [MNFNetworkProtocolForTesting setResponseData:[self accountHistoryResponse]];
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFJob *job = [_sut fetchHistoryFromDate:[NSDate dateWithTimeIntervalSinceNow:-30*24*60*60] toDate:[NSDate date] sortBy:nil ascending:YES completion:^(NSArray * _Nullable accountHistoryEntries, NSError * _Nullable error) {
        XCTAssertNil(error);
        XCTAssertNotNil(accountHistoryEntries);
        XCTAssertTrue(accountHistoryEntries.count == 7);
        
        MNFAccountHistoryEntry *entry = [accountHistoryEntries firstObject];
        XCTAssertNotNil(entry.identifier);
        XCTAssertNotNil(entry.accountId);
        XCTAssertNotNil(entry.balance);
        XCTAssertNotNil(entry.balanceDate);
        XCTAssertNotNil(entry.isDefault);
        XCTAssertTrue(entry.isNew == NO);
        
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

-(void)testFetchAccountHistoryWithIncorrectSortDescriptorReturnsError {
    [MNFNetworkProtocolForTesting setResponseData:[self accountHistoryResponse]];
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFJob *job = [_sut fetchHistoryFromDate:[NSDate dateWithTimeIntervalSinceNow:-30*24*60*60] toDate:[NSDate date] sortBy:@"Wrong" ascending:YES completion:^(NSArray<MNFAccountHistoryEntry *> * _Nullable accountHistoryEntries, NSError * _Nullable error) {
        XCTAssertNotNil(error);
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNil(result);
        XCTAssertNil(metaData);
        XCTAssertNotNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

-(NSData*)emptyResponse {
    return [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"emptyResponse" ofType:@"json"]];
}
-(NSData*)realmAccountTypesResponse {
    return [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"realmAccountTypesResponse" ofType:@"json"]];
}
-(NSData*)metadataResponse {
    return [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"accountMetadata" ofType:@"json"]];
}
-(NSData*)accountHistoryResponse {
    return [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"accountHistoryResponse" ofType:@"json"]];
}

@end
