//
//  MNFPredicateExpression.m
//  Meniga-ios-sdk
//
//  Created by Aske Bendtsen on 28/10/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFPredicateExpression.h"

@interface MNFPredicateExpression ()

@property(nonatomic, strong, readwrite)NSString *key;
@property(nonatomic, readwrite)NSPredicateOperatorType operatorType;
@property(nonatomic, strong, readwrite)id value;

@end

@implementation MNFPredicateExpression

- (instancetype)initWithPredicate:(NSComparisonPredicate*)predicate
{
    self = [super init];
    if (self) {
        self.key = predicate.leftExpression.keyPath;
        self.value = predicate.rightExpression.constantValue;
        self.operatorType = predicate.predicateOperatorType;
    }
    return self;
}

+(instancetype)expressionWithPredicate:(NSComparisonPredicate *)predicate{
    return [[self alloc] initWithPredicate:predicate];
}

+(NSArray*)expressionsWithPredicates:(NSArray<NSComparisonPredicate *> *)predicates{

    NSMutableArray *expressions = [[NSMutableArray alloc]init];
    
    for (NSComparisonPredicate* pred in predicates) {
        [expressions addObject:[self expressionWithPredicate:pred]];
    }
    
    return [expressions copy];
}

-(NSString*)description{

    return [NSString stringWithFormat:@"key: %@ value: %@ operatorType: %@", _key, _value, @(_operatorType)];
}

@end
