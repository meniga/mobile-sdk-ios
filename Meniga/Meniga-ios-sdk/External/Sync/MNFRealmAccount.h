//
//  MNFRealmAccount.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 12/07/2017.
//  Copyright © 2017 Meniga. All rights reserved.
//

#import "MNFObject.h"

@interface MNFRealmAccount : MNFObject

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *accountIdentifier;
@property (nonatomic, strong, readonly) NSNumber *accountTypeId;
@property (nonatomic, strong, readonly) NSNumber *accountExists;

@end
