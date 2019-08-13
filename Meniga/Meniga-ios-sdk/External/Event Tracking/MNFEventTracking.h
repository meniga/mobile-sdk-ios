//
//  MNFEventTracking.h
//  Meniga-ios-sdk
//
//  Created by Aske Bendtsen on 31/05/2018.
//  Copyright © 2018 Meniga. All rights reserved.
//

#import <MenigaSDK/Meniga.h>

NS_ASSUME_NONNULL_BEGIN

@interface MNFEventTracking : MNFObject

+(MNFJob*)trackEventWithType:(NSString*)type
                       state:(NSString*)state
                  identifier:(nullable NSNumber*)identifier
                       media:(nullable NSString*)media
                  completion:(nullable MNFErrorOnlyCompletionHandler)completion;

@end

NS_ASSUME_NONNULL_END
