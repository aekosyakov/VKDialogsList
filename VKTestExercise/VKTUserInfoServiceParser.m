//
//  VKTUserInfoServiceParser.m
//  VKTestExercise
//
//  Created by Alex Kosyakov on 1/11/18.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import "VKTUserInfoServiceParser.h"
#import "VKSDKHeader.h"
#import "VKTObject+JSONMapping.h"

#import "NSManagedObject+Fetches.h"
#import "NSManagedObjectContext+VKExtensions.h"

#import "VKTUser+Extensions.h"
#import "VKTMessage+Extensions.h"

#import "VKTUserInfoServiсeResult.h"
#import "NSNumber+PositiveValue.h"

@implementation VKTUserInfoServiceParser


- (NSObject <VKTUserInfoResult > *)resultWithError:(NSError *)error {
  NSObject <VKTUserInfoResult > *result = [[VKTUserInfoServiсeResult alloc] init];
  result.error = error;
  result.serviceType = VKServiceTypeUserInfo;
  return result;
}

- (void)makeResultFromResponse:(VKResponse *)response completion:(void(^)(NSObject <VKTUserInfoResult > * result))completion {
  NSArray *responseArray = response.json;
  [NSManagedObjectContext saveDataInBackgroundWithBlock:^(NSManagedObjectContext *localContext) {
    for (NSDictionary *userDict in responseArray) {
      NSNumber *userID = userDict[@"id"];
      NSNumber *peerID = [NSNumber createPeerIDFromChatID:nil userID:userID];
      NSPredicate *userIDPresdicate = [NSPredicate predicateWithFormat:@"peer_id == %@", peerID];
      NSArray *foundDialogs = [VKTMessage findAllWithPredicate:userIDPresdicate inContext:localContext];

      for (VKTMessage *message in foundDialogs) {
        VKTUser *user = [VKTUser findFirstOneWithPredicate:[NSPredicate predicateWithFormat:@"(uid == %@) && (root_id == %@)", userID, message.peer_id] inContext:localContext];
        if (!user) {
          user = [VKTUser createEntityInContext:localContext];
        }
        [user updateDataFromJSONDict:userDict managedObjectContext:localContext];
        user.root_id = message.peer_id;
        message.users = [NSOrderedSet orderedSetWithObject:user];
      }
    }
    
  } completion:^{
    id <VKTUserInfoResult > result = [[VKTUserInfoServiсeResult alloc] init];
    result.serviceType = VKServiceTypeUserInfo;
    if (completion) {
      completion(result);
    }
  }];
  
}


@end
