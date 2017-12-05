//
//  MNFPostalCode.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 23/02/2017.
//  Copyright © 2017 Meniga. All rights reserved.
//

#import "MNFObject.h"

NS_ASSUME_NONNULL_BEGIN

/**
 The MNFPostalCode class represents postal code information in an object.
 */
@interface MNFPostalCode : MNFObject

///******************************
/// @name Immutable properties
///******************************

/**
 The postal code.
 */
@property (nonatomic,copy,readonly) NSString *postalCode;

/**
 A list of areas that are available for community comparison for the current postal code.
 */
@property (nonatomic,copy,readonly) NSArray *filterAreas;

/**
 A list of all areas connected to the current postal code. Only returned when all postal codes are fetched.
 */
@property (nonatomic,copy,readonly) NSArray *allAreas;

+(MNFJob*)fetchPostalCode:(NSString*)postalCode withCompletion:(nullable MNFPostalCodeCompletionHandler)completion;
+(MNFJob*)fetchPostalCodesWithCompletion:(nullable MNFMultiplePostalCodesCompletionHandler)completion;

@end

NS_ASSUME_NONNULL_END
