//
//  VKTMessageView.m
//  VKTestExercise
//
//  Created by Alex Kosyakov on 06.01.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import "VKTMessageView.h"
#import "VKTMessage+CoreDataClass.h"
#import "UIView+MessageExtensions.h"
#import "VKTMessageViewProtocol.h"
#import "VKTUser+Extensions.h"
#import "VKTMessage+Extensions.h"

#import "VKTMessageAvatarViewModel.h"
#import "VKTMessageContentViewModel.h"


//  ------------------------------------------------
// |       |             top                        |
// | left  | -------------------------------------- |
// |       |                                        |
// |       |             bottom                     |
//  ------------------------------------------------


@interface VKTMessageView()
@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIView *separatorView;

@property (strong, nonatomic) UIView <VKTMessageTitleProtocol > *titleView;
@property (strong, nonatomic) UIView <VKTMessageStatusViewProtocol > *statusView;
@property (strong, nonatomic) UIView <VKTMessageAvatarViewProtocol > *avatarView;
@property (strong, nonatomic) UIView <VKTMessageContentViewProtocol > *messageContentView;

@property (strong, nonatomic) id <VKTMessageAvatarViewModelProtocol> messageAvatarViewModel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *separatorConstraint;

@end

@implementation VKTMessageView

- (void)awakeFromNib {
  [super awakeFromNib];
  [self layoutIfNeeded];
  self.separatorView.backgroundColor = [VKTColor cellSeparatorColor];
  self.separatorConstraint.constant = 1/[UIScreen mainScreen].scale;
}

- (void)reloadWithMessage:(VKTMessage *_Nonnull)message {
  [self layoutIfNeeded];

  if (!self.topView.subviews.count) {
    self.titleView = [UIView messageTitleView];
    self.titleView.frame = self.topView.bounds;
    [self.topView addSubview:self.titleView];
    [_titleView addAutoresizingFlexibleMask];
  }
    
  if (!self.leftView.subviews.count) {
      [self layoutIfNeeded];
      self.avatarView = [UIView messageAvatarView];
      self.avatarView.frame = self.leftView.bounds;
      [self.leftView addSubview:self.avatarView];
      [self.avatarView addAutoresizingFlexibleMask];
  }
  
  if (!self.bottomView.subviews.count) {
      [self layoutIfNeeded];
      self.messageContentView = [UIView messageContentView];
      self.messageContentView.frame = self.bottomView.bounds;
      self.messageContentView.frame = self.bottomView.bounds;
      [self.bottomView addSubview:self.messageContentView];
      [self.messageContentView addAutoresizingFlexibleMask];
  }
 
  VKTMessageAvatarViewModel *messageAvatarViewModel = [[VKTMessageAvatarViewModel alloc] init];
  messageAvatarViewModel.message = message;
  [self.avatarView reloadWithModel:messageAvatarViewModel];
  
  
  VKTUser *user = message.users.firstObject;
  if (user) {
    self.titleView.titleText = [message isChat] ? message.title : [user fullName];
  }

  BOOL verified = user.verified.boolValue && ![message isChat];
  self.titleView.verified = @(verified);
  self.titleView.muted = message.muted;
  self.titleView.time = message.date;
  
  VKTMessageContentViewModel *contentViewModel = [[VKTMessageContentViewModel alloc] init];
  
  contentViewModel.message = message;
  contentViewModel.messageID = message.peer_id;
  contentViewModel.unread_in    = @(!message.isOut.boolValue && !message.read_state.boolValue);
  contentViewModel.unread_out   = @(message.isOut.boolValue && !message.read_state.boolValue);;
  contentViewModel.unread_count = message.unread_count;
  contentViewModel.muted = message.muted;

  if (message.isOut.boolValue) {
      contentViewModel.photoURL = [NSURL URLWithString:[VKTUser currentUser].photo_url];
  } else {
      for (VKTUser *user in message.users) {
          if ([user.uid isEqualToNumber:message.user_id]) {
              contentViewModel.photoURL = [NSURL URLWithString:user.photo_url];
          }
      }
  }
  
  [self.messageContentView reloadWithModel:contentViewModel];
}

@end
