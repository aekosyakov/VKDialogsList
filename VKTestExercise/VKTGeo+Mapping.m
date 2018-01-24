//
//  VKTGeo+Mapping.m
//  VKTestExercise
//
//  Created by Alex Kosyakov on 11.01.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import "VKTGeo+Mapping.h"
#import "VKTObject+JSONMapping.h"
#import "VKTMessage+CoreDataClass.h"

@implementation VKTGeo (Mapping)
- (void)updateDataFromJSONDict:(NSDictionary *)dict
          managedObjectContext:(NSManagedObjectContext *)context {
    if (![dict respondsToSelector:@selector(objectForKey:)]) {
      return;
    }
  
    [super updateDataFromJSONDict:dict managedObjectContext:context];
    
    self.coordinates = [self stringOrNilFromValue:dict[@"coordinates"]];
    
    if (self.message && self.message.peer_id) {
        self.root_id = self.message.peer_id;
    }
}

@end
