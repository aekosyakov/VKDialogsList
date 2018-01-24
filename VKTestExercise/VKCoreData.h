//
//  VKCoreData.h
//  VKPlus
//
//  Created by iFreeman on 27.11.12.
//  Copyright (c) 2012 Moche Apps Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSManagedObjectContext+VKExtensions.h"

#ifdef DEBUG
#    define VKDLog(...) NSLog(__VA_ARGS__)
#else
#    define VKDLog(...) /* */
#endif
#define VKALog(...) NSLog(__VA_ARGS__)

#define VKDLogCurrentMethod VKDLog(@"[%@ %@];", NSStringFromClass(self.class), NSStringFromSelector(_cmd))

@interface VKCoreData : NSObject

/* setup core data stack with project name filename */
+ (void)setupCoreDataStack;
/* setup core data stack with custom store filename */
+ (void)setupCoreDataStackWithStoreNamed:(NSString *)name;

+ (NSManagedObjectModel *)model;

@end
