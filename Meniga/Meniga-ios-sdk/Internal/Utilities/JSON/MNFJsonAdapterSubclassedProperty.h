//
//  MNFJsonAdapterSubclassedProperty.h
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 4/13/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MNFJsonAdapter.h"

NS_ASSUME_NONNULL_BEGIN

@interface MNFJsonAdapterSubclassedProperty : NSObject

@property (nonatomic, strong) Class propertyClass;
@property (nonatomic, strong) id <MNFJsonAdapterDelegate> propertyDelegate;
@property (nonatomic) MNFAdapterOption propertyOption;

/**
 @absrtact When you do not need a delegate when you want to subserialize your property
 */
+(instancetype)subclassedPropertyWitoutDelegate:(Class)theClass option:(MNFAdapterOption)theOption;

/**
 @absrtact Instantiates an instance of the class the is used as the json adapter delegate for the subserialized property.
 */
+(instancetype)subclassedPropertyWithClass:(Class)theClass option:(MNFAdapterOption)theOption;

/**
 @abstract When you want to register a property to subserialize from a json response, add all the information with delegate and option. If you want to
 */
+(instancetype)subclassedPropertyWithClass:(Class)theClass delegate:(nullable id <MNFJsonAdapterDelegate>)theDelegate option:(MNFAdapterOption)theOption;

-(instancetype)initWithClass:(Class)theClass delegate:(nullable id <MNFJsonAdapterDelegate>)theDelegate option:(MNFAdapterOption)theOption;


@end

NS_ASSUME_NONNULL_END