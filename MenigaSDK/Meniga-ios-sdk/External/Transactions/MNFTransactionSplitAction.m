//
//  MNFTransactionSplitAction.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 31/03/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFTransactionSplitAction.h"
#import "MNFObject_Private.h"

@implementation MNFTransactionSplitAction

+(instancetype)transactionSplitActionWithRatio:(NSNumber *)ratio amount:(NSNumber *)amount categoryId:(NSNumber *)categoryId {
    
    MNFTransactionSplitAction *splitAction = [[MNFTransactionSplitAction alloc] initWithRatio:ratio amount:amount categoryId:categoryId];
    
    return splitAction;
}

-(instancetype)initWithRatio:(NSNumber *)ratio amount:(NSNumber *)amount categoryId:(NSNumber *)categoryId {
    
    if (self = [super init]) {
        
        _ratio = ratio;
        _amount = amount;
        _categoryId = categoryId;
        
        // bug on backend has to be populated, cannot be null.
        _transactionRuleId = @0;
        
        // cannot be null or the server sends an error
        [self setIdentifier:@0];
        
    }
    
    return self;
}

#pragma mark - json adapter delegates

-(NSDictionary*)jsonKeysMapToProperties {
    return @{@"identifier":@"id"};
}
-(NSDictionary*)propertyKeysMapToJson {
    return @{@"identifier":@"id"};
}

-(NSSet *)propertiesToIgnoreJsonDeserialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

-(NSSet *)propertiesToIgnoreJsonSerialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

#pragma mark - Description
-(NSString*)description {
    return [NSString stringWithFormat:@"Transaction split action %@ identifier: %@, transactionRuleId: %@, ratio: %@, amount: %@, categoryId: %@",[super description],self.identifier,self.transactionRuleId,self.ratio,self.amount,self.categoryId];
}

@end
