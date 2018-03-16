//
//  MNFPeerComparison.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 15/03/2018.
//  Copyright © 2018 Meniga. All rights reserved.
//

#import "MNFPeerComparison.h"
#import "MNFInternalImports.h"

@implementation MNFPeerComparison

+(MNFJob*)fetchPeerComparisonWithCategoryIds:(NSString *)categoryIds excludeUser:(NSNumber *)excludeUser previousMonths:(NSNumber *)previousMonths groupCategories:(NSNumber *)groupCategories segmentBy:(NSNumber *)segmentBy completion:(MNFPeerComparisonCompletionHandler)completion {
    [completion copy];
    
    MNFNumberToBoolValueTransformer *transformer = [MNFNumberToBoolValueTransformer transformer];
    NSMutableDictionary *jsonQuery = [NSMutableDictionary dictionary];
    jsonQuery[@"categoryIds"] = categoryIds;
    jsonQuery[@"excludeUser"] = [transformer reverseTransformedValue:excludeUser];
    jsonQuery[@"previousMonths"] = previousMonths;
    jsonQuery[@"groupCategories"] = [transformer reverseTransformedValue:groupCategories];
    jsonQuery[@"segmentBy"] = segmentBy;
    
    __block MNFJob *job = [self apiRequestWithPath:kMNFApiPathPeerComparison pathQuery:[jsonQuery copy] jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNamePeerComparison completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
            if ([response.result isKindOfClass:[NSArray class]]) {
                
                NSArray *peerComparison = [MNFPeerComparison initWithServerResults:response.result];
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:peerComparison error:nil];
                
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

+(MNFJob*)fetchTopMerchantsWithLimit:(NSNumber *)limit rankBy:(NSNumber *)rankBy excludeUser:(NSNumber *)excludeUser categoryIds:(NSString *)categoryIds previousMonths:(NSNumber *)previousMonths groupCategories:(NSNumber *)groupCategories segmentBy:(NSNumber *)segmentBy completion:(MNFPeerComparisonCompletionHandler)completion {
    [completion copy];
    
    MNFNumberToBoolValueTransformer *transformer = [MNFNumberToBoolValueTransformer transformer];
    NSMutableDictionary *jsonQuery = [NSMutableDictionary dictionary];
    jsonQuery[@"request.limit"] = limit;
    jsonQuery[@"request.rankBy"] = rankBy;
    jsonQuery[@"request.categoryIds"] = categoryIds;
    jsonQuery[@"request.excludeUser"] = [transformer reverseTransformedValue:excludeUser];
    jsonQuery[@"request.previousMonths"] = previousMonths;
    jsonQuery[@"request.groupCategories"] = [transformer reverseTransformedValue:groupCategories];
    jsonQuery[@"request.segmentBy"] = segmentBy;
    
    __block MNFJob *job = [self apiRequestWithPath:kMNFPeerComparisonTopMerchants pathQuery:[jsonQuery copy] jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNamePeerComparison completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
            if ([response.result isKindOfClass:[NSArray class]]) {
                
                NSArray *peerComparison = [MNFPeerComparison initWithServerResults:response.result];
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:peerComparison error:nil];
                
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

#pragma mark - json adaptor delegate methods
-(NSDictionary*)subclassedProperties {
    return @{
             @"user": [MNFJsonAdapterSubclassedProperty subclassedPropertyWithClass: [MNFPeerComparisonStats class] option: kMNFAdapterOptionNoOption],
             @"community": [MNFJsonAdapterSubclassedProperty subclassedPropertyWithClass: [MNFPeerComparisonStats class] option: kMNFAdapterOptionNoOption],
             @"userMerchants": [MNFJsonAdapterSubclassedProperty subclassedPropertyWithClass: [MNFPeerComparisonMerchants class] option: kMNFAdapterOptionNoOption],
             @"communityMerchants": [MNFJsonAdapterSubclassedProperty subclassedPropertyWithClass: [MNFPeerComparisonMerchants class] option: kMNFAdapterOptionNoOption]
             };
}

@end
