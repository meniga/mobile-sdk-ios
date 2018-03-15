//
//  MNFMedia.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 15/03/2018.
//  Copyright © 2018 Meniga. All rights reserved.
//

#import "MNFMedia.h"
#import "MNFInternalImports.h"

@implementation MNFMedia

+(MNFJob*)fetchMediaWithId:(NSString *)identifier width:(NSNumber *)width height:(NSNumber *)height completion:(MNFMediaCompletionHandler)completion {
    [completion copy];
    
    NSString *path = [NSString stringWithFormat:@"%@/%@",kMNFApiPathMedia,identifier];
    
    NSMutableDictionary *jsonQuery = [NSMutableDictionary dictionary];
    jsonQuery[@"width"] = width;
    jsonQuery[@"height"] = height;
    
    __block MNFJob *job = [self resourceRequestWithPath:path pathQuery:[jsonQuery copy] jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameMedia completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:response.rawData error:response.error];
    }];
    
    return job;
}

@end
