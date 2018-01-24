//
//  VKTObject+JSONMapping.m
//  VKTestExercise
//
//  Created by Alex Kosyakov on 11.01.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import "VKTObject+JSONMapping.h"
@implementation VKTObject (JSONMapping)
- (void)updateDataFromJSONDict:(NSDictionary *)dict
          managedObjectContext:(NSManagedObjectContext *)context {
    if (![dict respondsToSelector:@selector(objectForKey:)]) {
      return;
    }
    self.uid        = [self numberOrNilFromValue:dict[@"id"]];
    self.deleted    = [self numberOrNilFromValue:dict[@"deleted"]];
    self.title      = [self stringOrNilFromValue:dict[@"title"]];

    self.root_id    = self.uid;
}
@end


@implementation NSObject (TypeSafeMapping)
- (NSString *)stringOrNilFromValue:(id)value {
    if ([value isKindOfClass:[NSString class]]) {
        return value;
    }
    return nil;
}

- (NSNumber *)numberOrNilFromValue:(id)value {
    if ([value isKindOfClass:[NSNumber class]]) {
        return value;
    }
    return nil;
}
@end

