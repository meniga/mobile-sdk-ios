//
//  MNFDemoUser.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 4/19/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFDemoUser.h"
#import "MENIGAAuthentication.h"
#import "MNFObject_Private.h"
#import "NSObjectRuntimeUtils.h"

@implementation MNFDemoUser

static NSString *s_password = nil;
static NSString *s_email = nil;
static NSDictionary *s_tokens;
static NSURLSession *s_session;
static NSString *s_apiUrl;

+(NSString *)email {
    return s_email;
}

+(NSString *)password {
    return s_password;
}

+(NSDictionary *)tokenDictionary {
    
//    NSLog(@"s_tokens are: %@", s_tokens);
    return s_tokens;
}

+(void)setTokenDict:(NSDictionary *)theTokenDict {
    s_tokens = theTokenDict;
}

+(NSURLSession *)p_session {
    
    if (s_session == nil) {
        s_session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    }
    
    return s_session;
}

+(void)fetchDemoProfileIdsWithCompletion:(void (^)(NSArray<NSDictionary *> *, NSError *))completion {
    [completion copy];

    NSString *path;
    
    if (s_apiUrl != nil) {
        path = [NSString stringWithFormat:@"%@DemoAdmin.svc/GetDemoProfiles", s_apiUrl];
    }
    else {
        path = [NSString stringWithFormat:@"http://api.umw.test.meniga.net/DemoAdmin.svc/GetDemoProfiles"];
    }
    
    NSMutableURLRequest *request = [self p_requestWithPath:path];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"true" forHTTPHeaderField:@"X-XSRF-Header"];
    
    [[[self p_session] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (data != nil) {
            NSArray *profiles = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            completion(profiles, error);
        }
        else {
            completion(nil, error);
        }
        
    }] resume];


}

+(void)createDemoUserWithEmail:(NSString *)theEmail password:(NSString *)thePassword culture:(NSString *)theCulture demoProfileId:(NSNumber *)theDemoProfileId completion:(void (^)(NSError *))completion {
    [completion copy];
    
    NSString *path;
    
    if (s_apiUrl != nil) {
        path = [NSString stringWithFormat:@"%@/DemoAdmin.svc/CreateDemoPerson", s_apiUrl];
    }
    else {
        path = [NSString stringWithFormat:@"http://api.umw.test.meniga.net/DemoAdmin.svc/CreateDemoPerson"];
    }
    
    NSMutableURLRequest *request = [self p_requestWithPath:path];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"email"] = theEmail;
    dict[@"password"] = thePassword;
    dict[@"culture"] = theCulture;
    dict[@"roles"] = [NSNull null];
    dict[@"demoProfileId"] = theDemoProfileId;
    
    if (theEmail == nil) {
        s_email = [NSString stringWithFormat:@"autotestUMW-%@@hotmail.com", [self randomStringWithLength:12]];
        dict[@"email"] = s_email;
    }
    if (thePassword == nil) {
        s_password = [self randomStringWithLength:8];
        dict[@"password"] = s_password;
    }
    if (theCulture == nil) {
        dict[@"culture"] = @"en-GB";
    }
    
//    NSLog(@"dict is: %@", dict);
    
    [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:dict options:0 error:nil]];
    
    [[[self p_session] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSString *string;
        NSDictionary *dictionary;
        
        if (data != nil) {
        
            string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                    
        }
        
        completion(error);
        
    }] resume];
    
}

+(void)createRandomDemoUserWithCompletion:(void (^)(NSError *))completion {
    [completion copy];
    
    [self fetchDemoProfileIdsWithCompletion:^(NSArray <NSDictionary *> *profileIds, NSError *error) {
        
        if (profileIds != nil && profileIds.count != 0 && error == nil && [profileIds isKindOfClass:[NSArray class]]) {
            NSDictionary *profile = [profileIds firstObject];
            NSNumber *profileId = [profile objectForKey:@"Id"];
            
            [self createDemoUserWithEmail:nil password:nil culture:nil demoProfileId:profileId completion:completion];
            
        }
        else {
            completion(error);
        }
        
    }];
    
}

+(void)createRandomUserAndLoginWithCompletion:(void (^)(NSError *))completion {
    [completion copy];
    
    [self createRandomDemoUserWithCompletion:^(NSError *error) {
       
        if (error == nil) {
//            NSLog(@"email is: %@, password is: %@", s_email, s_password);
            [MENIGAAuthentication loginWithUsername:s_email password:s_password withCompletion:^(NSDictionary *tokenDictionary, NSError *error) {
               
                if (error == nil) {
//                    NSLog(@"token dictionary is: %@", tokenDictionary);
                    s_tokens = [tokenDictionary objectForKey:@"data"];
                    completion(nil);
                }
                else {
                    completion(error);
                }
                
            }];
        }
        else {
            completion(error);
        }
        
    }];
    
}

+(void)deleteUserWithCompletion:(nullable MNFErrorOnlyCompletionHandler)completion {
    [completion copy];
    
    [self apiRequestWithPath:kMNFApiPathUser pathQuery:nil jsonBody:nil HTTPMethod:kMNFHTTPMethodDELETE service:MNFServiceNameUsers completion:^(MNFResponse*  _Nullable response) {
        
        if (completion != nil) {
            completion(response.error);
        }
    }];
    
}

+(void)startSynchronizationWithWaitTime:(NSNumber *)theWaitTime completion:(void (^)(MNFSynchronization * _Nullable, NSError * _Nonnull))completion {
    [completion copy];
    
    NSDictionary *jsonDict;
    if (theWaitTime != nil) {
        jsonDict = @{ @"waitForCompleteMilliseconds" : theWaitTime };
    }
    else {
        jsonDict = @{ @"waitForCompleteMilliseconds" : @1000 };
    }
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:jsonDict options:0 error:nil];
    
    [MNFObject apiRequestWithPath:kMNFApiPathSynchronization pathQuery:nil jsonBody:data HTTPMethod:kMNFHTTPMethodPOST service:MNFServiceNameSync completion:^(MNFResponse *response) {
       
        if (response.error == nil) {
            if ([response.result isKindOfClass:[NSDictionary class]]) {
                MNFSynchronization *sync = [self initWithServerResult:response.result];
                completion(sync, response.error);
                return;
            }
            else {
                completion(nil, [MNFErrorUtils errorForUnexpectedDataOfType:[response.result class] expected:[NSDictionary class]]);
                return;
            }
        }
        completion(nil, response.error);
    }];
    
}


+(NSMutableURLRequest *)p_requestWithPath:(NSString *)thePath {
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:thePath]];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"true" forHTTPHeaderField:@"X-XSRF-Header"];
    [request setHTTPMethod:@"POST"];
    
    return request;
    
}

+(void)setCreateDemoUrl:(NSString *)theDemoUrl {
    s_apiUrl = theDemoUrl;
}

#pragma mark - Helpers

static NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

+(NSString *) randomStringWithLength: (int) len {
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform((u_int32_t)[letters length])]];
    }
    
    return randomString;
}

@end
