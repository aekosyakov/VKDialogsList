//
//  UIView+MessageExtensions.h
//  VKTestExercise
//
//  Created by Alex Kosyakov on 06.01.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VKTMessageViewProtocol.h"
@class VKTMessage;
@interface UIView (MessageExtensions)
+ (UIView <VKTMessageObjectProvider > *)messageView;
+ (UIView <VKTMessageObjectProvider > *)viewWithMessage:(VKTMessage *)message;
+ (UIView <VKTMessageContentViewProtocol> *)messageContentView;
+ (UIView <VKTMessageStatusViewProtocol> *)messageStatusView;
+ (UIView <VKTMessageTitleProtocol> *)messageTitleView;;
+ (UIView <VKTMessageAvatarViewProtocol> *)messageAvatarView;
+ (UIView <VKTAvatarViewProtocol> *)avatarView;
@end
