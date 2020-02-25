//
//  MNFNetworthHistory.m
//  Meniga-ios-sdk
//
//  Created by Aske Bendtsen on 30/03/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFNetworthBalanceHistory.h"
#import "MNFBasicDateValueTransformer.h"
#import "MNFInternalImports.h"
#import "MNFLogger.h"
#import "MNFObject_private.h"

@implementation MNFNetworthBalanceHistory

#pragma mark - saving

- (MNFJob *)saveWithCompletion:(MNFErrorOnlyCompletionHandler)completion {
    NSString *path = [NSString stringWithFormat:@"%@/%@", kMNFAPIPathNetworth, self.identifier];

    NSData *jsonData = [MNFJsonAdapter JSONDataFromObject:self option:kMNFAdapterOptionNoOption error:nil];

    __block MNFJob *job = [self updateWithApiPath:path
                                        pathQuery:nil
                                         jsonBody:jsonData
                                       httpMethod:kMNFHTTPMethodPUT
                                          service:MNFServiceNameNetWorth
                                       completion:^(MNFResponse *_Nullable response) {
                                           kObjectBlockDataDebugLog;
                                           [MNFObject executeOnMainThreadWithJob:job
                                                                      completion:completion
                                                                           error:response.error];
                                       }];

    return job;
}

#pragma mark - deleting

- (MNFJob *)deleteWithCompletion:(MNFErrorOnlyCompletionHandler)completion {
    NSString *path = [NSString stringWithFormat:@"%@/%@", kMNFAPIPathNetworth, self.identifier];

    __block MNFJob *job = [self updateWithApiPath:path
                                        pathQuery:nil
                                         jsonBody:nil
                                       httpMethod:kMNFHTTPMethodDELETE
                                          service:MNFServiceNameNetWorth
                                       completion:^(MNFResponse *_Nullable response) {
                                           kObjectBlockDataDebugLog;
                                           [MNFObject executeOnMainThreadWithJob:job
                                                                      completion:completion
                                                                           error:response.error];
                                       }];

    return job;
}

#pragma mark - Description
- (NSString *)description {
    return [NSString
        stringWithFormat:
            @"Networth balance history %@ identifier: %@, accountId: %@, balance: %@, balanceDate: %@, isDefault: %@",
            [super description],
            self.identifier,
            self.accountId,
            self.balance,
            self.balanceDate,
            self.isDefault];
}

#pragma mark - json delegate

- (NSSet *)propertiesToSerialize {
    return [NSSet setWithArray:@[@"balance", @"balanceDate"]];
}

- (NSDictionary *)propertyKeysMapToJson {
    return @{ @"identifier": @"id" };
}

- (NSDictionary *)jsonKeysMapToProperties {
    return @{ @"identifier": @"id" };
}

- (NSDictionary *)propertyValueTransformers {
    return @{ @"balanceDate": [MNFBasicDateValueTransformer transformer] };
}

- (NSSet *)propertiesToIgnoreJsonDeserialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

- (NSSet *)propertiesToIgnoreJsonSerialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

@end
