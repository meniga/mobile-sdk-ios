//
//  MNFChallenge.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 15/11/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFChallenge.h"
#import "MNFCustomChallenge.h"
#import "MNFGlobalChallenge.h"
#import "MNFInternalImports.h"
#import "MNFSpendingChallenge.h"

@interface MNFChallenge ()

@property (nonatomic, strong, readwrite) NSObject<MNFJsonAdapterDelegate> *challengeModel;

@end

@implementation MNFChallenge

- (void)setTitle:(NSString *)title {
    if ([self.type isEqualToString:@"SuggestedSpending"]) {
        MNFLogInfo(@"Can't change properties on a challenge of type 'SuggestedSpending'");
        MNFLogError(@"Can't change properties on a challenge of type 'SuggestedSpending'");
    } else if ([self.type isEqualToString:@"GlobalSpending"]) {
        MNFLogInfo(@"Can't change properties on a challenge of type 'GlobalSpending'");
        MNFLogError(@"Can't change properties on a challenge of type 'GlobalSpending'");
    } else {
        _title = title;
    }
}

- (void)setChallengeDescription:(NSString *)challengeDescription {
    if ([self.type isEqualToString:@"SuggestedSpending"]) {
        MNFLogInfo(@"Can't change properties on a challenge of type 'SuggestedSpending'");
        MNFLogError(@"Can't change properties on a challenge of type 'SuggestedSpending'");
    } else if ([self.type isEqualToString:@"GlobalSpending"]) {
        MNFLogInfo(@"Can't change properties on a challenge of type 'GlobalSpending'");
        MNFLogError(@"Can't change properties on a challenge of type 'GlobalSpending'");
    } else {
        _challengeDescription = challengeDescription;
    }
}

- (void)setStartDate:(NSDate *)startDate {
    if ([self.type isEqualToString:@"SuggestedSpending"]) {
        MNFLogInfo(@"Can't change properties on a challenge of type 'SuggestedSpending'");
        MNFLogError(@"Can't change properties on a challenge of type 'SuggestedSpending'");
    } else if ([self.type isEqualToString:@"GlobalSpending"]) {
        MNFLogInfo(@"Can't change properties on a challenge of type 'GlobalSpending'");
        MNFLogError(@"Can't change properties on a challenge of type 'GlobalSpending'");
    } else {
        _startDate = startDate;
    }
}

- (void)setEndDate:(NSDate *)endDate {
    if ([self.type isEqualToString:@"SuggestedSpending"]) {
        MNFLogInfo(@"Can't change properties on a challenge of type 'SuggestedSpending'");
        MNFLogError(@"Can't change properties on a challenge of type 'SuggestedSpending'");
    } else if ([self.type isEqualToString:@"GlobalSpending"]) {
        MNFLogInfo(@"Can't change properties on a challenge of type 'GlobalSpending'");
        MNFLogError(@"Can't change properties on a challenge of type 'GlobalSpending'");
    } else {
        _endDate = endDate;
    }
}

- (void)setIconUrl:(NSString *)iconUrl {
    if ([self.type isEqualToString:@"SuggestedSpending"]) {
        MNFLogInfo(@"Can't change properties on a challenge of type 'SuggestedSpending'");
        MNFLogError(@"Can't change properties on a challenge of type 'SuggestedSpending'");
    } else if ([self.type isEqualToString:@"GlobalSpending"]) {
        MNFLogInfo(@"Can't change properties on a challenge of type 'GlobalSpending'");
        MNFLogError(@"Can't change properties on a challenge of type 'GlobalSpending'");
    } else {
        _iconUrl = iconUrl;
    }
}

+ (MNFJob *)fetchChallengeWithId:(NSNumber *)identifier completion:(MNFChallengesCompletionHandler)completion {
    [completion copy];

    NSString *path = [NSString stringWithFormat:@"%@/%@", kMNFApiPathChallenges, identifier];

    __block MNFJob *job = [self
        apiRequestWithPath:path
                 pathQuery:nil
                  jsonBody:nil
                HTTPMethod:kMNFHTTPMethodGET
                   service:MNFServiceNameChallenges
                completion:^(MNFResponse *_Nullable response) {
                    kObjectBlockDataDebugLog;

                    if (response.error == nil) {
                        if ([response.result isKindOfClass:[NSDictionary class]]) {
                            MNFChallenge *challenge = [MNFChallenge initWithServerResult:response.result];
                            if ([challenge.type isEqualToString:@"SuggestedSpending"]) {
                                MNFSpendingChallenge *spending =
                                    [MNFSpendingChallenge initWithServerResult:response.result[@"typeData"]];
                                challenge.challengeModel = spending;
                            } else if ([challenge.type isEqualToString:@"GlobalSpending"]) {
                                MNFGlobalChallenge *global =
                                    [MNFGlobalChallenge initWithServerResult:response.result[@"typeData"]];
                                challenge.challengeModel = global;
                            } else if ([challenge.type isEqualToString:@"CustomSpending"]) {
                                MNFCustomChallenge *custom =
                                    [MNFCustomChallenge initWithServerResult:response.result[@"typeData"]];
                                challenge.challengeModel = custom;
                            }

                            [MNFObject executeOnMainThreadWithJob:job
                                                       completion:completion
                                                        parameter:challenge
                                                            error:nil];

                        } else {
                            [MNFObject
                                executeOnMainThreadWithJob:job
                                                completion:completion
                                                 parameter:nil
                                                     error:[MNFErrorUtils
                                                               errorForUnexpectedDataOfType:[response.result class]
                                                                                   expected:[NSDictionary class]]];
                        }
                    } else {
                        [MNFObject executeOnMainThreadWithJob:job
                                                   completion:completion
                                                    parameter:nil
                                                        error:response.error];
                    }
                }];

    return job;
}

+ (MNFJob *)fetchChallengesWithIncludeExpired:(NSNumber *)includeExpired
                             excludeSuggested:(nullable NSNumber *)excludeSuggested
                              excludeAccepted:(nullable NSNumber *)excludeAccepted
                               includeDisable:(nullable NSNumber *)includeDisabled
                                   completion:(MNFMultipleChallengesCompletionHandler)completion {
    [completion copy];

    NSMutableDictionary *jsonQuery = [NSMutableDictionary dictionary];
    jsonQuery[@"includeExpired"] =
        [[MNFNumberToBoolValueTransformer transformer] reverseTransformedValue:includeExpired];
    jsonQuery[@"excludeSuggested"] =
        [[MNFNumberToBoolValueTransformer transformer] reverseTransformedValue:excludeSuggested];
    jsonQuery[@"excludeAccepted"] =
        [[MNFNumberToBoolValueTransformer transformer] reverseTransformedValue:excludeAccepted];
    jsonQuery[@"includeDisabled"] =
        [[MNFNumberToBoolValueTransformer transformer] reverseTransformedValue:includeDisabled];

    __block MNFJob *job = [self
        apiRequestWithPath:kMNFApiPathChallenges
                 pathQuery:[jsonQuery copy]
                  jsonBody:nil
                HTTPMethod:kMNFHTTPMethodGET
                   service:MNFServiceNameChallenges
                completion:^(MNFResponse *_Nullable response) {
                    kObjectBlockDataDebugLog;

                    if (response.error == nil) {
                        if ([response.result isKindOfClass:[NSArray class]]) {
                            NSMutableArray *challenges = [NSMutableArray array];
                            for (NSDictionary *dict in response.result) {
                                MNFChallenge *challenge = [MNFChallenge initWithServerResult:dict];
                                if ([challenge.type isEqualToString:@"SuggestedSpending"]) {
                                    MNFSpendingChallenge *spending =
                                        [MNFSpendingChallenge initWithServerResult:dict[@"typeData"]];
                                    challenge.challengeModel = spending;
                                } else if ([challenge.type isEqualToString:@"GlobalSpending"]) {
                                    MNFGlobalChallenge *global =
                                        [MNFGlobalChallenge initWithServerResult:dict[@"typeData"]];
                                    challenge.challengeModel = global;
                                } else if ([challenge.type isEqualToString:@"CustomSpending"]) {
                                    MNFCustomChallenge *custom =
                                        [MNFCustomChallenge initWithServerResult:dict[@"typeData"]];
                                    challenge.challengeModel = custom;
                                }
                                [challenges addObject:challenge];
                            }

                            [MNFObject executeOnMainThreadWithJob:job
                                                       completion:completion
                                                        parameter:[challenges copy]
                                                            error:nil];

                        } else {
                            [MNFObject
                                executeOnMainThreadWithJob:job
                                                completion:completion
                                                 parameter:nil
                                                     error:[MNFErrorUtils
                                                               errorForUnexpectedDataOfType:[response.result class]
                                                                                   expected:[NSArray class]]];
                        }
                    } else {
                        [MNFObject executeOnMainThreadWithJob:job
                                                   completion:completion
                                                    parameter:nil
                                                        error:response.error];
                    }
                }];

    return job;
}

- (MNFJob *)fetchChallengeHistoryWithSkip:(NSNumber *)skip
                                     take:(NSNumber *)take
                               completion:(MNFMultipleChallengesCompletionHandler)completion {
    [completion copy];

    NSString *path = [NSString stringWithFormat:kMNFChallengesHistory, self.challengeId];
    NSMutableDictionary *jsonQuery = [NSMutableDictionary dictionary];
    jsonQuery[@"skip"] = skip;
    jsonQuery[@"take"] = take;

    __block MNFJob *job = [[self class]
        apiRequestWithPath:path
                 pathQuery:[jsonQuery copy]
                  jsonBody:nil
                HTTPMethod:kMNFHTTPMethodGET
                   service:MNFServiceNameChallenges
                completion:^(MNFResponse *_Nullable response) {
                    kObjectBlockDataDebugLog;

                    if (response.error == nil) {
                        if ([response.result isKindOfClass:[NSArray class]]) {
                            NSMutableArray *challenges = [NSMutableArray array];
                            for (NSDictionary *dict in response.result) {
                                MNFChallenge *challenge = [MNFChallenge initWithServerResult:dict];
                                if ([challenge.type isEqualToString:@"SuggestedSpending"]) {
                                    MNFSpendingChallenge *spending =
                                        [MNFSpendingChallenge initWithServerResult:dict[@"typeData"]];
                                    challenge.challengeModel = spending;
                                } else if ([challenge.type isEqualToString:@"GlobalSpending"]) {
                                    MNFGlobalChallenge *global =
                                        [MNFGlobalChallenge initWithServerResult:dict[@"typeData"]];
                                    challenge.challengeModel = global;
                                } else if ([challenge.type isEqualToString:@"CustomSpending"]) {
                                    MNFCustomChallenge *custom =
                                        [MNFCustomChallenge initWithServerResult:dict[@"typeData"]];
                                    challenge.challengeModel = custom;
                                }
                                [challenges addObject:challenge];
                            }

                            [MNFObject executeOnMainThreadWithJob:job
                                                       completion:completion
                                                        parameter:[challenges copy]
                                                            error:nil];

                        } else {
                            [MNFObject
                                executeOnMainThreadWithJob:job
                                                completion:completion
                                                 parameter:nil
                                                     error:[MNFErrorUtils
                                                               errorForUnexpectedDataOfType:[response.result class]
                                                                                   expected:[NSArray class]]];
                        }
                    } else {
                        [MNFObject executeOnMainThreadWithJob:job
                                                   completion:completion
                                                    parameter:nil
                                                        error:response.error];
                    }
                }];

    return job;
}

- (MNFJob *)acceptChallengeWithTargetAmount:(NSNumber *)targetAmount
                                   waitTime:(nullable NSNumber *)waitTime
                                 completion:(MNFErrorOnlyCompletionHandler)completion {
    [completion copy];

    NSString *path = [NSString stringWithFormat:kMNFChallengesAcceptWithId, self.challengeId];

    NSMutableDictionary *jsonDict = [NSMutableDictionary dictionary];
    jsonDict[@"targetAmount"] = targetAmount;
    jsonDict[@"waitForCompleteMilliseconds"] = waitTime;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[jsonDict copy] options:0 error:nil];

    __block MNFJob *job = [MNFObject
        apiRequestWithPath:path
                 pathQuery:nil
                  jsonBody:jsonData
                HTTPMethod:kMNFHTTPMethodPOST
                   service:MNFServiceNameChallenges
                completion:^(MNFResponse *_Nullable response) {
                    kObjectBlockDataDebugLog;

                    if (response.error == nil) {
                        if ([response.result isKindOfClass:[NSDictionary class]]) {
                            [MNFJsonAdapter refreshObject:self
                                             withJsonDict:response.result
                                                   option:kMNFAdapterOptionNoOption
                                                    error:nil];
                            if ([self.type isEqualToString:@"SuggestedSpending"]) {
                                MNFSpendingChallenge *spending =
                                    [MNFSpendingChallenge initWithServerResult:response.result[@"typeData"]];
                                self.challengeModel = spending;
                            } else if ([self.type isEqualToString:@"GlobalSpending"]) {
                                MNFGlobalChallenge *global =
                                    [MNFGlobalChallenge initWithServerResult:response.result[@"typeData"]];
                                self.challengeModel = global;
                            } else if ([self.type isEqualToString:@"CustomSpending"]) {
                                MNFCustomChallenge *custom =
                                    [MNFCustomChallenge initWithServerResult:response.result[@"typeData"]];
                                self.challengeModel = custom;
                            }
                            [MNFObject executeOnMainThreadWithJob:job completion:completion error:nil];

                        } else {
                            [MNFObject
                                executeOnMainThreadWithJob:job
                                                completion:completion
                                                     error:[MNFErrorUtils
                                                               errorForUnexpectedDataOfType:[response.result class]
                                                                                   expected:[NSDictionary class]]];
                        }
                    } else {
                        [MNFObject executeOnMainThreadWithJob:job completion:completion error:response.error];
                    }
                }];

    return job;
}

- (MNFJob *)saveWithCompletion:(MNFErrorOnlyCompletionHandler)completion {
    [completion copy];

    NSString *path = [NSString stringWithFormat:@"%@/%@", kMNFApiPathChallenges, self.challengeId];

    NSMutableDictionary *jsonDict = [[MNFJsonAdapter JSONDictFromObject:self option:kMNFAdapterOptionNoOption
                                                                  error:nil] mutableCopy];
    NSDictionary *modelDict = [MNFJsonAdapter JSONDictFromObject:self.challengeModel
                                                          option:kMNFAdapterOptionNoOption
                                                           error:nil];
    jsonDict[@"typeData"] = modelDict;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[jsonDict copy] options:0 error:nil];

    __block MNFJob *job = [self updateWithApiPath:path
                                        pathQuery:nil
                                         jsonBody:jsonData
                                       httpMethod:kMNFHTTPMethodPUT
                                          service:MNFServiceNameChallenges
                                       completion:^(MNFResponse *_Nullable response) {
                                           kObjectBlockDataDebugLog;

                                           [MNFObject executeOnMainThreadWithJob:job
                                                                      completion:completion
                                                                           error:response.error];
                                       }];

    return job;
}

- (MNFJob *)deleteWithCompletion:(MNFErrorOnlyCompletionHandler)completion {
    [completion copy];

    NSString *path = [NSString stringWithFormat:@"%@/%@", kMNFApiPathChallenges, self.challengeId];

    __block MNFJob *job = [self deleteWithApiPath:path
                                        pathQuery:nil
                                         jsonBody:nil
                                          service:MNFServiceNameChallenges
                                       completion:^(MNFResponse *_Nullable response) {
                                           kObjectBlockDataDebugLog;

                                           [MNFObject executeOnMainThreadWithJob:job
                                                                      completion:completion
                                                                           error:response.error];
                                       }];

    return job;
}

- (MNFJob *)refreshWithCompletion:(MNFErrorOnlyCompletionHandler)completion {
    [completion copy];

    NSString *path = [NSString stringWithFormat:@"%@/%@", kMNFApiPathChallenges, self.challengeId];

    __block MNFJob *job = [MNFObject
        apiRequestWithPath:path
                 pathQuery:nil
                  jsonBody:nil
                HTTPMethod:kMNFHTTPMethodGET
                   service:MNFServiceNameChallenges
                completion:^(MNFResponse *_Nullable response) {
                    kObjectBlockDataDebugLog;

                    if (response.error == nil) {
                        if ([response.result isKindOfClass:[NSDictionary class]]) {
                            [MNFJsonAdapter refreshObject:self
                                             withJsonDict:response.result
                                                   option:kMNFAdapterOptionNoOption
                                                    error:nil];
                            if ([self.type isEqualToString:@"SuggestedSpending"]) {
                                MNFSpendingChallenge *spending =
                                    [MNFSpendingChallenge initWithServerResult:response.result[@"typeData"]];
                                self.challengeModel = spending;
                            } else if ([self.type isEqualToString:@"GlobalSpending"]) {
                                MNFGlobalChallenge *global =
                                    [MNFGlobalChallenge initWithServerResult:response.result[@"typeData"]];
                                self.challengeModel = global;
                            } else if ([self.type isEqualToString:@"CustomSpending"]) {
                                MNFCustomChallenge *custom =
                                    [MNFCustomChallenge initWithServerResult:response.result[@"typeData"]];
                                self.challengeModel = custom;
                            }
                            [MNFObject executeOnMainThreadWithJob:job completion:completion error:nil];

                        } else {
                            [MNFObject
                                executeOnMainThreadWithJob:job
                                                completion:completion
                                                     error:[MNFErrorUtils
                                                               errorForUnexpectedDataOfType:[response.result class]
                                                                                   expected:[NSDictionary class]]];
                        }
                    } else {
                        [MNFObject executeOnMainThreadWithJob:job completion:completion error:response.error];
                    }
                }];

    return job;
}

- (MNFJob *)enableWithCompletion:(MNFErrorOnlyCompletionHandler)completion {
    NSString *path = [NSString stringWithFormat:kMNFChallengesEnable, self.challengeId];

    __block MNFJob *job = [MNFObject
        apiRequestWithPath:path
                 pathQuery:nil
                  jsonBody:nil
                HTTPMethod:kMNFHTTPMethodPOST
                   service:MNFServiceNameChallenges
                completion:^(MNFResponse *_Nullable response) {
                    kObjectBlockDataDebugLog;

                    if (response.error == nil) {
                        if ([response.result isKindOfClass:[NSDictionary class]]) {
                            [MNFJsonAdapter refreshObject:self
                                             withJsonDict:response.result
                                                   option:kMNFAdapterOptionNoOption
                                                    error:nil];
                            if ([self.type isEqualToString:@"SuggestedSpending"]) {
                                MNFSpendingChallenge *spending =
                                    [MNFSpendingChallenge initWithServerResult:response.result[@"typeData"]];
                                self.challengeModel = spending;
                            } else if ([self.type isEqualToString:@"GlobalSpending"]) {
                                MNFGlobalChallenge *global =
                                    [MNFGlobalChallenge initWithServerResult:response.result[@"typeData"]];
                                self.challengeModel = global;
                            } else if ([self.type isEqualToString:@"CustomSpending"]) {
                                MNFCustomChallenge *custom =
                                    [MNFCustomChallenge initWithServerResult:response.result[@"typeData"]];
                                self.challengeModel = custom;
                            }
                            [MNFObject executeOnMainThreadWithJob:job completion:completion error:nil];

                        } else {
                            [MNFObject
                                executeOnMainThreadWithJob:job
                                                completion:completion
                                                     error:[MNFErrorUtils
                                                               errorForUnexpectedDataOfType:[response.result class]
                                                                                   expected:[NSDictionary class]]];
                        }
                    } else {
                        [MNFObject executeOnMainThreadWithJob:job completion:completion error:response.error];
                    }
                }];

    return job;
}

- (MNFJob *)disableWithCompletion:(MNFErrorOnlyCompletionHandler)completion {
    NSString *path = [NSString stringWithFormat:kMNFChallengesDisable, self.challengeId];

    __block MNFJob *job = [MNFObject
        apiRequestWithPath:path
                 pathQuery:nil
                  jsonBody:nil
                HTTPMethod:kMNFHTTPMethodPOST
                   service:MNFServiceNameChallenges
                completion:^(MNFResponse *_Nullable response) {
                    kObjectBlockDataDebugLog;

                    if (response.error == nil) {
                        if ([response.result isKindOfClass:[NSDictionary class]]) {
                            [MNFJsonAdapter refreshObject:self
                                             withJsonDict:response.result
                                                   option:kMNFAdapterOptionNoOption
                                                    error:nil];
                            if ([self.type isEqualToString:@"SuggestedSpending"]) {
                                MNFSpendingChallenge *spending =
                                    [MNFSpendingChallenge initWithServerResult:response.result[@"typeData"]];
                                self.challengeModel = spending;
                            } else if ([self.type isEqualToString:@"GlobalSpending"]) {
                                MNFGlobalChallenge *global =
                                    [MNFGlobalChallenge initWithServerResult:response.result[@"typeData"]];
                                self.challengeModel = global;
                            } else if ([self.type isEqualToString:@"CustomSpending"]) {
                                MNFCustomChallenge *custom =
                                    [MNFCustomChallenge initWithServerResult:response.result[@"typeData"]];
                                self.challengeModel = custom;
                            }
                            [MNFObject executeOnMainThreadWithJob:job completion:completion error:nil];

                        } else {
                            [MNFObject
                                executeOnMainThreadWithJob:job
                                                completion:completion
                                                     error:[MNFErrorUtils
                                                               errorForUnexpectedDataOfType:[response.result class]
                                                                                   expected:[NSDictionary class]]];
                        }
                    } else {
                        [MNFObject executeOnMainThreadWithJob:job completion:completion error:response.error];
                    }
                }];

    return job;
}

+ (MNFJob *)challengeWithTitle:(NSString *)title
                   description:(NSString *)description
                     startDate:(NSDate *)startDate
                       endDate:(NSDate *)endDate
                       iconUrl:(NSString *)iconUrl
                      typeData:(NSDictionary *)typeData
                    completion:(MNFChallengesCompletionHandler)completion {
    [completion copy];

    NSMutableDictionary *jsonDict = [NSMutableDictionary dictionary];
    jsonDict[@"title"] = title;
    jsonDict[@"description"] = description;
    jsonDict[@"startDate"] = [[MNFBasicDateValueTransformer transformer] reverseTransformedValue:startDate];
    jsonDict[@"endDate"] = [[MNFBasicDateValueTransformer transformer] reverseTransformedValue:endDate];
    jsonDict[@"iconUrl"] = iconUrl;
    jsonDict[@"typeData"] = typeData;

    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[jsonDict copy] options:0 error:nil];

    __block MNFJob *job = [MNFObject
        apiRequestWithPath:kMNFApiPathChallenges
                 pathQuery:nil
                  jsonBody:jsonData
                HTTPMethod:kMNFHTTPMethodPOST
                   service:MNFServiceNameChallenges
                completion:^(MNFResponse *_Nullable response) {
                    kObjectBlockDataDebugLog;

                    if (response.error == nil) {
                        if ([response.result isKindOfClass:[NSDictionary class]]) {
                            MNFChallenge *challenge = [MNFChallenge initWithServerResult:response.result];
                            if ([challenge.type isEqualToString:@"SuggestedSpending"]) {
                                MNFSpendingChallenge *spending =
                                    [MNFSpendingChallenge initWithServerResult:response.result[@"typeData"]];
                                challenge.challengeModel = spending;
                            } else if ([challenge.type isEqualToString:@"GlobalSpending"]) {
                                MNFGlobalChallenge *global =
                                    [MNFGlobalChallenge initWithServerResult:response.result[@"typeData"]];
                                challenge.challengeModel = global;
                            } else if ([challenge.type isEqualToString:@"CustomSpending"]) {
                                MNFCustomChallenge *custom =
                                    [MNFCustomChallenge initWithServerResult:response.result[@"typeData"]];
                                challenge.challengeModel = custom;
                            }

                            [MNFObject executeOnMainThreadWithJob:job
                                                       completion:completion
                                                        parameter:challenge
                                                            error:nil];

                        } else {
                            [MNFObject
                                executeOnMainThreadWithJob:job
                                                completion:completion
                                                 parameter:nil
                                                     error:[MNFErrorUtils
                                                               errorForUnexpectedDataOfType:[response.result class]
                                                                                   expected:[NSDictionary class]]];
                        }
                    } else {
                        [MNFObject executeOnMainThreadWithJob:job
                                                   completion:completion
                                                    parameter:nil
                                                        error:response.error];
                    }
                }];

    return job;
}

+ (MNFJob *)fetchIconIdentifiersWithFormat:(NSString *)format
                                completion:(MNFChallengeIconIdentifiersCompletionHandler)completion {
    [completion copy];

    NSMutableDictionary *jsonQuery = [NSMutableDictionary dictionary];
    jsonQuery[@"format"] = format;

    __block MNFJob *job = [self
        apiRequestWithPath:kMNFChallengesIcons
                 pathQuery:[jsonQuery copy]
                  jsonBody:nil
                HTTPMethod:kMNFHTTPMethodGET
                   service:MNFServiceNameChallenges
                completion:^(MNFResponse *_Nullable response) {
                    kObjectBlockDataDebugLog;

                    if (response.error == nil) {
                        if ([response.result isKindOfClass:[NSArray class]]) {
                            NSMutableArray *iconIdentifiers = [NSMutableArray array];
                            for (NSDictionary *dict in response.result) {
                                NSString *identifier = dict[@"id"];
                                [iconIdentifiers addObject:identifier];
                            }

                            [MNFObject executeOnMainThreadWithJob:job
                                                       completion:completion
                                                        parameter:[iconIdentifiers copy]
                                                            error:nil];
                        } else {
                            [MNFObject
                                executeOnMainThreadWithJob:job
                                                completion:completion
                                                 parameter:nil
                                                     error:[MNFErrorUtils
                                                               errorForUnexpectedDataOfType:[response.result class]
                                                                                   expected:[NSArray class]]];
                        }
                    } else {
                        [MNFObject executeOnMainThreadWithJob:job
                                                   completion:completion
                                                    parameter:nil
                                                        error:response.error];
                    }
                }];

    return job;
}

+ (MNFJob *)fetchIconWithIdentifier:(NSString *)iconIdentifier
                         completion:(MNFChallengeIconImageDataCompletionHandler)completion {
    [completion copy];

    NSString *path = [NSString stringWithFormat:@"%@/%@", kMNFChallengesIcons, iconIdentifier];

    __block MNFJob *job = [self resourceRequestWithPath:path
                                              pathQuery:nil
                                               jsonBody:nil
                                             HTTPMethod:kMNFHTTPMethodGET
                                                service:MNFServiceNameChallenges
                                             completion:^(MNFResponse *_Nullable response) {
                                                 kObjectBlockDataDebugLog;

                                                 [MNFObject executeOnMainThreadWithJob:job
                                                                            completion:completion
                                                                             parameter:response.rawData
                                                                                 error:response.error];
                                             }];

    return job;
}

#pragma mark - json delegate

- (NSDictionary *)jsonKeysMapToProperties {
    return @{ @"challengeId": @"id", @"challengeDescription": @"description" };
}

- (NSDictionary *)propertyKeysMapToJson {
    return @{ @"challengeId": @"id", @"challengeDescription": @"description" };
}

- (NSDictionary *)propertyValueTransformers {
    return @{
        @"acceptedDate": [MNFBasicDateValueTransformer transformer],
        @"startDate": [MNFBasicDateValueTransformer transformer],
        @"endDate": [MNFBasicDateValueTransformer transformer],
        @"parentStartDate": [MNFBasicDateValueTransformer transformer],
        @"parentEndDate": [MNFBasicDateValueTransformer transformer]
    };
}

- (NSSet *)propertiesToIgnoreJsonDeserialization {
    return [NSSet setWithObjects:@"objectstate", @"typeData", nil];
}

- (NSSet *)propertiesToIgnoreJsonSerialization {
    return [NSSet setWithObjects:@"objectstate",
                                 @"dirty",
                                 @"deleted",
                                 @"isNew",
                                 @"mutableProperties",
                                 @"keyValueStore",
                                 @"identifier",
                                 @"type",
                                 @"accepted",
                                 @"acceptedDate",
                                 @"topicId",
                                 @"challengeModel",
                                 nil];
}

@end
