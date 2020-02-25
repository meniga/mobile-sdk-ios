//
//  MNFDemoUser.h
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 4/19/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFObject.h"
#import "MNFObject_Private.h"

NS_ASSUME_NONNULL_BEGIN

@interface MNFDemoUser : MNFObject

+ (void)fetchDemoProfileIdsWithCompletion:(void (^)(NSArray<NSDictionary *> *_Nullable listOfIds,
                                                    NSError *_Nullable error))completion;
+ (void)createDemoUserWithEmail:(nullable NSString *)theEmail
                       password:(nullable NSString *)thePassword
                        culture:(nullable NSString *)theCulture
                  demoProfileId:(NSNumber *)theDemoProfileId
                     completion:(void (^)(NSError *_Nullable error))completion;
+ (void)createRandomDemoUserWithCompletion:(void (^)(NSError *_Nullable error))completion;
+ (void)createRandomUserAndLoginWithCompletion:(void (^)(NSError *_Nullable error))completion;

+ (NSString *)email;
+ (NSString *)password;
+ (NSDictionary *)tokenDictionary;

@end

NS_ASSUME_NONNULL_END