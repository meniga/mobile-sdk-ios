//
//  MNFFeed_Private.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 12/11/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFFeed.h"

@interface MNFFeed ()

-(void)setDirty;
-(MNFFeedItem*)findFeedItemByDate:(NSDate*)date from:(int)from to:(int)to;
-(void)moveTransaction:(MNFTransaction*)transaction fromDate:(NSDate*)from toDate:(NSDate*)to;

@end
