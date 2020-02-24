//
//  MNFJSONStringToDictionaryValueTransformer.m
//  Meniga-ios-sdk
//
//  Created by Aske Bendtsen on 02/12/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFJSONStringToDictionaryValueTransformer.h"
#import "MNFConstants.h"

@implementation MNFJSONStringToDictionaryValueTransformer

+ (instancetype)transformer {
    return [[self alloc] init];
}


+ (Class)transformedValueClass {
    return [NSString class];
}

+ (BOOL)allowsReverseTransformation {
    return YES;
}



- (id)transformedValue:(id)value {
    
    if (value == nil || value == [NSNull null]) {
        return value;
    }
    
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:[value dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
    
    return jsonDict;
    
}

- (id)reverseTransformedValue:(id)value {
    
    if (value == nil || value == [NSNull null]) {
        return value;
    }
    //Readability equals zero, I know. But by referencing the repayment account key constants in the string format we can just change those constants when account info differs in foreign implementations.
    
    NSString *jsonString = [NSString stringWithFormat:@"{\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\"}", kMNFRepaymentAccountInfoBankAccountNumberKey, [value objectForKey:kMNFRepaymentAccountInfoBankAccountNumberKey], kMNFRepaymentAccountInfoLedgerKey, [value objectForKey:kMNFRepaymentAccountInfoLedgerKey], kMNFRepaymentAccountInfoSocialSecurityNumberKey, [value objectForKey:kMNFRepaymentAccountInfoSocialSecurityNumberKey], kMNFRepaymentAccountInfoBankNumberKey, [value objectForKey:kMNFRepaymentAccountInfoBankNumberKey]];
    
    return jsonString;
    
}

@end
