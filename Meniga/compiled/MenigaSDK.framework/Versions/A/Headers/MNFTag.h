//
//  MNFTag.h
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 11/6/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFObject.h"

NS_ASSUME_NONNULL_BEGIN

/**
 The MNFTag class encapsulates tag json data from the server in an object.
 
 A tag should not be created directly. It is instead created as part of a comment on a transaction using a hashtag (#) prefix.
 */
@interface MNFTag : MNFObject

///******************************
/// @name Immutable properties
///******************************

/**
 @abstract The name of the tag.
 */
@property (nonatomic, strong, readonly) NSString *name;

///******************************
/// @name Fetching
///******************************

/**
 @abstract Fetches a tag with a given identifier.
 
 @param tagId The identifier of the tag being fetched.
 @param completion A completion block returning a tag and an error.
 
 @return An MNFJob containing an MNFTag and an error.
 */
+ (MNFJob *)fetchWithId:(NSNumber *)tagId completion:(nullable MNFTagCompletionHandler)completion;

/**
 @abstract Fetches a list of all tags created by the user.
 
 @param completion A completion block returning a list of tags and an error.
 
 @return MNFJob A job containing an array of tags and an error.
 */
+ (MNFJob *)fetchTagsWithCompletion:(nullable MNFMultipleTagsCompletionHandler)completion;

/**
 @abstract Fetches a list of the most popular tags used by the user.
 
 @param count The number of tags to fetch.
 @param completion A completion block returning a list of tags and an error.
 
 @return An MNFJob containing a list of tags and an error.
 */
+ (MNFJob *)fetchPopularTagsWithCount:(NSNumber *)count
                           completion:(nullable MNFMultipleTagsCompletionHandler)completion;

@end

NS_ASSUME_NONNULL_END
