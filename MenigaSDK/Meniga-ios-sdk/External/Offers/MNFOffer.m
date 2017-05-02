//
//  MNFOffer.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 23/10/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFOffer.h"
#import "MNFInternalImports.h"

@implementation MNFOffer

//#pragma mark - Class Methods
//+(void)fetchWithId:(NSNumber *)identifier completion:(MNFFetchOfferCompletionHandler)completion {
//    [completion copy];
//    NSData *data = [NSJSONSerialization dataWithJSONObject:@{@"offerId":identifier} options:0 error:nil];
//    
//    [self fetchWithApiPath:kMNFGetOffer parameters:nil jsonData:data completion:^(id  _Nullable result, NSError * _Nullable error) {
//        
//        MNFOffer *offer = [MNFJsonAdapter objectOfClass:[MNFOffer class] jsonDict:result option:kMNFAdapterOptionFirstLetterUppercase error:nil];
//
//        [self executeOnMainThreadWithCompletion:completion withParameters:offer and:error];
//    }];
//}
//+(MNFJob*)fetchWithId:(NSNumber *)identifier {
//    NSData *data = [NSJSONSerialization dataWithJSONObject:@{@"offerId":identifier} options:0 error:nil];
//    return [[self fetchWithApiPath:kMNFGetOffer parameters:nil jsonData:data] jobWithParsedTaskDataToObjectOfClass:[self class]];
//}
//+(void)fetchOffersWithCompletion:(MNFCompletionHandler)completion {
//    [completion copy];
//    [self fetchWithApiPath:kMNFGetOffers parameters:nil jsonData:nil completion:^(id  _Nullable result, NSError * _Nullable error) {
//        NSArray *offers = [self initWithServerResults:result];
//        [self executeOnMainThreadWithCompletion:completion withParameters:offers and:error];
//    }];
//}
//+(MNFJob*)fetchOffers {
//    MNFJob *job = [self fetchWithApiPath:kMNFGetOffers parameters:nil jsonData:nil];
//    job.task = [job.task continueWithBlock:^id(MNF_BFTask *task) {
//        MNF_BFTaskCompletionSource *cs = [MNF_BFTaskCompletionSource taskCompletionSource];
//        if (task.error == nil) {
//            NSArray *array = [self initWithServerResults:task.result];
//            [cs setResult:array];
//        }
//        else {
//            [cs setError:task.error];
//        }
//        return cs.task;
//    }];
//    
//    return job;
//}
//+(void)createRepaymentAccountWithDisplayName:(NSString *)displayName repaymentType:(NSString *)repaymentType accountInfo:(NSString *)accountInfo completion:(MNFCompletionHandler)completion {
//    [completion copy];
//    NSData *data = [NSJSONSerialization dataWithJSONObject:@{@"DisplayName":displayName,@"RepaymentType":repaymentType,@"AccountInfo":accountInfo} options:0 error:nil];
//    [self serviceCallWithApiPath:kMNFCreateRepaymentAccount parameters:nil jsonData:data completion:^(id  _Nullable result, NSError * _Nullable error) {
//        [self executeOnMainThreadWithCompletion:completion withParameters:result and:error];
//    }];
//}
//+(MNFJob*)createRepaymentAccountWithDisplayName:(NSString *)displayName repaymentType:(NSString *)repaymentType accountInfo:(NSString *)accountInfo {
//    NSData *data = [NSJSONSerialization dataWithJSONObject:@{@"DisplayName":displayName,@"RepaymentType":repaymentType,@"AccountInfo":accountInfo} options:0 error:nil];
//    return [self serviceCallWithApiPath:kMNFCreateRepaymentAccount parameters:nil jsonData:data];
//}
//+(void)deleteRepaymentAccountWithId:(NSString *)accountId completion:(MNFCompletionHandler)completion {
//    [completion copy];
//    NSData *data = [NSJSONSerialization dataWithJSONObject:@{@"request":@{@"AccountId":accountId}} options:0 error:nil];
//    [self serviceCallWithApiPath:kMNFDeleteRepaymentAccount parameters:nil jsonData:data completion:^(id  _Nullable result, NSError * _Nullable error) {
//        [self executeOnMainThreadWithCompletion:completion withParameters:result and:error];
//    }];
//}
//+(MNFJob*)deleteRepaymentAccountWithId:(NSString *)accountId {
//    NSData *data = [NSJSONSerialization dataWithJSONObject:@{@"request":@{@"AccountId":accountId}} options:0 error:nil];
//    return [self serviceCallWithApiPath:kMNFDeleteRepaymentAccount parameters:nil jsonData:data];
//}
//+(void)updateRepaymentAccountWithId:(NSString *)accountId displayName:(NSString *)displayName accountInfo:(NSString *)accountInfo completion:(MNFCompletionHandler)completion {
//    [completion copy];
//    NSData *data = [NSJSONSerialization dataWithJSONObject:@{@"request":@{@"RepaymentAccountId":accountId,@"DisplayName":displayName,@"AccountInfo":accountInfo}} options:0 error:nil];
//    [self serviceCallWithApiPath:kMNFUpdateRepaymentAccount parameters:nil jsonData:data completion:^(id  _Nullable result, NSError * _Nullable error) {
//        [self executeOnMainThreadWithCompletion:completion withParameters:result and:error];
//    }];
//}
//+(MNFJob*)updateRepaymentAccountWithId:(NSString *)accountId displayName:(NSString *)displayName accountInfo:(NSString *)accountInfo {
//    NSData *data = [NSJSONSerialization dataWithJSONObject:@{@"request":@{@"RepaymentAccountId":accountId,@"DisplayName":displayName,@"AccountInfo":accountInfo}} options:0 error:nil];
//    return [self serviceCallWithApiPath:kMNFUpdateRepaymentAccount parameters:nil jsonData:data];
//}
//+(void)getTermsAndConditionsWithCompletion:(MNFCompletionHandler)completion {
//    [completion copy];
//    [self serviceCallWithApiPath:kMNFGetCashbackTermsAndConditions parameters:nil jsonData:nil completion:^(id  _Nullable result, NSError * _Nullable error) {
//        [self executeOnMainThreadWithCompletion:completion withParameters:result and:error];
//    }];
//}
//+(MNFJob*)getTermsAndConditions {
//    return [self serviceCallWithApiPath:kMNFGetCashbackTermsAndConditions parameters:nil jsonData:nil];
//}
//+(void)acceptTermsAndConditionsWithCompletion:(MNFCompletionHandler)completion {
//    [completion copy];
//    [self serviceCallWithApiPath:kMNFAcceptCashbackTermsAndConditions parameters:nil jsonData:nil completion:^(id  _Nullable result, NSError * _Nullable error) {
//        [self executeOnMainThreadWithCompletion:completion withParameters:result and:error];
//    }];
//}
//+(MNFJob*)acceptTermsAndConditions {
//    return [self serviceCallWithApiPath:kMNFAcceptCashbackTermsAndConditions parameters:nil jsonData:nil];
//}
//
//#pragma mark - Instance methods
//-(void)acceptOfferWithCompletion:(MNFCompletionHandler)completion {
//    [completion copy];
//    NSData *data = [NSJSONSerialization dataWithJSONObject:@{@"OfferId":_offerId,@"ValidationToken":_validationToken} options:0 error:nil];
//    [[self class] fetchWithApiPath:kMNFAcceptOffer parameters:nil jsonData:data completion:^(id  _Nullable result, NSError * _Nullable error) {
//        [[self class] executeOnMainThreadWithCompletion:completion withParameters:result and:error];
//    }];
//}
//-(MNFJob*)acceptOffer {
//    NSData *data = [NSJSONSerialization dataWithJSONObject:@{@"OfferId":_offerId,@"ValidationToken":_validationToken} options:0 error:nil];
//    return [[self class] fetchWithApiPath:kMNFAcceptOffer parameters:nil jsonData:data];
//}
//-(void)declineOfferWithCompletion:(MNFCompletionHandler)completion {
//    [completion copy];
//    NSData *data = [NSJSONSerialization dataWithJSONObject:@{@"OfferId":_offerId,@"MerchantId":_merchantId} options:0 error:nil];
//    [[self class] fetchWithApiPath:kMNFDeclineOffer parameters:nil jsonData:data completion:^(id  _Nullable result, NSError * _Nullable error) {
//        [[self class] executeOnMainThreadWithCompletion:completion withParameters:result and:error];
//    }];
//}
//-(MNFJob*)declineOffer {
//    NSData *data = [NSJSONSerialization dataWithJSONObject:@{@"OfferId":_offerId,@"MerchantId":_merchantId} options:0 error:nil];
//    return [[self class] fetchWithApiPath:kMNFDeclineOffer parameters:nil jsonData:data];
//}
//
//#pragma mark - refreshing
//
//-(void)refreshWithCompletion:(MNFErrorOnlyCompletionHandler)completion{
//    [completion copy];
//    NSData *data = [NSJSONSerialization dataWithJSONObject:@{@"offerId":self.offerId} options:0 error:nil];
//    
//    [[self class] fetchWithApiPath:kMNFGetOffer parameters:nil jsonData:data completion:^(id  _Nonnull result, NSError * _Nonnull error) {
//        MNFLogDebug(@"[%@ %@] with result: %@", [self class], NSStringFromSelector(_cmd), result);
//        [MNFJsonAdapter refreshObject:self withJsonDict:result option:kMNFAdapterOptionFirstLetterUppercase error:nil];
//        [[self class] executeOnMainThreadWithCompletion:completion withParameter:error];
//    }];
//}
//-(MNFJob *)refresh{
//    NSData *data = [NSJSONSerialization dataWithJSONObject:@{@"offerId":self.offerId} options:0 error:nil];
//    MNFJob *job = [[self class] fetchWithApiPath:kMNFGetOffer parameters:nil jsonData:data];
//    
//    job.task = [job.task continueWithBlock:^id(MNF_BFTask *task) {
//        MNF_BFTaskCompletionSource *completion = [MNF_BFTaskCompletionSource taskCompletionSource];
//        if (task.error == nil) {
//            [MNFJsonAdapter refreshObject:self withJsonDict:task.result option:kMNFAdapterOptionFirstLetterUppercase error:nil];
//            [completion setResult:@YES];
//        }
//        else{
//            [completion setError:task.error];
//        }
//        return completion.task;
//    }];
//    
//    return job;
//}

#pragma mark - Delegate methods
-(NSDictionary*)jsonKeysMapToProperties {
    return @{@"offerId":@"Id",
             @"offerDescription":@"Description"};
}
-(NSDictionary*)propertyKeysMapToJson {
    return @{@"offerId":@"Id",
             @"offerDescription":@"Description"};
}
-(NSDictionary*)propertyValueTransformers {
    return @{@"validFrom":[MNFBasicDateValueTransformer transformer],
             @"lastPaymentDate":[MNFBasicDateValueTransformer transformer],
             @"nextPaymentDate":[MNFBasicDateValueTransformer transformer],
             @"validTo":[MNFBasicDateValueTransformer transformer],
             @"acceptanceDate":[MNFBasicDateValueTransformer transformer],
             @"availableFrom":[MNFBasicDateValueTransformer transformer],
             @"declineDate":[MNFBasicDateValueTransformer transformer]};
}

@end
