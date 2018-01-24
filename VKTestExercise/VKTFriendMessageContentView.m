//
//  VKTChatMessageContentView.m
//  VKTestExercise
//
//  Created by Alex Kosyakov on 14.01.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import "VKTFriendMessageContentView.h"
#import "VKTAvatarView+Model.h"
#import "VKTAvatarViewModel.h"
#import "VKTMessage+Extensions.h"
#import "VKTAttachment+Extensions.h"
#import "VKTAttachmentTypes.h"
#import "VKTReadStatusView.h"
#import "VKTGeo+Extensions.h"
#import "UIView+MessageExtensions.h"

@interface VKTFriendMessageContentView()
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UILabel *attachmentLabel;
@property (weak, nonatomic) IBOutlet UIView *avatarContainerView;
@property (weak, nonatomic) IBOutlet UIView *statusContainerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *statusViewWidthConstraint;

@property (strong, nonatomic) UIView <VKTAvatarViewProtocol> *avatarView;
@property (strong, nonatomic) VKTAvatarViewModel *avatarViewModel;
@property (strong, nonatomic) UIView <VKTMessageStatusViewProtocol> *statusView;

@end

@implementation VKTFriendMessageContentView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.textLabel.backgroundColor = [UIColor whiteColor];
    self.attachmentLabel.backgroundColor = [UIColor whiteColor];
    self.textLabel.textColor = [VKTColor vkTextColor];
    self.attachmentLabel.textColor = [VKTColor vkAttachmentColor];
    self.textLabel.font = self.attachmentLabel.font = [VKTFont vkTextFont];
}

- (void)reloadWithModel:(id <VKTMessageContentViewModelProtocol > )model {
    if (!self.avatarViewModel) {
        self.avatarViewModel = [[VKTAvatarViewModel alloc] init];
    }
    
    if (model.photoURL.absoluteString.length > 0) {
            self.avatarViewModel.urls = @[model.photoURL];
    }
    self.avatarViewModel.messageID = model.message.peer_id;
    
    
    if (!self.avatarView) {
        self.avatarView = [VKTAvatarView loadWithModel:self.avatarViewModel];
        self.avatarView.frame = self.avatarContainerView.bounds;
        [self.avatarContainerView addSubview:self.avatarView];
        [self.avatarView addAutoresizingFlexibleMask];
    } else {
        [self.avatarView reloadWithModel:self.avatarViewModel];
    }
    BOOL needsToShowReadStatus = model.unread_in.boolValue || model.unread_out.boolValue;
    if (needsToShowReadStatus) {
      if (!self.statusContainerView.subviews.count) {
        self.statusView = [UIView messageStatusView];
        self.statusView.frame = self.statusContainerView.bounds;
        [self.statusContainerView addSubview:self.statusView];
        [self.statusView addAutoresizingFlexibleMask];
      }
        self.statusView.unread_in = model.unread_in;
        self.statusView.unread_out = model.unread_out;
        self.statusView.unread_count = model.unread_count;
        self.statusView.muted = model.muted;
        
    } else {
      [self.statusView removeFromSuperview];
      self.statusView = nil;
    }
  
    self.statusViewWidthConstraint.constant = needsToShowReadStatus ? 40.f : 10;

  
  NSString *attachmentTypeString = VKTAttachmentTitleFromType(model.message.attachment.type.integerValue);
  NSString *bobyStr = model.message.body;
  NSString *geoTitle = model.message.geo.title;
  
  if (!attachmentTypeString.length && !geoTitle.length && bobyStr.length > 0) {
    self.textLabel.text = bobyStr;
    self.textLabel.textColor = [VKTColor vkTextColor];
    self.attachmentLabel.hidden = YES;
    self.textLabel.hidden = NO;
    self.attachmentLabel.text = nil;
    return;
  }
  
  if (!bobyStr.length && !geoTitle.length && attachmentTypeString.length > 0) {
    self.textLabel.text = nil;
    self.textLabel.hidden = YES;
    self.attachmentLabel.hidden = NO;
    self.attachmentLabel.text = attachmentTypeString;
  }
  
  if (!bobyStr.length && !attachmentTypeString.length && geoTitle.length > 0) {
    self.textLabel.text = nil;
    self.textLabel.hidden = YES;
    self.attachmentLabel.hidden = NO;
    self.attachmentLabel.text = geoTitle;
  }
  
  if (attachmentTypeString.length > 0 && !geoTitle.length && bobyStr.length > 0) {
    self.textLabel.text = bobyStr;
    self.textLabel.textColor = [VKTColor vkTextColor];
    self.attachmentLabel.hidden = YES;
    self.textLabel.hidden = NO;
    self.attachmentLabel.text = nil;
    return;
  }
  
  if (geoTitle.length > 0 && attachmentTypeString.length > 0 && !bobyStr.length) {
    self.textLabel.text = nil;
    self.textLabel.hidden = YES;
    self.attachmentLabel.hidden = NO;
    self.attachmentLabel.text = geoTitle;
    return;
  }

}
@end
