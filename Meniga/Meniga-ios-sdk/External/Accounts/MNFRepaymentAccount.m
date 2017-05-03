//
//  MNFRepaymentAccount.m
//  Meniga-ios-sdk
//
//  Created by Aske Bendtsen on 01/12/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFRepaymentAccount.h"
#import "MNFInternalImports.h"

@implementation MNFRepaymentAccount

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isNew = YES;
    }
    return self;
}

//+(void)fetchRepaymentAccountWithCompletion:(MNFFetchRepaymentAccountCompletionHandler)completion{
//
//    [self fetchWithApiPath:kMNFGetRepaymentAccounts jsonData:nil completion:^(id  _Nullable result, NSError * _Nullable error) {
//        NSLog(@"Repayment account data: %@", result);
//        MNFRepaymentAccount *repaymentAccount = [MNFJsonAdapter objectOfClass:[self class] jsonDict:[result firstObject] option:kMNFAdapterOptionFirstLetterUppercase error:nil];
//        repaymentAccount.isNew = NO;
//        [self executeOnMainThreadWithCompletion:completion withParameters:repaymentAccount and:error];
//    }];
//}
//
//
//+(MNFJob*)fetchRepaymentAccount{
//    MNFJob *job = [self fetchWithApiPath:kMNFGetRepaymentAccounts jsonData:nil];
//    
//    job.task = [job.task continueWithBlock:^id(MNF_BFTask *task) {
//        MNF_BFTaskCompletionSource *compSource = [MNF_BFTaskCompletionSource taskCompletionSource];
//        if (task.error == nil) {
//            MNFRepaymentAccount *repAccount = [self initWithServerResult:[task.result firstObject]];
//            repAccount.isNew = NO;
//            
//            [compSource setResult:repAccount];
//        }
//        else{
//            [compSource setError:task.error];
//        }
//        
//        return compSource.task;
//    }];
//    
//    return job;
//}
//
//-(void)saveWithCompletion:(MNFSaveCompletionHandler)completion{
//    [completion copy];
//    if (self.isNew) {
//        [self p_createRepaymentAccountWithCompletion:completion];
//    }
//    else{
//        NSDictionary *jsonDict = @{@"request":[MNFJsonAdapter JSONDictFromObject:self option:kMNFAdapterOptionFirstLetterLowercase error:nil]};
//        NSData *jsonData = [MNFJsonAdapter JSONDataFromDictionary:jsonDict];
//        [self saveWithApiPath:kMNFUpdateRepaymentAccount parameters:nil jsonData:jsonData completion:^(id  _Nullable result, NSError * _Nullable error) {
//            [[self class] executeOnMainThreadWithCompletion:completion withParameters:result and:error];
//        }];
//    }
//}
//
//-(MNFJob*)save{
//    
//    NSDictionary *jsonDict = @{@"request":[MNFJsonAdapter JSONDictFromObject:self option:kMNFAdapterOptionFirstLetterLowercase error:nil]};
//    NSData *jsonData = [MNFJsonAdapter JSONDataFromDictionary:jsonDict];
//    
//    if (self.isNew) {
//        return [self p_createRepaymentAccount];
//    }
//    else{
//        return [self saveWithApiPath:kMNFUpdateRepaymentAccount parameters:nil jsonData:jsonData];
//    }
//}
//
//
//-(void)refreshWithCompletion:(MNFErrorOnlyCompletionHandler)completion{
//    [[self class] fetchWithApiPath:kMNFGetRepaymentAccounts jsonData:nil completion:^(id  _Nullable result, NSError * _Nullable error) {
//        NSLog(@"Repayment account update data: %@", result);
//        [MNFJsonAdapter refreshObject:self withJsonDict:[result firstObject] option:kMNFAdapterOptionFirstLetterUppercase error:nil];
//        [[self class] executeOnMainThreadWithCompletion:completion withParameter:error];
//    }];
//}
//
//-(MNFJob*)refresh{
//    MNFJob *job = [[self class] fetchWithApiPath:kMNFGetRepaymentAccounts jsonData:nil];
//    
//    job.task = [job.task continueWithBlock:^id(MNF_BFTask *task) {
//        MNF_BFTaskCompletionSource *compSource = [MNF_BFTaskCompletionSource taskCompletionSource];
//        if (task.error == nil) {
//            [MNFJsonAdapter refreshObject:self withJsonDict:[task.result firstObject] option:kMNFAdapterOptionFirstLetterUppercase error:nil];
//            [compSource setResult:@YES];
//        }
//        else{
//            [compSource setError:task.error];
//        }
//        
//        return compSource.task;
//    }];
//    
//    return job;
//}
//
//
//-(void)deleteWithCompletion:(MNFErrorOnlyCompletionHandler)completion{
//    NSData *jsonData = [MNFJsonAdapter JSONDataFromDictionary:@{@"request":@{@"AccountId":self.identifier}}];
//    [[self class] serviceCallWithApiPath:kMNFDeleteRepaymentAccount parameters:nil jsonData:jsonData completion:^(id  _Nullable result, NSError * _Nullable error) {
//        [[self class] executeOnMainThreadWithCompletion:completion withParameter:error];
//    }];
//}
//
//-(MNFJob*)delete{
//    NSData *jsonData = [MNFJsonAdapter JSONDataFromDictionary:@{@"request":@{@"AccountId":self.identifier}}];
//    return [[[self class] serviceCallWithApiPath:kMNFDeleteRepaymentAccount parameters:nil jsonData:jsonData] jobWithBooleanTaskResult];
//}
//
//#pragma mark - private
//
//-(MNFJob*)p_createRepaymentAccount{
//    NSDictionary *jsonDict = @{@"request":[MNFJsonAdapter JSONDictFromObject:self option:kMNFAdapterOptionFirstLetterLowercase error:nil]};
//    NSData *jsonData = [MNFJsonAdapter JSONDataFromDictionary:jsonDict];
//    return [[self saveWithApiPath:kMNFCreateRepaymentAccount parameters:nil jsonData:jsonData] jobWithBooleanTaskResult];
//}
//
//-(void)p_createRepaymentAccountWithCompletion:(MNFSaveCompletionHandler)completion{
//
//    NSDictionary *jsonDict = @{@"request":[MNFJsonAdapter JSONDictFromObject:self option:kMNFAdapterOptionFirstLetterLowercase error:nil]};
//    NSData *jsonData = [MNFJsonAdapter JSONDataFromDictionary:jsonDict];
//    [self saveWithApiPath:kMNFCreateRepaymentAccount parameters:nil jsonData:jsonData completion:^(id  _Nullable result, NSError * _Nullable error) {
//        [[self class] executeOnMainThreadWithCompletion:completion withParameters:result and:error];
//    }];
//}

#pragma mark - json adaptor delegate

-(NSDictionary*)jsonKeysMapToProperties{
    return @{@"identifier":@"Id",
             @"name":@"DisplayName",
             @"accountInfo":@"AccountInfoJson"};
}
-(NSDictionary*)propertyKeysMapToJson {
    return @{@"identifier":@"RepaymentAccountId",
             @"name":@"DisplayName",
             @"accountInfo":@"AccountInfo"};
}

-(NSDictionary*)propertyValueTransformers {
    return @{@"accountInfo":[MNFJSONStringToDictionaryValueTransformer transformer]};
}

@end