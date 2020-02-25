//
//  MNFObjectTypes.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 02/10/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#ifndef MNFObjectTypes_h
#define MNFObjectTypes_h

typedef enum : NSUInteger {
    MNFObjectTypeNone,
    MNFTransactionObject,
    MNFUserObject,
    MNFAccountObject,
    MNFUserEventObject,
    MNFUndefinedObject,
    MNFCashbackReportObject,
    MNFCategoryObject,
    MNFCustomCategoryObject,
    MNFOfferObject,
    MNFNetworkObject,
    MNFFeedObject,
    MNFFeedItemObject,
    MNFTagObject
} MNFObjectType;

#endif
