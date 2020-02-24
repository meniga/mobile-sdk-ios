//
//  MNFScheduledEvent.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 6/10/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFScheduledEvent.h"
#import "MNFInternalImports.h"
#import "MNFTransactionDayOverview.h"

@interface MNFScheduledEvent () <MNFJsonAdapterDelegate>

@end

@implementation MNFScheduledEvent

+ (MNFJob*)fetchWithId:(NSNumber *)identifier completion:(MNFScheduledEventCompletionHandler)completion {
    [completion copy];
    
    NSString *path = [NSString stringWithFormat:@"%@/%@",kMNFFeedUserEvents,identifier];
    
    __block MNFJob *job = [MNFObject apiRequestWithPath:path pathQuery:nil jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameFeed completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
            if ([response.result isKindOfClass:[NSDictionary class]]) {
                
                MNFScheduledEvent *event = [MNFScheduledEvent initWithServerResult:response.result];
                
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:event error:nil];
                
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

- (MNFJob*)refreshWithCompletion:(MNFErrorOnlyCompletionHandler)completion {
    [completion copy];
    
    NSString *path = [NSString stringWithFormat:@"%@/%@", kMNFFeedUserEvents, [self.identifier stringValue]];
    
    __block MNFJob *job = [[self class] apiRequestWithPath:path pathQuery:nil jsonBody:nil HTTPMethod:kMNFHTTPMethodGET service:MNFServiceNameAccounts completion:^(MNFResponse*  _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
            
            if ([response.result isKindOfClass:[NSDictionary class]]) {
                
                [MNFJsonAdapter refreshObject:self withJsonDict:response.result option:kMNFAdapterOptionNoOption error:nil];
                [MNFObject executeOnMainThreadWithJob:job completion:completion error: nil];
                
            }
            else {
                
                [MNFObject executeOnMainThreadWithJob:job completion:completion error: [MNFErrorUtils errorForUnexpectedDataOfType:[response.result class] expected:[NSDictionary class]] ];
                
            }
        }
        else {
            
            [MNFObject executeOnMainThreadWithJob:job completion:completion error: response.error];
            
        }
    }];
    
    return job;
}

#pragma mark - Json Adapter delegate

-(NSDictionary *)propertyKeysMapToJson {
    return @{ @"identifier" : @"id" };
}

-(NSDictionary *)jsonKeysMapToProperties {
    return @{ @"identifier" : @"id" };
}

-(NSSet *)propertiesToIgnoreJsonDeserialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

-(NSDictionary *)propertyValueTransformers {
    return  @{ @"date" : [MNFBasicDateValueTransformer transformer], @"startDate" : [MNFBasicDateValueTransformer transformer], @"endDate" : [MNFBasicDateValueTransformer transformer] };
}

-(NSDictionary <NSString *, MNFJsonAdapterSubclassedProperty *> *)subclassedProperties {
    
    return @{
             @"transactionsPerDay" : [MNFJsonAdapterSubclassedProperty subclassedPropertyWithClass: [MNFTransactionDayOverview class] option: kMNFAdapterOptionNoOption]
             };
}

@end
