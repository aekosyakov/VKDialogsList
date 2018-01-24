//
//  VKTMessage+Extensions.m
//  VKTestExercise
//
//  Created by Alex Kosyakov on 1/9/18.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import "VKTMessage+Extensions.h"
#import "NSNumber+PositiveValue.h"

@implementation VKTMessage (Extensions)

- (BOOL)isChat {
  return self.chat_id != nil && self.chat_id.integerValue != 0;
}

- (NSPredicate *)comparePredicate {
  return  [NSPredicate predicateWithFormat:@"peer_id == %@",  self.peer_id];
}

- (NSNumber *)getPeerID {
    return [NSNumber createPeerIDFromChatID:self.chat_id
                                     userID:self.user_id];
    
}

@end
