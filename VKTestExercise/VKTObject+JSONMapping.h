//
//  VKTObject+JSONMapping.h
//  VKTestExercise
//
//  Created by Alex Kosyakov on 11.01.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//


#import "VKTObject+CoreDataClass.h"
#import "NSManagedObjectContext+VKExtensions.h"
#import "NSManagedObject+Fetches.h"

@interface NSObject (TypeSafeMapping)
- (NSString *)stringOrNilFromValue:(id)value;
- (NSNumber *)numberOrNilFromValue:(id)value;
@end

@interface VKTObject (JSONMapping)
- (void)updateDataFromJSONDict:(NSDictionary *)dict
          managedObjectContext:(NSManagedObjectContext *)context;
@end

