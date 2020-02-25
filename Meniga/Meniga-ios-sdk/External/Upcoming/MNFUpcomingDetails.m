//
//  MNFUpcomingDetails.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 30/09/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFUpcomingDetails.h"
#import "MNFInternalImports.h"
#import "MNFUpcomingInvoice.h"
#import "MNFUpcomingScheduledPayment.h"

@implementation MNFUpcomingDetails

#pragma mark - json adaptor delegate

- (NSDictionary *)subclassedProperties {
    return @{
        @"invoice": [MNFJsonAdapterSubclassedProperty subclassedPropertyWithClass:[MNFUpcomingInvoice class]
                                                                           option:kMNFAdapterOptionNoOption],
        @"scheduledPayment":
            [MNFJsonAdapterSubclassedProperty subclassedPropertyWithClass:[MNFUpcomingScheduledPayment class]
                                                                   option:kMNFAdapterOptionNoOption]
    };
}

@end
