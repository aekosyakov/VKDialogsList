//
//  VKTReadStatusView.m
//  VKTestExercise
//
//  Created by Alex Kosyakov on 1/12/18.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import "VKTReadStatusView.h"
#import "UIView+CoreAnimation.h"

@interface VKTReadStatusView()
@property (weak, nonatomic) IBOutlet UIView *unreadInView;
@property (weak, nonatomic) IBOutlet UIView *unreadOutView;
@property (weak, nonatomic) IBOutlet UILabel *unreadCountLabel;
@end

@implementation VKTReadStatusView

@synthesize unread_out, unread_in, unread_count, muted;

- (void)awakeFromNib {
  [super awakeFromNib];
  self.unreadInView.backgroundColor = [VKTColor vkMainColor];
  [self.unreadInView makeRoundCorner:self.unreadInView.bounds.size.height/2];
  self.unreadOutView.backgroundColor = [VKTColor vkMainColor];
  [self.unreadOutView makeRound];

  self.unreadCountLabel.textColor = [UIColor whiteColor];
  self.unreadCountLabel.font = [VKTFont vkTextFontSize:13.f];
  self.unreadCountLabel.backgroundColor = [UIColor clearColor];

  [self clear];
}

- (void)setUnread_in:(NSNumber *)unread_in {
  self.unreadInView.hidden = !unread_in.boolValue;
}

- (void)setUnread_out:(NSNumber *)unread_out {
  self.unreadOutView.hidden = !unread_out.boolValue;
}

- (void)setUnread_count:(NSNumber *)unread_count {
  if (unread_count.integerValue > 0) {
      self.unreadCountLabel.text = unread_count.stringValue;
      [self.unreadInView makeRoundCorner:self.unreadInView.bounds.size.height/2];
  } else {
      self.unreadCountLabel.text = nil;
  }
  self.unreadCountLabel.hidden = unread_count.integerValue == 0;
}

- (void)setMuted:(NSNumber *)muted {
  self.unreadInView.backgroundColor = muted.boolValue ? [UIColor lightGrayColor] : [VKTColor vkMainColor];
}

- (void)clear {
  self.unreadCountLabel.text = nil;
  self.unreadInView.hidden = YES;
  self.unreadOutView.hidden = YES;
}

@end
