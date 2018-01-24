//
//  VKTObjectJSONMapping.h
//  VKTestExercise
//
//  Created by Alex Kosyakov on 11.01.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol VKTObjectJSONMapping <NSObject>
- (void)updateDataFromJSONDict:(NSDictionary *)dict
          managedObjectContext:(NSManagedObjectContext *)context;
@end
