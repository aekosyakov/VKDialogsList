//
//  NSNumber+PositiveValue.h
//  VKTestExercise
//
//  Created by Alex Kosyakov on 1/11/18.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (PositiveValue)
- (instancetype)makePositiveIfNeeded;
- (instancetype)makeNegativeIfNeeded;
+ (instancetype)createPeerIDFromChatID:(NSNumber *)chatID userID:(NSNumber *)userID;
@end
