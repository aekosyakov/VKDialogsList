//
//  VKService.m
//  VKTestExercise
//
//  Created by Alex Kosyakov on 23.12.2017.
//  Copyright © 2017 Alex Kosyakov. All rights reserved.
//

#import "VKTService.h"
#import "VKSDKHeader.h"
NSString *const kVKAPP_ID = @"6308626";
@class VKResponse;
@implementation VKTService
@synthesize refreshing, resultCompletion;

- (instancetype)init {
  if (self = [super init]) {
    [VKTNetworkReachability startObserving:^(BOOL reachable) {
      if (!reachable) {
        self.refreshing = NO;
      }
    }];
  }
  return self;
}

- (void)callDelegateWithResult:(id <VKTServiceResult > )result {
    self.refreshing = NO;
    if (self.resultCompletion) {
        self.resultCompletion(result);
    }
}

@end
