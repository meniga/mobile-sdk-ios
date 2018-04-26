//
//  MNFFeedItem.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 11/11/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFObject.h"

NS_ASSUME_NONNULL_BEGIN

/**
 The MNFFeedItem class encapsulates feed item json data from the server in an object.
 
 A feed item should not be directly initialized but instead should be constructed with data from the server.
 The response from the server will be automatically converted to an MNFFeedItem object.
 */
@interface MNFFeedItem : MNFObject

///******************************
/// @name Immutable properties
///******************************

/**
 @abstact The date of the feed item.
 */
@property (nonatomic,strong,readonly) NSDate *date;

/**
 @abstract The topic id of the feed item. This can correspond to identifiers of the object being returned in the feed.
 */
@property (nonatomic,strong,readonly) NSNumber *topicId;

/**
 @abstract The topic name of the feed item.
 */
@property (nonatomic,copy,readonly) NSString *topicName;

/**
 @abstract The title of the feed item. This is a convenient display title gathered from the object data.
 */
@property (nonatomic,copy,readonly) NSString *title;

/**
 @abstract The body of the feed item. This is a convenient display body gathered from the object data.
 */
@property (nonatomic,copy,readonly) NSString *body;

/**
 @abstract The type name of the feed item. This corresponds to the default type values of each feed item.
 */
@property (nonatomic,copy,readonly) NSString *typeName;

/**
 The type of the feed item. A value from /feed/types. 'Transactions','UserEvents','Cashback'.
 */
@property (nonatomic,copy,readonly) NSString *type;

/**
 @abstract The deserialized model object that this feed item represents.
 
 @discussion This object will be serialized according to the feed item type name. A 'TransactionFeedItemModel' type name means the model will be an MNFTransaction object.
 */
@property (nonatomic,strong,readonly) NSObject *model;

@end

NS_ASSUME_NONNULL_END
