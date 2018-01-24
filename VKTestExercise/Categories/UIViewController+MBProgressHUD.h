//
//  UIViewController+MBProgressHUD.h
//  Flowers
//
//  Created by Alex Kosyakov on 3/7/17.
//  Copyright © 2017 Cube Innovations, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (MBProgressHUD)

- (void)showProgressHUD;
- (void)showProgressHUDInContext:(UIView *)context;

- (void)hideProgressHUD;
- (void)hideProgressHUDInContext:(UIView *)context;
- (void)hideProgressHUDWithDelay:(CGFloat )delay;
- (void)hideProgressHUDInContext:(UIView *)context delay:(CGFloat )delay;

@end
