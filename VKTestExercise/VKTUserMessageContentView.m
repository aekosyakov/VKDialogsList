//
//  VKTDialogMessageContentView.m
//  VKTestExercise
//
//  Created by Alex Kosyakov on 14.01.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import "VKTUserMessageContentView.h"
#import "VKTMessage+Extensions.h"
#import "VKTAttachment+Extensions.h"
#import "VKTAttachmentTypes.h"
#import "VKTGeo+Extensions.h"
#import "UIView+MessageExtensions.h"

@interface VKTUserMessageContentView()
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UILabel *attachmentLabel;
@property (weak, nonatomic) IBOutlet UIView *statusContainerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *statusViewWidthConstraint;
@property (strong, nonatomic) UIView <VKTMessageStatusViewProtocol> *statusView;
@end

@implementation VKTUserMessageContentView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.textLabel.backgroundColor = [UIColor whiteColor];
    self.attachmentLabel.backgroundColor = [UIColor whiteColor];
    self.textLabel.textColor = [VKTColor vkTextColor];
    self.attachmentLabel.textColor = [VKTColor vkAttachmentColor];
    self.textLabel.font = self.attachmentLabel.font = [VKTFont vkTextFont];
}


- (void)reloadWithModel:(id <VKTMessageContentViewModelProtocol > )model {
    [self clear];

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
    self.textLabel.numberOfLines = 2;
    return;
  }
  
  if (!bobyStr.length && !geoTitle.length && attachmentTypeString.length > 0) {
    self.textLabel.text = attachmentTypeString;
    self.textLabel.textColor = [VKTColor vkAttachmentColor];
    self.attachmentLabel.text = nil;
    self.textLabel.numberOfLines = 2;
  }
  
  if (!bobyStr.length && !attachmentTypeString.length && geoTitle.length > 0) {
    self.textLabel.text = geoTitle;
    self.textLabel.textColor = [VKTColor vkAttachmentColor];
    self.attachmentLabel.text = nil;
    self.textLabel.numberOfLines = 2;
  }
  
  if (attachmentTypeString.length > 0 && !geoTitle.length && bobyStr.length > 0) {
    self.textLabel.text = bobyStr;
    self.textLabel.textColor = [VKTColor vkTextColor];
    self.textLabel.numberOfLines = 1;
    
    self.attachmentLabel.text = attachmentTypeString;
    self.attachmentLabel.textColor = [VKTColor vkAttachmentColor];
    self.attachmentLabel.numberOfLines = 1;
    return;
  }
  
  if (geoTitle.length > 0 && !attachmentTypeString.length && bobyStr.length > 0) {
    self.textLabel.text = bobyStr;
    self.textLabel.textColor = [VKTColor vkTextColor];
    self.textLabel.numberOfLines = 1;
    
    self.attachmentLabel.text = geoTitle;
    self.attachmentLabel.textColor = [VKTColor vkAttachmentColor];
    self.attachmentLabel.numberOfLines = 1;
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

- (void)clear {
    self.attachmentLabel.text = nil;
    self.textLabel.text = nil;
}

@end
