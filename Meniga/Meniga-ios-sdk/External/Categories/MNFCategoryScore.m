//
//  MNFCategoryScore.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 07/04/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFCategoryScore.h"

@implementation MNFCategoryScore

#pragma mark - Json Adapter Delegate

- (NSSet *)propertiesToIgnoreJsonDeserialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

- (NSSet *)propertiesToIgnoreJsonSerialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

#pragma mark - Description
- (NSString *)description {
    return [NSString stringWithFormat:@"Category score %@ categoryId: %@, score: %@",
                                      [super description],
                                      self.categoryId,
                                      self.score];
}

@end
