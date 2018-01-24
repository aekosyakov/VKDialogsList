//
//  VKTCachedIDs.h
//  VKTestExercise
//
//  Created by Alex Kosyakov on 1/17/18.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VKTCachedIDs : NSObject
+ (void)cacheIDs:(NSArray <NSNumber *> *)ids;
+ (void)resetCache;
+ (NSArray <NSNumber *> *)getCachedIDs;
@end
