//
//  VKTService+Extensions.m
//  VKTestExercise
//
//  Created by Alex Kosyakov on 20.01.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import "VKTService+Extensions.h"
#import "VKTServiceHeader.h"

@implementation VKTService (Extensions)

#pragma mark Services
+ (id <VKTAuthServiceProvider > )authService {
    id <VKTAuthServiceProvider > service = [[VKTAuthService alloc] init];
    service.parser = [[self class] authParser];
    return service;
}

+ (id <VKTUserInfoServiceProvider> )userInfoSerivce {
    id <VKTUserInfoServiceProvider > service = [[VKTUserInfoService alloc] init];
    service.parser = [[self class] userInfoParser];
    return service;
}

+ (id <VKTMessagesServiceProvider> )messagesService {
    id <VKTMessagesServiceProvider > service = [[VKTMessagesService alloc] init];
    service.parser = [[self class] messagesParser];
    return service;
}

+ (id <VKTChatInfoServiceProvider> )chatInfoService {
    id <VKTChatInfoServiceProvider > service = [[VKTChatInfoService alloc] init];
    service.parser = [[self class] chatInfoParser];
    return service;
}


#pragma mark Parsers
+ (id <VKTAuthParser > )authParser {
    id <VKTAuthParser > parser = [[VKTAuthParser alloc] init];
    return parser;
}

+ (id <VKTUserInfoParser > )userInfoParser {
    id <VKTUserInfoParser > parser = [[VKTUserInfoServiceParser alloc] init];
    return parser;
}

+ (id <VKTMessagesParser > )messagesParser {
    id <VKTMessagesParser > parser = [[VKTMessageServiceParser alloc] init];
    return parser;
}

+ (id <VKTChatInfoParser > )chatInfoParser {
    id <VKTChatInfoParser > parser = [[VKTChatInfoServiceParser alloc] init];
    return parser;
}


+ (void)getUsersInfo:(NSArray <NSNumber *> *)ids completion:(VKTServiceResultCompletion )completion {
    [[self userInfoSerivce] getUsersInfo:ids ];
    id <VKTUserInfoServiceProvider > service = [self userInfoSerivce];
    service.resultCompletion = completion;
    [service getUsersInfo:ids];
    
}

+ (void)getChatsInfo:(NSArray <NSNumber *> *)chatIds completion:(VKTServiceResultCompletion )completion {
    id <VKTChatInfoServiceProvider > service = [self chatInfoService];
    service.resultCompletion = completion;
    [service getChatsInfo:chatIds];
}

+ (void)getGroupsInfo:(NSArray <NSNumber *> *)groupIds completion:(VKTServiceResultCompletion )completion {
  id <VKTUserInfoServiceProvider > service = [self userInfoSerivce];
  service.resultCompletion = completion;
  [service getGroupsInfo:groupIds];
}

+ (void)deleteMessages:(NSNumber *)peer_id completion:(VKTServiceResultCompletion )completion {
    id <VKTMessagesServiceProvider > service = [self messagesService];
    service.resultCompletion = completion;
    [service deleteDialog:peer_id completion:completion];
}

@end
