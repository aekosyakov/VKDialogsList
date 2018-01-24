//
//  VKChatServiceProvider.h
//  VKTestExercise
//
//  Created by Alex Kosyakov on 23.12.2017.
//  Copyright © 2017 Alex Kosyakov. All rights reserved.
//

#import "VKTServiceProvider.h"
#import "VKTFetcherProtocol.h"

@class VKTMessage;
@protocol VKTMessagesResult <VKTServiceResult>
@property (strong, nonatomic) NSArray <NSNumber *> *userIDsToUpdate;
@property (strong, nonatomic) NSArray <NSNumber *> *chatIDsToUpdate;
@property (strong, nonatomic) NSArray <NSNumber *> *groupIDsToUpdate;

@property (strong, nonatomic) NSArray <VKTMessage *> *items;
@property (assign, nonatomic) BOOL allItemsDidLoaded;

@property (assign, nonatomic) VKTFetchType fetchType;

@property (strong, nonatomic) NSNumber *allItemsCount;
@property (strong, nonatomic) NSNumber *newiItemsCount;
@property (strong, nonatomic) NSNumber *oldiItemsCount;
@end

@protocol VKTMessageNextResult <VKTMessagesResult>
@end

@protocol VKTMessageDeleteResult <VKTMessagesResult>
@property (strong, nonatomic) NSNumber *deletedIndex;
@end

@protocol VKTMessagesParser <VKTServiceParser>
- (void)makeResultFromResponse:(VKResponse *)response
                     fetchType:(VKTFetchType )fetchType
                    completion:(void(^)(id <VKTMessagesResult > result))completion;
- (id <VKTMessageDeleteResult > )resultForDeletedPeerID:(NSNumber *)peerID;
@end

@protocol VKTMessagesQuery
@property (strong, nonatomic) NSNumber *offset;
@property (strong, nonatomic) NSNumber *count;
@property (assign, nonatomic) VKTFetchType fetchType;
@end;


@class VKTMessage;
@protocol VKTMessagesServiceProvider <VKTServiceProvider>
@property (strong, nonatomic) id <VKTMessagesParser > parser;
- (void)loadMessages:(id <VKTMessagesQuery > )query;
- (void)deleteDialog:(NSNumber *)peer_id completion:(VKTServiceResultCompletion )completion;
@end
