//
//  VKTUserInfoService.m
//  VKTestExercise
//
//  Created by Alex Kosyakov on 08.01.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import "VKTUserInfoService.h"
#import "VKTService+VKRequestApi.h"


@implementation VKTUserInfoService
@synthesize parser;


- (void)getUsersInfo:(NSArray <NSNumber *> *)ids {
    if (!ids.count) {
        [self callDelegateWithResult:[self.parser resultWithError:[NSError errorWithDomain:@"" code:0 userInfo:nil]]];
        return;
    }
    NSDictionary *paramsDict = @{@"user_ids" : ids,
                                 @"fields" : @"photo_100, verified, online, has_mobile"};
    [self requestVKAPIMethod:kUsersGetInfoMethodName params:paramsDict
                  completion:^(VKResponse *response, NSError *error) {
        if (!error) {
            [self.parser makeResultFromResponse:response
                                     completion:self.resultCompletion];
            return;
        }
        [self callDelegateWithResult:[self.parser resultWithError:error]];
    }];
}
- (void)getGroupsInfo:(NSArray <NSNumber *> *)ids {
  if (!ids.count) {
    [self callDelegateWithResult:[self.parser resultWithError:[NSError errorWithDomain:@"" code:0 userInfo:nil]]];
    return;
  }
  NSDictionary *paramsDict = @{@"group_ids" : ids,
                               @"fields" : @"photo_100, verified, online, has_mobile"};
  [self requestVKAPIMethod:kGroupsGetInfoMethodName params:paramsDict
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
