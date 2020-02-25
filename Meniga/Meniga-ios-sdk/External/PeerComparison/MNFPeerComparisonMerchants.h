//
//  MNFPeerComparisonMerchants.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 15/03/2018.
//  Copyright © 2018 Meniga. All rights reserved.
//

#import "MNFObject.h"

@interface MNFPeerComparisonMerchants : MNFObject

@property (nonatomic, copy, readonly) NSString *merchantIdentifier;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSNumber *rank;
@property (nonatomic, strong, readonly) NSNumber *amount;
@property (nonatomic, strong, readonly) NSNumber *numberOfVisits;

@end
