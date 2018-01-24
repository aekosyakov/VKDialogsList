//
//  NSManagedObject+Fetches.h
//  VKPlus
//
//  Created by iFreeman on 27.11.12.
//  Copyright (c) 2012 Moche Apps Limited. All rights reserved.
//

#import <CoreData/CoreData.h>

// taken from the MagicalRecord CoreData library

@interface NSManagedObject (Fetches)

+ (NSString *)entityName;

+ (NSArray *)executeFetchRequest:(NSFetchRequest *)request;
+ (NSArray *)executeFetchRequest:(NSFetchRequest *)request
                       inContext:(NSManagedObjectContext *)context;

+ (NSFetchRequest *)createFetchRequest;
+ (NSFetchRequest *)createFetchRequestInContext:(NSManagedObjectContext *)context;
+ (NSEntityDescription *)entityDescription;
+ (NSEntityDescription *)entityDescriptionInContext:(NSManagedObjectContext *)context;

+ (id)createEntity;
+ (id)createEntityInContext:(NSManagedObjectContext *)context;
- (void)deleteEntity;
- (void)deleteEntityInContext:(NSManagedObjectContext *)context;

+ (void)deleteAllMatchingPredicate:(NSPredicate *)predicate;
+ (void)deleteAllMatchingPredicate:(NSPredicate *)predicate
                         inContext:(NSManagedObjectContext *)context;

+ (void)deleteAll;
+ (void)deleteAllInContext:(NSManagedObjectContext *)context;

+ (NSArray *)ascendingSortDescriptors:(NSArray *)attributesToSortBy;
+ (NSArray *)descendingSortDescriptors:(NSArray *)attributesToSortBy;

+ (NSNumber *)numberOfEntities;
+ (NSNumber *)numberOfEntitiesWithContext:(NSManagedObjectContext *)context;
+ (NSNumber *)numberOfEntitiesWithPredicate:(NSPredicate *)searchTerm;
+ (NSNumber *)numberOfEntitiesWithPredicate:(NSPredicate *)searchTerm
                                  inContext:(NSManagedObjectContext *)context;

+ (NSUInteger)countOfEntities;
+ (NSUInteger)countOfEntitiesWithContext:(NSManagedObjectContext *)context;
+ (NSUInteger)countOfEntitiesWithPredicate:(NSPredicate *)searchFilter;
+ (NSUInteger)countOfEntitiesWithPredicate:(NSPredicate *)searchFilter
                                 inContext:(NSManagedObjectContext *)context;

+ (BOOL)hasAtLeastOneEntity;
+ (BOOL)hasAtLeastOneEntityInContext:(NSManagedObjectContext *)context;

+ (NSFetchRequest *)requestAll;
+ (NSFetchRequest *)requestAllInContext:(NSManagedObjectContext *)context;
+ (NSFetchRequest *)requestOneEntityWithPredicate:(NSPredicate *)predicate;
+ (NSFetchRequest *)requestOneEntityWithPredicate:(NSPredicate *)predicate
                                        inContext:(NSManagedObjectContext *)context;
+ (NSFetchRequest *)requestAllWithPredicate:(NSPredicate *)searchTerm;
+ (NSFetchRequest *)requestAllWithPredicate:(NSPredicate *)searchTerm
                                  inContext:(NSManagedObjectContext *)context;
+ (NSFetchRequest *)requestAllWhere:(NSString *)property
                          isEqualTo:(id)value;
+ (NSFetchRequest *)requestAllWhere:(NSString *)property
                          isEqualTo:(id)value
                          inContext:(NSManagedObjectContext *)context;
+ (NSFetchRequest *)requestFirstWithPredicate:(NSPredicate *)searchTerm;
+ (NSFetchRequest *)requestFirstWithPredicate:(NSPredicate *)searchTerm inContext:(NSManagedObjectContext *)context;
+ (NSFetchRequest *)requestFirstByAttribute:(NSString *)attribute
                                  withValue:(id)searchValue;
+ (NSFetchRequest *)requestFirstByAttribute:(NSString *)attribute
                                  withValue:(id)searchValue
                                  inContext:(NSManagedObjectContext *)context;
+ (NSFetchRequest *)requestAllSortedBy:(NSString *)sortTerm
                             ascending:(BOOL)ascending;
+ (NSFetchRequest *)requestAllSortedBy:(NSString *)sortTerm
                             ascending:(BOOL)ascending
                             inContext:(NSManagedObjectContext *)context;
+ (NSFetchRequest *)requestAllSortedBy:(NSString *)sortTerm
                             ascending:(BOOL)ascending
                         withPredicate:(NSPredicate *)searchTerm;
+ (NSFetchRequest *)requestAllSortedBy:(NSString *)sortTerm
                             ascending:(BOOL)ascending
                         withPredicate:(NSPredicate *)searchTerm
                             inContext:(NSManagedObjectContext *)context;

+ (NSArray *)findAll;
+ (NSArray *)findAllInContext:(NSManagedObjectContext *)context;
+ (NSArray *)findAllSortedBy:(NSString *)sortTerm
                   ascending:(BOOL)ascending;
+ (NSArray *)findAllSortedBy:(NSString *)sortTerm
                   ascending:(BOOL)ascending
                   inContext:(NSManagedObjectContext *)context;
+ (NSArray *)findAllSortedBy:(NSString *)sortTerm
                   ascending:(BOOL)ascending
               withPredicate:(NSPredicate *)searchTerm;
+ (NSArray *)findAllSortedBy:(NSString *)sortTerm
                   ascending:(BOOL)ascending
               withPredicate:(NSPredicate *)searchTerm
                   inContext:(NSManagedObjectContext *)context;

+ (NSArray *)findAllWithPredicate:(NSPredicate *)searchTerm;
+ (NSArray *)findAllWithPredicate:(NSPredicate *)searchTerm
                        inContext:(NSManagedObjectContext *)context;

+ (id)findLastOneWithPredicate:(NSPredicate *)predicate;
+ (id)findLastOneWithPredicate:(NSPredicate *)predicate
                     inContext:(NSManagedObjectContext *)context;

+ (id)findFirstOneWithPredicate:(NSPredicate *)predicate;
+ (id)findFirstOneWithPredicate:(NSPredicate *)predicate
                      inContext:(NSManagedObjectContext *)context;

+ (id)findLastOneWithPredicate:(NSPredicate *)predicate
                      sortedBy:(NSString *)sortTerm
                     ascending:(BOOL)ascending;
+ (id)findLastOneWithPredicate:(NSPredicate *)predicate
                      sortedBy:(NSString *)sortTerm
                     ascending:(BOOL)ascending
                     inContext:(NSManagedObjectContext *)context;

+ (id)findFirstOneWithPredicate:(NSPredicate *)predicate
                       sortedBy:(NSString *)sortTerm
                      ascending:(BOOL)ascending;
+ (id)findFirstOneWithPredicate:(NSPredicate *)predicate
                       sortedBy:(NSString *)sortTerm
                      ascending:(BOOL)ascending
                      inContext:(NSManagedObjectContext *)context;

- (id)inContext:(NSManagedObjectContext *)otherContext;

+ (void)performFetch:(NSFetchedResultsController *)controller;

+ (NSFetchedResultsController *)fetchAllSortedBy:(NSString *)sortTerm
                                       ascending:(BOOL)ascending
                                   withPredicate:(NSPredicate *)searchTerm
                                         groupBy:(NSString *)groupingKeyPath
                                        delegate:(id<NSFetchedResultsControllerDelegate>)delegate;

+ (NSFetchedResultsController *)fetchAllSortedBy:(NSString *)sortTerm
                                       ascending:(BOOL)ascending
                                   withPredicate:(NSPredicate *)searchTerm
                                         groupBy:(NSString *)groupingKeyPath
                                        delegate:(id<NSFetchedResultsControllerDelegate>)delegate
                                       inContext:(NSManagedObjectContext *)context;

+ (NSFetchedResultsController *)fetchAllGroupedBy:(NSString *)group
                                    withPredicate:(NSPredicate *)searchTerm
                                         sortedBy:(NSString *)sortTerm
                                        ascending:(BOOL)ascending;

+ (NSFetchedResultsController *)fetchAllGroupedBy:(NSString *)group
                                    withPredicate:(NSPredicate *)searchTerm
                                         sortedBy:(NSString *)sortTerm
                                        ascending:(BOOL)ascending
                                        inContext:(NSManagedObjectContext *)context;

+ (NSFetchedResultsController *)fetchAllGroupedBy:(NSString *)group
                                    withPredicate:(NSPredicate *)searchTerm
                                         sortedBy:(NSString *)sortTerm
                                        ascending:(BOOL)ascending
                                         delegate:(id<NSFetchedResultsControllerDelegate>)delegate;

+ (NSFetchedResultsController *)fetchAllGroupedBy:(NSString *)group
                                    withPredicate:(NSPredicate *)searchTerm
                                         sortedBy:(NSString *)sortTerm
                                        ascending:(BOOL)ascending
                                         delegate:(id<NSFetchedResultsControllerDelegate>)delegate
                                        inContext:(NSManagedObjectContext *)context;

@end
