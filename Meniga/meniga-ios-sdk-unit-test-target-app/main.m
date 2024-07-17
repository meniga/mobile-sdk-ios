//
//  main.m
//  meniga-ios-sdk-unit-test-target-app
//
//  Created by Szymon Kowalski on 17/07/2024.
//  Copyright © 2024 Meniga. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
