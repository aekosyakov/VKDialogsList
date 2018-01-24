//
//  VKCoreData.m
//  VKPlus
//
//  Created by iFreeman on 27.11.12.
//  Copyright (c) 2012 Moche Apps Limited. All rights reserved.
//

#import "VKCoreData.h"
#import "VKCoreDataConsts.h"

static NSManagedObjectContext *__privateThreadSavingContext = nil;
static NSManagedObjectContext *__mainThreadContext = nil;

static NSManagedObjectModel *__managedObjectModel = nil;

static NSPersistentStoreCoordinator *__persistentStoreCoordinator = nil;

static NSString *__storeName = nil;

@interface VKCoreData (Extended)
+ (NSManagedObjectContext *)mainThreadContext;
+ (NSManagedObjectContext *)privateThreadSavingManagedObjectContext;

+ (void)handleError:(NSError *)error;
+ (void)handleException:(NSException *)exception;
@end

@implementation VKCoreData (Extended)

#pragma mark - Core Data stack

+ (NSManagedObjectContext *)mainThreadContext {
    @synchronized (self) {
        if (!__mainThreadContext) {
            [self setupCoreDataStack];
        }
        return __mainThreadContext;
    }
}

+ (NSManagedObjectContext *)privateThreadSavingManagedObjectContext {
    if (__privateThreadSavingContext != nil) {
        return __privateThreadSavingContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        __privateThreadSavingContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        [__privateThreadSavingContext performBlockAndWait:^{
            [__privateThreadSavingContext setPersistentStoreCoordinator:coordinator];
        }];
        [__privateThreadSavingContext.userInfo setObject:[NSNumber numberWithInteger:VKCoreDataManagedObjectContextIDBackgroundRoot]
                                                  forKey:@"contextID"];
        [__privateThreadSavingContext.userInfo setObject:kVKCoreDataManagedObjectContextBackgroundRoot
                                                  forKey:@"contextDebugName"];
        __privateThreadSavingContext.undoManager = nil;
    }
    return __privateThreadSavingContext;
}

+ (NSManagedObjectModel *)managedObjectModel {
    if (__managedObjectModel != nil) {
        return __managedObjectModel;
    }
	NSURL *modelURL = [[NSBundle mainBundle] URLForResource:__storeName withExtension:@"momd"];
    if (!modelURL) {
        modelURL = [[NSBundle mainBundle] URLForResource:__storeName withExtension:@"mom"];
	}
	__managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return __managedObjectModel;
}

+ (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (__persistentStoreCoordinator != nil) {
        return __persistentStoreCoordinator;
    }
	NSString *storeName = [NSString stringWithFormat:@"%@.sqlite", __storeName];
	NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:storeName];
    
	__persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    NSError *error = nil;
	__unused NSPersistentStore *store = [__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
																				   configuration:nil
																							 URL:storeURL
																						 options:[self automigratingOptions]
																						   error:&error];
    return __persistentStoreCoordinator;
}

+ (NSDictionary *)automigratingOptions {
	NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES, NSSQLitePragmasOption:@{@"journal_mode":@"delete"}};
    return options;
}


#pragma mark - Application's Documents directory

+ (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark - error handling

+ (void)handleError:(NSError *)error {
    if (error) {
        VKDLog(@"*** VKCoreData error: %@ ***", [error localizedDescription]);
    }
}

+ (void)handleException:(NSException *)exception {
    if (exception) {
        VKDLog(@"*** VKCoreData exception: \n reason: %@\n stack trace: %@", [exception reason], [exception callStackSymbols]);
    }
}

@end

@implementation VKCoreData

+ (NSManagedObjectModel *)model
{
	return [self managedObjectModel];
}

+ (void)setupCoreDataStack {
    [self setupCoreDataStackWithStoreNamed:@"Model"];
}

+ (void)setupCoreDataStackWithStoreNamed:(NSString *)name {
    if (__mainThreadContext == nil) {
        __storeName = name;
        __mainThreadContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        __mainThreadContext.parentContext = [self privateThreadSavingManagedObjectContext];
        [__mainThreadContext.userInfo setObject:[NSNumber numberWithInteger:VKCoreDataManagedObjectContextIDMainThread]
                                         forKey:@"contextID"];
        [__mainThreadContext.userInfo setObject:kVKCoreDataManagedObjectContextMainThread
                                         forKey:@"contextDebugName"];
        __mainThreadContext.undoManager = nil;
    }
}

@end
