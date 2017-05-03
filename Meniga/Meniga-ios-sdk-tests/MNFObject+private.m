//
//  MNFObject+private.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 26/10/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFObject+private.h"
#import "MNFObjectController.h"
#import "MNFResponse.h"

@implementation MNFObject (private)

-(void)fetchWithApiPath:(NSString*)path parameters:(NSString *)parameters completion:(MNFFetchCompletionHandler)completion {
    [completion copy];
    [MNFObjectController fetchWithApiPath:path parameters:parameters completion:^(id result,NSError *error, BOOL success){
        completion(result,error,success);
    }];
}
-(void)fetchWithApiPath:(NSString*)path parameters:(NSString *)parameters data:(NSData *)data completion:(MNFFetchCompletionHandler)completion {
    [completion copy];
    [MNFObjectController fetchWithApiPath:path parameters:parameters data:data completion:^(id result,NSError *error, BOOL success) {
        completion(result,error,success);
    }];
}

@end
