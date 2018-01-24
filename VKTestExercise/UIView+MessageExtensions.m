//
//  UIView+MessageExtensions.m
//  VKTestExercise
//
//  Created by Alex Kosyakov on 06.01.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import "UIView+MessageExtensions.h"

#import "VKTMessageView.h"
#import "VKTAvatarView.h"
#import "VKTMessageTitleView.h"
#import "VKTMessageAvatarView.h"
#import "VKTReadStatusView.h"
#import "VKTMessageContentView.h"
#import "VKTFriendMessageContentView.h"
#import "VKTUserMessageContentView.h"
#import "VKTMessage+CoreDataClass.h"

@implementation UIView (MessageExtensions)

+ (UIView <VKTMessageObjectProvider > *)messageView {
  return [VKTMessageView loadFromNib];;
}

+ (UIView <VKTMessageObjectProvider > *)viewWithMessage:(VKTMessage *)message {
    VKTMessageView *view = [VKTMessageView loadFromNib];
    [view reloadWithMessage:message];
    return view;
}

+ (UIView <VKTMessageAvatarViewProtocol> *)messageAvatarView {
  return [VKTMessageAvatarView loadFromNib];;
}

+ (UIView <VKTAvatarViewProtocol> *)avatarView {
  return [VKTAvatarView loadFromNib];;
}

+ (UIView <VKTMessageContentViewProtocol> *)messageContentView {
  return [[VKTMessageContentView alloc] init];
}

+ (UIView <VKTMessageTitleProtocol> *)messageTitleView {
    return [VKTMessageTitleView loadFromNib];;
}

+ (UIView <VKTMessageStatusViewProtocol> *)messageStatusView {
    return [VKTReadStatusView loadFromNib];
}

@end
