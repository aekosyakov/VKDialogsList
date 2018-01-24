//
//  VKTUser+Mapping.m
//  VKTestExercise
//
//  Created by Alex Kosyakov on 04.01.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import "VKTUser+Mapping.h"
#import "VKTObject+JSONMapping.h"

#import "VKTMessage+CoreDataProperties.h"

@implementation VKTUser (Mapping)
- (void)updateDataFromJSONDict:(NSDictionary *)dict
          managedObjectContext:(NSManagedObjectContext *)context {
    if (![dict respondsToSelector:@selector(objectForKey:)]) {
        return;
    }
    [super updateDataFromJSONDict:dict managedObjectContext:context];
    
    self.firstName      = [self stringOrNilFromValue:dict[@"first_name"]];
    self.lastName       = [self stringOrNilFromValue:dict[@"last_name"]];
    self.photo_url      = [self stringOrNilFromValue:dict[@"photo_100"]];
    
    self.verified       = [self numberOrNilFromValue:dict[@"verified"]];
    self.online         = [self numberOrNilFromValue:dict[@"online"]];
    self.online_mobile  = [self numberOrNilFromValue:dict[@"online_mobile"]];
    self.deleted        = [self numberOrNilFromValue:dict[@"deactivated"]];

  
    NSString *groupName = [self stringOrNilFromValue:dict[@"name"]];
    if (groupName.length > 0) {
      self.firstName      = [self stringOrNilFromValue:dict[@"name"]];
      self.lastName       = nil;
    }
}
@end
