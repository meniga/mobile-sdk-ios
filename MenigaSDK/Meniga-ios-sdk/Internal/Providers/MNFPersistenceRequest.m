//
//  MNFPersistenceRequest.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 19/11/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFPersistenceRequest.h"
#import "Meniga.h"
#import "MNFCryptor.h"

@implementation MNFPersistenceRequest


-(instancetype)initWithRequest:(NSURLRequest*)request {
    self = [super init];
    if (self) {
        _request = [[self class] stringFromRequest:request];
        _data = [[self class] dataFromRequest:request];
        _key = [[self class] keyFromRequest:request];
    }
    return self;
}

+(NSString*)stringFromRequest:(NSURLRequest*)request {
    NSString *requestURL = request.URL.absoluteString;
    NSArray *apiSplitArray = [requestURL componentsSeparatedByString:@"Api/"];
    if (apiSplitArray == nil || [apiSplitArray count] == 0 || [apiSplitArray count] == 1) {
        return nil;
    }
    NSArray *paramSplitArray = [[apiSplitArray objectAtIndex:1] componentsSeparatedByString:@"/"];
    if ([paramSplitArray count] == 1) {
        return [paramSplitArray objectAtIndex:0];
    }
    else {
        return [paramSplitArray objectAtIndex:1];
    }
}
+(id)dataFromRequest:(NSURLRequest*)request {
    NSData *data = [request HTTPBody];
    if (data == nil) return nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    /*
    if ([Meniga localEncryptionPolicy] && ![request.URL.path containsString:@"Get"]) {
        
        if ([jsonObject isKindOfClass:[NSDictionary class]]) {
            return [self p_encryptJSONDictionary:jsonObject withRequest:request];
        }
        else if ([jsonObject isKindOfClass:[NSArray class]]) {
            return [self p_encryptJSONArray:jsonObject withRequest:request];
        }
        else if ([jsonObject isKindOfClass:[NSString class]]) {
            return [self p_encryptJSONString:jsonObject withRequest:request];
        }
        return nil;
    }*/
    
    NSLog(@"Persistence request data: %@",jsonObject);
    return jsonObject;
}
+(NSNumber*)keyFromRequest:(NSURLRequest*)request {
    NSData *data = [request HTTPBody];
    if (data == nil) return nil;
    id dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSNumber *key = nil;
    if ([dict isKindOfClass:[NSDictionary class]]) {
        key = [dict objectForKey:@"id"];
        if (key == nil) {
            NSArray *array = [dict allValues];
            if ([[array objectAtIndex:0] isKindOfClass:[NSDictionary class]]) {
                key = [[array objectAtIndex:0] objectForKey:@"id"];
            }
            else {
                key = [dict objectForKey:@"Id"];
            }
        }
        if (key == nil) key = [dict objectForKey:@"Id"];
        if (key == nil) key = [dict objectForKey:@"accountId"];
        if (key == nil) key = [dict objectForKey:@"tagId"];
        if (key == nil) key = [dict objectForKey:@"transactionId"];
        if (key == nil) key = [dict objectForKey:@"offerId"];
    }
    
    return key;
}

+(NSDictionary*)p_encryptJSONDictionary:(NSDictionary*)dict withRequest:(NSURLRequest*)request {
    NSString *serviceKey = nil;
    if ([request.URL.path containsString:@"Transaction"]) {
        serviceKey = @"Transaction";
    }
    else if ([request.URL.path containsString:@"Profile"]) {
        serviceKey = @"Profile";
    }
    else if ([request.URL.path containsString:@"Offer"]) {
        serviceKey = @"Offer";
    }
    else if ([request.URL.path containsString:@"Categor"]) {
        serviceKey = @"Category";
    }
    else if ([request.URL.path containsString:@"Feed"]) {
        serviceKey = @"Feed";
    }
    else if ([request.URL.path containsString:@"Account"]) {
        serviceKey = @"Account";
    }
    
    if (serviceKey != nil) {
        NSMutableDictionary *tempDict = [dict mutableCopy];
        for (NSString *key in dict) {
            id object = [dict objectForKey:key];
            NSData *dataToEncrypt = [NSJSONSerialization dataWithJSONObject:@{@"object":object} options:0 error:nil];
            if (![key isEqualToString:@"id"] || ![key isEqualToString:@"Id"] || ![key isEqualToString:@"accountId"] || ![key isEqualToString:@"categoryId"] || ![key isEqualToString:@"tagId"] || ![key isEqualToString:@"transactionId"] || ![key isEqualToString:@"offerId"]) {
                NSData *encryptedData = [MNFCryptor encryptData:dataToEncrypt forKey:serviceKey];
                [tempDict setObject:encryptedData forKey:key];
            }
        }
        NSLog(@"Persistence request encrypted data: %@",tempDict);
        return [tempDict copy];
    }
    return nil;
}
+(NSArray*)p_encryptJSONArray:(NSArray*)array withRequest:(NSURLRequest*)request {
    NSMutableArray *newArray = [NSMutableArray array];
    for (NSDictionary *dictionary in array) {
        NSDictionary *encryptedDict = [self p_encryptJSONDictionary:dictionary withRequest:request];
        [newArray addObject:encryptedDict];
    }
    return [newArray copy];
}
+(NSData*)p_encryptJSONString:(NSString*)string withRequest:(NSURLRequest*)request {
    NSString *serviceKey = nil;
    if ([request.URL.path containsString:@"Transaction"]) {
        serviceKey = @"Transaction";
    }
    else if ([request.URL.path containsString:@"Profile"]) {
        serviceKey = @"Profile";
    }
    else if ([request.URL.path containsString:@"Offer"]) {
        serviceKey = @"Offer";
    }
    else if ([request.URL.path containsString:@"Categor"]) {
        serviceKey = @"Category";
    }
    else if ([request.URL.path containsString:@"Feed"]) {
        serviceKey = @"Feed";
    }
    else if ([request.URL.path containsString:@"Account"]) {
        serviceKey = @"Account";
    }
    
    if (serviceKey != nil) {
        NSData *dataToEncrypt = [string dataUsingEncoding:NSUTF8StringEncoding];
        NSData *encryptedData = [MNFCryptor encryptData:dataToEncrypt forKey:serviceKey];
        return encryptedData;
    }
    return nil;
}

-(void)decryptData {
    NSString *serviceKey = nil;
    if ([self.request containsString:@"Transaction"]) {
        serviceKey = @"Transaction";
    }
    else if ([self.request containsString:@"Profile"]) {
        serviceKey = @"Profile";
    }
    else if ([self.request containsString:@"Offer"]) {
        serviceKey = @"Offer";
    }
    else if ([self.request containsString:@"Categor"]) {
        serviceKey = @"Category";
    }
    else if ([self.request containsString:@"Feed"]) {
        serviceKey = @"Feed";
    }
    else if ([self.request containsString:@"Account"]) {
        serviceKey = @"Account";
    }
    
    if (serviceKey != nil) {
        NSMutableDictionary *tempDict = [self.data mutableCopy];
        for (NSString *key in self.data) {
            if (![key isEqualToString:@"id"]) {
                NSData *dataToDecrypt = [self.data objectForKey:key];
                NSData *decryptedData = [MNFCryptor decryptData:dataToDecrypt forKey:serviceKey];
                NSDictionary *object = [NSJSONSerialization JSONObjectWithData:decryptedData options:0 error:nil];
                //NSString *decryptedString = [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];
                [tempDict setObject:[object objectForKey:@"object"] forKey:key];
            }
        }
        NSLog(@"Persistence request decrypted data: %@",tempDict);
        _request = [tempDict copy];
    }
}

@end
