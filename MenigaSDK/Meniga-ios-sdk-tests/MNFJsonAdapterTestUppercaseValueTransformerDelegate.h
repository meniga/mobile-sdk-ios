//
//  MNFJsonAdapterTestUppercaseValueTransformerDelegate.h
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 11/5/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MNFJsonAdapter.h"

@interface MNFJsonAdapterTestUppercaseValueTransformerDelegate : NSObject <MNFJsonAdapterDelegate>

@property (nonatomic, strong) NSString *NAME;
@property (nonatomic, strong) NSDate *BIRTHDAY;

-(id)initWithName:(NSString *)theName birthday:(NSDate *)theBirthday;


@end
