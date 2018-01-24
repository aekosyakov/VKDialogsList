//
// UIView (Utils)
// EE Utilities
//
// Copyright (c) 2013 Eugene Egorov. All rights reserved.
//

#import "UIView+Utils.h"

@implementation UIView (Utils)



#pragma mark - Transition
- (void)addFadeTransition {
  CATransition *transition = [CATransition animation];
  transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
  transition.type = kCATransitionFade;
  transition.duration = 0.3; // default duration
  [self.layer addAnimation:transition forKey:nil];
}

- (void)addFadeTransition:(CGFloat )duration {
  CATransition *transition = [CATransition animation];
  transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
  transition.type = kCATransitionFade;
  transition.duration = duration;
  [self.layer addAnimation:transition forKey:nil];
}


- (void)addPopAnimation {
  CATransition *transition = [CATransition animation];
  transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
  transition.type = kCATransitionFade;
  transition.duration = 0.5; // default duration
  [self.layer addAnimation:transition forKey:nil];
}

- (void)addFlipFromRightTransition {
  CATransition *transition = [CATransition animation];
  transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
  transition.type = kCATransitionFromRight;
  transition.duration = 0.3; // default duration
  [self.layer addAnimation:transition forKey:nil];
}

- (void)addFlipFromLeftTransition {
  CATransition *transition = [CATransition animation];
  transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
  transition.type = kCATransitionFromLeft;
  transition.duration = 0.3; // default duration
  [self.layer addAnimation:transition forKey:nil];
}

- (void)addRoundAnimation {
  [self addRoundAnimationRotationsCount:1];
}

- (void)addRoundAnimationRotationsCount:(NSUInteger )count {
  CABasicAnimation* rotationAnimation;
  rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
  rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 * count];
  rotationAnimation.duration = 0.4;
  rotationAnimation.cumulative = YES;
  rotationAnimation.repeatCount = 0; //repeat ? HUGE_VALF : 0;
  [self.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

#pragma mark - Screenshot

- (UIImage *)screenshot {
  UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0.0);
  [self.layer renderInContext:UIGraphicsGetCurrentContext()];
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return image;
}

- (UIImage *)screenshot7 {
  UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0.0);
  if(![self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)] || ![self drawViewHierarchyInRect:self.bounds afterScreenUpdates:NO])
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return image;
}


#pragma mark - Mask

- (CALayer *)addMaskWithImage:(UIImage *)maskImage
{
  CALayer *mask = [CALayer layer];
  mask.contents = (id)maskImage.CGImage;
  CGRect frame = self.bounds;
  mask.frame = frame;
  self.layer.mask = mask;
  self.layer.masksToBounds = YES;
  return mask;
}

#pragma mark - Size

- (CGSize)sizeThatFitWidth:(CGFloat)width
{
  if([self respondsToSelector:@selector(systemLayoutSizeFittingSize:withHorizontalFittingPriority:verticalFittingPriority:)])
    return [self systemLayoutSizeFittingSize:CGSizeMake(width, 0)
      withHorizontalFittingPriority:UILayoutPriorityRequired
      verticalFittingPriority:UILayoutPriorityFittingSizeLevel];
  else
    return [self systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
}

- (CGSize)sizeThatFitHeight:(CGFloat)height
{
  if([self respondsToSelector:@selector(systemLayoutSizeFittingSize:withHorizontalFittingPriority:verticalFittingPriority:)])
    return [self systemLayoutSizeFittingSize:CGSizeMake(0, height)
      withHorizontalFittingPriority:UILayoutPriorityFittingSizeLevel
      verticalFittingPriority:UILayoutPriorityRequired];
  else
    return [self systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
}

#pragma mark - Animations

- (void)showFadeAnimationView:(BOOL)show completion:(void(^)(BOOL finished))completion {
  [self showView:show duration:show ? 0.3f : 0.2f completion:completion];
}

- (void)showView:(BOOL)show duration:(NSTimeInterval)duration completion:(void (^)(BOOL))completion {
  dispatch_async(dispatch_get_main_queue(), ^{
    if(show) {
      self.alpha = 0.f;
      self.hidden = NO;
      
      [UIView animateWithDuration:duration animations:^{
        self.alpha = 1.f;
      } completion:completion];
    }
    else {
      [UIView animateWithDuration:duration animations:^{
        self.alpha = 0.f;
      } completion:^(BOOL finished) {
        self.hidden = YES;
        self.alpha = 1.f;
        
        if(completion) {
          completion(finished);
        }
      }];
    }
  });
}

@end
