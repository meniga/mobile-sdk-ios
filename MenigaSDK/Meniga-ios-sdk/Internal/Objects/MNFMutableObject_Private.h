//
//  MNFMutableObject_Private.h
//  Meniga-ios-sdk
//
//  Created by Aske Bendtsen on 30/10/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFMutableObject.h"
#import "MNFJob.h"
#import "MNFObject_Private.h"

@class MNFObjectState;
@interface MNFMutableObject(Private)

-(void)updateWithApiPath:(NSString*)path pathQuery:(NSDictionary*)pathQuery jsonBody:(NSData*)data httpMethod:(NSString*)httpMethod completion:(MNFCompletionHandler)completion;
-(MNFJob*)updateWithApiPath:(NSString*)path pathQuery:(NSDictionary*)pathQuery jsonBody:(NSData*)data httpMethod:(NSString*)httpMethod;

-(void)deleteWithApiPath:(NSString*)path pathQuery:(NSDictionary*)pathQuery jsonBody:(NSData*)data completion:(MNFCompletionHandler)completion;
-(MNFJob*)deleteWithApiPath:(NSString*)path pathQuery:(NSDictionary*)pathQuery jsonBody:(NSData*)data;

-(void)setIsNew:(BOOL)isNew;

//Used for test
-(MNFObjectState*)objectState;

@end
