//
//  VKTUserToken.h
//  VKTestExercise
//
//  Created by Alex Kosyakov on 03.01.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VKTUserToken : NSObject
+ (void)setUserID:(NSNumber *)userID;
+ (NSNumber *)userID;

+ (void)updateToken:(NSString *)token;
+ (void)resetToken;
+ (NSString *)token;
+ (BOOL)isAuthorized;
@end
