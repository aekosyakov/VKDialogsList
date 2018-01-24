//
//  VKTChatInfoService.m
//  VKTestExercise
//
//  Created by Alex Kosyakov on 1/11/18.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import "VKTChatInfoService.h"
#import "VKTService+VKRequestApi.h"

@implementation VKTChatInfoService
@synthesize parser;

- (void)getChatsInfo:(NSArray <NSNumber *> *)chatIds  {
    if (!chatIds.count) {
        [self callDelegateWithResult:[self.parser resultWithError:[NSError errorWithDomain:@"" code:0 userInfo:nil]]];
    }
  
    NSDictionary *paramsDict = @{@"chat_ids" : chatIds,
                                 @"fields" : @"photo_100, verified"};
    [self requestVKAPIMethod:kChatsGetMethodName params:paramsDict
                  completion:^(VKResponse *response, NSError *error) {
      if (!error) {
          [self.parser makeResultFromResponse:response
                                   completion:self.resultCompletion];
          return;
      }
      [self callDelegateWithResult:[self.parser resultWithError:error]];
    }];
}

@end
