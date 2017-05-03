//
//  MNFRouter.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 24/11/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MNFConstants.h"

@class MNFJob;

@interface MNFRouter : NSObject

+(MNFJob *)routeRequest:(NSURLRequest*)request withCompletion:(MNFCompletionHandler)completion;
+(MNFJob*)routeRequest:(NSURLRequest*)request;

@end
