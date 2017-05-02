//
//  MNFJsonAdapterValueTransformer.h
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 3/23/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MNFJsonAdapter.h"


@interface MNFJsonAdapterValueTransformer : NSValueTransformer

+(instancetype)transformerWithClass:(Class)theClass option:(MNFAdapterOption)theOption;

-(id)transformedValue:(id)value error:(NSError **)theError;
-(id)reverseTransformedValue:(id)value error:(NSError **)theError;

@end
