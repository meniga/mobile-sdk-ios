//
//  MNFObjectState.h
//  Meniga-ios-sdk
//
//  Created by Aske Bendtsen on 30/10/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MNFObjectState : NSObject

@property(nonatomic, copy, readonly)NSDictionary *serverData;

-(instancetype)initForClass:(id)theClass withServerData:(NSDictionary*)dictionary;
+(instancetype)stateForClass:(id)theClass withServerData:(NSDictionary *)dictionary;

-(void)setState:(NSDictionary*)state;

-(void)clearState;

-(id)stateValueForKey:(NSString*)key;

-(void)setStateValue:(id)value forKey:(NSString*)key;

@end
