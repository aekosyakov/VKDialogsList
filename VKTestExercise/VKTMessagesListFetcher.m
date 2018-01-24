//
//  VKTMessagesListFetcher.m
//  VKTestExercise
//
//  Created by Alex Kosyakov on 1/15/18.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import "VKTMessagesListFetcher.h"
#import "VKTMessagesService.h"
#import "VKTMessageServiceParser.h"
#import "VKTMessageServiceResult.h"
#import "VKTMessageFetchResult.h"
#import "VKTMessagesQuery.h"
#import "NSManagedObject+Fetches.h"
#import "VKTMessage+Extensions.h"
#import "VKTPeerIDs.h"

static NSUInteger const kMaxRefreshBatchSize = 100;
static NSUInteger const kDefaultBatchSize = 20;

@interface VKTMessagesListFetcher() <VKTServiceDelegate>
@property (strong, nonatomic) VKTMessagesService *messageService;
@property (strong, nonatomic) VKTServiceParser *parser;
@property (assign, nonatomic) BOOL allItemsDidLoaded;
@end

@implementation VKTMessagesListFetcher
@synthesize items, count, delegate, allItemsCount;


- (instancetype)initWithMessageService:(id <VKTMessagesServiceProvider > )service {
  if (self = [super init]) {
      self.messageService = service;
      __weak typeof (self) self_ = self;
      self.messageService.resultCompletion = ^(NSObject<VKTServiceResult> *result) {
          [self_ serviceDidFinishWithResult:result];
      };
  }
  return self;
}



- (BOOL)checkForPreloadedData {
    self.items = [VKTPeerIDs getActualItems];
    return self.items.count > 0;
}

- (void)refreshData {
    if (![VKTNetworkReachability isReachable]) {
      return;
    }
    [self.messageService loadMessages:[self queryTypeRefresh]];
}

- (BOOL)canLoadNext {
    return (self.items.count != self.allItemsCount.integerValue) && ([VKTNetworkReachability isReachable]);
}

- (void)loadNextPage {
    if (self.allItemsDidLoaded) {
        return;
    }
    [self.messageService loadMessages:[self queryTypeLoadNext]];
}

- (void)deleteItemAtIndex:(NSUInteger )index {
    [self.messageService deleteDialog:[self.items[index] peer_id] completion:^(id <VKTMessageDeleteResult> result) {
        if (result.error || !result) {
          [self.delegate fetcherDidFinishWithResult:nil];
        }
        if (result.fetchType == VKTFetchTypeDelete) {
            result.deletedIndex = @(index);
            VKTMessageFetchResult *fetchResult = [[VKTMessageFetchResult alloc] initWithResult:result
                                                                                      currentItems:self.items];
            if (fetchResult.fetchedItems.count > 0) {
              self.items = [NSArray arrayWithArray:fetchResult.fetchedItems];
            }
            self.allItemsCount = @(self.allItemsCount.integerValue - 1);
            [self.delegate fetcherDidFinishWithResult:fetchResult];
        }
    }];
}

- (void)resetData {
  [VKTPeerIDs resetData];
  [VKTMessage deleteAll];
  self.allItemsDidLoaded = NO;
  self.items = [NSArray array];
}

- (BOOL)hasResults {
  return @(self.items.count).boolValue;
}

- (void)serviceDidFinishWithResult:(id <VKTServiceResult> )result {
  if (!result || result.error) {
    [self.delegate fetcherDidFinishWithResult:nil];
    return;
  }
    id <VKTMessagesResult > messageResult = (id <VKTMessagesResult >)result;
    VKTMessageFetchResult *fetchResult= [[VKTMessageFetchResult alloc] initWithResult:messageResult
                                                                         currentItems:self.items];
    self.allItemsCount = messageResult.allItemsCount;
    if (fetchResult.fetchedItems.count > 0) {
      self.items = [NSArray arrayWithArray:fetchResult.fetchedItems];
    }
    [self.delegate fetcherDidFinishWithResult:fetchResult];
}


- (VKTMessagesQuery *)queryTypeLoadNext {
  VKTMessagesQuery *query = [[VKTMessagesQuery alloc] init];
  query.fetchType = VKTFetchTypeLoadNext;
  query.count = @(kDefaultBatchSize);
  query.offset = @(self.items.count - 1);
  return query;
}

- (VKTMessagesQuery *)queryTypeRefresh {
  VKTMessagesQuery *query = [[VKTMessagesQuery alloc] init];
  query.fetchType = VKTFetchTypeRefresh;
  query.count = [self hasResults] ? self.items.count > kMaxRefreshBatchSize ? @(kMaxRefreshBatchSize) : @(self.items.count) : @(kDefaultBatchSize);
  query.offset = @0;
  return query;
}

@end
