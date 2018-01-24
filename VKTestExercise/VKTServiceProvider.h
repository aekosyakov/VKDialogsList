//
//  VKTServiceProvider.h
//  VKTestExercise
//
//  Created by Alex Kosyakov on 1/11/18.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, VKServiceType) {
  VKServiceTypeAuth,
  VKServiceTypeUserInfo,
  VKServiceTypeDeleteMessages,
  VKServiceTypeMessages,
  VKServiceTypeLongPoll,
  VKServiceTypeChatInfo,
  VKServiceTypeBatch
};

@protocol VKTServiceResult <NSObject>
@property (assign, nonatomic) VKServiceType serviceType;
@property (strong, nonatomic) NSError *error;
@end

typedef void (^VKTServiceResultCompletion)(NSObject <VKTServiceResult > * result);

@class VKResponse;
@protocol VKTServiceParser <NSObject>
- (id <VKTServiceResult > )resultWithError:(NSError *)error;
@optional
- (id <VKTServiceResult> )resultWithResponse:(VKResponse *)response;
@end

@protocol VKTServiceDelegate
- (void)serviceDidFinishWithResult:(id <VKTServiceResult> )result;
@end

@protocol VKTServiceProvider <NSObject>
@property (copy, nonatomic) VKTServiceResultCompletion resultCompletion;
@property (assign, nonatomic, getter=isResfreshing) BOOL refreshing;
@end
