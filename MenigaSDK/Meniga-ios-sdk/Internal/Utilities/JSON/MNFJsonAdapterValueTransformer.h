//
//  MNFJsonAdapterValueTransformer.h
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 3/23/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MNFJsonAdapter.h"

NS_ASSUME_NONNULL_BEGIN

@interface MNFJsonAdapterValueTransformer : NSValueTransformer

+(instancetype)transformerWithClass:(Class)theClass delegate:(nullable id <MNFJsonAdapterDelegate>)theDelegate option:(MNFAdapterOption)theOption;

-(instancetype)initWithClass:(Class)theClass delegate:(nullable id <MNFJsonAdapterDelegate> )theDelegate option:(MNFAdapterOption)theOption;

-(id)transformedValue:(id)value error:(NSError **)theError;
-(id)reverseTransformedValue:(id)value error:(NSError **)theError;

@end

NS_ASSUME_NONNULL_END
