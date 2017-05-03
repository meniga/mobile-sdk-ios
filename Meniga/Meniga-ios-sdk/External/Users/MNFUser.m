//
//  MNFUser.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 23/10/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFUser.h"
#import "MNFInternalImports.h"

@implementation MNFUser

#pragma mark - class methods

+(MNFJob *)fetchUsersWithCompletion:(MNFMultipleUsersCompletionHandler)completion {
    
    [completion copy];
    
    NSDictionary *jsonQuery = @{@"includeAll":@"true"};
    
    __block MNFJob *job = [self apiRequestWithPath:kMNFApiPathUser pathQuery:jsonQuery jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameUsers completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
        
            if ([response.result isKindOfClass:[NSArray class]]) {
            
                NSArray *users = [MNFUser initWithServerResults:response.result];
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:users error:nil];
            
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

#pragma mark - instance methods

-(MNFJob *)saveWithCompletion:(nullable MNFErrorOnlyCompletionHandler)completion {
    
    [completion copy];
    
    NSMutableDictionary *jsonDict = [NSMutableDictionary dictionary];
    
    if (self.firstName != nil) {
        [jsonDict setObject:self.firstName forKey:@"firstName"];
    }
    else {
        [jsonDict setObject:@"" forKey:@"firstName"];
    }
    if (self.lastName != nil) {
        [jsonDict setObject:self.lastName forKey:@"lastName"];
    }
    else {
        [jsonDict setObject:@"" forKey:@"lastName"];
    }
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[jsonDict copy] options:0 error:nil];
    
    __block MNFJob *job = [self updateWithApiPath:kMNFApiPathUser pathQuery:nil jsonBody:jsonData httpMethod:kMNFHTTPMethodPUT service:MNFServiceNameUsers completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        [MNFObject executeOnMainThreadWithJob:job completion:completion error:response.error];
    
    }];
    
    return job;
}

-(MNFJob *)deleteUserWithCompletion:(nullable MNFErrorOnlyCompletionHandler)completion {
    
    [completion copy];
    
    __block MNFJob *job = [self deleteWithApiPath:kMNFApiPathUser pathQuery:nil jsonBody:nil service:MNFServiceNameUsers completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        [MNFObject executeOnMainThreadWithJob:job completion:completion error:response.error];
    
    }];
    
    return job;
}

-(MNFJob *)refreshWithCompletion:(nullable MNFErrorOnlyCompletionHandler)completion {
    
    [completion copy];
    
    NSDictionary *jsonQuery = @{@"includeAll":@"true"};
    
    __block MNFJob *job = [[self class] apiRequestWithPath:kMNFApiPathUser pathQuery:jsonQuery jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameUsers completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
        
            if ([response.result isKindOfClass:[NSArray class]]) {
            
                for (NSDictionary *dict in response.result) {
                
                    if ([[dict objectForKey:@"userId"] isEqualToNumber:self.identifier]) {
                    
                        [self revert];
                        [MNFJsonAdapter refreshObject:self withJsonDict:dict option:kMNFAdapterOptionNoOption error:nil];
                    }

                }
                
                [MNFObject executeOnMainThreadWithJob:job completion:completion error:nil];
                
            }
            else {
                
                [MNFObject executeOnMainThreadWithJob:job completion:completion error: [MNFErrorUtils errorForUnexpectedDataOfType:[response.result class] expected:[NSArray class]] ];
            
            }
        
        }
        else {
            
            [MNFObject executeOnMainThreadWithJob:job completion:completion error:response.error];
        
        }
        
    }];

    return job;
}

-(MNFJob *)changeCulture:(NSString *)culture withCompletion:(nullable MNFErrorOnlyCompletionHandler)completion {
    
    [completion copy];
    
    NSDictionary *jsonQuery = @{@"culture":culture};
    
    __block MNFJob *job = [self updateWithApiPath:kMNFUserCulture pathQuery:jsonQuery jsonBody:nil httpMethod:kMNFHTTPMethodPUT service:MNFServiceNameUsers completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
        
            _culture = culture;
        
        }
        
        [MNFObject executeOnMainThreadWithJob:job completion:completion error:response.error];
    
    }];
    
    return job;
}

-(MNFJob *)optInWithCompletion:(nullable MNFErrorOnlyCompletionHandler)completion {
    
    [completion copy];
    
    __block MNFJob *job = [[self class] apiRequestWithPath:kMNFUserOptin pathQuery:nil jsonBody:nil HTTPMethod:kMNFHTTPMethodPUT service:MNFServiceNameUsers completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        [MNFObject executeOnMainThreadWithJob:job completion:completion error:response.error];
    
    }];
    
    return job;
}

-(MNFJob *)optOutWithCompletion:(nullable MNFErrorOnlyCompletionHandler)completion {
    
    [completion copy];
    
    __block MNFJob *job = [[self class] apiRequestWithPath:kMNFUserOptout pathQuery:nil jsonBody:nil HTTPMethod:kMNFHTTPMethodPUT service:MNFServiceNameUsers completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        [MNFObject executeOnMainThreadWithJob:job completion:completion error:response.error];
    
    }];
    
    return job;
}

-(MNFJob *)fetchMetaDataForKeys:(NSString *)keys completion:(MNFMultipleMetadataCompletionHandlers)completion {
    
    NSDictionary *jsonQuery = @{@"names":keys};
    
    __block MNFJob *job = [[self class] apiRequestWithPath:kMNFUserMetaData pathQuery:jsonQuery jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameUsers completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:response.result error:response.error];
    
    }];

    return job;
}

-(MNFJob *)updateMetaDataForKey:(NSString *)key value:(NSString *)value completion:(MNFErrorOnlyCompletionHandler)completion {
    
    [completion copy];
    
    NSDictionary *jsonBody = @{@"name":key,@"value":value};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonBody options:0 error:nil];
    
    __block MNFJob *job = [[self class] apiRequestWithPath:kMNFUserMetaData pathQuery:nil jsonBody:jsonData HTTPMethod:kMNFHTTPMethodPUT service:MNFServiceNameUsers completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        [MNFObject executeOnMainThreadWithJob:job completion:completion error:response.error];
        
    }];
    
    return job;
}


#pragma mark - Description
-(NSString*)description {
    return [NSString stringWithFormat:@"User %@ identifier: %@, personId: %@, firstName: %@, lastName: %@, lastLoginDate: %@, isInitialSetupDone: %@, email: %@, culture: %@, lastLoginRemoteHost: %@, createDate: %@, termsAndConditionsId: %@, termsAndConditionsAcceptDate: %@, optOutDate: %@, profile: %@, phoneNumber: %@, passwordExpiryDate: %@, hide: %@",[super description],self.identifier,self.personId,self.firstName,self.lastName,self.lastLoginDate,self.isInitialSetupDone,self.email,self.culture,self.lastLoginRemoteHost,self.createDate,self.termsAndConditionsId,self.termsAndConditionsAcceptDate,self.optOutDate,self.profile,self.phoneNumber,self.passwordExpiryDate,self.hide];
}

#pragma mark - Json Adapter Delegate

-(NSDictionary*)jsonKeysMapToProperties {
    return @{@"identifier":@"userId"};
}
-(NSDictionary*)propertyKeysMapToJson {
    return @{@"identifier":@"userId"};
}

-(NSDictionary*)propertyValueTransformers {
    return @{@"lastLoginDate":[MNFBasicDateValueTransformer transformer],
             @"createDate":[MNFBasicDateValueTransformer transformer],
             @"termsAndConditionsAcceptDate":[MNFBasicDateValueTransformer transformer],
             @"optOutDate":[MNFBasicDateValueTransformer transformer],
             @"passwordExpiryDate":[MNFBasicDateValueTransformer transformer]};
}

-(NSDictionary*)subclassedProperties {
    return @{
             @"profile": [MNFJsonAdapterSubclassedProperty subclassedPropertyWithClass: [MNFUserProfile class] option: kMNFAdapterOptionNoOption]
             };
}

-(NSSet *)propertiesToIgnoreJsonDeserialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

-(NSSet *)propertiesToIgnoreJsonSerialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

@end
