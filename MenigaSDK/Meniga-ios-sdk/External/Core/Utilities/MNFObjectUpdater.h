//
//  MNFObjectUpdater.h
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 10/12/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MNFObjectUpdater : NSObject

/**
 @description Updates the object with the new one.
 
 @warning Make sure the classes are identical or a crash will occur.
 */
+(void)updateMNFObject:(id)objectToUpdate withMNFObject:(id)object;

@end
