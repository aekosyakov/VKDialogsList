//
//  NSManagedObjectContext+VKExtensions.m
//  VKPlus
//
//  Created by iFreeman on 21.11.12.
//  Copyright (c) 2012 Moche Apps Limited. All rights reserved.
//

#import "NSManagedObjectContext+VKExtensions.h"
#import "VKCoreData.h"
#import "VKCoreDataConsts.h"

@interface VKCoreData (Extended)
+ (NSManagedObjectContext *)mainThreadContext;
+ (NSManagedObjectContext *)privateThreadSavingManagedObjectContext;
+ (void)handleError:(NSError *)error;
+ (void)handleException:(NSException *)exception;
@end

@interface NSManagedObjectContext (VKExtensionsHidden)

/*
 * returns single background private NSManagedObjectContext which is used for DataBase disk writing.
 * actually in should not be used outside this class
 */
+ (NSManagedObjectContext *)privateBackgroundSavingContext;

@end

@implementation NSManagedObjectContext (VKExtensionsHidden)

+ (NSManagedObjectContext *)privateBackgroundSavingContext {
    return [VKCoreData privateThreadSavingManagedObjectContext];
}

@end

@implementation NSManagedObjectContext (VKExtensions)

+ (NSManagedObjectContext *)mainThreadContext {
    return [VKCoreData mainThreadContext];
}

+ (NSManagedObjectContext *)temploraryMainThreadContext {
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    context.parentContext = [self mainThreadContext];
    [context.userInfo setObject:[NSNumber numberWithInteger:VKCoreDataManagedObjectContextIDTempMainThread]
                         forKey:@"contextID"];
    [context.userInfo setObject:kVKCoreDataManagedObjectContextMainThreadTemp
                         forKey:@"contextDebugName"];
    VKDLog(@"* New mergable templorary mainthread context created! *");
    return context;
}

+ (NSManagedObjectContext *)currentThreadContext {
    if ([[NSThread currentThread] isMainThread]) {
        return [self mainThreadContext];
    }
    return [self newMergableBackgroundThreadContext];
}

+ (NSManagedObjectContext *)newMergableBackgroundThreadContext {
    return [self childTemploraryBackgroundContextForContext:[self mainThreadContext]];
}

+ (NSManagedObjectContext *)childTemploraryBackgroundContextForContext:(NSManagedObjectContext *)parentContext {
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    context.parentContext = parentContext;
    [context.userInfo setObject:[NSNumber numberWithInteger:VKCoreDataManagedObjectContextIDTempBackground]
                         forKey:@"contextID"];
    [context.userInfo setObject:kVKCoreDataManagedObjectContextBackgroundTemp
                         forKey:@"contextDebugName"];
    context.undoManager = nil;
    return context;
}

+ (void)saveDataInBackgroundWithBlock:(void(^)(NSManagedObjectContext *))saveBlock completion:(void(^)(void))completion {
    NSManagedObjectContext *tempContext = [self newMergableBackgroundThreadContext];
    [tempContext performBlock:^{
        
        if (saveBlock) {
            saveBlock(tempContext);
        }
        
        if ([tempContext hasChanges]) {
            [tempContext saveWithCompletion:completion];
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completion) {
                    completion();
                }
            });
        }
    }];
}

+ (void)saveDataWithBlock:(void(^)(void))block {
    [[[self class] mainThreadContext] performBlockAndWait:^{
        if (block) {
            block();
        }
        
        if (![[[self class] mainThreadContext] hasChanges]) {
            VKDLog(@"*** No changes were found in mainThreadContext! Save operation was cancelled! ***");
            return ;
        }
        
        NSError *mainThreadError = nil;
        if (![[[self class] mainThreadContext] save:&mainThreadError]) {
            [VKCoreData handleError:mainThreadError];
        }
        
        [[[self class] privateBackgroundSavingContext] performBlock:^{
            NSError *privateSavingError = nil;
            if (![[[self class] privateBackgroundSavingContext] save:&privateSavingError]) {
                [VKCoreData handleError:privateSavingError];
            }
        }];
    }];
}

- (void)saveWithCompletion:(void(^)(void))completion {
    [self performBlock:^{
        NSError *error = nil;
        if ([self save:&error]) {
            NSNumber *contextID = [self.userInfo objectForKey:@"contextID"];
            if (contextID.integerValue == VKCoreDataManagedObjectContextIDMainThread) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (completion) {
                        completion();
                    }
                });
            }
            [[self class] logContextSaved:self];
            if (self.parentContext) {
                [self.parentContext saveWithCompletion:completion];
            }
        } else {
            [VKCoreData handleError:error];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completion) {
                    completion();
                }
            });
        }
    }];
}

- (void)save {
    [self saveWithCompletion:NULL];
}

+ (void)logContextSaved:(NSManagedObjectContext *)context {
    VKDLog(@"%@", [NSString stringWithFormat:@"* Saving %@ context is DONE *", [context.userInfo objectForKey:@"contextDebugName"]]);
}

@end
