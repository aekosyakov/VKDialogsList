//
//  VKTChatInfoServiceParser.m
//  VKTestExercise
//
//  Created by Alex Kosyakov on 1/11/18.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import "VKTChatInfoServiceParser.h"
#import "VKSDKHeader.h"
#import "VKTObject+JSONMapping.h"

#import "VKTChatInfoServiceResult.h"
#import "VKTMessage+Extensions.h"
#import "VKTUser+Extensions.h"
#import "NSNumber+PositiveValue.h"

@implementation VKTChatInfoServiceParser

- (NSObject <VKTChatInfoResult > *)resultWithError:(NSError *)error {
  NSObject <VKTChatInfoResult > *result = [[VKTChatInfoServiceResult alloc] init];
  result.error = error;
  result.serviceType = VKServiceTypeChatInfo;
  return result;
}

- (void)makeResultFromResponse:(VKResponse *)response completion:(void(^)(NSObject <VKTChatInfoResult > * result))completion {
  NSArray *responseArray = response.json;
  [NSManagedObjectContext saveDataInBackgroundWithBlock:^(NSManagedObjectContext *localContext) {
    for (NSDictionary *chatDict in responseArray) {
      NSNumber *chatID = chatDict[@"id"];
      NSNumber *peerID = [NSNumber createPeerIDFromChatID:chatID userID:nil];
      VKTMessage *chat = [VKTMessage findFirstOneWithPredicate:[NSPredicate predicateWithFormat:@"peer_id == %@", peerID] inContext:localContext];
      if (chat) {
        
        NSArray *users = chatDict[@"users"];
        NSMutableOrderedSet *tempOrderedSet = [NSMutableOrderedSet orderedSet];
        for (NSDictionary *userDict in users) {
          NSNumber *userID = userDict[@"id"];
          
          VKTUser *user = [VKTUser findFirstOneWithPredicate:[NSPredicate predicateWithFormat:@"(uid == %@) && (root_id == %@)", userID, chat.peer_id] inContext:localContext];
          if (!user) {
            user = [VKTUser createEntityInContext:localContext];
          }
          [user updateDataFromJSONDict:userDict managedObjectContext:localContext];
          user.root_id = chat.peer_id;
          [tempOrderedSet addObject:user];
        }

          chat.users = [NSOrderedSet orderedSetWithOrderedSet:tempOrderedSet];
      }
    }
  } completion:^{
    id <VKTChatInfoResult > result = [[VKTChatInfoServiceResult alloc] init];
    result.serviceType = VKServiceTypeChatInfo;
    if (completion) {
      completion(result);
    }
  }];
}

@end
