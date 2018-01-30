//
//  MNFAuthentication.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 08/05/2017.
//  Copyright © 2017 Meniga. All rights reserved.
//

#import "MNFAuthentication.h"
#import "MNFInternalImports.h"

@implementation MNFAuthentication

+ (MNFJob *)authenticateWithEmail:(NSString *)email password:(NSString *)password completion:(MNFAuthenticationCompletionHandler)completion {
    
    return [self authenticateWithEmail:email password:password clientId:nil clientSecret:nil completion:completion];
}

+ (MNFJob*)authenticateWithEmail:(NSString *)email password:(NSString *)password clientId:(NSString *)clientId clientSecret:(NSString *)clientSecret completion:(MNFAuthenticationCompletionHandler)completion {
    
    [completion copy];
    
    NSMutableDictionary *jsonDictionary = [NSMutableDictionary dictionary];
    jsonDictionary[@"email"] = email;
    jsonDictionary[@"password"] = password;
    jsonDictionary[@"clientId"] = clientId;
    jsonDictionary[@"clientSecret"] = clientSecret;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[jsonDictionary copy] options:0 error:nil];
    
    __block MNFJob *job = [self apiRequestWithPath:kMNFApiPathAuthentication pathQuery:nil jsonBody:jsonData HTTPMethod:kMNFHTTPMethodPOST service:MNFServiceNameAuthentication completion:^(MNFResponse*  _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
            if ([response.result isKindOfClass:[NSDictionary class]]) {
                
                MNFAuthentication *authentication = [MNFAuthentication initWithServerResult:response.result];
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:authentication error:nil];
                
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

+ (MNFJob*)authenticateAfterWithUserIdentifier:(NSString *)userIdentifier realmIdentifier:(NSString *)realmIdentifier parameters:(NSDictionary *)parameters completion:(MNFErrorOnlyCompletionHandler)completion {
    [completion copy];
    
    NSMutableDictionary *jsonDictionary = [NSMutableDictionary dictionary];
    jsonDictionary[@"userIdentifier"] = userIdentifier;
    jsonDictionary[@"realmIdentifier"] = realmIdentifier;
    jsonDictionary[@"parameters"] = parameters;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[jsonDictionary copy] options:0 error:nil];
    
    __block MNFJob *job = [self apiRequestWithPath:kMNFAuthenticationAfter pathQuery:nil jsonBody:jsonData HTTPMethod:kMNFHTTPMethodPOST service:MNFServiceNameAuthentication completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        [MNFObject executeOnMainThreadWithJob:job completion:completion error:response.error];
    }];
    
    return job;
}

+ (MNFJob *)authenticateWithSSOToken:(NSString *)token ofType:(NSString *)type withCompletion:(MNFAuthenticationCompletionHandler)completion {
    
    [completion copy];
    
    NSString *path = [NSString stringWithFormat:kMNFAuthenticationSSO,type];
    NSDictionary *pathQuery = @{@"securityToken":token};
    
    __block MNFJob *job = [self apiRequestWithPath:path pathQuery:pathQuery jsonBody:nil HTTPMethod:kMNFHTTPMethodPOST service:MNFServiceNameAuthentication completion:^(MNFResponse*  _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
            if ([response.result isKindOfClass:[NSDictionary class]]) {
                
                MNFAuthentication *authentication = [MNFAuthentication initWithServerResult:response.result];
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:authentication error:nil];
                
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

+ (MNFJob *)refreshTokensWithRefreshToken:(NSString *)refreshToken completion:(MNFAuthenticationCompletionHandler)completion {
    
    return [self refreshTokensWithRefreshToken:refreshToken clientId:nil clientSecret:nil subject:nil completion:completion];
}

+ (MNFJob*)refreshTokensWithRefreshToken:(NSString *)refreshToken clientId:(NSString *)clientId clientSecret:(NSString *)clientSecret subject:(NSString *)subject completion:(MNFAuthenticationCompletionHandler)completion {
    
    [completion copy];
    
    NSMutableDictionary *jsonDictionary = [NSMutableDictionary dictionary];
    jsonDictionary[@"refreshToken"] = refreshToken;
    jsonDictionary[@"clientId"] = clientId;
    jsonDictionary[@"clientSecret"] = clientSecret;
    jsonDictionary[@"subject"] = subject;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[jsonDictionary copy] options:0 error:nil];
    
    __block MNFJob *job = [self apiRequestWithPath:kMNFAuthenticationRefresh pathQuery:nil jsonBody:jsonData HTTPMethod:kMNFHTTPMethodPOST service:MNFServiceNameAuthentication completion:^(MNFResponse*  _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
            if ([response.result isKindOfClass:[NSDictionary class]]) {
                
                MNFAuthentication *authentication = [MNFAuthentication initWithServerResult:response.result];
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:authentication error:nil];
                
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

- (MNFJob *)refreshTokensWithCompletion:(MNFErrorOnlyCompletionHandler)completion {
    
    [completion copy];
    
    NSDictionary *jsonDictionary = @{@"refreshToken":self.refreshToken};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary options:0 error:nil];
    
    __block MNFJob *job = [MNFObject apiRequestWithPath:kMNFAuthenticationRefresh pathQuery:nil jsonBody:jsonData HTTPMethod:kMNFHTTPMethodPOST service:MNFServiceNameAuthentication completion:^(MNFResponse*  _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
            if ([response.result isKindOfClass:[NSDictionary class]]) {
                
                [MNFJsonAdapter refreshObject:self withJsonDict:response.result option:kMNFAdapterOptionNoOption error:nil];
                [MNFObject executeOnMainThreadWithJob:job completion:completion error:nil];
                
            }
            else {
                
                [MNFObject executeOnMainThreadWithJob:job completion:completion error:[MNFErrorUtils errorForUnexpectedDataOfType:[response.result class] expected:[NSDictionary class]]];
                
            }
        }
        else {
            [MNFObject executeOnMainThreadWithJob:job completion:completion error:response.error];
        }
    }];
    
    return job;

}

@end
