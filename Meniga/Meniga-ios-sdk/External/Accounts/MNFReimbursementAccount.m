//
//  MNFReimbursementAccount.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 5/17/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFReimbursementAccount.h"
#import "MNFInternalImports.h"



@implementation MNFReimbursementAccountType

-(NSDictionary *)jsonKeysMapToProperties {
    return @{ @"identifier" : @"id" };
}

-(NSDictionary *)propertyKeysMapToJson {
    return @{ @"identifier" : @"id" };
}

@end



@implementation MNFReimbursementAccount

+(void)fetchReimbursementAccountsWithCompletion:(MNFMultipleReimbursementAccountsCompletionHandler)completion {
    [self p_fetchReimubrsementAccountsWithCompletion:completion];
}

+(MNFJob *)fetchReimbursementAccounts {
    return [self p_fetchReimubrsementAccountsWithCompletion:nil];
}

+(MNFJob *)p_fetchReimubrsementAccountsWithCompletion:(nullable MNFMultipleReimbursementAccountsCompletionHandler)completion {
    
    NSString *path = [NSString stringWithFormat:@"%@", kMNFApiPathReimbursementAccounts];
    
    __block MNFJob *job = [MNFObject apiRequestWithPath:path pathQuery:nil jsonBody:nil HTTPMethod:kMNFHTTPMethodGET completion:^(MNFResponse *response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
            if ([response.result isKindOfClass:[NSArray class]] == YES) {
                
                NSArray <MNFReimbursementAccount *> *reimbursementAccounts = [MNFReimbursementAccount initWithServerResults:response.result];
                
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:reimbursementAccounts error:nil];
            
            }
            else {
                
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error: [MNFErrorUtils errorForUnexpectedDataOfType:[response.result class] expected:[NSArray class]] ];
                
            }
        }
        else {
            
            [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error:response.error];
            
        }
        
    }];
    
    return job;
}

+(void)createReimbursementAccountWithName:(NSString *)theAccountName accountType:(NSString *)theAccountType accountInfo:(NSString *)theAccountInfo withCompletion:(MNFRemibursementAccountCompletionHandler)completion {
    [self p_createReimbursementAccountWithName:theAccountName accountType:theAccountType accountInfo:theAccountInfo withCompletion:completion];
}

+(MNFJob *)createReimbursementAccountWithName:(NSString *)theAccountName accountType:(NSString *)theAccountType accountInfo:(NSString *)theAccountInfo {
    return [self p_createReimbursementAccountWithName:theAccountName accountType:theAccountType accountInfo:theAccountInfo withCompletion:nil];
}

+(MNFJob *)p_createReimbursementAccountWithName:(NSString *)theAccountName accountType:(NSString *)theAccountType accountInfo:(NSString *)theAccountInfo withCompletion:(nullable MNFRemibursementAccountCompletionHandler)completion {
    
    NSString *path = [NSString stringWithFormat:@"%@", kMNFApiPathReimbursementAccounts];
    
    __block MNFJob *job = [MNFObject apiRequestWithPath:path pathQuery:nil jsonBody:nil HTTPMethod:kMNFHTTPMethodPOST completion:^(MNFResponse *response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
            
            if ([response.result isKindOfClass:[NSDictionary class]] == YES) {
                
                MNFReimbursementAccount *account = [MNFReimbursementAccount initWithServerResult:response.result];
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:account error:nil];
            
            }
            else {
            
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error:[MNFErrorUtils errorForUnexpectedDataOfType:[response.result class] expected:[NSDictionary class]]];
            
            }
            
        }
        else {
            
            [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error:response.error];
        
        }
        
    }];
    
    return job;
}

+(void)fetchReimbursementAccountTypesWithCompletion:(MNFMultipleReimbursementAccountTypesCompletionHandler)completion {
    [self p_fetchReimbursementAccountTypesWithCompletion:completion];
}

+(MNFJob *)fetchReimbursementAccountTypes {
    return [self p_fetchReimbursementAccountTypesWithCompletion:nil];
}

+(MNFJob *)p_fetchReimbursementAccountTypesWithCompletion:(MNFMultipleReimbursementAccountTypesCompletionHandler)completion {
    
    NSString *path = [NSString stringWithFormat:@"%@/types", kMNFApiPathReimbursementAccounts];
    
    __block MNFJob *job = [MNFObject apiRequestWithPath:path pathQuery:nil jsonBody:nil HTTPMethod:kMNFHTTPMethodGET completion:^(MNFResponse *response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
            
            if ([response.result isKindOfClass:[NSArray class]]) {
                
                NSArray *reimbursementAccountTypes = [MNFReimbursementAccountType initWithServerResults: response.result];
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:reimbursementAccountTypes error:nil];
                
            }
            else {
                
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error: [MNFErrorUtils errorForUnexpectedDataOfType:[response.result class] expected:[NSArray class]] ];
                
            }
            
        }
        else {
            
            [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error: response.error];
            
        }
        
    }];
    
    return job;
    
}

#pragma mark - Json Adapter

-(NSDictionary *)jsonKeysMapToProperties {
    return @{ @"identifier" : @"id" };
}

-(NSDictionary *)propertyKeysMapToJson {
    return @{ @"identifier" : @"id" };
}

@end
