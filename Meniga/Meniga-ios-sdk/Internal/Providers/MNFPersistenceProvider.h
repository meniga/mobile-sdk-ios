//
//  MNFPersistenceProvider.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 23/10/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MNFPersistenceProviderProtocol.h"

@interface MNFPersistenceProvider : NSObject <MNFPersistenceProviderProtocol>

@property (nonatomic,strong) NSCache *defaultCache;

@end
