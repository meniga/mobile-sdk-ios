//
//  MNFOffer.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 4/27/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFOffer.h"
#import "MNFSimilarBrand.h"
#import "MNFOfferTransaction.h"
#import "MNFInternalImports.h"
#import "MNFBasicDateValueTransformer.h"
#import "MNFObjectUpdater.h"

@interface MNFOffer () <MNFJsonAdapterDelegate>

@end

@implementation MNFOffer

+(MNFJob *)fetchWithId:(NSNumber *)identifier completion:(MNFOfferCompletionHandler)completion {
    [completion copy];
    
    NSString *path = [NSString stringWithFormat:@"%@/%@", kMNFApiPathOffers, identifier];
    
    
    __block MNFJob *job = [MNFObject apiRequestWithPath:path pathQuery:nil jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameOffers completion:^(MNFResponse *response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
            if ([response.result isKindOfClass:[NSDictionary class]] == YES) {
                
                MNFOffer *offer = [MNFOffer initWithServerResult:response.result];
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:offer error:nil];
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

+(MNFJob*)fetchWithToken:(NSString *)theToken completion:(MNFOfferCompletionHandler)completion {
    [completion copy];
    
    NSString *path = [NSString stringWithFormat:@"%@/%@", kMNFApiPathOffers, theToken];
    
    __block MNFJob *job = [MNFObject apiRequestWithPath:path pathQuery:nil jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameOffers completion:^(MNFResponse *response) {
        
        kObjectBlockDataDebugLog;
        
        if(response.error == nil) {
            
            if ([response.result isKindOfClass:[NSDictionary class]] == YES) {
                
                MNFOffer *offer = [MNFOffer initWithServerResult:response.result];
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:offer error:nil];
            }
            else {
                
                NSError *error = [MNFErrorUtils errorForUnexpectedDataOfType:[response.result class] expected:[NSDictionary class]];
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error:error];
            }
        }
        else {
            
            [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error:response.error];
        }
        
    }];
    
    return job;
}

+(MNFJob *)fetchOffersWithFilter:(MNFOfferFilter *)offerFilter take:(NSNumber *)take skip:(NSNumber *)skip completion:(MNFMultipleOffersCompletionHandler)completion {
    [completion copy];
    
    NSMutableDictionary *queryDict = [NSMutableDictionary dictionary];
    
    if (offerFilter != nil) {
        NSDictionary *filterDict = [MNFJsonAdapter JSONDictFromObject: offerFilter option:0 error:nil];
        if (filterDict != nil) {
            [queryDict setDictionary:filterDict];
        }
    }
    
    if (take != nil) {
        queryDict[@"take"] = take;
    }
    else {
        queryDict[@"take"] = [NSNumber numberWithInt:20];
    }
    
    if (skip != nil) {
        queryDict[@"skip"] = skip;
    }
    else {
        queryDict[@"skip"] = @0;
    }
    
    NSString *path = [NSString stringWithFormat:@"%@", kMNFApiPathOffers];
    
    __block MNFJob *job = [MNFObject apiRequestWithPath:path pathQuery:queryDict jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameOffers completion:^(MNFResponse *response) {
        
        kObjectBlockDataDebugLog;
        
        
        if (response.error == nil) {
            
            if ([response.result isKindOfClass:[NSArray class]] == YES) {
                
                NSArray *offers = [MNFOffer initWithServerResults:response.result];
                
                [MNFObject executeOnMainThreadWithJob: job completion: completion resultParameter: offers metaDataParm: response.metaData error: response.error];
            
            }
            else {
        
                
                [MNFObject executeOnMainThreadWithJob: job completion: completion resultParameter: response.result metaDataParm: response.metaData error: [MNFErrorUtils errorForUnexpectedDataOfType:[response.result class] expected:[NSArray class]] ];
            
            }
            
        }
        else {
                        
            
            [MNFObject executeOnMainThreadWithJob: job completion: completion resultParameter: response.result metaDataParm: response.metaData error: response.error];
        
        }
        
    }];
    
    return job;
}

+(MNFJob*)activateOfferWithToken:(NSString *)theToken completion:(MNFErrorOnlyCompletionHandler)completion {
    [completion copy];
    
    NSString *path = [NSString stringWithFormat:@"%@/%@/activate", kMNFApiPathOffers, theToken];
    
    __block MNFJob *job = [MNFObject apiRequestWithPath:path pathQuery:nil jsonBody:nil HTTPMethod:kMNFHTTPMethodPOST service:MNFServiceNameOffers completion:^(MNFResponse *response) {
        
        kObjectBlockDataDebugLog;
        
        [MNFObject executeOnMainThreadWithJob:job completion:completion error:response.error];
        
    }];
    
    return job;
}

+(MNFJob *)enableOffers:(BOOL)enable completion:(MNFErrorOnlyCompletionHandler)completion {
    [completion copy];
    
    NSString *path = [NSString stringWithFormat:@"%@/enable", kMNFApiPathOffers];
    
    NSString *method = nil;
    if (enable == YES) {
        method = kMNFHTTPMethodPOST;
    }
    else {
        method = kMNFHTTPMethodDELETE;
    }
    
    __block MNFJob *job = [MNFObject apiRequestWithPath:path pathQuery:nil jsonBody:nil HTTPMethod:method service:MNFServiceNameOffers completion:^(MNFResponse *response) {
        
        kObjectBlockDataDebugLog;
        
        [MNFObject executeOnMainThreadWithJob:job completion:completion error:response.error];
        
    }];
    
    return job;
}

+(MNFJob *)acceptOffersTermsAndConditionsWithCompletion:(MNFErrorOnlyCompletionHandler)completion {
    
    NSString *path = [NSString stringWithFormat:@"%@/acceptTermsAndConditions", kMNFApiPathOffers];
    
    __block MNFJob *job = [MNFObject apiRequestWithPath:path pathQuery:nil jsonBody:nil HTTPMethod:kMNFHTTPMethodPOST service:MNFServiceNameOffers completion:^(MNFResponse *response) {
    
        kObjectBlockDataDebugLog;
        
        [MNFObject executeOnMainThreadWithJob:job completion:completion error:response.error];
    
    }];
    
    return job;
}

#pragma mark Instance methods


-(MNFJob *)fetchSimilarBrandSpendingWithCompletion:(MNFOfferSimilarBrandSpendingCompletionHandler)completion {
    [completion copy];
    
    NSString *path = [NSString stringWithFormat:@"%@/%@/similarBrandSpending", kMNFApiPathOffers, self.identifier];
    
    __block MNFJob *job = [MNFObject apiRequestWithPath:path pathQuery:nil jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameOffers completion:^(MNFResponse *response) {
        
        kObjectBlockDataDebugLog;
                
        if (response.error == nil) {
            if ([response.result isKindOfClass:[NSArray class]] == YES && [response.metaData isKindOfClass:[NSDictionary class]] == YES) {
                
                NSArray <MNFSimilarBrand *> *similarBrands = [MNFSimilarBrand initWithServerResults:response.result];
                MNFSimilarBrandMetaData *metaData = [MNFSimilarBrandMetaData initWithServerResult:response.metaData];
                [MNFObject executeOnMainThreadWithJob:job completion:completion resultParameter:similarBrands metaDataParm:metaData error:nil];
                
            }
            else {
                
                if ([response.result isKindOfClass:[NSArray class]] == NO) {
                    [MNFObject executeOnMainThreadWithJob:job completion:completion resultParameter:nil metaDataParm:nil error:[MNFErrorUtils errorForUnexpectedDataOfType:[response.result class] expected:[NSArray class]]];
                }
                else if([response.metaData isKindOfClass:[NSDictionary class]] == NO) {
                    [MNFObject executeOnMainThreadWithJob:job completion:completion resultParameter:nil metaDataParm:nil error:[MNFErrorUtils errorForUnexpectedDataOfType:[response.metaData class] expected:[NSDictionary class]]];
                }
                
            }
        }
        else {

            [MNFObject executeOnMainThreadWithJob:job completion:completion resultParameter:nil metaDataParm:nil error:response.error];
        }
        
    }];
    
    return job;
}



-(MNFJob *)fetchRedeemedTransactionsWithCompletion:(MNFMultipleOfferTransactionsCompletionHandler)completion {
    
    NSString *path = [NSString stringWithFormat:@"%@/%@/redemptions", kMNFApiPathOffers, self.identifier];
    
    __block MNFJob *job = [MNFObject apiRequestWithPath:path pathQuery:nil jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameOffers completion:^(MNFResponse *response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
            
            if ([response.result isKindOfClass:[NSArray class]] == YES) {
                NSArray <MNFOfferTransaction *> *offerTransactions = [MNFOfferTransaction initWithServerResults:response.result];
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:offerTransactions error:nil];
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

-(MNFJob *)activateOffer:(BOOL)activate completion:(MNFErrorOnlyCompletionHandler)completion {
    
    NSString *path = [NSString stringWithFormat:@"%@/%@/activate", kMNFApiPathOffers, self.identifier];
    
    NSString *method = nil;
    
    if (activate == YES) {
        method = kMNFHTTPMethodPOST;
    }
    else {
        method = kMNFHTTPMethodDELETE;
    }
    
    __block MNFJob *job = [MNFObject apiRequestWithPath:path pathQuery:nil jsonBody:nil HTTPMethod:method service:MNFServiceNameOffers completion:^(MNFResponse *response) {
        
        kObjectBlockDataDebugLog;
        
        [MNFObject executeOnMainThreadWithJob:job completion:completion error:response.error];
    
    }];
    
    return job;

}

-(MNFJob *)markAsSeenWithCompletion:(MNFErrorOnlyCompletionHandler)completion {
    
    MNFJob *job = [self p_markAsSeenWithCompletino:completion];
    
    return job;
}

-(MNFJob *)p_markAsSeenWithCompletino:(MNFErrorOnlyCompletionHandler)completion {
    
    NSString *path = [NSString stringWithFormat:@"%@/%@/seen", kMNFApiPathOffers, self.identifier];
    
    __block MNFJob *job = [[self class] apiRequestWithPath:path pathQuery:nil jsonBody:nil HTTPMethod:kMNFHTTPMethodPOST service:MNFServiceNameOffers completion:^(MNFResponse *response) {
        
        [MNFObject executeOnMainThreadWithJob:job completion:completion error:response.error];
        
    }];
    
    
    return job;
}

-(MNFJob *)refreshWithCompletion:(MNFErrorOnlyCompletionHandler)completion {
    [completion copy];
    
    MNFJob *job = [MNFOffer fetchWithId: self.identifier completion:^(MNFOffer *offer, NSError *error) {
        
        if (error == nil) {
            [MNFObjectUpdater updateMNFObject: self withMNFObject: offer];
        }
        
        completion( error );
        
        
    }];
    
    return job;
}

#pragma mark - Json Adapter Delegate

-(NSDictionary *)jsonKeysMapToProperties {
    return @{ @"identifier" : @"id", @"offerDescription"  : @"description" };
}

-(NSDictionary *)propertyKeysMapToJson {
    return @{ @"identifier" : @"id", @"offerDescription" : @"description" };
}

-(NSDictionary *)propertyValueTransformers {
    return @{
              @"lastReimbursementDate" : [MNFBasicDateValueTransformer transformer],
              @"scheduledReimbursementDate" : [MNFBasicDateValueTransformer transformer],
              @"validFrom" : [MNFBasicDateValueTransformer transformer],
              @"validTo" : [MNFBasicDateValueTransformer transformer],
              @"activatedDate" : [MNFBasicDateValueTransformer transformer],
              @"declineDate" : [MNFBasicDateValueTransformer transformer]
              };
}

-(NSDictionary <NSString *, MNFJsonAdapterSubclassedProperty *> *)subclassedProperties {
    
    return  @{ @"relevanceHook" : [MNFJsonAdapterSubclassedProperty subclassedPropertyWithClass: [MNFOfferRelevanceHook class] option: kMNFAdapterOptionNoOption],
               @"merchantLocations" : [MNFJsonAdapterSubclassedProperty subclassedPropertyWithClass: [MNFMerchantLocation class] option: kMNFAdapterOptionNoOption]};
}

@end
