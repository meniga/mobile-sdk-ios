//
//  MNFJsonAdapterTestValueTransformerDelegate.h
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 11/2/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MNFJsonAdapter.h"

@interface MNFJsonAdapterTestValueTransformerDelegate : NSObject <MNFJsonAdapterDelegate>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSDate *birthday;

- (id)initWithName:(NSString *)theName birthday:(NSDate *)theBirthday;

@end
