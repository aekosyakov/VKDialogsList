//
//  VKTNetworkReachability.m
//  VKTestExercise
//
//  Created by Alex Kosyakov on 03.01.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import "VKTNetworkReachability.h"
#import "Reachability.h"

static Reachability *__reachbilityCient;

@implementation VKTNetworkReachability

+ (void)startObserving:(void(^)(BOOL reachable))completion {
  if (!__reachbilityCient) {
    __reachbilityCient = [Reachability reachabilityForInternetConnection];
  }
  
  void (^ReachableBlock)(Reachability *reach) = ^(Reachability *reach) {
    dispatch_async(dispatch_get_main_queue(), ^{
      if (completion) {
        completion([reach isReachable]);
      }
    });
  };
  __reachbilityCient.reachableBlock   = ReachableBlock;
  __reachbilityCient.unreachableBlock = ReachableBlock;
  
  
  [__reachbilityCient startNotifier];
}

+ (BOOL)isReachable {
  return [__reachbilityCient isReachable];
}

@end
