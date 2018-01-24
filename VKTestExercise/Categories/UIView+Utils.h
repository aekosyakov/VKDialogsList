//
// UIView (Utils)
// EE Utilities
//
// Copyright (c) 2013 Eugene Egorov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Utils)

- (void)addFadeTransition;
- (void)addFadeTransition:(CGFloat )duration;
- (void)addFlipFromRightTransition;
- (void)addFlipFromLeftTransition;
- (void)addRoundAnimation;
- (void)addRoundAnimationRotationsCount:(NSUInteger )count;

- (UIImage *)screenshot;
- (UIImage *)screenshot7;


- (CALayer *)addMaskWithImage:(UIImage *)maskImage;

- (CGSize)sizeThatFitWidth:(CGFloat)width;
- (CGSize)sizeThatFitHeight:(CGFloat)height;

- (void)showFadeAnimationView:(BOOL)show completion:(void(^)(BOOL finished))completion;

- (void)showView:(BOOL)show duration:(NSTimeInterval)duration completion:(void(^)(BOOL finished))completion;

@end
