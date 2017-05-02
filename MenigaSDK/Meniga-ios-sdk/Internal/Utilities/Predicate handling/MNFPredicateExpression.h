//
//  MNFPredicateExpression.h
//  Meniga-ios-sdk
//
//  Created by Aske Bendtsen on 28/10/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MNFPredicateExpression : NSObject

@property(nonatomic, strong, readonly)NSString *key;
@property(nonatomic, readonly)NSPredicateOperatorType operatorType;
@property(nonatomic, strong, readonly)id value;


+(instancetype)expressionWithPredicate:(NSComparisonPredicate*)predicate;
+(NSArray*)expressionsWithPredicates:(NSArray<NSComparisonPredicate*>*)predicate;

@end
