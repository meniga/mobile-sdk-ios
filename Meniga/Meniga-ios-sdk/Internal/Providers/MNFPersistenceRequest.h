//
//  MNFPersistenceRequest.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 19/11/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Meniga;

/**
 The MNFPersistenceRequest class translates a URL request to a persistence request used by the persistence provider.
 */
@interface MNFPersistenceRequest : NSObject

/**
 @abstract The api request extracted from the URL.
 */
@property (nonatomic,strong,readonly) NSString *request;

/**
 @abstract The URL request json data.
 */
@property (nonatomic,strong,readonly) id data;

/**
 @abstract The identifier of the object being fetched.
 */
@property (nonatomic,strong,readonly) NSNumber *key;

/**
 @description Initializes a persistence request from a URL request.
 
 @param request The URL request to initialize with.
 
 @return MNFPersistenceRequest An instance of MNFPersistenceRequest.
 */
-(instancetype)initWithRequest:(NSURLRequest*)request;

-(void)decryptData;
@end
