//
//  MNFReimbursementAccount.h
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 5/17/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface MNFReimbursementAccountType: MNFObject

/**
 @abstract The name of the account type.
 */
@property (nonatomic, strong, nullable) NSString *name;

@end

@interface MNFReimbursementAccount : MNFObject

@property (nonatomic, strong, nullable) NSString *name;
@property (nonatomic, strong, nullable) NSString *accountType;
@property (nonatomic, strong, nullable) NSString *accountInfo;

+(void)fetchReimbursementAccountsWithCompletion:(MNFMultipleReimbursementAccountsCompletionHandler)completion;
+(MNFJob *)fetchReimbursementAccounts;

+(void)createReimbursementAccountWithName:(NSString *)theAccountName accountType:(NSString *)theAccountType accountInfo:(NSString *)theAccountInfo withCompletion:(MNFRemibursementAccountCompletionHandler)completion;
+(MNFJob *)createReimbursementAccountWithName:(NSString *)theAccountNAme accountType:(NSString *)theAccountType accountInfo:(NSString *)theAccountInfo;

+(void)fetchReimbursementAccountTypesWithCompletion:(MNFMultipleReimbursementAccountTypesCompletionHandler)completion;
+(MNFJob *)fetchReimbursementAccountTypes;

@end

NS_ASSUME_NONNULL_END