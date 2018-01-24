//
//  NSManagedObjectContext+VKExtensions.h
//  VKPlus
//
//  Created by iFreeman on 21.11.12.
//  Copyright (c) 2012 Moche Apps Limited. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObjectContext (VKExtensions)

/*
 * returns single main thread NSManagedObjectContext with concurrency type NSMainQueueConcurrencyType
 */
+ (NSManagedObjectContext *)mainThreadContext;

/*
 * returns templorary main thread NSManagedObjectContext (NSMainQueueConcurrencyType).
 */
+ (NSManagedObjectContext *)temploraryMainThreadContext;

/*
 * returns mainThreadContext when called on main thread, and creates new NSManagedObjectContext on background threads.
 */
+ (NSManagedObjectContext *)currentThreadContext;

/*
 * returns new configured instance of NSManagedObjectContext with parentContext = income context
*/
+ (NSManagedObjectContext *)childTemploraryBackgroundContextForContext:(NSManagedObjectContext *)context;

/*
 * saving data in backround with block, creates localContext to work with. 
 * all changes you made in block will be saved and automerged with main thread context, completion will fired after that.
 * next all changes will be merged and saved in private background data base writing queue.
 */
+ (void)saveDataInBackgroundWithBlock:(void(^)(NSManagedObjectContext *localContext))saveBlock
                           completion:(void(^)(void))completion;

/*
 * saving data on main thread, can be used only with Main Thread ManagedObjectContext with -perfomBlock: method call
 */
+ (void)saveDataWithBlock:(void(^)(void))block;

/*
 * saving data on main thread, can be used only with Main Thread ManagedObjectContext with -perfomBlockAndWait: method call
 */
- (void)saveWithCompletion:(void(^)(void))completion;

/*
 simple saving NSManagedObjectContext on main thread. this method call will be ignored for non main thread context
 */
- (void)save;

@end
