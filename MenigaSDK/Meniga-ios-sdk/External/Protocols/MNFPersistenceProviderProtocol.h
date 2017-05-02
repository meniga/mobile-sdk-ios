//
//  MNFPersistenceProviderProtocol.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 23/10/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MNFJob.h"
#import "MNFPersistenceRequest.h"

/**
 MNFPersistenceProtocol is implemented by a persistence provider.
 */
@protocol MNFPersistenceProviderProtocol <NSObject>

@required
/**
 @description Fetches from persistence using an MNFPersistenceRequest. URL request are translated to a persistence request in the form of 'Get' requests. For example a fetch account request translates to a 'GetAccount' request. Any implementation of a persistence provider should use the Meniga API documentation as reference.
 */
-(MNFJob*)fetchWithRequest:(MNFPersistenceRequest*)request;

/**
 @description Saves to persistence using an MNFPersistenceRequest. If a persistence network policy is used any data fetched from the server will be automatically saved to persistence before being returned to the user. A fetch request will be translated to a save request. For example a 'GetAccount' request will be translated to a 'SaveAccount' request. Any implementation of a persistence provider should use the Meniga API documentation as reference.
 */
-(MNFJob*)saveWithRequest:(MNFPersistenceRequest*)request;

/**
 @description Queries the persistence if it has an object with a given identifying key. In fetch requests a URL request property such as for example 'id', 'identifier', 'offerId' etc. are set as the persistence request key. This key can be used to query the database and therefore possibly reducing the amount of fetches done in the persistence. Any implementation of a persistence provider should use the Meniga API documentation as reference. To skip this method simply return YES in all cases.
 */
-(BOOL)hasKey:(MNFPersistenceRequest*)request;

@end
