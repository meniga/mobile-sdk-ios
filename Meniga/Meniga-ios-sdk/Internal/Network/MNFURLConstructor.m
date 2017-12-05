//
//  MenigaURLConstructor.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 01/10/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFURLConstructor.h"

@implementation MNFURLConstructor

+(NSURL *)URLFromBaseUrl:(NSString *)baseURL path:(NSString *)path pathQuery:(nullable NSDictionary *)pathQuery {

    NSURLComponents *urlComponents;
    
    if (baseURL != nil) {
        urlComponents = [[NSURLComponents alloc] initWithString:baseURL];
    }
    else {
        // MARK: Check
        urlComponents = [[NSURLComponents alloc] initWithString:@""];
    }
    
    
    if (urlComponents.path.length > 0) {
        path = [urlComponents.path stringByAppendingString:path]; //If there's a path included in the base url it is in the path component after init. We therefore need to concatenate the base path with the path/endpoint parameter.
    }
    
    [urlComponents setPath:path];
    
    NSString *queryString = [self pathQueryFromDictionary:pathQuery];
    
    /*
    NSMutableCharacterSet *mutableSet = [[NSCharacterSet URLQueryAllowedCharacterSet] mutableCopy];
    [mutableSet removeCharactersInString:@"+"];
    
    queryString = [queryString stringByAddingPercentEncodingWithAllowedCharacters: mutableSet];
     */
    
    if (queryString != nil) {
        [urlComponents setQuery:queryString];
    }
    
    return urlComponents.URL;
}

+(NSURL *)URLFromBaseUrl:(NSString *)baseURL path:(NSString *)path pathQuery:(NSDictionary *)pathQuery percentageEncoded:(BOOL)percentageEncoded {
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", baseURL, path]];
    
    return url;
}

+(NSURL *)URLFromBaseUrl:(NSString *)baseURL path:(NSString *)path {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", baseURL, path]];
    return url;
}


+(NSString*)pathQueryFromDictionary:(NSDictionary*)paramQuery{

    if ([paramQuery count]==0) {
        return nil;
    }
    
    NSMutableString *queryString = [[NSMutableString alloc] init];
    
    NSArray *keys = [paramQuery allKeys];
    BOOL firstQuery = YES;
    for (int i=0; i<keys.count; i++) {
        
        if (paramQuery[keys[i]] != nil && ![paramQuery[keys[i]] isEqual:[NSNull null]]) {
            id value = paramQuery[keys[i]];
            NSString *stringVal  = [NSString stringWithFormat:@"%@", value];
            if ([value isKindOfClass:[NSArray class]] && [value count]>0) {
                stringVal = [NSString stringWithFormat:@"%@", value[0]];
                for (int j=1; j<[value count]; j++) {
                    stringVal = [stringVal stringByAppendingFormat:@",%@", value[j]];
                }
            }
            
            if (firstQuery) {
                [queryString appendFormat:@"%@=%@",keys[i],stringVal];
                firstQuery = NO;
            }
            else {
                [queryString appendFormat:@"&%@=%@",keys[i],stringVal];
            }
        }
    }
    
    return queryString;
}

@end
