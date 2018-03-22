//
//  MNFImportAccountConfiguration.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 30/01/2018.
//  Copyright © 2018 Meniga. All rights reserved.
//

#import "MNFObject.h"

/**
 MNFImportAccountConfiguration describes account configuration when fetching account types.
 */
@interface MNFImportAccountConfiguration : MNFObject

///******************************
/// @name Immutable properties
///******************************

/**
 The description for the import account configuration.
 */
@property (nonatomic,copy,readonly) NSString *configurationDescription;

/**
 The supported file type extensions where key is the file type extension (e.g. .xls) and value is the file type extension description (e.g. Excel Workbook).
 */
@property (nonatomic,copy,readonly) NSArray <NSDictionary*> *supportedFileTypeExtensions;

/**
 Whether or not this import configuration supports copy/paste import.
 */
@property (nonatomic,strong,readonly) NSNumber *isCopyPaste;

@end
