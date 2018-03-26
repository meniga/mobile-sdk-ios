//
//  MNFTestFactory.m
//  Meniga-ios-sdk-tests
//
//  Created by Haukur Ísfeld on 21/03/2018.
//  Copyright © 2018 Meniga. All rights reserved.
//

#import "MNFTestFactory.h"

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

@end
