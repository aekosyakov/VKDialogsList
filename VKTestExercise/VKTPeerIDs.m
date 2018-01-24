//
//  VKTStorage.m
//  VKTestExercise
//
//  Created by Alex Kosyakov on 04.01.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import "VKTPeerIDs.h"
#import "VKTMessage+Extensions.h"
#import "VKTObject+JSONMapping.h"
#import "VKTCachedIDs.h"
static NSArray *__innerArray;
@import CoreData;

@interface VKTPeerIDs()

@end

@implementation VKTPeerIDs
+ (void)saveActualIDs:(NSArray <NSNumber *> *)ids {
    __innerArray = [NSArray arrayWithArray:ids];
    [VKTCachedIDs cacheIDs:__innerArray];
}


+ (void)addActualIDs:(NSArray <NSNumber *> *)ids {
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:__innerArray];
    [tempArray addObjectsFromArray:ids];
    __innerArray = [NSArray arrayWithArray:tempArray];
    [VKTCachedIDs cacheIDs:__innerArray];
}

+ (NSNumber *)removeID:(NSNumber *)uid {
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:__innerArray];
    NSUInteger deleteIndex = 0;
    if ([tempArray containsObject:uid]) {
        deleteIndex = [tempArray indexOfObject:uid];
        [tempArray removeObject:uid];
    }
    
    __innerArray = [NSArray arrayWithArray:tempArray];
    [VKTCachedIDs cacheIDs:__innerArray];
    return @(deleteIndex);
}

+ (NSArray <NSNumber *> *)getActualIDs {
    if (!__innerArray) {
        __innerArray = [VKTCachedIDs getCachedIDs];;
    }
    return [NSArray arrayWithArray:__innerArray];
}

+ (void)resetData {
    __innerArray = [NSArray array];
    [VKTCachedIDs resetCache];
}

+ (NSArray *)getActualItems {
    
    NSArray *currentMessageIDS = [VKTPeerIDs getActualIDs];
    //[VKTMessage deleteAllMatchingPredicate:[NSPredicate predicateWithFormat:@"not (peer_id IN %@)", currentMessageIDS]];
    NSPredicate *actualItemsPredicate = [NSPredicate predicateWithFormat:@"peer_id IN %@", currentMessageIDS];
    NSArray *items = [VKTMessage findAllSortedBy:@"date" ascending:NO withPredicate:actualItemsPredicate];
    return items;
}


@end
