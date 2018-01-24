//
//  UIView+CoreAnimation.h
//  cube
//
//  Created by Alex Kosyakov on 8/16/16.
//  Copyright © 2016 Cube Innovations, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CoreAnimation)

- (void)pushFromBottomAnimation;
- (void)pushFromTopAnimation;
- (void)pushFromTopAnimationWithDuration:(CGFloat )duration;

- (void)fadeAnimation;

- (void)fontSizeAnimation:(CGFloat )fromSize toFont:(CGFloat )toSize;
- (void)fadeAnimationWithColor:(UIColor *)fadeColor;
- (void)cornerRadiusAnimation:(CGFloat )cornerRadius duration:(CGFloat )duration;

- (void)makeRound;
- (void)makeRoundCorner:(CGFloat )corner;
- (void)addPixelBorderColor:(UIColor *)borderColor;
- (void)addBorderColor:(UIColor *)borderColor
           borderWidth:(CGFloat )borderWidth;
- (void)addShadow;

- (void)pressAnimation;
- (void)pressAnimationScale:(CGFloat )scale duration:(CGFloat )duration;

- (void)scaleAnimationFromZero;
- (void)scaleAnimationFromValue:(CGFloat )fromValue
                        toValue:(CGFloat )toValue
                       duration:(CGFloat )duration;

- (void)slideToUnlockAnimation;


- (void)animateCenterPosition;
- (void)animateFromCenter:(CGPoint )fromPoint
                  toPoint:(CGPoint )toPoint
                 duration:(CGFloat )duratio;

- (void)wrongPassAnimation;
- (void)easyWrongPassAnimation;
- (void)infiniteShakeAnimation;


- (void)addAutoresizingFlexibleMask;
- (void)addConstraintsToFillSuperView;
- (void)addConstraintsToFillView:(UIView *)view;
- (void)addConstraintsToFillFrame:(CGRect)frame;
@end
