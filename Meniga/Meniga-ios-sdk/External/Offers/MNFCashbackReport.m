//
//  MNFCashbackReport.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 25/11/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFCashbackReport.h"
#import "MNFInternalImports.h"

@implementation MNFCashbackReport

//+(void)fetchReportWithCompletion:(MNFFetchCashbackReportCompletionHandler)completion {
//    [completion copy];
//    [self fetchWithApiPath:kMNFGetCashBackReport jsonData:nil completion:^(id  _Nullable result, NSError * _Nullable error) {
//        MNFLogDebug(@"[%@ %@] with result: %@", [self class], NSStringFromSelector(_cmd), result);
//        MNFCashbackReport *cashbackReport = [MNFCashbackReport initWithServerResult:result];
//        [self executeOnMainThreadWithCompletion:completion withParameters:cashbackReport and:error];
//        
//    }];
//}
//+(MNFJob*)fetchReport {
//    return [[self fetchWithApiPath:kMNFGetCashBackReport jsonData:nil] jobWithParsedTaskDataToObjectOfClass:[self class]];
//}
//
//-(void)refreshWithCompletion:(MNFErrorOnlyCompletionHandler)completion{
//    [completion copy];
//    
//    [[self class] fetchWithApiPath:kMNFGetCashBackReport parameters:nil jsonData:nil completion:^(id  _Nonnull result, NSError * _Nonnull error) {
//        MNFLogDebug(@"[%@ %@] with result: %@", [self class], NSStringFromSelector(_cmd), result);
//        [MNFJsonAdapter refreshObject:self withJsonDict:result option:kMNFAdapterOptionFirstLetterUppercase error:nil];
//        [[self class] executeOnMainThreadWithCompletion:completion withParameter:error];
//    }];
//}
//
//-(MNFJob *)refresh{
//    
//    MNFJob *job = [[self class] fetchWithApiPath:kMNFGetCashBackReport parameters:nil jsonData:nil];
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

@end
