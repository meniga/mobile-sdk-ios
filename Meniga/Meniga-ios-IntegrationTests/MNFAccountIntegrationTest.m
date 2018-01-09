//
//  MNFAccountIntegrationTest.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 19/04/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNFIntegrationTestSetup.h"
#import "MNFAccount.h"

@interface MNFAccountIntegrationTest : MNFIntegrationTestSetup

@end

@implementation MNFAccountIntegrationTest

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

-(void)testFetchAccounts {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [MNFAccount fetchAccountsWithFilter: [[MNFAccountFilter alloc] init] completion:^(NSArray *accounts, NSError *error) {
        
    }];
    
    MNFJob *job = [MNFAccount fetchAccountsWithFilter: nil completion:^(NSArray<MNFAccount *> * _Nullable accounts, NSError * _Nullable error) {
        XCTAssertNotNil(accounts);
        XCTAssertNil(error);
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    }];
    
    [self waitForExpectationsWithTimeout:kMNFIntegrationTestWaitTime handler:nil];
}


-(void)testFetchAccountWithId {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [MNFAccount fetchAccountsWithFilter: nil completion:^(NSArray<MNFAccount *> * _Nullable accounts, NSError * _Nullable error) {
        
        MNFJob *job = [MNFAccount fetchWithId:[accounts firstObject].identifier completion:^(MNFAccount * _Nullable account, NSError * _Nullable error) {
            
            XCTAssertNotNil(account);
            XCTAssertNotNil(account.accountCategory);
            XCTAssertNotNil(account.accountTypeId);
            XCTAssertNil(error);
            
            [expectation fulfill];
        }];
        
        [job handleCompletion:^(MNFAccount *result, id metadata, NSError *error) {
            
            XCTAssertNotNil(result);
            XCTAssertNotNil(result.accountCategory);
            XCTAssertNotNil(result.accountTypeId);
            XCTAssertNil(error);
            
        }];
        
    }];
    
    
    [self waitForExpectationsWithTimeout:kMNFIntegrationTestWaitTime handler:nil];
}

-(void)testSaveAccount {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [MNFAccount fetchAccountsWithFilter: nil completion: ^(NSArray <MNFAccount *> *accounts, NSError *error) {
        
        XCTAssertTrue(accounts.count != 0);
        
        MNFAccount *account = [accounts firstObject];
        account.name = @"newName";
        account.orderId = @1;
        account.emergencyFundBalanceLimit = @100;
        account.isHidden = @YES;
        
        MNFJob *job = [account saveWithCompletion:^(NSError * _Nullable error) {
            
            XCTAssertNil(error);
            XCTAssertTrue([account.name isEqualToString:@"newName"]);
            XCTAssertTrue([account.orderId isEqualToNumber:@1]);
            XCTAssertTrue([account.emergencyFundBalanceLimit isEqualToNumber:@100]);
            XCTAssertTrue([account.isHidden boolValue]);
            
            [expectation fulfill];
        }];
        
        [job handleCompletion:^(id result, NSDictionary *metadata, NSError *error) {
            
            XCTAssertNil(error);
            XCTAssertTrue([account.name isEqualToString:@"newName"]);
            XCTAssertTrue([account.orderId isEqualToNumber:@1]);
            XCTAssertTrue([account.emergencyFundBalanceLimit isEqualToNumber:@100]);
            XCTAssertTrue([account.isHidden boolValue]);
            
        }];
        
    }];
    
    [self waitForExpectationsWithTimeout:kMNFIntegrationTestWaitTime handler:nil];
}

-(void)testDeleteAccount {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [MNFAccount fetchAccountsWithFilter: nil completion:^(NSArray<MNFAccount *> * _Nullable accounts, NSError * _Nullable error) {
        
        MNFAccount *account = [accounts lastObject];
        
        MNFJob *job = [account deleteAccountWithCompletion:^(NSError * _Nullable error) {
            XCTAssertNotNil(error);
            XCTAssertFalse(account.isDeleted);
            [expectation fulfill];
        }];
        
        [job handleCompletion:^(id _Nullable result, id _Nullable metaData, NSError * _Nullable error) {
           
            XCTAssertNotNil(error);
            XCTAssertFalse(account.isDeleted);
            
        }];
        
    }];

    [self waitForExpectationsWithTimeout:kMNFIntegrationTestWaitTime handler:nil];
}

-(void)testAccountMetadata {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [MNFAccount fetchAccountsWithFilter: nil completion:^(NSArray<MNFAccount *> * _Nullable accounts, NSError * _Nullable error) {
        
        __weak MNFAccount *account = [accounts firstObject];
        if ([account.accountCategory isEqualToString: @"Wallet"]) {
            account = [accounts objectAtIndex: 2];
        }
        
        XCTAssertNotNil(account);
        XCTAssertTrue(accounts.count != 0);
        XCTAssertNil(error);
        
        MNFJob *job = [account setMetadataValue:@"metadataValue" forKey:@"metadataKey" completion:^(NSError * _Nullable error) {
            
            XCTAssertNil(error);
            
            MNFJob *secondJob = [account fetchMetadataForKey:@"metadataKey" withCompletion:^(NSString * _Nullable metadataValue, NSError * _Nullable error) {
                
                XCTAssertNil(error);
                XCTAssertEqualObjects(metadataValue, @"metadataValue");
                XCTAssertNotNil(metadataValue);
                
                [account fetchMetadataWithCompletion:^(NSArray<NSDictionary *> * _Nullable metadatas, NSError * _Nullable error) {
                    
                    XCTAssertNil(error);
                    XCTAssertNotNil(metadatas);
                    
                    [expectation fulfill];
                }];
                
                
            }];
            
            [secondJob handleCompletion:^(id _Nullable result, id _Nullable metadata, NSError * _Nullable error) {
               
                XCTAssertNil(error);
                XCTAssertEqualObjects(result, @"metadataValue");
                XCTAssertNotNil(result);
                
            }];
            
        }];
        
        [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
            
            XCTAssertNil(error);
            
        }];
    }];
    
    [self waitForExpectationsWithTimeout:kMNFIntegrationTestWaitTime handler:nil];
}

-(void)testFetchAccountHistory {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [MNFAccount fetchAccountsWithFilter: nil completion:^(NSArray<MNFAccount *> * _Nullable accounts, NSError * _Nullable error) {
        
        MNFAccount *account = [accounts firstObject];
        
        MNFJob *job = [account fetchHistoryFromDate:[NSDate dateWithTimeIntervalSinceNow:-30*24*60*60] toDate:[NSDate date] sortBy:nil ascending:YES completion:^(NSArray<MNFAccountHistoryEntry *> * _Nullable accountHistoryEntries, NSError * _Nullable error) {
            
            XCTAssertNil(error);
            XCTAssertNotNil(accountHistoryEntries);
            
            [expectation fulfill];
        }];
        
        [job handleCompletion:^(NSArray<MNFAccountHistoryEntry *> * _Nullable accountHistoryEntries, id metadata, NSError *error) {
           
            XCTAssertNil(error);
            XCTAssertNotNil(accountHistoryEntries);
            
        }];
        
    }];
    

    [self waitForExpectationsWithTimeout:kMNFIntegrationTestWaitTime handler:nil];
}

-(void)testFetchAccountTypes {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFJob *job = [MNFAccount fetchAccountTypesWithCompletion:^(NSArray<MNFAccountType *> * _Nullable accountTypes, NSError * _Nullable error) {
        
        XCTAssertNotNil(accountTypes);
        XCTAssertNil(error);
        
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    
    }];
    
    [self waitForExpectationsWithTimeout:kMNFIntegrationTestWaitTime handler:nil];
}

-(void)testFetchAccountCategories {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFJob *job = [MNFAccount fetchAccountCategoriesWithCompletion:^(NSArray<MNFAccountCategory *> * _Nullable accountTypes, NSError * _Nullable error) {
        
        XCTAssertNotNil(accountTypes);
        XCTAssertNil(error);
        
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    
    }];
    
    [self waitForExpectationsWithTimeout:kMNFIntegrationTestWaitTime handler:nil];
}

-(void)testFetchAccountAuthorizationTypes {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    MNFJob *job = [MNFAccount fetchAccountAuthorizationTypesWithCompletion:^(NSArray<MNFAccountAuthorizationType *> * _Nullable accountAuthorizationTypes, NSError * _Nullable error) {
        
        XCTAssertNil(error);
        XCTAssertNotNil(accountAuthorizationTypes);
        
        [expectation fulfill];
    }];
    
    [job handleCompletion:^(id  _Nullable result, id  _Nullable metaData, NSError * _Nullable error) {
        
        XCTAssertNotNil(result);
        XCTAssertNil(metaData);
        XCTAssertNil(error);
    
    }];
    
    [self waitForExpectationsWithTimeout:kMNFIntegrationTestWaitTime handler:nil];
}


@end
