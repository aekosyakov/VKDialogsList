//
//  VKTUserToken.m
//  VKTestExercise
//
//  Created by Alex Kosyakov on 03.01.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import "VKTUserToken.h"

@implementation VKTUserToken

#pragma mark UserToken
NSString * const kAuthTokenKey  = @"AuthTokenKey";

+ (void)updateToken:(NSString *)token {
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:kAuthTokenKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)resetToken {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kAuthTokenKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)token {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kAuthTokenKey];;;
}

+ (BOOL)isAuthorized {
    NSString *token = [self token];
    return token.length > 0;
}


#pragma mark UserID
NSString * const kUserIDKey  = @"UserIDKey";

+ (void)setUserID:(NSNumber *)userID {
  [[NSUserDefaults standardUserDefaults] setObject:userID forKey:kUserIDKey];
  [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSNumber *)userID {
  NSNumber *userID = [[NSUserDefaults standardUserDefaults] objectForKey:kUserIDKey];
  
  return userID?:@0;
}

@end
