//
//  MNFRepaymentAccount.h
//  Meniga-ios-sdk
//
//  Created by Aske Bendtsen on 01/12/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFObject.h"

/**
 The MNFRepaymentAccount class encapsulates repayment account data in an object.
 
 A repayment account should not be directly initialized but instead should be constructed with data from the server.
 The response from the server will be automatically converted to an MNFRepaymentAccount object.
 
 A repayment account has two mutable properties, a name and account info.
 */
@interface MNFRepaymentAccount : MNFObject

/**
 @abstract The name of the account.
 */
@property(nonatomic, copy, readwrite)NSString *name;

/**
 @abstract The account info.
 
 @discussion The account info contains any info relevant to the account such as account no., social security no etc.
 */
@property(nonatomic, copy, readwrite)NSDictionary *accountInfo;

/**
 @description Fetches the repayment account from the server.
 
 @return The completion block returns an MNFRepaymentAccount and an error.
 */
+(void)fetchRepaymentAccountWithCompletion:(MNFFetchRepaymentAccountCompletionHandler)completion;

/**
 @description Fetches the repayment account from the server.
 
 @return MNFJob A job containing an MNFRepaymentAccount and an error.
 */
+(MNFJob*)fetchRepaymentAccount;

/**
 @description Saves changes to the repayment account to the server.
 
 @return The completion block returns a result and an error.
 */
-(void)saveWithCompletion:(MNFSaveCompletionHandler)block;

/**
 @description Saves changes to the repayment account to the server.
 
 @return MNFJob A job containing a result and an error.
 */
-(MNFJob*)save;

/**
 @description Refreshes the repayment account with data from the server.
 
 @return The completion block returns an error.
 */
-(void)refreshWithCompletion:(MNFErrorOnlyCompletionHandler)completion;

/**
 @description Refreshes the repayment account with data from the server.
 
 @return MNFJob A job containing an error.
 */
-(MNFJob*)refresh;

-(void)deleteWithCompletion:(MNFErrorOnlyCompletionHandler)completion;
-(MNFJob*)delete;

@end
