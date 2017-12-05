//
//  MNFJsonAdapterKeyAndProperty.h
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 3/23/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MNFJsonAdapterKeyAndProperty : NSObject

@property (nonatomic, strong) NSString *propertyKey;
@property (nonatomic, strong) id propertyValue;

+(instancetype)jsonAdapterKey:(NSString*)theKey value:(id)theValue;

@end
