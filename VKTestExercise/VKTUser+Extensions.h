//
//  VKTUser+Extensions.h
//  VKTestExercise
//
//  Created by Alex Kosyakov on 1/9/18.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import "VKTUser+CoreDataClass.h"
#import "VKTUserTypes.h"


@interface VKTUser (Extensions)
+ (instancetype)currentUser;

+ (NSPredicate *)userIDPredicate;
- (VKTUserOnlineStatus )onlineStatus;
- (NSString *)fullName;
@end
