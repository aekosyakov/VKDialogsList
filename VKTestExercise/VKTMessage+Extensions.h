//
//  VKTMessage+Extensions.h
//  VKTestExercise
//
//  Created by Alex Kosyakov on 1/9/18.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import "VKTMessage+CoreDataClass.h"

@interface VKTMessage (Extensions)
- (BOOL)isChat;
- (NSPredicate *)comparePredicate;
- (NSNumber *)getPeerID;
@end
