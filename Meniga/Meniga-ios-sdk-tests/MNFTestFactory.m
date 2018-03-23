//
//  MNFTestFactory.m
//  Meniga-ios-sdk-tests
//
//  Created by Haukur Ísfeld on 21/03/2018.
//  Copyright © 2018 Meniga. All rights reserved.
//

#import "MNFTestFactory.h"

static NSDictionary *apiSpecDictionary;

@implementation MNFTestFactory

+(void)initialize {
    
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:self] pathForResource:@"apispec" ofType:@"json"]];
    apiSpecDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
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

@end
