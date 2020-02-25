//
//  MNFMedia.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 15/03/2018.
//  Copyright © 2018 Meniga. All rights reserved.
//

#import "MNFObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface MNFMedia : MNFObject

/**
 Fetches image data with a given identifier and dimensions.
 
 @param identifier The identifier of the data with a requested file ending type. Ex. 'myIdentifier.png'. If the file ending type is missing then the image's default content type is used.
 @param width Requested width of the image. If not provided then image's default width is used.
 @param height Requested height of the image. If not provided then image's default height is used.
 @param completion A completion block returning image data and an error.
 
 @return An MNFJob containing image data and an error.
 */
+ (MNFJob *)fetchMediaWithId:(NSString *)identifier
                       width:(nullable NSNumber *)width
                      height:(nullable NSNumber *)height
                  completion:(nullable MNFMediaCompletionHandler)completion;

@end

NS_ASSUME_NONNULL_END
