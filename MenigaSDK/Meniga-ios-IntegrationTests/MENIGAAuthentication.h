//
//  MENIGAAuthentication.h
//  bank42
//
//  Created by Mathieu Grettir Skulason on 1/18/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MENIGAAuthentication : NSObject

+(void)loginWithUsername:(NSString*)theUsername password:(NSString*)thePassword withCompletion:(void (^)(NSDictionary *tokenDictionary, NSError *error))completion;
//+(void)setLoginApiPath:(NSString *)theLoginPath;

@end
