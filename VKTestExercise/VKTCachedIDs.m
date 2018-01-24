//
//  VKTCachedIDs.m
//  VKTestExercise
//
//  Created by Alex Kosyakov on 1/17/18.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import "VKTCachedIDs.h"
static NSString *const kCacheKey = @"CacheKey";
@implementation VKTCachedIDs

+ (void)cacheIDs:(NSArray <NSNumber *> *) ids{
    [[NSUserDefaults standardUserDefaults] setObject:ids forKey:kCacheKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (void)resetCache {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kCacheKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSArray <NSNumber *> *)getCachedIDs {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kCacheKey];;;
}

@end
