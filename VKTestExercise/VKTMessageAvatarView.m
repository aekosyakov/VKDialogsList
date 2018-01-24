//
//  VKTMessageAvatarView.m
//  VKTestExercise
//
//  Created by Alex Kosyakov on 13.01.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import "VKTMessageAvatarView.h"
#import "VKTAvatarViewModel.h"
#import "VKTMessage+Extensions.h"
#import "VKTUser+Extensions.h"
#import "VKTOnlineStatusView.h"
#import "VKTAvatarView+Model.h"

@interface VKTMessageAvatarView()
@property (weak, nonatomic) IBOutlet UIView *avatarContainerView;
@property (weak, nonatomic) IBOutlet UIView *onlineStatusContainerView;

@property (strong, nonatomic) VKTAvatarView *avatarView;
@property (strong, nonatomic) VKTAvatarViewModel *avatarViewModel;
@property (strong, nonatomic) VKTOnlineStatusView *onlineStatusView;
@end

@implementation VKTMessageAvatarView

- (void)awakeFromNib {
  [super awakeFromNib];
  self.avatarContainerView.backgroundColor = [UIColor clearColor];
}

- (void)reloadWithModel:(id <VKTMessageAvatarViewModelProtocol > )model {
  if (!self.avatarViewModel) {
      self.avatarViewModel = [[VKTAvatarViewModel alloc] init];
  }

  if (self.avatarView.type != [model photoURLs].count) {
      [self.avatarView removeFromSuperview];
      self.avatarView = nil;
  }

  self.avatarViewModel.urls = [model photoURLs];
  self.avatarViewModel.messageID = model.message.peer_id;

  if (!self.avatarContainerView.subviews.count) {
      self.avatarView = [VKTAvatarView loadWithModel:self.avatarViewModel];
      self.avatarView.frame = self.avatarContainerView.bounds;
      [self.avatarContainerView addSubview:self.avatarView];
      [self.avatarView addAutoresizingFlexibleMask];
  } else {
      [self.avatarView reloadWithModel:self.avatarViewModel];
  }

  /// online status
  if (!self.onlineStatusContainerView.subviews.count) {
      self.onlineStatusView = [VKTOnlineStatusView loadFromNib];
      self.onlineStatusView.frame = self.onlineStatusContainerView.bounds;
      [self.onlineStatusContainerView addSubview:self.onlineStatusView];
      [self.onlineStatusView addAutoresizingFlexibleMask];
  }
  self.onlineStatusView.onlineStatus = [model onlineStatus];
}

@end
