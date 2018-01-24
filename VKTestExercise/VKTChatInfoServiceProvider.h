//
//  VKTChatInfoServiceProvider.h
//  VKTestExercise
//
//  Created by Alex Kosyakov on 1/11/18.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import "VKTServiceProvider.h"

@protocol VKTChatInfoResult <VKTServiceResult>
@property (nonatomic) NSUInteger itemsCount;
@end

@protocol VKTChatInfoParser
- (NSObject <VKTChatInfoResult > *)resultWithError:(NSError *)error;
- (void)makeResultFromResponse:(VKResponse *)response completion:(void(^)(NSObject <VKTChatInfoResult > * result))completion;
@end

@protocol VKTChatInfoServiceProvider <VKTServiceProvider>
@property (strong, nonatomic) id <VKTChatInfoParser >parser;
- (void)getChatsInfo:(NSArray <NSNumber *> *)chatIds;
@end
