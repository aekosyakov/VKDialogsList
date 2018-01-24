//
//  VKTUser+Extensions.m
//  VKTestExercise
//
//  Created by Alex Kosyakov on 1/9/18.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import "VKTUser+Extensions.h"
#import "NSManagedObject+Fetches.h"
#import "NSManagedObjectContext+VKExtensions.h"

@implementation VKTUser (Extensions)
+ (instancetype)currentUser {
  return [VKTUser findFirstOneWithPredicate:[[self class] userIDPredicate]];
}

+ (NSPredicate *)userIDPredicate {
  return [NSPredicate predicateWithFormat:@"uid == %@", [VKTUserToken userID]];
}

- (VKTUserOnlineStatus )onlineStatus {
    if (self.online.boolValue && !self.online_mobile.boolValue) {
        return VKTUserOnline;
    }
    
    if (self.online_mobile.boolValue) {
        return VKTUserOnlineMobile;
    }
    return VKTUserOffline;
}

- (NSString *)fullName {
    NSString *fullNameString = self.firstName;
    if (self.lastName.length > 0) {
      fullNameString = [fullNameString stringByAppendingFormat:@" %@", self.lastName];
    }
  
    return fullNameString;
}
@end
