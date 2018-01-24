//
//  VKTAttachment+Mapping.m
//  VKTestExercise
//
//  Created by Alex Kosyakov on 04.01.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import "VKTAttachment+Mapping.h"
#import "VKTObject+JSONMapping.h"

#import "VKTMessage+Extensions.h"

@implementation VKTAttachment (Mapping)

- (void)updateDataFromJSONDict:(NSDictionary *)dict
          managedObjectContext:(NSManagedObjectContext *)context {
    if (![dict respondsToSelector:@selector(objectForKey:)]) {
        return;
    }
    
    [super updateDataFromJSONDict:dict managedObjectContext:context];

    self.title         = [self stringOrNilFromValue:dict[@"text"]];
    self.photo_url     = [self stringOrNilFromValue:dict[@"photo_100"]];
    self.from_id       = [self numberOrNilFromValue:dict[@"from_id"]];
    self.read_state    = [self numberOrNilFromValue:dict[@"read_state"]];
}

@end
