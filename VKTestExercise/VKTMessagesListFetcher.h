//
//  VKTMessagesListFetcher.h
//  VKTestExercise
//
//  Created by Alex Kosyakov on 1/15/18.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VKTFetcherProtocol.h"
#import "VKTMessagesServiceProvider.h"

@interface VKTMessagesListFetcher : NSObject <VKTFetcherProtocol>
@property (strong, nonatomic, readonly) NSArray <NSNumber *> *allMessageIDs;
- (instancetype)initWithMessageService:(id <VKTMessagesServiceProvider > )service;
@end
