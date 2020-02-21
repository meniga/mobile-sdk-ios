//
//  MNFErrorUtils.m
//  Meniga-ios-sdk
//
//  Created by Aske Bendtsen on 01/12/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFErrorUtils.h"
#import "MNFObject.h"
#import "MNFLogger.h"

@implementation MNFErrorUtils

+(NSError*)errorForDeletedObject:(MNFObject*)deletedObject{
    return [self errorWithCode:kMNFErrorInvalidOperation message:[NSString stringWithFormat:@"Attempts to perform API operations on a deleted object is not allowed. The operation has been cancelled. Please ensure to deallocate local objects which have been deleted remotely. Info:[ class: %@ id: %@ ]", [deletedObject class], deletedObject.identifier]];
}

+(NSError*)errorForUnexpectedDataOfType:(Class)returnedClass expected:(Class)expectedClass {
    return [self errorWithCode:kMNFErrorIncorrectDataFormat message:[NSString stringWithFormat:@"Unexpected response data format. Expected %@, got %@",NSStringFromClass(expectedClass),NSStringFromClass(returnedClass)]];
}

+(NSError*)errorForNewObject {
    return [self errorWithCode:kMNFErrorInvalidOperation message:@"Trying to perform API operations on a directly initialized object is not allowed. Please create the object on the server first before attempting API operations"];
}

+(NSError*)errorWithCode:(NSInteger)code message:(NSString *)message{
    
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    
    if (message != nil) {
        MNFLogError(@"%@",message);
        MNFLogInfo(@"%@",message);
        MNFLogDebug(@"%@",message);
        MNFLogVerbose(@"%@",message);
        [userInfo setObject:message forKey:NSLocalizedDescriptionKey];
    }
    
    return [NSError errorWithDomain:MNFMenigaErrorDomain code:code userInfo: userInfo];
}

+(NSError *)errorWithCode:(NSInteger)code message:(NSString *)message errorInfo:(NSDictionary *)errorInfo {
    
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    
    if (message != nil) {
        MNFLogError(@"%@",message);
        MNFLogInfo(@"%@",message);
        MNFLogDebug(@"%@",message);
        MNFLogVerbose(@"%@",message);
        [userInfo setObject:message forKey:NSLocalizedDescriptionKey];
    }
    
    if (errorInfo != nil) {
        [userInfo setObject:errorInfo forKey:NSUnderlyingErrorKey];
    }
    
    return [NSError errorWithDomain:MNFMenigaErrorDomain code:code userInfo: userInfo];
}

@end
