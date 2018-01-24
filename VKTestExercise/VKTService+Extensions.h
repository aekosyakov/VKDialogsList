//
//  VKTService+Extensions.h
//  VKTestExercise
//
//  Created by Alex Kosyakov on 20.01.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import "VKTService.h"
#import "VKTAuthServiceProvider.h"
#import "VKTUserInfoServiceProvider.h"
#import "VKTMessagesServiceProvider.h"
#import "VKTChatInfoServiceProvider.h"

@interface VKTService (Extensions)

+ (id <VKTAuthServiceProvider > )authService;
+ (id <VKTUserInfoServiceProvider> )userInfoSerivce;
+ (id <VKTMessagesServiceProvider> )messagesService;
+ (id <VKTChatInfoServiceProvider> )chatInfoService;


+ (void)getUsersInfo:(NSArray <NSNumber *> *)ids completion:(VKTServiceResultCompletion )completion;
+ (void)getChatsInfo:(NSArray <NSNumber *> *)chatIds completion:(VKTServiceResultCompletion )completion;
+ (void)getGroupsInfo:(NSArray <NSNumber *> *)groupIds completion:(VKTServiceResultCompletion )completion;
@end
