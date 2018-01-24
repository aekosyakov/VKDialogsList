//
//  VKTAuthServiceProvider.h
//  VKTestExercise
//
//  Created by Alex Kosyakov on 27.12.2017.
//  Copyright © 2017 Alex Kosyakov. All rights reserved.
//

#import "VKTServiceProvider.h"

extern NSString *const kVKTAuthServiceDidLoginNotificationName;
extern NSString *const kVKTAuthServiceDidLogoutNotificationName;

typedef NS_ENUM(NSUInteger, VKTAuthStatus){
    VKTAuthStatusUnknown,
    VKTAuthStatusError,
    VKTAuthStatusSuccess
};

@protocol VKTAuthResult <VKTServiceResult>
@property (assign, nonatomic) VKTAuthStatus status;
@end

@class VKAuthorizationResult;
@protocol VKTAuthParser <VKTServiceParser>
- (id <VKTAuthResult > )resultWithResponse:(VKAuthorizationResult *)response;
@end

@protocol VKTAuthServiceProvider <VKTServiceProvider>
@property (strong, nonatomic) id <VKTAuthParser > parser;
- (void)authorizeUserIfNeeded;
- (void)logOut;
@end



