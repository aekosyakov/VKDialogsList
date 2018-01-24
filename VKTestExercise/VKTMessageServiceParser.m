//
//  VKTMessageServiceParser.m
//  VKTestExercise
//
//  Created by Alex Kosyakov on 1/11/18.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import "VKTMessageServiceParser.h"
#import "VKTMessage+Extensions.h"
#import "VKTObject+JSONMapping.h"
#import "VKTMessageServiceResult.h"
#import "VKSDKHeader.h"
#import "NSNumber+PositiveValue.h"
#import "VKTMessage+Mapping.h"
#import "VKTMessageServiceDeleteResult.h"
#import "VKTPeerIDs.h"
#import "VKTMessageAvatarViewModel.h"
@interface VKTMessageServiceParser()

@end

@implementation VKTMessageServiceParser

- (NSObject <VKTServiceResult > *)resultWithError:(NSError *)error {
  id <VKTMessagesResult > result = [[VKTMessageServiceResult alloc] init];
  result.serviceType = VKServiceTypeMessages;
  result.error = error;
  if (!error) {
    result.error = [NSError errorWithDomain:@"" code:0 userInfo:nil];
  }
  return result;
}


- (NSObject <VKTServiceResult > *)resultForDeletedPeerID:(NSNumber *)peerID {
    id <VKTMessageDeleteResult > result = [[VKTMessageServiceDeleteResult alloc] init];
    result.serviceType = VKServiceTypeDeleteMessages;
    result.fetchType = VKTFetchTypeDelete;
    result.deletedIndex = [VKTPeerIDs removeID:peerID];
    
    NSArray *currentMessageIDS = [VKTPeerIDs getActualIDs];
    [VKTMessage deleteAllMatchingPredicate:[NSPredicate predicateWithFormat:@"not (peer_id IN %@)", currentMessageIDS]];
    NSPredicate *actualItemsPredicate = [NSPredicate predicateWithFormat:@"peer_id IN %@", currentMessageIDS];
    result.items = [VKTMessage findAllSortedBy:@"date" ascending:NO withPredicate:actualItemsPredicate];
    return result;
}


- (void)makeResultFromResponse:(VKResponse *)response fetchType:(VKTFetchType )fetchType completion:(void(^)(id <VKTMessagesResult > result))completion {
  if (![response.json respondsToSelector:@selector(objectForKey:)]) {
    if (completion) {
      completion(nil);
    }
    return;
  }
  
  NSArray *responseArray = response.json[@"items"];
  NSNumber *allItemsCount = [self numberOrNilFromValue:response.json[@"count"]];

  NSMutableArray *tempPeerIDsArray = [NSMutableArray arrayWithCapacity:responseArray.count];
  NSMutableArray *tempChatIDsArray = [NSMutableArray arrayWithCapacity:responseArray.count];
  NSMutableArray *tempMessageUserIDs = [NSMutableArray arrayWithCapacity:responseArray.count];
  NSMutableArray *tempMessageGroupIDs = [NSMutableArray arrayWithCapacity:responseArray.count];

  [NSManagedObjectContext saveDataInBackgroundWithBlock:^(NSManagedObjectContext *localContext) {
    for (NSDictionary *dict in responseArray) {
      if ([dict respondsToSelector:@selector(objectForKey:)]) {

          VKTMessage *message = [VKTMessage createNewOrUpdateExistedFromDict:dict context:localContext];
          
          if (message.peer_id && ![tempPeerIDsArray containsObject:message.peer_id]) {
               [tempPeerIDsArray addObject:message.peer_id];
          }
         
        if (message.chat_id && ![tempChatIDsArray containsObject:message.chat_id]) {
          [tempChatIDsArray addObject:message.chat_id];
        }
        
        NSDictionary *messageDict = dict[@"message"];
        NSNumber *userID = [self numberOrNilFromValue:messageDict[@"user_id"]];
        
        if (![tempMessageUserIDs containsObject:userID] && !message.chat_id && userID.integerValue > 0) {
          [tempMessageUserIDs addObject:message.user_id];
        }
        
        if (userID.integerValue < 0) {
          [tempMessageGroupIDs addObject:message.user_id];
        }

      }
    }
    
  } completion:^{

      id <VKTMessagesResult > result = [[VKTMessageServiceResult alloc] init];
      result.serviceType = VKServiceTypeMessages;
      result.chatIDsToUpdate = [NSArray arrayWithArray:tempChatIDsArray];
      result.userIDsToUpdate = [NSArray arrayWithArray:tempMessageUserIDs];
      result.groupIDsToUpdate = [NSArray arrayWithArray:tempMessageGroupIDs];
      result.allItemsCount = allItemsCount;
      NSArray *currentMessageIDs = [NSArray arrayWithArray:tempPeerIDsArray];
      
      switch (fetchType) {
          case VKTFetchTypeRefresh: {
              [VKTPeerIDs saveActualIDs:currentMessageIDs];
              [VKTMessage deleteAllMatchingPredicate:[NSPredicate predicateWithFormat:@"not (peer_id IN %@)", currentMessageIDs]];
              NSPredicate *actualItemsPredicate = [NSPredicate predicateWithFormat:@"peer_id IN %@", currentMessageIDs];
              result.items = [VKTMessage findAllSortedBy:@"date" ascending:NO withPredicate:actualItemsPredicate];;
          } break;
          case VKTFetchTypeLoadNext: {
              NSArray *oldActualIDs = [VKTPeerIDs getActualIDs];
              [VKTPeerIDs addActualIDs:currentMessageIDs];
              NSArray *actualIDs = [VKTPeerIDs getActualIDs];
              result.oldiItemsCount = @(oldActualIDs.count);
              NSPredicate *actualItemsPredicate = [NSPredicate predicateWithFormat:@"peer_id IN %@", actualIDs];
              result.items = [VKTMessage findAllSortedBy:@"date" ascending:NO withPredicate:actualItemsPredicate];;
              result.newiItemsCount = @(result.items .count);
          } break;
          default:
              break;
      }
      
    result.allItemsDidLoaded = result.items.count == allItemsCount.integerValue;
    if (completion) {
      completion(result);
    }
  }];
}


@end
