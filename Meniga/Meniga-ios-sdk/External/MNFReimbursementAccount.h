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
@property (nonatomic, strong, nullable, readonly) NSString *name;

@end

@interface MNFReimbursementAccount : MNFObject

@property (nonatomic,strong,readonly) NSNumber *isActive;
@property (nonatomic,strong,readonly) NSNumber *isVerified;
@property (nonatomic, strong, nullable, readonly) NSString *name;
@property (nonatomic, strong, nullable, readonly) NSString *accountType;
@property (nonatomic, strong, nullable, readonly) NSString *accountInfo;

+(MNFJob*)fetchReimbursementAccountsIncludesInactive:(NSNumber *)includesInactive completion:(nullable MNFMultipleReimbursementAccountsCompletionHandler)completion;

+(MNFJob *)fetchReimbursementAccountWithId:(NSNumber *)identifier completion:(MNFRemibursementAccountCompletionHandler)completion;


+(MNFJob*)createReimbursementAccountWithName:(NSString *)theAccountName accountType:(NSString *)theAccountType accountInfo:(NSString *)theAccountInfo withCompletion:(nullable MNFRemibursementAccountCompletionHandler)completion;

+(MNFJob*)fetchReimbursementAccountTypesWithCompletion:(nullable MNFMultipleReimbursementAccountTypesCompletionHandler)completion;

@end

NS_ASSUME_NONNULL_END
