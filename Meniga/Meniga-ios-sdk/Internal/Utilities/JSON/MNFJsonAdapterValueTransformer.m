//
//  MNFJsonAdapterValueTransformer.m
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 3/23/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFJsonAdapterValueTransformer.h"

@interface MNFJsonAdapterValueTransformer ()

@property (nonatomic) MNFAdapterOption option;
@property (nonatomic, strong) Class class;
@property (nonatomic, weak) id<MNFJsonAdapterDelegate> delegate;

@end

@implementation MNFJsonAdapterValueTransformer

+ (instancetype)transformerWithClass:(Class)theClass
                            delegate:(id<MNFJsonAdapterDelegate>)theDelegate
                              option:(MNFAdapterOption)theOption {
    MNFJsonAdapterValueTransformer *valueTransformer = [[MNFJsonAdapterValueTransformer alloc] initWithClass:theClass
                                                                                                    delegate:theDelegate
                                                                                                      option:theOption];

    //    s_class = theClass;

    return valueTransformer;
}

- (instancetype)initWithClass:(Class)theClass
                     delegate:(id<MNFJsonAdapterDelegate>)theDelegate
                       option:(MNFAdapterOption)theOption {
    if (self = [super init]) {
        _class = theClass;
        _delegate = theDelegate;
        _option = theOption;
    }

    return self;
}

+ (BOOL)allowsReverseTransformation {
    return YES;
}

- (nullable id)transformedValue:(nullable id)value error:(NSError **)theError {
    if (value == nil || value == [NSNull null]) {
        return value;
    }

    if ([value isKindOfClass:[NSArray class]] == YES) {
        NSArray *array = (NSArray *)value;

        NSArray *objects = [MNFJsonAdapter objectsOfClass:_class
                                                 delegate:_delegate
                                                jsonArray:array
                                                   option:_option
                                                    error:theError];

        return objects;

    } else if ([value isKindOfClass:[NSDictionary class]] == YES) {
        NSDictionary *dict = (NSDictionary *)value;

        id object = [MNFJsonAdapter objectOfClass:_class
                                         delegate:_delegate
                                         jsonDict:dict
                                           option:_option
                                            error:theError];

        return object;
    }

    return nil;
}

- (nullable id)reverseTransformedValue:(nullable id)value error:(NSError *__autoreleasing *)theError {
    if (value == nil || value == [NSNull null]) {
        return value;
    }

    if ([value isKindOfClass:[NSArray class]] == YES) {
        NSArray *array = (NSArray *)value;

        NSArray *objects = [MNFJsonAdapter JSONArrayFromArray:array option:_option error:theError];

        return objects;

    } else {
        NSDictionary *object = [MNFJsonAdapter JSONDictFromObject:value option:_option error:theError];

        return object;
    }

    return nil;
}

@end
