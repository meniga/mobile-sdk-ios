//
//  MNFRealmUser.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 08/04/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFRealmUser.h"
#import "MNFInternalImports.h"

@implementation MNFRealmUser

+(MNFJob *)fetchRealmUsersWithCompletion:(MNFMultipleRealmUsersComletionHandler)completion {
    
    [completion copy];
    
    __block MNFJob *job = [self apiRequestWithPath:kMNFRealmUsers pathQuery:nil jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameUsers completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
        
            if ([response.result isKindOfClass:[NSArray class]]) {
            
                NSArray *realmUsers = [self initWithServerResults:response.result];
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:realmUsers error:nil];
            
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

-(MNFJob *)deleteRealmUserWithCompletion:(nullable MNFErrorOnlyCompletionHandler)completion {
    
    NSString *path = [NSString stringWithFormat:@"%@/%@",kMNFRealmUsers,[self.identifier stringValue]];
    
    __block MNFJob *job = [self deleteWithApiPath:path pathQuery:nil jsonBody:nil service:MNFServiceNameUsers  completion:^(MNFResponse * _Nullable response) {

        kObjectBlockDataDebugLog;
        
        [MNFObject executeOnMainThreadWithJob:job completion:completion error:response.error];
    
    }];
    
    return job;
}

#pragma mark - Description
-(NSString*)description {
    return [NSString stringWithFormat:@"Realm user %@ identifier: %@, userIdentifier: %@, realmId: %@, personId: %@, userId: %@",[super description],self.identifier,self.userIdentifier,self.realmId,self.personId,self.userId];
}

#pragma mark - json delegates

-(NSDictionary*)jsonKeysMapToProperties {
    return @{@"identifier":@"id"};
}

-(NSSet *)propertiesToIgnoreJsonDeserialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

-(NSSet *)propertiesToIgnoreJsonSerialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

@end
