//
//  MNFMerchant.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 07/04/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFMerchant.h"
#import "MNFMerchantAddress.h"
#import "MNFCategoryScore.h"
#import "MNFURLRequestConstants.h"
#import "MNFHTTPMethods.h"
#import "MNFObject_Private.h"
#import "MNFLogger.h"
#import "MNFResponse.h"

@implementation MNFMerchant

+(MNFJob *)fetchWithId:(NSNumber *)identifier completion:(MNFMerchantCompletionHandler)completion {
    
    NSString *path = [NSString stringWithFormat:@"%@/%@",kMNFApiPathMerchants,[identifier stringValue]];
    
    __block MNFJob *job = [self apiRequestWithPath:path pathQuery:nil jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameMerchants completion:^(MNFResponse * _Nullable response) {
        kObjectBlockDataDebugLog;
        if (response.error == nil) {
            if ([response.result isKindOfClass:[NSDictionary class]]) {
                MNFMerchant *merchant = [self initWithServerResult:response.result];
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:merchant error:nil];
            }
            else {
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error:[MNFErrorUtils errorForUnexpectedDataOfType:[response.result class] expected:[NSDictionary class]]];
                
            }
        }
        else {
            
            [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error:response.error];
        }
    }];
    
    return job;
}

+(MNFJob *)fetchMerchantsWithIds:(NSArray <NSNumber*>*)identifiers completion:(MNFMultipleMerchantsCompletionHandler)completion {
    
    NSArray *distinctIdentifiers = [identifiers valueForKeyPath:@"@distinctUnionOfObjects.self"];
    NSString *merchantIds = [distinctIdentifiers componentsJoinedByString:@","];
    
    NSDictionary *jsonQuery = @{@"merchantIds":merchantIds};
    
    __block MNFJob *job = [self apiRequestWithPath:kMNFApiPathMerchants pathQuery:jsonQuery jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameMerchants completion:^(MNFResponse * _Nullable response) {
        kObjectBlockDataDebugLog;
        if (response.error == nil) {
            if ([response.result isKindOfClass:[NSArray class]]) {
                NSArray *merchants = [self initWithServerResults:response.result];
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:merchants error:nil];
            }
            else {
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error:[MNFErrorUtils errorForUnexpectedDataOfType:[response.result class] expected:[NSArray class]]];
                
            }
        }
        else {
            
            [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error:response.error];
        }
    }];
    
    return job;
}

#pragma mark - Description
-(NSString*)description {
    return [NSString stringWithFormat:@"Merchant %@ identifier: %@, address: %@, categoryScores: %@, childMerchants: %@, detectedCategory: %@, directoryLink: %@, email: %@, merchantIdentifier: %@, masterIdentifier: %@, merchantCategoryIdentifier: %@, name: %@, offersLink: %@, parentId: %@, parentMerchant: %@, parentName: %@, publicIdentifier: %@, telephone: %@, webpage: %@",[super description],self.identifier,self.address,self.categoryScores,self.childMerchants,self.detectedCategory,self.directoryLink,self.email,self.merchantIdentifier,self.masterIdentifier,self.merchantCategoryIdentifier,self.name,self.offersLink,self.parentId,self.parentMerchant,self.parentName,self.publicIdentifier,self.telephone,self.webpage];
}

#pragma mark - json adapter delegates

-(NSDictionary *)jsonKeysMapToProperties {
    return @{@"identifier":@"id",
             @"merchantIdentifier":@"identifier"};
}
-(NSDictionary *)propertyKeysMapToJson {
    return @{@"identifier":@"id"};
}
-(NSDictionary <NSString *, MNFJsonAdapterSubclassedProperty *> *)subclassedProperties {
    return @{
             @"address": [MNFJsonAdapterSubclassedProperty subclassedPropertyWithClass: [MNFMerchantAddress class] option: kMNFAdapterOptionNoOption],
             @"childMerchants": [MNFJsonAdapterSubclassedProperty subclassedPropertyWithClass: [MNFMerchant class] option: kMNFAdapterOptionNoOption],
             @"categoryScores": [MNFJsonAdapterSubclassedProperty subclassedPropertyWithClass: [MNFCategoryScore class] option: kMNFAdapterOptionNoOption],
             @"detectedCategory": [MNFJsonAdapterSubclassedProperty subclassedPropertyWithClass: [MNFCategoryScore class] option: kMNFAdapterOptionNoOption],
             @"parentMerchant": [MNFJsonAdapterSubclassedProperty subclassedPropertyWithClass: [MNFMerchant class] option: kMNFAdapterOptionNoOption]
             };
}

-(NSSet *)propertiesToIgnoreJsonDeserialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

-(NSSet *)propertiesToIgnoreJsonSerialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

@end
