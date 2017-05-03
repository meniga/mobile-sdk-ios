//
//  MNFPersistenceProviderTest.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 17/11/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNFPersistenceProvider.h"
#import "MNFPersistenceRequest.h"
#import "MNFJsonAdapter.h"
#import "Meniga.h"

@interface MNFPersistenceProviderTest : XCTestCase {
    MNFPersistenceProvider *populatedProvider;
}

@end

@implementation MNFPersistenceProviderTest

/*
- (void)setUp {
    [super setUp];
    populatedProvider = [MNFPersistenceProvider new];
    NSCache *cache = [NSCache new];
    NSData *accountData = [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"accountResponse" ofType:@"json"]];
    NSDictionary *account = [NSJSONSerialization JSONObjectWithData:accountData options:0 error:nil];
    [cache setObject:@[account] forKey:@"Accounts"];
    
    [cache setObject:@[@{@"Name":@"TestOne",@"Id":@1},@{@"Name":@"TestTwo",@"Id":@2},@{@"Name":@"TestThree",@"Id":@3}] forKey:@"AccountCategoryTypes"];
    [cache setObject:@[@{@"Name":@"TestFour",@"Id":@4},@{@"Name":@"TestFive",@"Id":@5},@{@"Name":@"TestSix",@"Id":@6}] forKey:@"AccountAuthorizationTypes"];
    
    NSData *categoryData = [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"categoryResponse" ofType:@"json"]];
    NSDictionary *category = [NSJSONSerialization JSONObjectWithData:categoryData options:0 error:nil];
    [cache setObject:@[category] forKey:@"UserCategories"];
    
    [cache setObject:@[@"1",@"2",@"3",@"4",@"5"] forKey:@"TopCategoryIds"];
    [cache setObject:@[category] forKey:@"PublicCategoryTree"];
    [cache setObject:@[category] forKey:@"UserCategoryTree"];
    
    NSData *offerData = [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"offerResponse" ofType:@"json"]];
    NSDictionary *offer = [NSJSONSerialization JSONObjectWithData:offerData options:0 error:nil];
    [cache setObject:@[offer] forKey:@"Offers"];
    
    NSData *feedData = [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"feedResponse" ofType:@"json"]];
    NSDictionary *feed = [NSJSONSerialization JSONObjectWithData:feedData options:0 error:nil];
    [cache setObject:feed forKey:@"Feed"];
    
    [cache setObject:@[@{@"Name":@"TestOne",@"Id":@1},@{@"Name":@"TestTwo",@"Id":@2}] forKey:@"Tags"];
    
    NSData *transactionData = [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"transactionResponse" ofType:@"json"]];
    NSDictionary *transaction = [NSJSONSerialization JSONObjectWithData:transactionData options:0 error:nil];
    [cache setObject:@[transaction] forKey:@"Transactions"];
    
    NSData *profileData = [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"userProfileResponse" ofType:@"json"]];
    NSDictionary *profile = [NSJSONSerialization JSONObjectWithData:profileData options:0 error:nil];
    [cache setObject:profile forKey:@"UserProfile"];
    
    [populatedProvider setDefaultCache:cache];
    [Meniga clearSettings];
}

- (void)tearDown {
    populatedProvider = nil;
    [super tearDown];
}

-(void)testHasKey {
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"www.example.com/api/getAccountWidhId"]];
    NSData *data = [NSJSONSerialization dataWithJSONObject:@{@"id":@1428,@"name":@"test"} options:0 error:nil];
    urlRequest.HTTPBody = data;
    MNFPersistenceRequest *persistenceRequest = [[MNFPersistenceRequest alloc] initWithRequest:[urlRequest copy]];
    
    XCTAssertTrue([populatedProvider hasKey:persistenceRequest]);
}

-(void)testEmptyFetchAccountWithId {
    MNFPersistenceProvider *provider = [MNFPersistenceProvider new];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"www.example.com/Api/Transactions/GetAccount"]];
    NSData *data = [NSJSONSerialization dataWithJSONObject:@{@"accountId":@1} options:0 error:nil];
    urlRequest.HTTPBody = data;
    MNFPersistenceRequest *persistenceRequest = [[MNFPersistenceRequest alloc] initWithRequest:[urlRequest copy]];
    NSLog(@"Persistence request:%@",persistenceRequest.request);
    MNFJob *task = [provider fetchWithRequest:persistenceRequest];
    
    XCTAssertNotNil(task);
    XCTAssertNil(task.task.result);
    XCTAssertNotNil(task.task.error);
}
-(void)testPopulatedFetchAccountWithId {
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"www.example.com/Api/Transactions/GetAccount"]];
    NSData *data = [NSJSONSerialization dataWithJSONObject:@{@"accountId":@1428} options:0 error:nil];
    urlRequest.HTTPBody = data;
    MNFPersistenceRequest *persistenceRequest = [[MNFPersistenceRequest alloc] initWithRequest:[urlRequest copy]];
    MNFJob *task = [populatedProvider fetchWithRequest:persistenceRequest];
    XCTAssertNotNil(task);
    XCTAssertNotNil(task.task.result);
    XCTAssertNil(task.task.error);
}
-(void)testEmptyFetchAccounts {
    MNFPersistenceProvider *provider = [MNFPersistenceProvider new];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"www.example.com/Api/Transactions/GetAccounts"]];
    MNFPersistenceRequest *persistenceRequest = [[MNFPersistenceRequest alloc] initWithRequest:[urlRequest copy]];
    MNFJob *task = [provider fetchWithRequest:persistenceRequest];
    XCTAssertNotNil(task);
    XCTAssertNil(task.task.result);
    XCTAssertNotNil(task.task.error);
}
-(void)testPopulatedFetchAccounts {
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"www.example.com/Api/Transactions/GetAccounts"]];
    MNFPersistenceRequest *persistenceRequest = [[MNFPersistenceRequest alloc] initWithRequest:[urlRequest copy]];
    MNFJob *task = [populatedProvider fetchWithRequest:persistenceRequest];
    XCTAssertNotNil(task);
    XCTAssertNotNil(task.task.result);
    XCTAssertNil(task.task.error);
}
-(void)testEmptyFetchAccountCategoryTypes {
    MNFPersistenceProvider *provider = [MNFPersistenceProvider new];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"www.example.com/Api/Transactions/GetAccountCategoryTypes"]];
    MNFPersistenceRequest *persistenceRequest = [[MNFPersistenceRequest alloc] initWithRequest:[urlRequest copy]];
    MNFJob *task = [provider fetchWithRequest:persistenceRequest];
    XCTAssertNotNil(task);
    XCTAssertNil(task.task.result);
    XCTAssertNotNil(task.task.error);
}
-(void)testPopulatedFetchAccountCategoryTypes {
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"www.example.com/Api/Transactions/GetAccountCategoryTypes"]];
    MNFPersistenceRequest *persistenceRequest = [[MNFPersistenceRequest alloc] initWithRequest:[urlRequest copy]];
    MNFJob *task = [populatedProvider fetchWithRequest:persistenceRequest];
    XCTAssertNotNil(task);
    XCTAssertNotNil(task.task.result);
    XCTAssertNil(task.task.error);
}
-(void)testEmptyFetchAccountAuthorizationTypes {
    MNFPersistenceProvider *provider = [MNFPersistenceProvider new];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"www.example.com/Api/Transactions/GetAccountAuthorizationTypes"]];
    MNFPersistenceRequest *persistenceRequest = [[MNFPersistenceRequest alloc] initWithRequest:[urlRequest copy]];
    MNFJob *task = [provider fetchWithRequest:persistenceRequest];
    XCTAssertNotNil(task);
    XCTAssertNil(task.task.result);
    XCTAssertNotNil(task.task.error);
}
-(void)testPopulatedFetchAccountAuthorizationTypes {
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"www.example.com/Api/Transactions/GetAccountAuthorizationTypes"]];
    MNFPersistenceRequest *persistenceRequest = [[MNFPersistenceRequest alloc] initWithRequest:[urlRequest copy]];
    MNFJob *task = [populatedProvider fetchWithRequest:persistenceRequest];
    XCTAssertNotNil(task);
    XCTAssertNotNil(task.task.result);
    XCTAssertNil(task.task.error);
}
-(void)testEmptySaveAccount {
    MNFPersistenceProvider *provider = [MNFPersistenceProvider new];
    NSData *data = [NSJSONSerialization dataWithJSONObject:@{@"account":@{@"Id":@10,@"Name":@"testName",@"IsHidden":@0}} options:0 error:nil];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"www.example.com/Api/Transactions/SetAccountProperties"]];
    urlRequest.HTTPBody = data;
    MNFPersistenceRequest *persistenceRequest = [[MNFPersistenceRequest alloc] initWithRequest:[urlRequest copy]];
    MNFJob *task = [provider saveWithRequest:persistenceRequest];
    XCTAssertNotNil(task);
    XCTAssertNotNil(task.task.result);
    XCTAssertNil(task.task.error);
}
-(void)testPopulatedSaveAccount {
    NSData *data = [NSJSONSerialization dataWithJSONObject:@{@"account":@{@"Id":@1428,@"Name":@"testName",@"IsHidden":@0}} options:0 error:nil];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"www.example.com/Api/Transactions/SetAccountProperties"]];
    urlRequest.HTTPBody = data;
    MNFPersistenceRequest *persistenceRequest = [[MNFPersistenceRequest alloc] initWithRequest:[urlRequest copy]];
    MNFJob *task = [populatedProvider saveWithRequest:persistenceRequest];
    NSLog(@"Task result: %@",task.task.result);
    XCTAssertNotNil(task);
    XCTAssertNotNil(task.task.result);
    XCTAssertNil(task.task.error);
}
-(void)testEmptyDeleteAccount {
    MNFPersistenceProvider *provider = [MNFPersistenceProvider new];
    NSData *data = [NSJSONSerialization dataWithJSONObject:@{@"accountId":@10} options:0 error:nil];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"www.example.com/Api/Transactions/DeleteAccount"]];
    urlRequest.HTTPBody = data;
    MNFPersistenceRequest *persistenceRequest = [[MNFPersistenceRequest alloc] initWithRequest:[urlRequest copy]];
    MNFJob *task = [provider saveWithRequest:persistenceRequest];
    XCTAssertNotNil(task);
    XCTAssertNil(task.task.result);
    XCTAssertNotNil(task.task.error);
}
-(void)testPopulatedDeleteAccount {
    NSData *data = [NSJSONSerialization dataWithJSONObject:@{@"accountId":@1428} options:0 error:nil];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"www.example.com/Api/Transactions/DeleteAccount"]];
    urlRequest.HTTPBody = data;
    MNFPersistenceRequest *persistenceRequest = [[MNFPersistenceRequest alloc] initWithRequest:[urlRequest copy]];
    MNFJob *task = [populatedProvider saveWithRequest:persistenceRequest];
    XCTAssertNotNil(task);
    XCTAssertNotNil(task.task.result);
    XCTAssertNil(task.task.error);
}

-(void)testEmptyFetchCategoryWithId {
    MNFPersistenceProvider *provider = [MNFPersistenceProvider new];
    NSData *data = [NSJSONSerialization dataWithJSONObject:@{@"id":@10} options:0 error:nil];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"www.example.com/Api/Transactions/GetCategoryById"]];
    urlRequest.HTTPBody = data;
    MNFPersistenceRequest *persistenceRequest = [[MNFPersistenceRequest alloc] initWithRequest:[urlRequest copy]];
    MNFJob *task = [provider fetchWithRequest:persistenceRequest];
    XCTAssertNotNil(task);
    XCTAssertNil(task.task.result);
    XCTAssertNotNil(task.task.error);
}
-(void)testPopulatedFetchCategoryWithId {
    NSData *data = [NSJSONSerialization dataWithJSONObject:@{@"id":@23} options:0 error:nil];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"www.example.com/Api/Transactions/GetCategoryById"]];
    urlRequest.HTTPBody = data;
    MNFPersistenceRequest *persistenceRequest = [[MNFPersistenceRequest alloc] initWithRequest:[urlRequest copy]];
    MNFJob *task = [populatedProvider fetchWithRequest:persistenceRequest];
    XCTAssertNotNil(task);
    XCTAssertNotNil(task.task.result);
    XCTAssertNil(task.task.error);
}
-(void)testEmptyFetchTopCategoryIds {
    MNFPersistenceProvider *provider = [MNFPersistenceProvider new];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"www.example.com/Api/Transactions/GetTopCategoryIds"]];
    MNFPersistenceRequest *persistenceRequest = [[MNFPersistenceRequest alloc] initWithRequest:[urlRequest copy]];
    MNFJob *task = [provider fetchWithRequest:persistenceRequest];
    XCTAssertNotNil(task);
    XCTAssertNil(task.task.result);
    XCTAssertNotNil(task.task.error);
}
-(void)testPopulatedFetchTopCategoryIds {
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"www.example.com/Api/Transactions/GetTopCategoryIds"]];
    MNFPersistenceRequest *persistenceRequest = [[MNFPersistenceRequest alloc] initWithRequest:[urlRequest copy]];
    MNFJob *task = [populatedProvider fetchWithRequest:persistenceRequest];
    XCTAssertNotNil(task);
    XCTAssertNotNil(task.task.result);
    XCTAssertNil(task.task.error);
}
-(void)testEmptyFetchPublicCategoryTree {
    MNFPersistenceProvider *provider = [MNFPersistenceProvider new];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"www.example.com/Api/Transactions/GetPublicCategoryTree"]];
    MNFPersistenceRequest *persistenceRequest = [[MNFPersistenceRequest alloc] initWithRequest:[urlRequest copy]];
    MNFJob *task = [provider fetchWithRequest:persistenceRequest];
    XCTAssertNotNil(task);
    XCTAssertNil(task.task.result);
    XCTAssertNotNil(task.task.error);
}
-(void)testPopulatedFetchPublicCategoryTree {
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"www.example.com/Api/Transactions/GetPublicCategoryTree"]];
    MNFPersistenceRequest *persistenceRequest = [[MNFPersistenceRequest alloc] initWithRequest:[urlRequest copy]];
    MNFJob *task = [populatedProvider fetchWithRequest:persistenceRequest];
    XCTAssertNotNil(task);
    XCTAssertNotNil(task.task.result);
    XCTAssertNil(task.task.error);
}

-(void)testEmptyFetchUserCategories {
    MNFPersistenceProvider *provider = [MNFPersistenceProvider new];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"www.example.com/Api/Transactions/GetUserCategories"]];
    MNFPersistenceRequest *persistenceRequest = [[MNFPersistenceRequest alloc] initWithRequest:[urlRequest copy]];
    MNFJob *task = [provider fetchWithRequest:persistenceRequest];
    XCTAssertNotNil(task);
    XCTAssertNil(task.task.result);
    XCTAssertNotNil(task.task.error);
}
-(void)testPopulatedFetchUserCategories {
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"www.example.com/Api/Transactions/GetUserCategories"]];
    MNFPersistenceRequest *persistenceRequest = [[MNFPersistenceRequest alloc] initWithRequest:[urlRequest copy]];
    MNFJob *task = [populatedProvider fetchWithRequest:persistenceRequest];
    XCTAssertNotNil(task);
    XCTAssertNotNil(task.task.result);
    XCTAssertNil(task.task.error);
}
-(void)testEmptyFetchUserCategoryTree {
    MNFPersistenceProvider *provider = [MNFPersistenceProvider new];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"www.example.com/Api/Transactions/GetUserCategoryTree"]];
    MNFPersistenceRequest *persistenceRequest = [[MNFPersistenceRequest alloc] initWithRequest:[urlRequest copy]];
    MNFJob *task = [provider fetchWithRequest:persistenceRequest];
    XCTAssertNotNil(task);
    XCTAssertNil(task.task.result);
    XCTAssertNotNil(task.task.error);
}
-(void)testPopulatedFetchUserCategoryTree {
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"www.example.com/Api/Transactions/GetUserCategoryTree"]];
    MNFPersistenceRequest *persistenceRequest = [[MNFPersistenceRequest alloc] initWithRequest:[urlRequest copy]];
    MNFJob *task = [populatedProvider fetchWithRequest:persistenceRequest];
    XCTAssertNotNil(task);
    XCTAssertNotNil(task.task.result);
    XCTAssertNil(task.task.error);
}
-(void)testEmptySaveUserCategory {
    MNFPersistenceProvider *provider = [MNFPersistenceProvider new];
    NSData *data = [NSJSONSerialization dataWithJSONObject:@{@"id":@10,@"name":@"testName",@"isFixedExpense":@1,@"categoryType":@13,@"parentId":@21} options:0 error:nil];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"www.example.com/Api/Transactions/UpdateUserCategory"]];
    urlRequest.HTTPBody = data;
    MNFPersistenceRequest *persistenceRequest = [[MNFPersistenceRequest alloc] initWithRequest:[urlRequest copy]];
    MNFJob *task = [provider saveWithRequest:persistenceRequest];
    XCTAssertNotNil(task);
    XCTAssertNotNil(task.task.result);
    XCTAssertNil(task.task.error);
}
-(void)testPopulatedSaveUserCategory {
    NSData *data = [NSJSONSerialization dataWithJSONObject:@{@"id":@23,@"name":@"testName",@"isFixedExpense":@1,@"categoryType":@13,@"parentId":@21} options:0 error:nil];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"www.example.com/Api/Transactions/UpdateUserCategory"]];
    urlRequest.HTTPBody = data;
    MNFPersistenceRequest *persistenceRequest = [[MNFPersistenceRequest alloc] initWithRequest:[urlRequest copy]];
    MNFJob *task = [populatedProvider saveWithRequest:persistenceRequest];
    XCTAssertNotNil(task);
    XCTAssertNotNil(task.task.result);
    XCTAssertNil(task.task.error);
}
-(void)testEmptyDeleteUserCategory {
    MNFPersistenceProvider *provider = [MNFPersistenceProvider new];
    NSData *data = [NSJSONSerialization dataWithJSONObject:@{@"categoryId":@10} options:0 error:nil];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"www.example.com/Api/Transactions/DeleteUserCategory"]];
    urlRequest.HTTPBody = data;
    MNFPersistenceRequest *persistenceRequest = [[MNFPersistenceRequest alloc] initWithRequest:[urlRequest copy]];
    MNFJob *task = [provider saveWithRequest:persistenceRequest];
    XCTAssertNotNil(task);
    XCTAssertNil(task.task.result);
    XCTAssertNotNil(task.task.error);
}
-(void)testPopulatedDeleteUserCategory {
    NSData *data = [NSJSONSerialization dataWithJSONObject:@{@"categoryId":@23} options:0 error:nil];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"www.example.com/Api/Transactions/DeleteUserCategory"]];
    urlRequest.HTTPBody = data;
    MNFPersistenceRequest *persistenceRequest = [[MNFPersistenceRequest alloc] initWithRequest:[urlRequest copy]];
    MNFJob *task = [populatedProvider saveWithRequest:persistenceRequest];
    XCTAssertNotNil(task);
    XCTAssertNotNil(task.task.result);
    XCTAssertNil(task.task.error);
}

-(void)testEmptyFetchFeedFromDateToDate {
    MNFPersistenceProvider *provider = [MNFPersistenceProvider new];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy.MM.dd"];
    NSDate *from = [NSDate dateWithTimeIntervalSince1970:1447027100];
    NSDate *to = [NSDate dateWithTimeIntervalSince1970:1447113700];
    NSData *data = [NSJSONSerialization dataWithJSONObject:@{@"request":@{@"userEventTypes":@[],
                                                                          @"DateFrom":[NSString stringWithFormat:@"%@ 00:00:00",[format stringFromDate:from]],
                                                                          @"DateTo":[NSString stringWithFormat:@"%@ 23:59:59",[format stringFromDate:to]],
                                                                          @"PageNumber":[NSNumber numberWithInt:1],
                                                                          @"itemsPerPage":[NSNumber numberWithInt:100],
                                                                          @"Channel":@"Activity_Feed_Mobile"}}
                                                   options:0 error:nil];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"www.example.com/Api/UserEvent/GetUserFeed"]];
    urlRequest.HTTPBody = data;
    MNFPersistenceRequest *persistenceRequest = [[MNFPersistenceRequest alloc] initWithRequest:[urlRequest copy]];
    MNFJob *task = [provider fetchWithRequest:persistenceRequest];
    XCTAssertNotNil(task);
    XCTAssertNil(task.task.result);
    XCTAssertNotNil(task.task.error);
}
-(void)testPopulatedFetchFeedFromDateToDate {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy.MM.dd"];
    NSDate *from = [NSDate dateWithTimeIntervalSince1970:1447027100];
    NSDate *to = [NSDate dateWithTimeIntervalSince1970:1447113700];
    NSData *data = [NSJSONSerialization dataWithJSONObject:@{@"request":@{@"userEventTypes":@[],
                                                                          @"DateFrom":[NSString stringWithFormat:@"%@ 00:00:00",[format stringFromDate:from]],
                                                                          @"DateTo":[NSString stringWithFormat:@"%@ 23:59:59",[format stringFromDate:to]],
                                                                          @"PageNumber":[NSNumber numberWithInt:1],
                                                                          @"itemsPerPage":[NSNumber numberWithInt:100],
                                                                          @"Channel":@"Activity_Feed_Mobile"}}
                                                   options:0 error:nil];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"www.example.com/Api/UserEvent/GetUserFeed"]];
    urlRequest.HTTPBody = data;
    MNFPersistenceRequest *persistenceRequest = [[MNFPersistenceRequest alloc] initWithRequest:[urlRequest copy]];
    MNFJob *task = [populatedProvider fetchWithRequest:persistenceRequest];
    XCTAssertNotNil(task);
    XCTAssertNotNil(task.task.result);
    XCTAssertNil(task.task.error);
}

-(void)testEmptyFetchOfferWithId {
    MNFPersistenceProvider *provider = [MNFPersistenceProvider new];
    NSData *data = [NSJSONSerialization dataWithJSONObject:@{@"offerId":@10} options:0 error:nil];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"www.example.com/Api/Transactions/GetOffer"]];
    urlRequest.HTTPBody = data;
    MNFPersistenceRequest *persistenceRequest = [[MNFPersistenceRequest alloc] initWithRequest:[urlRequest copy]];
    MNFJob *task = [provider fetchWithRequest:persistenceRequest];
    XCTAssertNotNil(task);
    XCTAssertNil(task.task.result);
    XCTAssertNotNil(task.task.error);
}
-(void)testPopulatedFetchOfferWithId {
    NSData *data = [NSJSONSerialization dataWithJSONObject:@{@"offerId":@10} options:0 error:nil];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"www.example.com/Api/Transactions/GetOffer"]];
    urlRequest.HTTPBody = data;
    MNFPersistenceRequest *persistenceRequest = [[MNFPersistenceRequest alloc] initWithRequest:[urlRequest copy]];
    MNFJob *task = [populatedProvider fetchWithRequest:persistenceRequest];
    XCTAssertNotNil(task);
    XCTAssertNotNil(task.task.result);
    XCTAssertNil(task.task.error);
}
-(void)testEmptyFetchOffers {
    MNFPersistenceProvider *provider = [MNFPersistenceProvider new];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"www.example.com/Api/Transactions/GetOffers"]];
    MNFPersistenceRequest *persistenceRequest = [[MNFPersistenceRequest alloc] initWithRequest:[urlRequest copy]];
    MNFJob *task = [provider fetchWithRequest:persistenceRequest];
    XCTAssertNotNil(task);
    XCTAssertNil(task.task.result);
    XCTAssertNotNil(task.task.error);
}
-(void)testPopulatedFetchOffers {
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"www.example.com/Api/Transactions/GetOffers"]];
    MNFPersistenceRequest *persistenceRequest = [[MNFPersistenceRequest alloc] initWithRequest:[urlRequest copy]];
    MNFJob *task = [populatedProvider fetchWithRequest:persistenceRequest];
    XCTAssertNotNil(task);
    XCTAssertNotNil(task.task.result);
    XCTAssertNil(task.task.error);
}

-(void)testEmptyFetchTagWithId {
    MNFPersistenceProvider *provider = [MNFPersistenceProvider new];
    NSData *data = [NSJSONSerialization dataWithJSONObject:@{ @"id" : @10 } options:0 error:nil];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"www.example.com/Api/Transactions/GetTag"]];
    urlRequest.HTTPBody = data;
    MNFPersistenceRequest *persistenceRequest = [[MNFPersistenceRequest alloc] initWithRequest:[urlRequest copy]];
    MNFJob *task = [provider fetchWithRequest:persistenceRequest];
    XCTAssertNotNil(task);
    XCTAssertNil(task.task.result);
    XCTAssertNotNil(task.task.error);
}
-(void)testPopulatedFetchTagWithId {
    NSData *data = [NSJSONSerialization dataWithJSONObject:@{ @"id" : @1 } options:0 error:nil];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"www.example.com/Api/Transactions/GetTag"]];
    urlRequest.HTTPBody = data;
    MNFPersistenceRequest *persistenceRequest = [[MNFPersistenceRequest alloc] initWithRequest:[urlRequest copy]];
    MNFJob *task = [populatedProvider fetchWithRequest:persistenceRequest];
    XCTAssertNotNil(task);
    XCTAssertNotNil(task.task.result);
    XCTAssertNil(task.task.error);
}
-(void)testEmptyFetchTags {
    MNFPersistenceProvider *provider = [MNFPersistenceProvider new];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"www.example.com/Api/Transactions/GetTags"]];
    MNFPersistenceRequest *persistenceRequest = [[MNFPersistenceRequest alloc] initWithRequest:[urlRequest copy]];
    MNFJob *task = [provider fetchWithRequest:persistenceRequest];
    XCTAssertNotNil(task);
    XCTAssertNil(task.task.result);
    XCTAssertNotNil(task.task.error);
}
-(void)testPopulatedFetchTags {
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"www.example.com/Api/Transactions/GetTags"]];
    MNFPersistenceRequest *persistenceRequest = [[MNFPersistenceRequest alloc] initWithRequest:[urlRequest copy]];
    MNFJob *task = [populatedProvider fetchWithRequest:persistenceRequest];
    XCTAssertNotNil(task);
    XCTAssertNotNil(task.task.result);
    XCTAssertNil(task.task.error);
}
-(void)testEmptySaveTag {
    MNFPersistenceProvider *provider = [MNFPersistenceProvider new];
    NSData *data = [NSJSONSerialization dataWithJSONObject:@{@"Name":@"TestName",@"Id":@3} options:0 error:nil];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"www.example.com/Api/Transactions/UpdateTag"]];
    urlRequest.HTTPBody = data;
    MNFPersistenceRequest *persistenceRequest = [[MNFPersistenceRequest alloc] initWithRequest:[urlRequest copy]];
    MNFJob *task = [provider saveWithRequest:persistenceRequest];
    XCTAssertNotNil(task);
    XCTAssertNotNil(task.task.result);
    XCTAssertNil(task.task.error);
}
-(void)testPopulatedSaveTag {
    NSData *data = [NSJSONSerialization dataWithJSONObject:@{@"Name":@"TestName",@"Id":@3} options:0 error:nil];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"www.example.com/Api/Transactions/UpdateTag"]];
    urlRequest.HTTPBody = data;
    MNFPersistenceRequest *persistenceRequest = [[MNFPersistenceRequest alloc] initWithRequest:[urlRequest copy]];
    MNFJob *task = [populatedProvider saveWithRequest:persistenceRequest];
    XCTAssertNotNil(task);
    XCTAssertNotNil(task.task.result);
    XCTAssertNil(task.task.error);
}
-(void)testEmptyDeleteTag {
    MNFPersistenceProvider *provider = [MNFPersistenceProvider new];
    NSData *data = [NSJSONSerialization dataWithJSONObject: @{ @"tagId" : @1 } options:0 error:nil];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"www.example.com/Api/Transactions/DeleteTag"]];
    urlRequest.HTTPBody = data;
    MNFPersistenceRequest *persistenceRequest = [[MNFPersistenceRequest alloc] initWithRequest:[urlRequest copy]];
    MNFJob *task = [provider saveWithRequest:persistenceRequest];
    XCTAssertNotNil(task);
    XCTAssertNil(task.task.result);
    XCTAssertNotNil(task.task.error);
}
-(void)testPopulatedDeleteTag {
    NSData *data = [NSJSONSerialization dataWithJSONObject: @{ @"tagId" : @2 } options:0 error:nil];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"www.example.com/Api/Transactions/DeleteTag"]];
    urlRequest.HTTPBody = data;
    MNFPersistenceRequest *persistenceRequest = [[MNFPersistenceRequest alloc] initWithRequest:[urlRequest copy]];
    MNFJob *task = [populatedProvider saveWithRequest:persistenceRequest];
    XCTAssertNotNil(task);
    XCTAssertNotNil(task.task.result);
    XCTAssertNil(task.task.error);
}

-(void)testEmptyFetchTransactionWithId {
    MNFPersistenceProvider *provider = [MNFPersistenceProvider new];
    NSData *data = [NSJSONSerialization dataWithJSONObject:@{@"id":@12} options:0 error:nil];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"www.example.com/Api/Transactions/GetTransaction"]];
    urlRequest.HTTPBody = data;
    MNFPersistenceRequest *persistenceRequest = [[MNFPersistenceRequest alloc] initWithRequest:[urlRequest copy]];
    MNFJob *task = [provider fetchWithRequest:persistenceRequest];
    XCTAssertNotNil(task);
    XCTAssertNil(task.task.result);
    XCTAssertNotNil(task.task.error);
}
-(void)testPopulatedFetchTransactionWithId {
    NSData *data = [NSJSONSerialization dataWithJSONObject:@{@"id":@12} options:0 error:nil];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"www.example.com/Api/Transactions/GetTransaction"]];
    urlRequest.HTTPBody = data;
    MNFPersistenceRequest *persistenceRequest = [[MNFPersistenceRequest alloc] initWithRequest:[urlRequest copy]];
    MNFJob *task = [populatedProvider fetchWithRequest:persistenceRequest];
    XCTAssertNotNil(task);
    XCTAssertNotNil(task.task.result);
    XCTAssertNil(task.task.error);
}
-(void)testEmptyFetchTransactionsWithFilter {
    MNFPersistenceProvider *provider = [MNFPersistenceProvider new];
    NSDictionary *filter = @{};
    NSData *data = [NSJSONSerialization dataWithJSONObject:@{@"batchNumber":[NSNull null], @"batchSize": [NSNull null], @"filter": filter} options:0 error:nil];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"www.example.com/Api/Transactions/GetTransactions"]];
    urlRequest.HTTPBody = data;
    MNFPersistenceRequest *persistenceRequest = [[MNFPersistenceRequest alloc] initWithRequest:[urlRequest copy]];
    MNFJob *task = [provider fetchWithRequest:persistenceRequest];
    XCTAssertNotNil(task);
    XCTAssertNil(task.task.result);
    XCTAssertNotNil(task.task.error);
}
-(void)testPopulatedFetchTransactionsWithFilter {
    NSDictionary *filter = @{@"AccountIds":@[],
                             @"AccountIdentifiers":@[@"testIdentifier"],
                             @"CategoryIds":@[@1,@2,@3,@42],
                             @"CategoryTypes":@[],
                             @"CounterpartyAccountIdentifiers":@[@1,@2,@3],
                             @"OnlyUnread":@0,
                             @"OnlyFlagged":@0,
                             @"OnlyUncertain":@0,
                             @"OnlyUncategorized":@0,
                             @"UncertainOrFlagged":@0,
                             @"HideExcluded":@0,
                             @"InsertedBefore":@"/Date(1441105123857+0000)/",
                             @"PeriodFrom":@"/Date(1441102123857+0000)/",
                             @"PeriodTo":@"/Date(1441105123857+0000)/",
                             @"OriginalPeriodFrom":@"/Date(1441102123857+0000)/",
                             @"OriginalPeriodTo":@"/Date(1441105123857+0000)/",
                             @"AmountFrom":@2000,
                             @"AmountTo":@3000,
                             @"SearchText":@"ISK",
                             @"Description":@"",
                             @"BankId":@"testBank",
                             @"Currency":@"ISK",
                             @"Comment":@"TestComment",
                             @"Tags":@[@"tags",@"moretags",@"test"],
                             @"OrderBy":@0,
                             @"ParsedDataNameToOrderBy":@"Parse",
                             @"AscendingOrder":@0,
                             @"UseAbsoluteAmountSearch":@0,
                             @"UseAndSearchForTags":@1,
                             @"UseEqualsSearchForBankId":@0,
                             @"UseAmountInCurrencySearch":@0,
                             @"UseExactDescription":@0,
                             @"UseExactMerchantTexts":@0,
                             @"UseAccentInsensitiveSearch":@0,
                             @"MerchantIds":@[@18195],
                             @"ExcludeMerchantIds":@[@18196],
                             @"MerchantTexts":@[],
                             @"ParsedData":@{@"Key":@"TransactionKey",@"Value":@"05|4306983549|3187318"},
                             @"ParsedDataExactKeys":@"Transactionkey",
                             @"UseParentMerchantIds":@0};
    NSData *data = [NSJSONSerialization dataWithJSONObject:@{@"batchNumber":[NSNull null], @"batchSize": [NSNull null], @"filter": filter} options:0 error:nil];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"www.example.com/Api/Transactions/GetTransactions"]];
    urlRequest.HTTPBody = data;
    MNFPersistenceRequest *persistenceRequest = [[MNFPersistenceRequest alloc] initWithRequest:[urlRequest copy]];
    MNFJob *task = [populatedProvider fetchWithRequest:persistenceRequest];
    XCTAssertNotNil(task);
    XCTAssertNotNil(task.task.result);
    XCTAssertNil(task.task.error);
}
-(void)testEmptySaveTransaction {
    MNFPersistenceProvider *provider = [MNFPersistenceProvider new];
    NSData *data = [NSJSONSerialization dataWithJSONObject:@{@"transactionId":@10,@"Amount":@1500} options:0 error:nil];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"www.example.com/Api/Transactions/UpdateTransaction"]];
    urlRequest.HTTPBody = data;
    MNFPersistenceRequest *persistenceRequest = [[MNFPersistenceRequest alloc] initWithRequest:[urlRequest copy]];
    MNFJob *task = [provider saveWithRequest:persistenceRequest];
    XCTAssertNotNil(task);
    XCTAssertNotNil(task.task.result);
    XCTAssertNil(task.task.error);
}
-(void)testPopulatedSaveTransaction {
    NSData *data = [NSJSONSerialization dataWithJSONObject:@{@"transactionId":@10,@"Amount":@1500} options:0 error:nil];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"www.example.com/Api/Transactions/UpdateTransaction"]];
    urlRequest.HTTPBody = data;
    MNFPersistenceRequest *persistenceRequest = [[MNFPersistenceRequest alloc] initWithRequest:[urlRequest copy]];
    MNFJob *task = [populatedProvider saveWithRequest:persistenceRequest];
    XCTAssertNotNil(task);
    XCTAssertNotNil(task.task.result);
    XCTAssertNil(task.task.error);
}
-(void)testEmptyDeleteTransaction {
    MNFPersistenceProvider *provider = [MNFPersistenceProvider new];
    NSData *data = [NSJSONSerialization dataWithJSONObject:@{@"transactionId":@10} options:0 error:nil];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"www.example.com/Api/Transactions/DeleteTransaction"]];
    urlRequest.HTTPBody = data;
    MNFPersistenceRequest *persistenceRequest = [[MNFPersistenceRequest alloc] initWithRequest:[urlRequest copy]];
    MNFJob *task = [provider saveWithRequest:persistenceRequest];
    XCTAssertNotNil(task);
    XCTAssertNil(task.task.result);
    XCTAssertNotNil(task.task.error);
}
-(void)testPopulatedDeleteTransaction {
    NSData *data = [NSJSONSerialization dataWithJSONObject:@{@"transactionId":@12} options:0 error:nil];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"www.example.com/Api/Transactions/DeleteTransaction"]];
    urlRequest.HTTPBody = data;
    MNFPersistenceRequest *persistenceRequest = [[MNFPersistenceRequest alloc] initWithRequest:[urlRequest copy]];
    MNFJob *task = [populatedProvider saveWithRequest:persistenceRequest];
    XCTAssertNotNil(task);
    XCTAssertNotNil(task.task.result);
    XCTAssertNil(task.task.error);
}

-(void)testEmptyFetchProfile {
    MNFPersistenceProvider *provider = [MNFPersistenceProvider new];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"www.example.com/Api/User/GetUserProfile"]];
    MNFPersistenceRequest *persistenceRequest = [[MNFPersistenceRequest alloc] initWithRequest:[urlRequest copy]];
    MNFJob *task = [provider fetchWithRequest:persistenceRequest];
    XCTAssertNotNil(task);
    XCTAssertNil(task.task.result);
    XCTAssertNotNil(task.task.error);
}
-(void)testPopulatedFetchProfile {
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"www.example.com/Api/User/GetUserProfile"]];
    MNFPersistenceRequest *persistenceRequest = [[MNFPersistenceRequest alloc] initWithRequest:[urlRequest copy]];
    MNFJob *task = [populatedProvider fetchWithRequest:persistenceRequest];
    XCTAssertNotNil(task);
    XCTAssertNotNil(task.task.result);
    XCTAssertNil(task.task.error);
}
-(void)testEmptySaveProfile {
    MNFPersistenceProvider *provider = [MNFPersistenceProvider new];
    NSData *data = [NSJSONSerialization dataWithJSONObject:@{@"Name":@"Meniga",@"Age":@"9"} options:0 error:nil];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"www.example.com/Api/User/UpdateUserProfile"]];
    urlRequest.HTTPBody = data;
    MNFPersistenceRequest *persistenceRequest = [[MNFPersistenceRequest alloc] initWithRequest:[urlRequest copy]];
    MNFJob *task = [provider saveWithRequest:persistenceRequest];
    XCTAssertNotNil(task);
    XCTAssertNotNil(task.task.result);
    XCTAssertNil(task.task.error);
}
-(void)testPopulatedSaveProfile {
    NSData *data = [NSJSONSerialization dataWithJSONObject:@{@"Name":@"Meniga",@"Age":@"9"} options:0 error:nil];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"www.example.com/Api/User/UpdateUserProfile"]];
    urlRequest.HTTPBody = data;
    MNFPersistenceRequest *persistenceRequest = [[MNFPersistenceRequest alloc] initWithRequest:[urlRequest copy]];
    MNFJob *task = [populatedProvider saveWithRequest:persistenceRequest];
    XCTAssertNotNil(task);
    XCTAssertNotNil(task.task.result);
    XCTAssertNil(task.task.error);
}

-(void)testEncryptedSaveProfile {
    MNFSettings *settings = [[MNFSettings alloc] initWithApiURL:@"www.example.com"];
    settings.localEncryptionPolicy = YES;
    [Meniga initWithSettings:settings];
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:@[@{@"Name":@"Meniga",@"Age":@"9"},@{@"Name":@"UMW",@"Age":@"1"}] options:0 error:nil];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"www.example.com/Api/User/UpdateUserProfile"]];
    urlRequest.HTTPBody = data;
    MNFPersistenceRequest *persistenceRequest = [[MNFPersistenceRequest alloc] initWithRequest:[urlRequest copy]];
    NSLog(@"Data: %@",persistenceRequest.data);
    MNFJob *task = [populatedProvider saveWithRequest:persistenceRequest];
    XCTAssertNotNil(task);
    XCTAssertNotNil(task.task.result);
    XCTAssertNil(task.task.error);
}
*/
@end
