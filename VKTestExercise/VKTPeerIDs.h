//
//  VKTStorage.h
//  VKTestExercise
//
//  Created by Alex Kosyakov on 04.01.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VKTPeerIDs : NSObject
+ (void)saveActualIDs:(NSArray <NSNumber *> *)ids;
+ (void)addActualIDs:(NSArray <NSNumber *> *)ids;
+ (NSNumber *)removeID:(NSNumber *)uid;
+ (NSArray <NSNumber *> *)getActualIDs;
+ (void)resetData;
+ (NSArray *)getActualItems;


@end
