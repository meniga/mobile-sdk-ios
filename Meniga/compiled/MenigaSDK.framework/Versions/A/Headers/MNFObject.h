//
//  MenigaObject.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 30/09/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MNFConstants.h"
#import "MNFJob.h"
#import "MNFJsonAdapterDelegate.h"

@class MNFJob, MNFObjectState;

NS_ASSUME_NONNULL_BEGIN

/**
 The MNFObject class is the superclass for all objects in the Meniga SDK.
 
 The superclass handless internal operations of the objects and state handling.
 */
@interface MNFObject : NSObject <MNFJsonAdapterDelegate>

/**
 @abstract Identifier for the object.
 
 @discussion This identifier is common to all objects that are serialized from the server.
 */
@property (nonatomic, strong, readonly) NSNumber *identifier;

/**
 @abstract Whether the object is dirty and needs to be saved to the server.
 */
@property (nonatomic, readonly, getter=isDirty) BOOL dirty;

/**
 @abstract Whether the object has been deleted from the server.
 */
@property (nonatomic, readonly, getter=isDeleted) BOOL deleted;

/**
 @abstract Whether the object has yet to be created on the server.
 
 @discussion Only user created objects are marked as new and need to be created on the server. Once they are created the object is no longer marked as new.
 */
@property (nonatomic, readonly) BOOL isNew;

/**
 @abstract Reverts the object to the last fetched server data
 */
- (void)revert;

@end

NS_ASSUME_NONNULL_END