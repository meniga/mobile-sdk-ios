//
//  MNFJsonAdapterTestFirstUppercaseValueTransformerDelegate.h
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 11/5/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MNFJsonAdapter.h"

@interface MNFJsonAdapterTestFirstUppercaseValueTransformerDelegate : NSObject <MNFJsonAdapterDelegate>

@property (nonatomic, strong) NSString *Name;
@property (nonatomic, strong) NSDate *Birthday;

-(id)initWithName:(NSString *)theName birthday:(NSDate *)theBirthday;

@end
