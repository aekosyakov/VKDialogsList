//
//  VKTSerialOperationQueue.m
//  VKTestExercise
//
//  Created by Alex Kosyakov on 1/16/18.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import "VKTSerialOperationQueue.h"

@implementation VKTSerialOperationQueue

- (instancetype)init {
  if (self = [super init]) {
    self.maxConcurrentOperationCount = 1;
  }
  return self;
}

@end
