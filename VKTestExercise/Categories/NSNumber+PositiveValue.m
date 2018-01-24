//
//  NSNumber+PositiveValue.m
//  VKTestExercise
//
//  Created by Alex Kosyakov on 1/11/18.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import "NSNumber+PositiveValue.h"

@implementation NSNumber (PositiveValue)

- (instancetype)makePositiveIfNeeded {
  NSInteger selfInt = self.integerValue;
  if (selfInt >= 0) {
    return self;
  }
  
  selfInt = -1 * selfInt;
  return @(selfInt);
}

- (instancetype)makeNegativeIfNeeded {
  NSInteger selfInt = self.integerValue;
  if (selfInt < 0) {
    return self;
  }
  
  selfInt = -1 * selfInt;
  return @(selfInt);
}

+ (NSNumber *)createPeerIDFromChatID:(NSNumber *)chatID userID:(NSNumber *)userID {
    if (!chatID) {
        NSInteger userIDInt =  -1 * [userID integerValue];
        return @(userIDInt);
    }
    NSUInteger largeInt = 2000000000;
    NSUInteger chatIDInt = [chatID integerValue];
    NSUInteger sumInt = largeInt + chatIDInt;
    return @(sumInt);
}

@end
