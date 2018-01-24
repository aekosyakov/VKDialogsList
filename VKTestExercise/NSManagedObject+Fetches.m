//
//  NSManagedObject+Fetches.m
//  VKPlus
//
//  Created by iFreeman on 27.11.12.
//  Copyright (c) 2012 Moche Apps Limited. All rights reserved.
//

#import "NSManagedObject+Fetches.h"
#import "VKCoreData.h"
#import "NSManagedObjectContext+VKExtensions.h"

@interface VKCoreData (Extended)
+ (NSManagedObjectContext *)mainThreadContext;
+ (NSManagedObjectContext *)privateThreadSavingManagedObjectContext;

+ (void)handleError:(NSError *)error;
+ (void)handleException:(NSException *)exception;
@end

@implementation NSManagedObject (Fetches)

+ (NSArray *)executeFetchRequest:(NSFetchRequest *)request inContext:(NSManagedObjectContext *)context {
	NSError *error = nil;
	NSArray *results = [context executeFetchRequest:request error:&error];
    
    if (results == nil) {
        [VKCoreData handleError:error];
    }
	return results;
}

+ (NSArray *)executeFetchRequest:(NSFetchRequest *)request {
	return [self executeFetchRequest:request inContext:[NSManagedObjectContext mainThreadContext]];
}

+ (NSString *)entityName {
    return NSStringFromClass(self);
}

+ (NSEntityDescription *)entityDescriptionInContext:(NSManagedObjectContext *)context {
  NSString *entityName = [self entityName];
  return [NSEntityDescription entityForName:entityName inManagedObjectContext:context];
}

+ (NSEntityDescription *)entityDescription {
	return [self entityDescriptionInContext:[NSManagedObjectContext mainThreadContext]];
}

+ (NSArray *)sortAscending:(BOOL)ascending attributes:(NSArray *)attributesToSortBy {
	NSMutableArray *attributes = [NSMutableArray array];
    
    for (NSString *attributeName in attributesToSortBy) {
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:attributeName ascending:ascending];
        [attributes addObject:sortDescriptor];
    }
	return attributes;
}

+ (NSArray *)ascendingSortDescriptors:(NSArray *)attributesToSortBy {
	return [self sortAscending:YES attributes:attributesToSortBy];
}

+ (NSArray *)descendingSortDescriptors:(NSArray *)attributesToSortBy {
	return [self sortAscending:NO attributes:attributesToSortBy];
}

+ (NSFetchRequest *)createFetchRequestInContext:(NSManagedObjectContext *)context {
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setEntity:[self entityDescriptionInContext:context]];
    return request;
}

+ (NSFetchRequest *)createFetchRequest {
	return [self createFetchRequestInContext:[NSManagedObjectContext mainThreadContext]];
}

#pragma mark - count of entities requests

+ (NSNumber *)numberOfEntitiesWithContext:(NSManagedObjectContext *)context {
	return [NSNumber numberWithUnsignedInteger:[self countOfEntitiesWithContext:context]];
}

+ (NSNumber *)numberOfEntities {
	return [self numberOfEntitiesWithContext:[NSManagedObjectContext mainThreadContext]];
}

+ (NSNumber *)numberOfEntitiesWithPredicate:(NSPredicate *)searchTerm inContext:(NSManagedObjectContext *)context {
	return [NSNumber numberWithUnsignedInteger:[self countOfEntitiesWithPredicate:searchTerm inContext:context]];
}

+ (NSNumber *)numberOfEntitiesWithPredicate:(NSPredicate *)searchTerm {
	return [self numberOfEntitiesWithPredicate:searchTerm
                                     inContext:[NSManagedObjectContext mainThreadContext]];
}

+ (NSUInteger)countOfEntities {
    return [self countOfEntitiesWithContext:[NSManagedObjectContext mainThreadContext]];
}

+ (NSUInteger)countOfEntitiesWithContext:(NSManagedObjectContext *)context; {
	NSError *error = nil;
	NSUInteger count = [context countForFetchRequest:[self createFetchRequestInContext:context] error:&error];
	[VKCoreData handleError:error];
    return count;
}

+ (NSUInteger)countOfEntitiesWithPredicate:(NSPredicate *)searchFilter; {
    return [self countOfEntitiesWithPredicate:searchFilter inContext:[NSManagedObjectContext mainThreadContext]];
}

+ (NSUInteger)countOfEntitiesWithPredicate:(NSPredicate *)searchFilter inContext:(NSManagedObjectContext *)context; {
	NSError *error = nil;
	NSFetchRequest *request = [self createFetchRequestInContext:context];
	[request setPredicate:searchFilter];
	
	NSUInteger count = [context countForFetchRequest:request error:&error];
	[VKCoreData handleError:error];
    
    return count;
}

+ (BOOL)hasAtLeastOneEntity {
    return [self hasAtLeastOneEntityInContext:[NSManagedObjectContext mainThreadContext]];
}

+ (BOOL)hasAtLeastOneEntityInContext:(NSManagedObjectContext *)context {
    return [[self numberOfEntitiesWithContext:context] intValue] > 0;
}

#pragma mark - fetch requests

+ (NSFetchRequest *)requestAll {
	return [self createFetchRequestInContext:[NSManagedObjectContext mainThreadContext]];
}

+ (NSFetchRequest *)requestAllInContext:(NSManagedObjectContext *)context {
	return [self createFetchRequestInContext:context];
}

+ (NSFetchRequest *)requestOneEntityWithPredicate:(NSPredicate *)predicate {
    return [self requestOneEntityWithPredicate:predicate inContext:[NSManagedObjectContext mainThreadContext]];
}

+ (NSFetchRequest *)requestOneEntityWithPredicate:(NSPredicate *)predicate
                                        inContext:(NSManagedObjectContext *)context {
    NSFetchRequest *request = [self createFetchRequestInContext:context];
    request.predicate = predicate;
    request.fetchLimit = 1;
    request.fetchBatchSize = 1;
    request.includesPropertyValues = NO;
    return request;
}

+ (NSFetchRequest *)requestAllWithPredicate:(NSPredicate *)searchTerm {
    return [self requestAllWithPredicate:searchTerm inContext:[NSManagedObjectContext mainThreadContext]];
}

+ (NSFetchRequest *)requestAllWithPredicate:(NSPredicate *)searchTerm
                                  inContext:(NSManagedObjectContext *)context; {
    NSFetchRequest *request = [self createFetchRequestInContext:context];
    [request setPredicate:searchTerm];
    return request;
}

+ (NSFetchRequest *)requestAllWhere:(NSString *)property
                          isEqualTo:(id)value {
    return [self requestAllWhere:property isEqualTo:value inContext:[NSManagedObjectContext mainThreadContext]];
}

+ (NSFetchRequest *)requestAllWhere:(NSString *)property
                          isEqualTo:(id)value
                          inContext:(NSManagedObjectContext *)context {
    NSFetchRequest *request = [self createFetchRequestInContext:context];
    [request setPredicate:[NSPredicate predicateWithFormat:@"%K = %@", property, value]];
    return request;
}

+ (NSFetchRequest *)requestFirstWithPredicate:(NSPredicate *)searchTerm {
    return [self requestFirstWithPredicate:searchTerm
                                 inContext:[NSManagedObjectContext mainThreadContext]];
}

+ (NSFetchRequest *)requestFirstWithPredicate:(NSPredicate *)searchTerm
                                    inContext:(NSManagedObjectContext *)context {
    NSFetchRequest *request = [self createFetchRequestInContext:context];
    [request setPredicate:searchTerm];
    [request setFetchLimit:1];
    return request;
}

+ (NSFetchRequest *)requestFirstByAttribute:(NSString *)attribute
                                  withValue:(id)searchValue {
    return [self requestFirstByAttribute:attribute
                               withValue:searchValue
                               inContext:[NSManagedObjectContext mainThreadContext]];
}

+ (NSFetchRequest *)requestFirstByAttribute:(NSString *)attribute
                                  withValue:(id)searchValue
                                  inContext:(NSManagedObjectContext *)context {
    NSFetchRequest *request = [self requestAllWhere:attribute isEqualTo:searchValue inContext:context];
    [request setFetchLimit:1];
    return request;
}

+ (NSFetchRequest *)requestAllSortedBy:(NSString *)sortTerm
                             ascending:(BOOL)ascending
                             inContext:(NSManagedObjectContext *)context {
	NSFetchRequest *request = [self requestAllInContext:context];
	NSSortDescriptor *sortBy = [[NSSortDescriptor alloc] initWithKey:sortTerm ascending:ascending];
	[request setSortDescriptors:[NSArray arrayWithObject:sortBy]];
	return request;
}

+ (NSFetchRequest *) requestAllSortedBy:(NSString *)sortTerm
                              ascending:(BOOL)ascending {
	return [self requestAllSortedBy:sortTerm
                          ascending:ascending
                          inContext:[NSManagedObjectContext mainThreadContext]];
}

+ (NSFetchRequest *)requestAllSortedBy:(NSString *)sortTerm
                             ascending:(BOOL)ascending
                         withPredicate:(NSPredicate *)searchTerm
                             inContext:(NSManagedObjectContext *)context {
	NSFetchRequest *request = [self requestAllInContext:context];
	[request setPredicate:searchTerm];
	[request setFetchBatchSize:20];
	
    NSMutableArray* sortDescriptors = [[NSMutableArray alloc] init];
    NSArray* sortKeys = [sortTerm componentsSeparatedByString:@","];
    for (NSString* sortKey in sortKeys) {
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:sortKey ascending:ascending];
        [sortDescriptors addObject:sortDescriptor];
    }
    
	[request setSortDescriptors:sortDescriptors];
	return request;
}

+ (NSFetchRequest *)requestAllSortedBy:(NSString *)sortTerm
                             ascending:(BOOL)ascending
                         withPredicate:(NSPredicate *)searchTerm {
	NSFetchRequest *request = [self requestAllSortedBy:sortTerm
                                             ascending:ascending
                                         withPredicate:searchTerm
                                             inContext:[NSManagedObjectContext mainThreadContext]];
	return request;
}

#pragma mark - fetching itself

+ (id)findLastOneWithPredicate:(NSPredicate *)predicate {
    return [self findLastOneWithPredicate:predicate inContext:[NSManagedObjectContext mainThreadContext]];
}

+ (id)findLastOneWithPredicate:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context {
    NSError *error = nil;
    NSArray *fetched = [context executeFetchRequest:[self requestOneEntityWithPredicate:predicate
                                                                              inContext:context]
                                              error:&error];
    [VKCoreData handleError:error];
    return fetched.lastObject;
}

+ (id)findFirstOneWithPredicate:(NSPredicate *)predicate {
    return [self findFirstOneWithPredicate:predicate inContext:[NSManagedObjectContext mainThreadContext]];
}

+ (id)findFirstOneWithPredicate:(NSPredicate *)predicate
                      inContext:(NSManagedObjectContext *)context {
    NSError *error = nil;
    NSArray *fetched = [context executeFetchRequest:[self requestOneEntityWithPredicate:predicate inContext:context]
                                              error:&error];
    [VKCoreData handleError:error];
    if (fetched.count) {
        return [fetched objectAtIndex:0];
    }
    return nil;
}

+ (id)findLastOneWithPredicate:(NSPredicate *)predicate
                      sortedBy:(NSString *)sortTerm
                     ascending:(BOOL)ascending {
    return [self findLastOneWithPredicate:predicate
                                 sortedBy:sortTerm
                                ascending:ascending
                                inContext:[NSManagedObjectContext mainThreadContext]];
}

+ (id)findLastOneWithPredicate:(NSPredicate *)predicate
                      sortedBy:(NSString *)sortTerm
                     ascending:(BOOL)ascending
                     inContext:(NSManagedObjectContext *)context {
    NSArray *fetched = [self findAllSortedBy:sortTerm
                                   ascending:ascending
                               withPredicate:predicate
                                   inContext:context];
    if (fetched.count) {
        return fetched.lastObject;
    }
    return nil;
}

+ (id)findFirstOneWithPredicate:(NSPredicate *)predicate
                       sortedBy:(NSString *)sortTerm
                      ascending:(BOOL)ascending {
    return [self findFirstOneWithPredicate:predicate
                                  sortedBy:sortTerm
                                 ascending:ascending
                                 inContext:[NSManagedObjectContext mainThreadContext]];
}

+ (id)findFirstOneWithPredicate:(NSPredicate *)predicate
                       sortedBy:(NSString *)sortTerm
                      ascending:(BOOL)ascending
                      inContext:(NSManagedObjectContext *)context {
    NSArray *fetched = [self findAllSortedBy:sortTerm
                                   ascending:ascending
                               withPredicate:predicate
                                   inContext:context];
    if (fetched.count) {
        return [fetched objectAtIndex:0];
    }
    return nil;
}

+ (NSArray *)findAllInContext:(NSManagedObjectContext *)context {
	return [self executeFetchRequest:[self requestAllInContext:context]
                           inContext:context];
}

+ (NSArray *)findAll {
	return [self findAllInContext:[NSManagedObjectContext mainThreadContext]];
}

+ (NSArray *)findAllSortedBy:(NSString *)sortTerm
                   ascending:(BOOL)ascending
                   inContext:(NSManagedObjectContext *)context {
	NSFetchRequest *request = [self requestAllSortedBy:sortTerm ascending:ascending inContext:context];
	return [self executeFetchRequest:request inContext:context];
}

+ (NSArray *)findAllSortedBy:(NSString *)sortTerm
                   ascending:(BOOL)ascending {
	return [self findAllSortedBy:sortTerm
                       ascending:ascending
                       inContext:[NSManagedObjectContext mainThreadContext]];
}

+ (NSArray *)findAllSortedBy:(NSString *)sortTerm
                   ascending:(BOOL)ascending
               withPredicate:(NSPredicate *)searchTerm
                   inContext:(NSManagedObjectContext *)context {
	NSFetchRequest *request = [self requestAllSortedBy:sortTerm
                                             ascending:ascending
                                         withPredicate:searchTerm
                                             inContext:context];
	
	return [self executeFetchRequest:request inContext:context];
}

+ (NSArray *)findAllSortedBy:(NSString *)sortTerm
                   ascending:(BOOL)ascending
               withPredicate:(NSPredicate *)searchTerm {
	return [self findAllSortedBy:sortTerm
                       ascending:ascending
                   withPredicate:searchTerm
                       inContext:[NSManagedObjectContext mainThreadContext]];
}

+ (NSArray *)findAllWithPredicate:(NSPredicate *)searchTerm inContext:(NSManagedObjectContext *)context {
	NSFetchRequest *request = [self createFetchRequestInContext:context];
	[request setPredicate:searchTerm];
	return [self executeFetchRequest:request inContext:context];
}

+ (NSArray *)findAllWithPredicate:(NSPredicate *)searchTerm {
	return [self findAllWithPredicate:searchTerm inContext:[NSManagedObjectContext mainThreadContext]];
}

#pragma mark - NSFetchedResultsController's stuff

+ (void)performFetch:(NSFetchedResultsController *)controller {
	NSError *error = nil;
	if (![controller performFetch:&error]) {
		[VKCoreData handleError:error];
	}
}

+ (NSFetchedResultsController *)fetchController:(NSFetchRequest *)request
                                       delegate:(id<NSFetchedResultsControllerDelegate>)delegate
                                   useFileCache:(BOOL)useFileCache
                                      groupedBy:(NSString *)groupKeyPath
                                      inContext:(NSManagedObjectContext *)context {
    NSString *cacheName = useFileCache ? [NSString stringWithFormat:@"VKCoreData-Cache-%@", NSStringFromClass([self class])] : nil;
    
	NSFetchedResultsController *controller = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                                 managedObjectContext:context
                                                                                   sectionNameKeyPath:groupKeyPath
                                                                                            cacheName:cacheName];
    controller.delegate = delegate;
    
    return controller;
}

+ (NSFetchedResultsController *)fetchAllGroupedBy:(NSString *)group
                                    withPredicate:(NSPredicate *)searchTerm
                                         sortedBy:(NSString *)sortTerm
                                        ascending:(BOOL)ascending
                                         delegate:(id<NSFetchedResultsControllerDelegate>)delegate
                                        inContext:(NSManagedObjectContext *)context {
	NSFetchRequest *request = [self requestAllSortedBy:sortTerm
                                             ascending:ascending
                                         withPredicate:searchTerm
                                             inContext:context];
    
    NSFetchedResultsController *controller = [self fetchController:request
                                                          delegate:delegate
                                                      useFileCache:NO
                                                         groupedBy:group
                                                         inContext:context];
    
    [self performFetch:controller];
    return controller;
}

+ (NSFetchedResultsController *)fetchAllGroupedBy:(NSString *)group
                                    withPredicate:(NSPredicate *)searchTerm
                                         sortedBy:(NSString *)sortTerm
                                        ascending:(BOOL)ascending
                                         delegate:(id)delegate {
	return [self fetchAllGroupedBy:group
                     withPredicate:searchTerm
                          sortedBy:sortTerm
                         ascending:ascending
                          delegate:delegate
                         inContext:[NSManagedObjectContext mainThreadContext]];
}

+ (NSFetchedResultsController *)fetchAllGroupedBy:(NSString *)group
                                    withPredicate:(NSPredicate *)searchTerm
                                         sortedBy:(NSString *)sortTerm
                                        ascending:(BOOL)ascending
                                        inContext:(NSManagedObjectContext *)context {
    return [self fetchAllGroupedBy:group
                     withPredicate:searchTerm
                          sortedBy:sortTerm
                         ascending:ascending
                          delegate:nil
                         inContext:context];
}

+ (NSFetchedResultsController *)fetchAllGroupedBy:(NSString *)group
                                    withPredicate:(NSPredicate *)searchTerm
                                         sortedBy:(NSString *)sortTerm
                                        ascending:(BOOL)ascending {
    return [self fetchAllGroupedBy:group
                     withPredicate:searchTerm
                          sortedBy:sortTerm
                         ascending:ascending
                         inContext:[NSManagedObjectContext mainThreadContext]];
}


+ (NSFetchedResultsController *)fetchAllSortedBy:(NSString *)sortTerm
                                       ascending:(BOOL)ascending
                                   withPredicate:(NSPredicate *)searchTerm
                                         groupBy:(NSString *)groupingKeyPath
                                       inContext:(NSManagedObjectContext *)context {
    NSFetchRequest *request = [self requestAllSortedBy:sortTerm
                                             ascending:ascending
                                         withPredicate:searchTerm
                                             inContext:context];
    
	NSFetchedResultsController *controller = [self fetchController:request
                                                          delegate:nil
                                                      useFileCache:NO
                                                         groupedBy:groupingKeyPath
                                                         inContext:[NSManagedObjectContext mainThreadContext]];
    
    [self performFetch:controller];
    return controller;
}

+ (NSFetchedResultsController *)fetchAllSortedBy:(NSString *)sortTerm
                                       ascending:(BOOL)ascending
                                   withPredicate:(NSPredicate *)searchTerm
                                         groupBy:(NSString *)groupingKeyPath {
    return [self fetchAllSortedBy:sortTerm
                        ascending:ascending
                    withPredicate:searchTerm
                          groupBy:groupingKeyPath
                        inContext:[NSManagedObjectContext mainThreadContext]];
}

+ (NSFetchedResultsController *)fetchAllSortedBy:(NSString *)sortTerm
                                       ascending:(BOOL)ascending
                                   withPredicate:(NSPredicate *)searchTerm
                                         groupBy:(NSString *)groupingKeyPath
                                        delegate:(id<NSFetchedResultsControllerDelegate>)delegate
                                       inContext:(NSManagedObjectContext *)context {
	NSFetchedResultsController *controller = [self fetchAllGroupedBy:groupingKeyPath
                                                       withPredicate:searchTerm
                                                            sortedBy:sortTerm
                                                           ascending:ascending
                                                            delegate:delegate
                                                           inContext:context];
	
	[self performFetch:controller];
	return controller;
}

+ (NSFetchedResultsController *)fetchAllSortedBy:(NSString *)sortTerm
                                       ascending:(BOOL)ascending
                                   withPredicate:(NSPredicate *)searchTerm
                                         groupBy:(NSString *)groupingKeyPath
                                        delegate:(id<NSFetchedResultsControllerDelegate>)delegate {
	return [self fetchAllSortedBy:sortTerm
                        ascending:ascending
                    withPredicate:searchTerm
                          groupBy:groupingKeyPath
                         delegate:delegate
                        inContext:[NSManagedObjectContext mainThreadContext]];
}

#pragma mark - create/delete management

- (id)inContext:(NSManagedObjectContext *)otherContext {
    NSError *error = nil;
    NSManagedObject *inContext = [otherContext existingObjectWithID:[self objectID]
                                                              error:&error];
    if (!inContext) {
        [VKCoreData handleError:error];
        @try {
            inContext = [otherContext objectWithID:[self objectID]];
        }
        @catch (NSException *exception) {
            [VKCoreData handleException:exception];
        }
    }
    return inContext;
}

+ (id)createEntityInContext:(NSManagedObjectContext *)context {
    return [NSEntityDescription insertNewObjectForEntityForName:[self entityName] inManagedObjectContext:context];
}

+ (id)createEntity {
	NSManagedObject *newEntity = [self createEntityInContext:[NSManagedObjectContext mainThreadContext]];
	return newEntity;
}

- (void)deleteEntityInContext:(NSManagedObjectContext *)context {
	[context deleteObject:self];
}

- (void)deleteEntity {
	[self deleteEntityInContext:[self managedObjectContext]];
}

+ (void)deleteAllMatchingPredicate:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context {
    NSFetchRequest *request = [self requestAllWithPredicate:predicate inContext:context];
    [request setReturnsObjectsAsFaults:YES];
    [request setIncludesPropertyValues:NO];
    [[self executeFetchRequest:request inContext:context] makeObjectsPerformSelector:@selector(deleteEntityInContext:) withObject:context];
}

+ (void)deleteAllMatchingPredicate:(NSPredicate *)predicate {
    [self deleteAllMatchingPredicate:predicate inContext:[NSManagedObjectContext mainThreadContext]];
}

+ (void)deleteAllInContext:(NSManagedObjectContext *)context {
    [[self findAllInContext:context] makeObjectsPerformSelector:@selector(deleteEntityInContext:) withObject:context];
}

+ (void)deleteAll {
    [self deleteAllInContext:[NSManagedObjectContext mainThreadContext]];
}

@end
