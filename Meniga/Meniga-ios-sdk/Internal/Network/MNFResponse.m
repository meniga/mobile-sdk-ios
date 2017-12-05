//
//  MenigaResponse.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 30/09/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFResponse.h"
#import "MNFConstants.h"
#import "MNFErrorUtils.h"
#import "Meniga.h"
#import "MNFLogger.h"

@implementation MNFResponse

-(id)init {
    self = [super init];
    if (self) {
        _error = nil;
        _result = nil;
    }
    return self;
}
-(id)initWithData:(NSData *)data error:(NSError *)error statusCode:(NSInteger)statusCode headerFields:(NSDictionary *)allHeaderFields {
    self = [super init];
    if (self) {
        
        _rawData = data;
        _statusCode = statusCode;
        _allHeaderFields = allHeaderFields;

        if (error == nil) {
            
            NSError *jsonError;
            NSDictionary *JSONData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                        
            if (_statusCode < 200 || _statusCode >= 300) {
                
                _error = [self p_createErrorWithDictionary:JSONData statusCode:statusCode];
            }
            else if (jsonError != nil && data.length != 0) {
                _error = jsonError;
            }
            else {
                id requestResult;
                id metaDataResult;
                
                if ([JSONData isKindOfClass:[NSDictionary class]]) {
                    requestResult = [JSONData objectForKey:@"data"];
                    metaDataResult = [JSONData objectForKey:@"meta"];
                    if (requestResult == nil) {
                        _result = JSONData;
                    }
                    else {
                        _result = requestResult;
                    }
                    _metaData = metaDataResult;
                }
                else {
                    _result = JSONData;
                }
            }
        }
        else{
            _error = error;
        }
        
        [self p_sendNotification];

    }
    return self;
}
+(instancetype)responseWithData:(nullable NSData *)data error:(nullable NSError *)error statusCode:(NSInteger)statusCode headerFields:(nullable NSDictionary *)allHeaderFields {
    return [[[self class] alloc] initWithData:data error:error statusCode:statusCode headerFields:allHeaderFields];
}

-(BOOL)p_isValidStatusCodeForEmptyResult:(NSInteger)statusCode{
    NSArray *validStatusCode = @[@204, @404];//Add all accepted status code for empty results to this array, 404 May contain an error object but may be empty as well. Look at api spec: https://git.meniga.net/projects/API/repos/meniga-api-spec/browse/spec/format/1.0/index.md
    return [validStatusCode containsObject:@(statusCode)];
}

-(NSError *)p_createErrorForNoContentResponseWithStatusCode:(NSInteger)statusCode {
    
    if (statusCode == 404) {
        return [MNFErrorUtils errorWithCode:statusCode message:@"Resource could not be found"];
    }
    
    return nil;
}

-(NSError *)p_createErrorWithDictionary:(NSDictionary *)theErrorDict statusCode:(NSInteger)theStatusCode {
    
    NSArray *theDictionaryErrors = [theErrorDict objectForKey:@"errors"];
    
    if (theDictionaryErrors != nil && theDictionaryErrors.count != 0) {
        
        NSDictionary *firstError = [theDictionaryErrors firstObject];
        NSString *errorMessage = [self p_errorMessageFromData:firstError];
        NSDictionary *errorInfo = [firstError objectForKey:@"modelState"];

        return [MNFErrorUtils errorWithCode:theStatusCode message:errorMessage errorInfo:errorInfo];
        
    }
    else {
        
        MNFLogDebug(@"Unknown error format, %@", theErrorDict);
        
        return [MNFErrorUtils errorWithCode: kMNFErrorInvalidResponse message: @"An unknown error occured"];
    }
    
    return nil;
}

-(NSString*)p_errorMessageFromData:(NSDictionary*)errorData{
    return [errorData objectForKey:kMNFErrorMessageJSONKey];
}

-(void)p_sendNotification {
    
    NSString *notificationName = [Meniga notificationNameForStatusCode:_statusCode];
    NSNotificationCenter *notificationCenter = [Meniga notificationCenterForStatusCode:_statusCode];
    if (notificationName != nil) {
        [notificationCenter postNotificationName:notificationName object:_error];
    }
}

@end
