//
//  MNFErrorUtils.h
//  Meniga-ios-sdk
//
//  Created by Aske Bendtsen on 01/12/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MNFObject;
@interface MNFErrorUtils : NSObject

+ (NSError *)errorForDeletedObject:(MNFObject *)deletedObject;
+ (NSError *)errorForUnexpectedDataOfType:(Class)returnedClass expected:(Class)expectedClass;
+ (NSError *)errorForNewObject;
+ (NSError *)errorWithCode:(NSInteger)code message:(NSString *)message;
+ (NSError *)errorWithCode:(NSInteger)code message:(NSString *)message errorInfo:(NSDictionary *)errorInf;

@end
