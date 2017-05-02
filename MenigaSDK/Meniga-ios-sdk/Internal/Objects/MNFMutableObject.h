//
//  MNFModifiableObject.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 23/10/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFObject.h"

@class MNFJob, MNFObjectState;

@interface MNFMutableObject : MNFObject


@property(nonatomic, readonly, getter=isDirty)BOOL dirty;
@property(nonatomic, readonly, getter=isDeleted)BOOL deleted;
@property(nonatomic, readonly)BOOL isNew;

/**
 Reverts the object to the last fetched server data
 */
-(void)revert;


@end
