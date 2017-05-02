//
//  MNFJsonAdapterKeyAndProperty.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 3/23/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFJsonAdapterKeyAndProperty.h"

@implementation MNFJsonAdapterKeyAndProperty


+(instancetype)jsonAdapterKey:(NSString*)theKey value:(id)theValue {
    
    MNFJsonAdapterKeyAndProperty *object = [[MNFJsonAdapterKeyAndProperty alloc] init];
    object.propertyKey = theKey;
    object.propertyValue = theValue;
    
    return object;
}

-(NSString*)description {
    return [NSString stringWithFormat:@"propertyKey: %@, propertyValue: %@", self.propertyKey, self.propertyValue];
}

@end