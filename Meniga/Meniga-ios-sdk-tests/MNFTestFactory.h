//
//  MNFTestFactory.h
//  Meniga-ios-sdk-tests
//
//  Created by Haukur Ísfeld on 21/03/2018.
//  Copyright © 2018 Meniga. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MNFTestFactory : NSObject

+(NSDictionary*)apiModelWithDefinition:(NSString*)definition;
+(NSArray<NSDictionary*>*)filterParametersWithPath:(NSString*)path;

+(NSDictionary*)cashbackapiModelWithDefinition:(NSString*)definition;
+(NSArray<NSDictionary*>*)cashbackfilterParametersWithPath:(NSString*)path;

@end
