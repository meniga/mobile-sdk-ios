//
//  MENIGAAuthentication.m
//  bank42
//
//  Created by Mathieu Grettir Skulason on 1/18/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MENIGAAuthentication.h"
#import "Meniga.h"


static NSURLSession *s_session;
static NSArray *s_cookies;
static NSArray *s_tokens;
static NSString *s_loginApiPath;


@implementation MENIGAAuthentication

+(void)setupSession {
    if (s_session == nil) {
        s_session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        
    }
}

+(void)setLoginApiPath:(NSString *)theLoginPath {
    s_loginApiPath = theLoginPath;
}

+(void)loginWithUsername:(NSString *)theUsername password:(NSString *)thePassword withCompletion:(void (^)(NSDictionary *, NSError *))completion {
    [completion copy];
    
    [self setupSession];
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject: @{ @"email" : theUsername, @"password" : thePassword } options:0 error:nil];
    
    NSURL *url;
    if (s_loginApiPath != nil) {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/authentication", s_loginApiPath ]];
    }
    else {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/authentication", [Meniga apiURL]]];
    }
    NSDictionary *headers = [NSDictionary dictionaryWithObjectsAndKeys:@"true", @"X-XSRF-Header", nil];
    
    NSURLRequest *request = [self urlRequestWithURL:url httpMethod:@"POST" httpHeaders:headers parameters:postData];
    
    NSURLSessionDataTask *task = [s_session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        s_cookies = [NSHTTPCookie cookiesWithResponseHeaderFields:[(NSHTTPURLResponse*)response allHeaderFields] forURL:response.URL];
        
        if (error != nil) {
            completion(nil, error);
        }
        else if([[response class] isSubclassOfClass:[NSHTTPURLResponse class]]) {
            
            NSNumber *statusCode = [NSNumber numberWithInteger:[(NSHTTPURLResponse*)response statusCode]];
            
            NSDictionary *tokenDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            if ([statusCode intValue] >= 200 && [statusCode intValue] < 300) {
                
                
                
                if (completion != nil) {
                    completion(tokenDict, nil);
                }
            }
            else {
                                
                if (completion != nil) {
                    completion(nil, [NSError errorWithDomain:@"Some domain" code:-5000 userInfo:@{ NSLocalizedDescriptionKey : NSLocalizedString(@"ServerUnreachable", @"When we the email and pass is right and the status code we get is not related to authentication.") }]);
                }
                
            }
            
        }
        else {
            
            NSError *unexpectedError = [NSError errorWithDomain:@"" code:101 userInfo: @{ NSLocalizedDescriptionKey : [NSString stringWithFormat:@"Unexpected response type. Expected class: %@. Got class: %@",NSStringFromClass([NSHTTPURLResponse class]), NSStringFromClass([response class])]} ];
            
            if (completion != nil) {
                completion(nil, unexpectedError);
            }
            
        }
        
    }];
    
    [task resume];
}


#pragma mark - Helpers

+(void)executeBlockOnMainThreadWithCompletion:(void (^)(NSError *error))completion withError:(NSError *)theError {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        completion(theError);
    });
    
}

+(NSURLRequest *)urlRequestWithURL:(NSURL *)theUrl httpMethod:(NSString *)theHTTPMethod httpHeaders:(NSDictionary *)theHttpHeaders parameters:(NSData *)postData {
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theUrl];
    request.HTTPMethod = theHTTPMethod;
    request.HTTPBody = postData;
    
    NSMutableDictionary *postHeaders = [NSMutableDictionary dictionaryWithDictionary:theHttpHeaders];
    [postHeaders addEntriesFromDictionary:@{ @"Content-type":@"application/json" }];
    
    [request setAllHTTPHeaderFields:postHeaders];
    
    return [request copy];
}


@end
