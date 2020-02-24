//
//  MNFTransactionParsedDataTransformer.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 22/05/2018.
//  Copyright © 2018 Meniga. All rights reserved.
//

#import "MNFTransactionParsedDataTransformer.h"

@implementation MNFTransactionParsedDataTransformer

+(instancetype)transformer {
    MNFTransactionParsedDataTransformer *trans = [[MNFTransactionParsedDataTransformer alloc] init];
    
    return trans;
}

+(BOOL)allowsReverseTransformation {
    return YES;
}

-(id)transformedValue:(id)value {
    
    if ([value isKindOfClass:[NSDictionary class]]) {
        return value;
    }
    else if (![value isKindOfClass:[NSArray class]]) {
        return nil;
    }
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    NSArray *parsedData = (NSArray*)value;
    
    for (NSDictionary *parsedDataEntries in parsedData) {
        id key = parsedDataEntries[@"key"];
        id value = parsedDataEntries[@"value"];
        dictionary[key] = value;
    }
    
    return [dictionary copy];
    
}

-(id)reverseTransformedValue:(id)value {
    
    return value;
}

@end
