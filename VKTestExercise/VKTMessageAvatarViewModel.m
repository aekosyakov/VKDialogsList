//
//  VKTMessageAvatarViewModel.m
//  VKTestExercise
//
//  Created by Alex Kosyakov on 13.01.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import "VKTMessageAvatarViewModel.h"
#import "VKTMessage+Extensions.h"
#import "VKTUser+Extensions.h"
#import "VKTUserToken.h"

@interface VKTMessageAvatarViewModel()
@property (strong, nonatomic) NSArray *urlsArray;
@end
@implementation VKTMessageAvatarViewModel
@synthesize message;

- (NSArray <NSURL *> *)photoURLs {
      NSMutableSet *mutableSet = [NSMutableSet set];
      if (self.message.users.count > 1) {
        if (self.message.chat_photo_url.length > 0) {
          [mutableSet addObject:[NSURL URLWithString:self.message.chat_photo_url]];
        } else {
          for (int i = 0; i < self.message.users.count; i ++) {
            VKTUser *user = self.message.users[i];
            if (user.photo_url.length > 0 && ![user.uid isEqualToNumber:[VKTUserToken userID]]) {
              [mutableSet addObject:[NSURL URLWithString:user.photo_url]];
            }
          }
        }
      } else {
        if (self.message.users.firstObject.photo_url.length > 0) {
          [mutableSet addObject:[NSURL URLWithString:self.message.users.firstObject.photo_url]];
        }
      }

    return [mutableSet allObjects];
}

- (VKTUserOnlineStatus )onlineStatus {
  if (self.message && self.message.users.firstObject && self.message.users.count == 1) {
    return [self.message.users.firstObject onlineStatus];
  }
  return VKTUserOffline;
}


@end
