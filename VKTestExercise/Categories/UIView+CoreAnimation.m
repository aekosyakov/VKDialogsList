//
//  UIView+CoreAnimation.m
//  cube
//
//  Created by Alex Kosyakov on 8/16/16.
//  Copyright © 2016 Cube Innovations, Inc. All rights reserved.
//

#import "UIView+CoreAnimation.h"

static CGFloat const kTransitionDuration = 0.3f;

@implementation UIView (CoreAnimation)


//MARK: Font Size Animation

- (void)fontSizeAnimation:(CGFloat )fromSize toFont:(CGFloat )toSize {
  CABasicAnimation* animation = [CABasicAnimation
                                 animationWithKeyPath:@"fontSize"];
  animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
  animation.duration = kTransitionDuration;
  animation.fromValue = (id)@(fromSize);
  animation.toValue = (id)@(toSize);
  [self.layer addAnimation:animation forKey:nil];
}

//MARK: Background Color Animation

- (void)fadeAnimationWithColor:(UIColor *)fadeColor {
  [self fadeAnimationWithColor:fadeColor duration:kTransitionDuration/2];
}

- (void)fadeAnimationWithColor:(UIColor *)fadeColor duration:(CGFloat )duration{
  CABasicAnimation* animation = [CABasicAnimation
                                 animationWithKeyPath:@"backgroundColor"];
  animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
  animation.duration = duration;
  animation.autoreverses = YES;
  animation.fromValue = (id)self.backgroundColor.CGColor;
  animation.toValue = (id)fadeColor.CGColor;
  [self.layer addAnimation:animation forKey:nil];
}

//MARK: Corner Radius Animation

- (void)cornerRadiusAnimation:(CGFloat )cornerRadius duration:(CGFloat )duration {
  CABasicAnimation* animation = [CABasicAnimation
                                 animationWithKeyPath:@"cornerRadius"];
  animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
  animation.duration = duration;
  animation.fromValue = (id)@(self.layer.cornerRadius);
  animation.toValue = (id)@(cornerRadius);
  animation.removedOnCompletion = NO;
  [self.layer addAnimation:animation forKey:nil];
}

- (void)makeRound {
  self.layer.cornerRadius = CGRectGetMidX(self.bounds);
  self.layer.masksToBounds = YES;
  [self layoutIfNeeded];
}

- (void)makeRoundCorner:(CGFloat )corner {
  self.layer.cornerRadius = corner;
  self.layer.masksToBounds = YES;
  [self layoutIfNeeded];
}

- (void)addPixelBorderColor:(UIColor *)borderColor {
  [self addBorderColor:borderColor borderWidth:1.f];
}

- (void)addBorderColor:(UIColor *)borderColor
           borderWidth:(CGFloat )borderWidth {
  self.layer.masksToBounds = YES;
  self.layer.borderColor = borderColor.CGColor;
  self.layer.borderWidth = borderWidth;
  [self layoutIfNeeded];
}

- (void)addShadow {
  self.layer.shadowColor = [UIColor blackColor].CGColor;
  self.layer.shadowOpacity = 0.4;
  self.layer.shadowRadius = 4.f;
  self.layer.shadowOffset = CGSizeMake(0, -2.f);
  [self layoutIfNeeded];
}

//MARK: Shake Animation

- (void)wrongPassAnimation {
  CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
  animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
  animation.duration = 0.5;
  animation.values = @[@(-20), @20, @(-20), @(20), @(-10), @(10), @(-5), @(5), @(0)];
  [self.layer addAnimation:animation forKey:@"shake"];
}

- (void)easyWrongPassAnimation {
  CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
  animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
  animation.duration = 0.65;
  animation.values = @[@(-10), @(15), @(-15), @(10), @(-10), @(5), @(-5), @(5), @(0)];
  [self.layer addAnimation:animation forKey:@"shake"];
}

- (void)infiniteShakeAnimation {
  CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
  animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
  //animation.autoreverses = YES;
  animation.duration = 0.4;
  animation.repeatCount = HUGE_VALF;
  animation.values = @[@(-5),@(0), @(5), @(0), @(-5)];
  [self.layer addAnimation:animation forKey:@"shake"];
}

//MARK: Scale Animation

- (void)pressAnimation {
  CABasicAnimation* animation = [CABasicAnimation
                                 animationWithKeyPath:@"transform.scale"];
  animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
  animation.duration = 0.1f;
  animation.toValue    = (id)@(0.9);
  animation.autoreverses = YES;
  [self.layer addAnimation:animation forKey:nil];
}

- (void)pressAnimationScale:(CGFloat )scale duration:(CGFloat )duration {
  CABasicAnimation* animation = [CABasicAnimation
                                 animationWithKeyPath:@"transform.scale"];
  animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
  animation.duration = duration;
  animation.toValue    = (id)@(scale);
  animation.autoreverses = YES;
  [self.layer addAnimation:animation forKey:nil];
}

- (void)scaleAnimationFromZero {
  [self scaleAnimationFromValue:0.0
                        toValue:1.0
                       duration:0.3];
}


- (void)scaleAnimationFromValue:(CGFloat )fromValue
                        toValue:(CGFloat )toValue
                       duration:(CGFloat )duration {
  CABasicAnimation* animation = [CABasicAnimation
                                 animationWithKeyPath:@"transform.scale"];
  animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
  animation.duration   = duration;
  animation.fromValue  = (id)@(fromValue);
  animation.toValue    = (id)@(toValue);
  animation.autoreverses = NO;
  animation.removedOnCompletion = YES;
  [self.layer addAnimation:animation forKey:nil];
}

//MARK: Position animations

- (void)animateCenterPosition {
  [self animateFromCenter:CGPointMake((self.frame.size.width/2), (self.frame.size.height/2))
                  toPoint:CGPointMake((self.frame.size.width/2), (self.frame.size.height/2))
                 duration:0.2f];
}

- (void)animateFromCenter:(CGPoint )fromPoint
                  toPoint:(CGPoint )toPoint
                 duration:(CGFloat )duration {
  
  CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
  animation.duration = duration;
  animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
  
  animation.fromValue = [NSValue valueWithCGPoint:fromPoint];
  animation.toValue   = [NSValue valueWithCGPoint:toPoint];
  
  animation.autoreverses = NO;
  animation.removedOnCompletion = YES;
  
  [self.layer addAnimation:animation forKey:@"position"];
}


//MARK: SlideToUnlock animation


- (void)slideToUnlockAnimation {
  
  static NSString *const kSlideToUnlockMaskImageName = @"slide_to_unlock_mask";
  static NSString *const kPositionXAnimationKeyPath  = @"position.x";
  static NSString *const kSlideToUnlockAnimationKey  = @"slideAnimation";
  
  static CGFloat const kSlideToUnlockMaskDefaultInset  = 50.f;
  static CGFloat const kSlideToUnlockAnimationDuration = 2.f;
  CALayer *maskLayer = [CALayer layer];
  
  CGFloat height = self.frame.size.height;
  CGFloat width  = self.frame.size.width;
  
  
  maskLayer.backgroundColor = [[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.15f] CGColor];
  maskLayer.contents = (id)[[UIImage imageNamed:kSlideToUnlockMaskImageName] CGImage];
  maskLayer.contentsGravity = kCAGravityCenter;
  maskLayer.frame = CGRectMake(-2*width, 0.0f, 4 *width, height);
  
  // Animate the mask layer's horizontal position
  CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:kPositionXAnimationKeyPath];
  positionAnimation.fromValue = @(-kSlideToUnlockMaskDefaultInset);
  positionAnimation.toValue   = @(width + kSlideToUnlockMaskDefaultInset);
  positionAnimation.repeatCount = HUGE_VALF;
  positionAnimation.duration    = kSlideToUnlockAnimationDuration;
  [maskLayer addAnimation:positionAnimation forKey:kSlideToUnlockAnimationKey];
  
  [self.layer addSublayer:maskLayer];
}

//MARK: kCATransitionFade

- (void)fadeAnimation {
  [self transitionType:kCATransitionFade duration:kTransitionDuration];;
}

//MARK: kCATransitionPush

- (void)pushFromBottomAnimation {
  [self pushSubtype:kCATransitionFromBottom];
}

- (void)pushFromTopAnimation {
  [self pushSubtype:kCATransitionFromTop];
}

- (void)pushFromTopAnimationWithDuration:(CGFloat )duration {
  [self pushSubtype:kCATransitionFromTop duration:duration];
}

- (void)pushSubtype:(NSString *)subtype {
  [self pushSubtype:subtype duration:kTransitionDuration];
}

- (void)pushSubtype:(NSString *)subtype duration:(CGFloat )duration {
  [self transitionType:kCATransitionPush subtype:subtype duration:duration];
}

//MARK: CATransition

- (void)transitionType:(NSString *)type duration:(CGFloat )duration {
  [self transitionType:type subtype:nil duration:duration];
}

- (void)transitionType:(NSString *)type subtype:(NSString *)subtype duration:(CGFloat )duration {
  CATransition *transition = [CATransition animation];
  transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
  transition.type = type;
  transition.subtype = subtype;
  transition.duration = duration;
  [self.layer addAnimation:transition forKey:nil];
}

//MARK: CATransaction

- (void)addTransactionAnimations:(void (^)(void))animations duration:(CGFloat )duration completion:(void (^)(void))completion {
  [CATransaction begin];
  [CATransaction setValue:[NSNumber numberWithFloat:duration]
                   forKey:kCATransactionAnimationDuration];
  [CATransaction setCompletionBlock:completion];
  if (animations) { animations(); }
  [CATransaction commit];
}


- (void)addAutoresizingFlexibleMask {
  self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin;
}

#pragma mark - Constraints

- (void)addConstraintsToFillSuperView
{
  UIView *superView = self.superview;
  if(!superView)
    return;
  
  self.translatesAutoresizingMaskIntoConstraints = NO;
  
  NSLayoutConstraint *left = [NSLayoutConstraint
                              constraintWithItem:self attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual
                              toItem:superView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0];
  
  NSLayoutConstraint *right = [NSLayoutConstraint
                               constraintWithItem:self attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual
                               toItem:superView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0];
  
  NSLayoutConstraint *top = [NSLayoutConstraint
                             constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual
                             toItem:superView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
  NSLayoutConstraint *bottom = [NSLayoutConstraint
                                constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual
                                toItem:superView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
  
  [superView addConstraints:@[ left, right, top, bottom ]];
}

- (void)addConstraintsToFillView:(UIView *)view
{
  UIView *superView = view;
  if(!superView)
    return;
  
  self.translatesAutoresizingMaskIntoConstraints = NO;
  
  NSLayoutConstraint *left = [NSLayoutConstraint
                              constraintWithItem:self attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual
                              toItem:superView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0];
  
  NSLayoutConstraint *right = [NSLayoutConstraint
                               constraintWithItem:self attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual
                               toItem:superView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0];
  
  NSLayoutConstraint *top = [NSLayoutConstraint
                             constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual
                             toItem:superView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
  NSLayoutConstraint *bottom = [NSLayoutConstraint
                                constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual
                                toItem:superView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
  
  [superView addConstraints:@[ left, right, top, bottom ]];
}

- (void)addConstraintsToFillFrame:(CGRect)frame
{
  UIView *superView = self.superview;
  if(!superView)
    return;
  
  self.translatesAutoresizingMaskIntoConstraints = NO;
  
  NSLayoutConstraint *left = [NSLayoutConstraint
                              constraintWithItem:self attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual
                              toItem:superView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:frame.origin.x];
  
  NSLayoutConstraint *top = [NSLayoutConstraint
                             constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual
                             toItem:superView attribute:NSLayoutAttributeTop multiplier:1.0 constant:frame.origin.y];
  
  NSLayoutConstraint *width = [NSLayoutConstraint
                               constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual
                               toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:frame.size.width];
  
  NSLayoutConstraint *height = [NSLayoutConstraint
                                constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual
                                toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:frame.size.height];
  
  [superView addConstraints:@[ left, top, width, height ]];
}

@end
