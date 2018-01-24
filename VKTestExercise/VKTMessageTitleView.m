//
//  VKTMessageTitleView.m
//  VKTestExercise
//
//  Created by Alex Kosyakov on 08.01.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import "VKTMessageTitleView.h"
#import "VKTDateTransformer.h"

@interface VKTMessageTitleView()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *verifiedIcon;
@property (weak, nonatomic) IBOutlet UIImageView *mutedIcon;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconsContainerWidthConstraint;
@end

@implementation VKTMessageTitleView

- (void)dealloc {
    [self clear];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self clear];
    [self setupView];
}

- (void)setupView {
    self.titleLabel.font = [VKTFont vkTitleFontSize:16.f];
    self.titleLabel.textColor = [VKTColor vkTitleColor];
  
    self.timeLabel.font = [VKTFont vkTextFontSize:13.f];
    self.timeLabel.textColor = [VKTColor vkTextColor];
    
    self.verifiedIcon.image = [VKTImage vkVerifiedIconImage];
    self.mutedIcon.image = [VKTImage vkMutedIconImage];
}

- (void)setTitleText:(NSString *)titleText {
    _titleText = titleText;
    [self updateUI];
}

- (void)setVerified:(NSNumber *)verified {
    _verified = verified;

    [self updateUI];
}

- (void)setMuted:(NSNumber *)muted {
    _muted = muted;
    [self updateUI];
}

- (void)setTime:(NSNumber *)time {
  self.timeLabel.text = [VKTDateTransformer getTimeStringFromTimestamp:time];
}

- (void)updateUI {
    self.titleLabel.text = self.titleText;
    self.verifiedIcon.hidden = !self.verified.boolValue;
    self.mutedIcon.hidden = !self.muted.boolValue;
    self.iconsContainerWidthConstraint.constant = (self.verified.boolValue && self.muted.boolValue) ? 
  36 : (self.verified.boolValue || self.muted.boolValue) ? 16 : 0;
}

- (void)clear {
  self.titleLabel.text  = nil;
  self.verifiedIcon.hidden = YES;
  self.mutedIcon.hidden = YES;
}

@end
