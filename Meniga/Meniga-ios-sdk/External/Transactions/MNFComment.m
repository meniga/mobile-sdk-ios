//
//  MNFComment.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 17/02/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFComment.h"
#import "MNFComment_Private.h"
#import "MNFInternalImports.h"

@interface MNFComment () <MNFJsonAdapterDelegate>

@end

@implementation MNFComment

#pragma mark - saving

-(MNFJob *)saveWithCompletion:(MNFErrorOnlyCompletionHandler)completion {
    
    [completion copy];
    
    NSString *path = [NSString stringWithFormat:@"%@/%@%@/%@",kMNFApiPathTransactions,[self.transactionId stringValue],kMNFTransactionsComments,[self.identifier stringValue]];
        
    NSDictionary *jsonBody = @{@"comment":self.comment};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonBody options:0 error:nil];
    
    __block MNFJob *job = [self updateWithApiPath:path pathQuery:nil jsonBody:jsonData httpMethod:kMNFHTTPMethodPUT service:MNFServiceNameTransactions completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        [MNFObject executeOnMainThreadWithJob:job completion:completion error:response.error];
    
    }];
    
    return job;
}

#pragma mark - deleting

-(MNFJob *)deleteCommentWithCompletion:(MNFErrorOnlyCompletionHandler)completion {
    
    NSString *path = [NSString stringWithFormat:@"%@/%@%@/%@",kMNFApiPathTransactions,[self.transactionId stringValue],kMNFTransactionsComments,[self.identifier stringValue]];
    
    __block MNFJob *job = [self deleteWithApiPath:path pathQuery:nil jsonBody:nil service:MNFServiceNameTransactions completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        [MNFObject executeOnMainThreadWithJob:job completion:completion error:response.error];
        
    }];
    
    
    return job;
}

#pragma mark - Description
-(NSString*)description {
    return [NSString stringWithFormat:@"Comment %@ identifier: %@, personId: %@, comment: %@, createdDate: %@, modifiedDate: %@",[super description],self.identifier,self.personId,self.comment,self.createdDate,self.modifiedDate];
}

#pragma mark - json adapter delegates

-(NSDictionary*)jsonKeysMapToProperties {
    return @{@"identifier":@"id"};
}

-(NSDictionary*)propertyKeysMapToJson {
    return @{@"identifier":@"id"};
}

-(NSDictionary*)propertyValueTransformers {
    return @{@"createdDate":[MNFBasicDateValueTransformer transformer],
             @"modifiedDate":[MNFBasicDateValueTransformer transformer]};
}

-(NSSet *)propertiesToIgnoreJsonDeserialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

-(NSSet *)propertiesToIgnoreJsonSerialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

@end
