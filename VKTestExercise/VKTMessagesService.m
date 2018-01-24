//
//  VKChatService.m
//  VKTestExercise
//
//  Created by Alex Kosyakov on 23.12.2017.
//  Copyright © 2017 Alex Kosyakov. All rights reserved.
//

#import "VKTMessagesService.h"
#import "VKSDKHeader.h"

#import "VKTService+Extensions.h"
#import "VKTService+VKRequestApi.h"
#import "VKTPeerIDs.h"

@implementation VKTMessagesService
@synthesize parser;


- (void)loadMessages:(id <VKTMessagesQuery > )query {
  if (self.isResfreshing) {
    return;
  }
    NSDictionary *paramsDict = @{@"count" : query.count,
                                 @"offset" : query.offset};
    self.refreshing = YES;
    [self requestVKAPIMethod:kGetDialogsMethodName params:paramsDict
                  completion:^(VKResponse *response, NSError *error) {
        if (!error && response) {
            [self.parser makeResultFromResponse:response fetchType:query.fetchType completion:^(id <VKTMessagesResult> messageResult) {
                [self updateAdditionalInfoFromResult:messageResult completion:^(NSObject<VKTServiceResult> *result) {
                    messageResult.fetchType = query.fetchType;
                    [self callDelegateWithResult:messageResult];
                }];
            }];
            return;
        }
                    
        [self callDelegateWithResult:[self.parser resultWithError:[NSError errorWithDomain:@"" code:0 userInfo:nil]]];
    }];
    
    NSLog(@"loadMessages count %@ offset %@", query.count, query.offset);
}


- (void)updateAdditionalInfoFromResult:(id <VKTMessagesResult> )messageResult
                            completion:(VKTServiceResultCompletion )completion {
    dispatch_group_t group = dispatch_group_create();
    if (messageResult.userIDsToUpdate.count > 0) {
        dispatch_group_enter(group);
        [VKTService getUsersInfo:messageResult.userIDsToUpdate
                      completion:^(id <VKTServiceResult> result) {
            dispatch_group_leave(group);
        }];
    }
    
    if (messageResult.chatIDsToUpdate.count > 0) {
        dispatch_group_enter(group);
        [VKTService getChatsInfo:messageResult.chatIDsToUpdate
                      completion:^(id <VKTServiceResult> result) {
            dispatch_group_leave(group);
        }];
    }
  
    if (messageResult.groupIDsToUpdate.count > 0) {
        dispatch_group_enter(group);
        [VKTService getGroupsInfo:messageResult.groupIDsToUpdate
                       completion:^(id <VKTServiceResult> result) {
          dispatch_group_leave(group);
        }];
    }
  
      dispatch_group_notify(group, dispatch_get_main_queue(), ^{
          if (completion){
              completion(messageResult);
          }
      });
}

- (void)deleteDialog:(NSNumber *)peer_id completion:(VKTServiceResultCompletion )completion {
      if (!peer_id) {
        return;
      }
    
    NSDictionary *paramsDict = @{@"peer_id": peer_id};
    [self requestVKAPIMethod:kDeleteDialogsMethodName params:paramsDict
                  completion:^(VKResponse *response, NSError *error) {
                      NSNumber *responseNum = (NSNumber *)response.json;
                      if (responseNum && [responseNum respondsToSelector:@selector(integerValue)]) {
                          if ([responseNum integerValue] == 1) {
                              if (completion) {
                                  completion([self.parser resultForDeletedPeerID:peer_id]);
                              }
                              return;
                          }
                      }
                      if (completion) {
                          completion([self.parser resultWithError:error]);
                      }
                      self.refreshing = NO;
                  }];
}

@end
