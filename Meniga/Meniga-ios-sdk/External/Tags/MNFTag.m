//
//  MNFTag.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 11/6/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFTag.h"
#import "MNFInternalImports.h"

@implementation MNFTag

#pragma mark - Class methods

+(MNFJob *)fetchWithId:(NSNumber *)tagId completion:(MNFTagCompletionHandler)completion {
    
    [completion copy];
    
    NSString *path = [NSString stringWithFormat:@"%@/%@",kMNFApiPathTags,tagId];
    
    __block MNFJob *job = [self apiRequestWithPath:path pathQuery:nil jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameTags completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
        
            if ([response.result isKindOfClass:[NSDictionary class]]) {
            
                MNFTag *tag = [self initWithServerResult:response.result];
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:tag error: nil];
            
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

+(MNFJob *)fetchTagsWithCompletion:(MNFMultipleTagsCompletionHandler)completion {
    
    __block MNFJob *job = [self apiRequestWithPath:kMNFApiPathTags pathQuery:nil jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameTags completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
        
            if ([response.result isKindOfClass:[NSArray class]]) {
            
                NSArray *tags = [self initWithServerResults:response.result];
//                NSLog(@"tags are: %@", tags);
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:tags error:nil];
            
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

+(MNFJob *)fetchPopularTagsWithCount:(NSNumber *)count completion:(MNFMultipleTagsCompletionHandler)completion {
    
    [completion copy];
    
    NSString *path = [NSString stringWithFormat:@"%@/popular",kMNFApiPathTags];
    
    __block MNFJob *job = [self apiRequestWithPath:path pathQuery:nil jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameTags completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
        
            if ([response.result isKindOfClass:[NSArray class]]) {
            
                NSArray *tags = [self initWithServerResults:response.result];
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:tags error:nil];
            
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

#pragma mark - Description
-(NSString*)description {
    return [NSString stringWithFormat:@"Tag %@ identifier: %@, name: %@",[super description],self.identifier,self.name];
}

#pragma mark - Json Adapter Delegate

-(NSDictionary *)jsonKeysMapToProperties {
    return @{ @"identifier" : @"id" };
}

-(NSDictionary *)propertyKeysMapToJson {
    
    return @{ @"identifier" : @"id" };
}

-(NSSet *)propertiesToIgnoreJsonDeserialization {
    return [NSSet setWithObjects:@"isDeleted", @"objectstate", nil];
}

-(NSSet *)propertiesToIgnoreJsonSerialization {
    return [NSSet setWithObjects:@"isDeleted", @"objectstate", nil];
}


@end
