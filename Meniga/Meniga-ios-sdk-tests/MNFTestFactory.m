//
//  MNFTestFactory.m
//  Meniga-ios-sdk-tests
//
//  Created by Haukur Ísfeld on 21/03/2018.
//  Copyright © 2018 Meniga. All rights reserved.
//

#import "MNFTestFactory.h"
#import "MNFInternalImports.h"

static NSDictionary *apiSpecDictionary;
static NSDictionary *cashbackapiSpecDictionary;

@implementation MNFTestFactory

+(void)initialize {
    
    NSData *apidata = [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:self] pathForResource:@"apispec" ofType:@"json"]];
    apiSpecDictionary = [NSJSONSerialization JSONObjectWithData:apidata options:0 error:nil];
    
    NSData *cashbackapidata = [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:self] pathForResource:@"cashbackapispec" ofType:@"json"]];
    cashbackapiSpecDictionary = [NSJSONSerialization JSONObjectWithData:cashbackapidata options:0 error:nil];
}

+(NSDictionary*)apiModelWithDefinition:(NSString *)definition {
    return apiSpecDictionary[@"definitions"][definition][@"properties"];
}
+(NSArray<NSDictionary*>*)filterParametersWithPath:(NSString *)path {
    NSArray *parameters = apiSpecDictionary[@"paths"][path][@"get"][@"parameters"];
    NSMutableArray *sanitizedArray = [parameters mutableCopy];
    for (NSDictionary *parameter in parameters) {
        if ([parameter[@"in"] isEqualToString:@"path"] || [parameter[@"name"] isEqualToString:@"skip"] || [parameter[@"name"] isEqualToString:@"take"]) {
            [sanitizedArray removeObject:parameter];
        }
    }
    
    return [sanitizedArray copy];
}

+(NSDictionary*)cashbackapiModelWithDefinition:(NSString *)definition {
    return cashbackapiSpecDictionary[@"definitions"][definition][@"properties"];
}

+(NSArray<NSDictionary*>*)cashbackfilterParametersWithPath:(NSString *)path {
    NSArray *parameters = cashbackapiSpecDictionary[@"paths"][path][@"get"][@"parameters"];
    NSMutableArray *sanitizedArray = [parameters mutableCopy];
    for (NSDictionary *parameter in parameters) {
        if ([parameter[@"in"] isEqualToString:@"path"] || [parameter[@"name"] isEqualToString:@"skip"] || [parameter[@"name"] isEqualToString:@"take"]) {
            [sanitizedArray removeObject:parameter];
        }
    }
    
    return [sanitizedArray copy];
}

+(NSDictionary*)jsonModelWithDefinition:(NSString *)definition {
    
    NSDictionary *apiModel = [self apiModelWithDefinition:definition];
    NSLog(@"Api model: %@",apiModel);
    
    NSMutableDictionary *jsonDictionary = [NSMutableDictionary dictionary];
    
    for (NSString *key in apiModel.allKeys) {
        
        NSDictionary *model = apiModel[key];
        if (model[@"$ref"] != nil) {
            NSString *modelKey = model[@"$ref"];
            modelKey = [modelKey stringByReplacingOccurrencesOfString:@"#/definitions/" withString:@""];
            NSLog(@"Modelkey: %@",modelKey);
            if (![modelKey isEqualToString:definition]) {
                jsonDictionary[key] = [self jsonModelWithDefinition:modelKey];
            }
        }
        else if ([model[@"type"] isEqualToString:@"array"]) {
            if (model[@"items"] != nil) {
                NSString *itemRef = model[@"items"][@"$ref"];
                itemRef = [itemRef stringByReplacingOccurrencesOfString:@"#/definitions/" withString:@""];
                if (![itemRef isEqualToString:definition]) {
                    jsonDictionary[key] = @[[self jsonModelWithDefinition:itemRef]];
                }
                else {
                    jsonDictionary[key] = @[];
                }
            }
        }
        else {
            jsonDictionary[key] = [self randomValueForModel:model];
        }
    }
    
    return [jsonDictionary copy];
}

+(id)randomValueForModel:(NSDictionary *)model {
    
    NSString *modelType = model[@"type"];
    NSString *modelFormat = model[@"format"];
    NSString *ref = model[@"$ref"];
    
    if ([modelFormat isEqualToString:@"date-time"]) {
        return [NSString stringWithFormat:@"2018-%02u-%02uT23:59:59.360Z",(arc4random_uniform(12)+1),(arc4random_uniform(30)+1)];
    }
    if ([modelType isEqualToString:@"string"]) {
        return [NSStringUtils randomStringWithLength:6];
    }
    if ([modelType isEqualToString:@"boolean"]) {
        return (arc4random() % 2 ? @1 : @0);
    }
    if ([modelType isEqualToString:@"integer"]) {
        return [NSNumber numberWithInt:arc4random_uniform(100)];
    }
    if ([modelType isEqualToString:@"number"]) {
        return [NSNumber numberWithDouble:arc4random_uniform(100)/10.0];
    }
    if ([modelType isEqualToString:@"array"]) {
        return @[];
    }
    if (ref != nil || [modelType isEqualToString:@"object"]) {
        return @{};
    }
    
    return nil;
}

@end
