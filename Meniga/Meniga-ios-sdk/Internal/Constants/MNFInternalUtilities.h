//
//  MNFUtilities.h
//  Meniga-ios-sdk
//
//  Created by Aske Bendtsen on 26/04/2018.
//  Copyright © 2018 Meniga. All rights reserved.
//

#ifndef MNFInternalUtilities_h
#define MNFInternalUtilities_h

#include <stdio.h>

#endif /* MNFUtilities_h */


//Weakify - strongify
#define MNFweakify(var) __weak typeof(var) MNFWeak_##var = var;

#define MNFstrongify(var) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
__strong typeof(var) var = MNFWeak_##var; \
_Pragma("clang diagnostic pop")
