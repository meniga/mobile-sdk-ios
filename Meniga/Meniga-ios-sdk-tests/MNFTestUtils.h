//
//  MNFTestUtils.h
//  Meniga-ios-sdk-tests
//
//  Created by Haukur Ísfeld on 21/03/2018.
//  Copyright © 2018 Meniga. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MNFObject;

@interface MNFTestUtils : NSObject

+(BOOL)validateApiModel:(NSDictionary*)apiModel withModelObject:(MNFObject*)modelObject;

@end
