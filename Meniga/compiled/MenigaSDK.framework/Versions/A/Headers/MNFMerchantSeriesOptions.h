//
//  MNFMerchantSeriesOptions.h
//  Meniga-ios-sdk
//
//  Created by Aske Bendtsen on 19/01/17.
//  Copyright © 2017 Meniga. All rights reserved.
//

#import "MNFObject.h"

@interface MNFMerchantSeriesOptions : NSObject <MNFJsonAdapterDelegate>

NS_ASSUME_NONNULL_BEGIN

/**
 @description The maximum number of merchants to return. Default value is @10
 **/
@property (nonatomic, strong) NSNumber *maxMerchants;

/**
 @description The measurement used to decide the order of the returned merchant result. Currently supported values: 'NettoAmount'. Default value is @"NettoAmount"
 **/
@property (nonatomic, copy) NSString *measurement;

/**
  @description Whether or not to include in the aggregation transactions where the merchantId is null. Default value is @NO
 **/
@property (nonatomic, strong) NSNumber *includeUnMappedMerchants;

/**
 @description If set to true, the result will be aggregated using transactions merchant parent instead of the merchant itself. Default value is @NO
 **/
@property (nonatomic, strong) NSNumber *useParentMerchantIds;

NS_ASSUME_NONNULL_END

@end
