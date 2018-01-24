//
//  VKTFetcherProtocol.h
//  VKTestExercise
//
//  Created by Alex Kosyakov on 1/15/18.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import <Foundation/Foundation.h>

//#import "VKTMessagesServiceProvider.h"
#import "VKTServiceProvider.h"

typedef NS_ENUM(NSUInteger, VKTFetchType) {
  VKTFetchTypeRefresh,
  VKTFetchTypeLoadNext,
  VKTFetchTypeDelete
};

@class VKTMessage;
@protocol VKTMessagesResult;
@protocol VKTFetchResultProtocol <NSObject>
@property (strong, nonatomic) NSArray *indexPathsToInsert;
@property (strong, nonatomic) NSArray *indexPathsToDelete;
@property (strong, nonatomic) NSArray *indexPathsToMove;
@property (strong, nonatomic) NSArray *fetchedItems;
@property (assign, nonatomic) BOOL hasChanges;
@property (assign, nonatomic) BOOL allItemsDidLoaded;
@property (assign, nonatomic) VKTFetchType fetchType;
- (instancetype)initWithResult:(NSObject <VKTMessagesResult > *)messageResult
                  currentItems:(NSArray <VKTMessage *>*)items;
@end

@protocol VKTFetchDelegate
- (void)fetcherDidFinishWithResult:(id <VKTFetchResultProtocol >)result;
@end

@protocol VKTFetcherProtocol <NSObject>
@property (strong, nonatomic) NSArray *items;
@property (weak, nonatomic) NSObject <VKTFetchDelegate > *delegate;
@property (strong, nonatomic) NSNumber *allItemsCount;
@property (strong, nonatomic) NSNumber *count;

- (BOOL)canLoadNext;
- (void)refreshData;
- (void)loadNextPage;
- (void)resetData;
- (void)deleteItemAtIndex:(NSUInteger )index;
- (BOOL)hasResults;
- (BOOL)checkForPreloadedData;
@end

