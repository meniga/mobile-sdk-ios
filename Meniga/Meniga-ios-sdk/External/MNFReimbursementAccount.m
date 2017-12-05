//
//  MNFReimbursementAccount.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 5/17/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFReimbursementAccount.h"
#import "MNFInternalImports.h"

@interface MNFReimbursementAccountType () <MNFJsonAdapterDelegate>

@end

@implementation MNFReimbursementAccountType

-(NSDictionary *)jsonKeysMapToProperties {
    return @{ @"identifier" : @"id" };
}

-(NSDictionary *)propertyKeysMapToJson {
    return @{ @"identifier" : @"id" };
}

@end


@interface MNFReimbursementAccount () <MNFJsonAdapterDelegate>

@end

@implementation MNFReimbursementAccount

+(MNFJob*)fetchReimbursementAccountsIncludesInactive:(NSNumber *)includesInactive completion:(nullable MNFMultipleReimbursementAccountsCompletionHandler)completion; {
    
    NSString *path = [NSString stringWithFormat:@"%@", kMNFApiPathReimbursementAccounts];
    
    NSMutableDictionary *query = [NSMutableDictionary dictionary];
    query[@"includeInactive"] = [[MNFNumberToBoolValueTransformer transformer] reverseTransformedValue:includesInactive];
    
    __block MNFJob *job = [MNFObject apiRequestWithPath:path pathQuery: query jsonBody: nil HTTPMethod: kMNFHTTPMethodGET service: MNFServiceNameOffers completion:^(MNFResponse *response) {
        
        if (response.error == nil) {
            if ([response.result isKindOfClass:[NSArray class]] == YES) {
                NSArray <MNFReimbursementAccount *> *reimbursementAccounts = [MNFReimbursementAccount initWithServerResults:response.result];
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:reimbursementAccounts error:nil];
            }
            else {
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error:[MNFErrorUtils errorForUnexpectedDataOfType:[response.result class] expected:[NSArray class]]];
            }
        }
        else {
            [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error:response.error];
        }
        
    }];
    
    return job;
}

+(MNFJob *)fetchReimbursementAccountWithId:(NSNumber *)identifier completion:(MNFRemibursementAccountCompletionHandler)completion {
    
    NSString *path = [NSString stringWithFormat:@"%@/%@", kMNFApiPathReimbursementAccounts, identifier];
    
    __block MNFJob *job = [MNFObject apiRequestWithPath:path pathQuery:nil jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameOffers completion:^(MNFResponse *response) {
       
        if (response.error == nil) {
            
            if ([response.result isKindOfClass:[NSDictionary class]] == YES) {
                
                MNFReimbursementAccount *account = [MNFReimbursementAccount initWithServerResult: response.result];
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:account error:nil];
                
            }
            else {
                
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error: [MNFErrorUtils errorForUnexpectedDataOfType:[response.result class] expected:[NSDictionary class]] ];
            }
            
        }
        else {
            [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error:response.error];
        }
        
    }];
    
    return job;
}

+(MNFJob *)createReimbursementAccountWithName:(NSString *)theAccountName accountType:(NSString *)theAccountType accountInfo:(NSString *)theAccountInfo withCompletion:(nullable MNFRemibursementAccountCompletionHandler)completion {

    
    NSString *path = [NSString stringWithFormat:@"%@", kMNFApiPathReimbursementAccounts];
    
    NSMutableDictionary *jsonBody = [NSMutableDictionary dictionary];
    
    jsonBody[@"name"] = theAccountName;
    jsonBody[@"accountType"] = theAccountType;
    jsonBody[@"accountInfo"] = theAccountInfo;
    
    __block MNFJob *job = [MNFObject apiRequestWithPath:path pathQuery:nil jsonBody: [NSJSONSerialization dataWithJSONObject:jsonBody options: 0 error: nil] HTTPMethod:kMNFHTTPMethodPOST service:MNFServiceNameOffers completion:^(MNFResponse *response) {
        
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

+(MNFJob *)fetchReimbursementAccountTypesWithCompletion:(MNFMultipleReimbursementAccountTypesCompletionHandler)completion {
    
    NSString *path = [NSString stringWithFormat:@"%@/types", kMNFApiPathReimbursementAccounts];
    
    __block MNFJob *job = [MNFObject apiRequestWithPath:path pathQuery:nil jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameOffers completion:^(MNFResponse *response) {
        
        if (response.error == nil) {
            
            if ([response.result isKindOfClass:[NSArray class]] == YES) {
                
                NSArray <MNFReimbursementAccountType *> *accountTypes = [MNFReimbursementAccountType initWithServerResults: response.result];
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:accountTypes error:nil];
                
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

#pragma mark - Json Adapter

-(NSDictionary *)jsonKeysMapToProperties {
    return @{ @"identifier" : @"id" };
}

-(NSDictionary *)propertyKeysMapToJson {
    return @{ @"identifier" : @"id" };
}

@end
