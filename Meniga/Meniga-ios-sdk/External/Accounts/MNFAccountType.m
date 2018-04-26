//
//  MNFRealmAccountType.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 11/04/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFAccountType.h"
#import "MNFInternalImports.h"
#import "MNFImportAccountConfiguration.h"

@implementation MNFAccountType

+ (MNFJob*)fetchAccountTypesWithOrganizationId:(NSNumber *)organizationId completion:(MNFMultipleAccountTypesCompletionHandler)completion {
    [completion copy];
    
    NSMutableDictionary *jsonQuery = [NSMutableDictionary dictionary];
    jsonQuery[@"organizationId"] = organizationId;
    
    __block MNFJob *job = [self apiRequestWithPath:kMNFAccountTypes pathQuery:[jsonQuery copy] jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameAccounts completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
            
            if ([response.result isKindOfClass:[NSArray class]]) {
                
                NSArray *accountTypes = [MNFAccountType initWithServerResults:response.result];
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:accountTypes error:nil];
                
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

+ (MNFJob*)fetchAccountTypeWithId:(NSNumber *)identifier completion:(MNFAccountTypeCompletionHandler)completion {
    [completion copy];
    
    NSString *path = [NSString stringWithFormat:@"%@/%@",kMNFAccountTypes,identifier];
    
    __block MNFJob *job = [self apiRequestWithPath:path pathQuery:nil jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameAccounts completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
            
            if ([response.result isKindOfClass:[NSDictionary class]]) {
                
                MNFAccountType *accountType = [MNFAccountType initWithServerResult:response.result];
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:accountType error:nil];
                
            }
            else {
                
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error: [MNFErrorUtils errorForUnexpectedDataOfType:[response.result class] expected:[NSDictionary class]] ];
                
            }
        }
        else {
            
            [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error: response.error];
            
        }
    }];
    
    return job;
}

#pragma mark - json adapter delegates
-(NSDictionary*)jsonKeysMapToProperties {
    return @{@"identifier":@"id",
             @"accountDescription":@"description"};
}

-(NSDictionary*)propertyKeysMapToJson {
    return @{@"identifier":@"id",
             @"accountDescription":@"description"};
}

-(NSSet *)propertiesToIgnoreJsonDeserialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

-(NSSet *)propertiesToIgnoreJsonSerialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

-(NSDictionary*)subclassedProperties {
    return @{
             @"importAccountConfiguration": [MNFJsonAdapterSubclassedProperty subclassedPropertyWithClass: [MNFImportAccountConfiguration class] option: kMNFAdapterOptionNoOption]
             };
}

#pragma mark - Description
-(NSString*)description {
    return [NSString stringWithFormat:@"Realm account type %@ identifier: %@, accountDescription: %@, accountType: %@, name: %@",[super description],self.identifier,self.accountDescription,self.accountCategory,self.name];
}

@end
