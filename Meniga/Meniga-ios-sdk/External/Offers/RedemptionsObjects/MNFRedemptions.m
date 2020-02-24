//
//  MNFRedemptions.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 5/17/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFRedemptions.h"
#import "MNFOfferTransaction.h"
#import "MNFInternalImports.h"
#import "MNFBasicDateValueTransformer.h"
#import "MNFJsonAdapter.h"

@interface MNFScheduledReimbursement () <MNFJsonAdapterDelegate>

@end

@implementation MNFScheduledReimbursement

-(NSDictionary *)propertyValueTransformers {
    return @{
      @"date" : [MNFBasicDateValueTransformer transformer]
      };
}

@end

@interface MNFRedemptionsMetaData () <MNFJsonAdapterDelegate>

@end

@implementation MNFRedemptionsMetaData

-(NSDictionary <NSString *, MNFJsonAdapterSubclassedProperty *> *)subclassedProperties {
    return @{
             @"scheduledReimbursements" : [MNFJsonAdapterSubclassedProperty subclassedPropertyWithClass: [MNFScheduledReimbursement class] option: kMNFAdapterOptionNoOption]
             };
}

@end

@interface MNFRedemptions () <MNFJsonAdapterDelegate>

@end

@implementation MNFRedemptions

+(MNFJob *)fetchRedemptionsFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate skip:(NSNumber *)skip take:(NSNumber *)take completion:(nonnull MNFRedemptionsCompletionHandler)completion {
    
    NSString *path = [NSString stringWithFormat:@"%@", kMNFApiPathRedemptions];
    
    NSMutableDictionary *queryDict = [NSMutableDictionary dictionary];
    
    MNFBasicDateValueTransformer *transformer = [MNFBasicDateValueTransformer transformer];
    
    if (fromDate != nil) {
        [queryDict setObject: [transformer reverseTransformedValue: fromDate] forKey: @"dateFrom"];
    }
    
    if (toDate != nil) {
        [queryDict setObject: [transformer reverseTransformedValue: toDate] forKey: @"dateTo"];
    }
    
    if (skip != nil) {
        [queryDict setObject: skip forKey: @"skip"];
    }
    
    if (take != nil) {
        [queryDict setObject: take forKey: @"take"];
    }
    
    __block MNFJob *job = [MNFObject apiRequestWithPath: path pathQuery: nil jsonBody: nil HTTPMethod: kMNFHTTPMethodGET service: MNFServiceNameOffers completion:^(MNFResponse *response) {
       
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
            
            if ([response.result isKindOfClass:[NSArray class]] == YES && [response.metaData isKindOfClass:[NSDictionary class]] == YES) {
                
                NSArray <MNFOfferTransaction *> *offerTransactions = [MNFOfferTransaction initWithServerResults:response.result];
                MNFRedemptionsMetaData *metaData = [MNFRedemptionsMetaData initWithServerResult:response.metaData];
                
                [MNFObject executeOnMainThreadWithJob: job completion: completion resultParameter: offerTransactions metaDataParm: metaData error: nil];
            }
            else {
                
                if ([response.result isKindOfClass:[NSArray class]] == NO) {
                    
                    [MNFObject executeOnMainThreadWithJob:job completion: completion resultParameter:nil metaDataParm:nil error:[MNFErrorUtils errorForUnexpectedDataOfType:[response.result class] expected:[NSArray class]]];
                }
                else if([response.metaData isKindOfClass:[NSDictionary class]] == NO) {
                    
                    [MNFObject executeOnMainThreadWithJob:job completion: completion resultParameter:nil metaDataParm:nil error:[MNFErrorUtils errorForUnexpectedDataOfType:[response.metaData class] expected:[NSDictionary class]]];
                }
                
            }
            
        }
        else {
            [MNFObject executeOnMainThreadWithJob:job completion: completion resultParameter:nil metaDataParm:nil error:response.error];
        }

        
        
    }];
    
    return job;
}


#pragma mark - Json Adatper

-(NSDictionary *)jsonKeysMapToProperties {
    return @{ @"identifier" : @"id" };
}

-(NSDictionary *)propertyKeysMapToJson {
    return @{ @"identifier" : @"id" };
}


@end

