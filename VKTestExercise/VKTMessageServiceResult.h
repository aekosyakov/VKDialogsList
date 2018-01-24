//
//  VKChatServiceResult.h
//  VKTestExercise
//
//  Created by Alex Kosyakov on 31.12.2017.
//  Copyright © 2017 Alex Kosyakov. All rights reserved.
//

#import "VKTServiceResult.h"
#import "VKTMessagesServiceProvider.h"
#import "VKTFetcherProtocol.h"
@class VKTMessage;
@interface VKTMessageServiceResult : VKTServiceResult <VKTMessagesResult>
@end
