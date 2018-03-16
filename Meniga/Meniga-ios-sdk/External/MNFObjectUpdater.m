//
//  MNFObjectUpdater.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 10/12/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFObjectUpdater.h"
#import "MNFJsonAdapter.h"

@implementation MNFObjectUpdater

+(void)updateMNFObject:(id)objectToUpdate withMNFObject:(id)object {
    
    NSAssert([objectToUpdate isKindOfClass: [object class]] == YES, @"Updating object with incompatible class");
    
    NSDictionary *updateDict = [MNFJsonAdapter JSONDictFromObject: object option: 0 error: nil];
    [MNFJsonAdapter refreshObject: objectToUpdate withJsonDict: updateDict option: 0 error: nil];
    
}

@end
