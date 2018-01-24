//
//  VKTMessagesFetcherResult.m
//  VKTestExercise
//
//  Created by Alex Kosyakov on 1/15/18.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import "VKTMessageFetchResult.h"
#import "VKTMessagesServiceProvider.h"
#import "VKTMessage+Extensions.h"
#import "NSIndexPath+Extensions.h"
#import "VKTMessageFetchResult.h"
#import "VKTPeerIDs.h"

@implementation VKTMessageFetchResult
@synthesize indexPathsToMove, indexPathsToDelete, indexPathsToInsert, hasChanges, allItemsDidLoaded, fetchType, fetchedItems;


- (instancetype)initWithResult:(NSObject <VKTMessagesResult > *)messageResult
                  currentItems:(NSArray <VKTMessage *>*)items {
  if (self = [super init]) {
   
    NSArray *indexPathsToInsert = nil;
    NSArray *indexPathsToDelete = nil;
    NSArray *indexPathsToMove   = nil;
    
    NSArray *oldResults = [NSArray arrayWithArray:items];
    BOOL hasOldResults = oldResults.count > 0;
    NSArray *results = [NSArray arrayWithArray:messageResult.items];
   
    switch (messageResult.fetchType) {
      case VKTFetchTypeRefresh: {
        if (!hasOldResults) {
          indexPathsToInsert = [NSIndexPath indexPathsForCount:results.count];
        }
        self.fetchedItems = [NSArray arrayWithArray:results];
      }
        break;
        
      case VKTFetchTypeLoadNext: {
        if (!hasOldResults) {
          indexPathsToInsert = [NSIndexPath indexPathsForCount:results.count];
        } else {
          NSUInteger deltaCount = messageResult.newiItemsCount.integerValue - items.count;
          
          indexPathsToInsert = [NSIndexPath indexPathsForCount:deltaCount fromIndex:items.count];
          self.fetchedItems = [NSArray arrayWithArray:results];
        }
        break;
      }
      case VKTFetchTypeDelete: {
        id <VKTMessageDeleteResult > deleteResult = (id <VKTMessageDeleteResult >) messageResult;
        
        indexPathsToDelete = @[[NSIndexPath indexPathForRow:deleteResult.deletedIndex.integerValue inSection:0]];
        NSMutableArray *tempArray = [NSMutableArray arrayWithArray:items];
        if (tempArray.count > deleteResult.deletedIndex.integerValue) {
          [tempArray removeObjectAtIndex:deleteResult.deletedIndex.integerValue];
          self.fetchedItems = [NSArray arrayWithArray:tempArray];
        }
      } break;
      default:
        break;
    }
    
    self.indexPathsToInsert = [NSArray arrayWithArray:indexPathsToInsert];
    self.indexPathsToMove   = [NSArray arrayWithArray:indexPathsToMove];;
    self.indexPathsToDelete = [NSArray arrayWithArray:indexPathsToDelete];;
    self.allItemsDidLoaded  = messageResult.allItemsDidLoaded;
    self.fetchType          = messageResult.fetchType;
  }
  return self;
}



@end
