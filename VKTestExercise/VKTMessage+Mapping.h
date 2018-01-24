//
//  VKTMessage+Mapping.h
//  VKTestExercise
//
//  Created by Alex Kosyakov on 04.01.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import "VKTMessage+CoreDataClass.h"
@interface VKTMessage (Mapping)
+ (instancetype)createNewOrUpdateExistedFromDict:(NSDictionary *)dict context:(NSManagedObjectContext *)context;
+ (NSPredicate *)comparePredicateFromDict:(NSDictionary *)dict;
@end
