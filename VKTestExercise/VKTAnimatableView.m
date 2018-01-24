//
//  VKTFooterView.m
//  VKTestExercise
//
//  Created by Alex Kosyakov on 1/16/18.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import "VKTAnimatableView.h"

@interface VKTAnimatableView()
@property (strong, nonatomic) UIActivityIndicatorView *activityView;
@end
@implementation VKTAnimatableView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
      self.backgroundColor = [UIColor whiteColor];
      _activityView = [[UIActivityIndicatorView alloc] initWithFrame:self.bounds];
      _activityView.center = self.center;
      _activityView.color = [UIColor lightGrayColor];
      _activityView.translatesAutoresizingMaskIntoConstraints = NO;
      [self addSubview:_activityView];
      NSLayoutConstraint *centerYConstraint = [NSLayoutConstraint constraintWithItem:_activityView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:0.7f constant:0.f];
      NSLayoutConstraint *centerXConstraint = [NSLayoutConstraint constraintWithItem:_activityView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.f constant:0.f];
      [self addConstraints:@[centerYConstraint, centerXConstraint]];
      [_activityView startAnimating];
  }
  return self;
}

@end
