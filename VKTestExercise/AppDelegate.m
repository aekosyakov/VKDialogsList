//
//  AppDelegate.m
//  VKTestExercise
//
//  Created by Alex Kosyakov on 19.12.2017.
//  Copyright © 2017 Alex Kosyakov. All rights reserved.
//

#import "AppDelegate.h"
#import "VKSDKHeader.h"
#import "VKTService+Extensions.h"
@interface AppDelegate ()
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    return YES;
}

//iOS 9 workflow
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    if (@available(iOS 9.0, *)) {
        [VKSdk processOpenURL:url fromApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]];
    }
    return YES;
}

//iOS 8 and lower
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    [VKSdk processOpenURL:url fromApplication:sourceApplication];
    return YES;
}

+ (UIViewController *)topController {
  AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
  if (appDelegate) {
    UIViewController * rootViewCoontroller = appDelegate.window.rootViewController;
    if([rootViewCoontroller isKindOfClass:[UINavigationController class]]) {
      UINavigationController * navController = (UINavigationController*)rootViewCoontroller;
      return navController.topViewController;
    }
    return rootViewCoontroller;
  }
  return nil;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}

@end
