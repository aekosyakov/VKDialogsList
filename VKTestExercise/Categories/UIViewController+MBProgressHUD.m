
//
//  UIViewController+MBProgressHUD.m
//  Flowers
//
//  Created by Alex Kosyakov on 3/7/17.
//  Copyright © 2017 Cube Innovations, Inc. All rights reserved.
//

#import "UIViewController+MBProgressHUD.h"
#import "MBProgressHUD.h"

@implementation UIViewController (MBProgressHUD)


- (void)showProgressHUD {
  [self showProgressHUDInContext:self.navigationController.view ?: self.view];
}

- (void)showProgressHUDInContext:(UIView *)context {
   [MBProgressHUD showHUDAddedTo:context animated:YES];
}

- (void)hideProgressHUD {
  [self hideProgressHUDWithDelay:0.f];
}

- (void)hideProgressHUDInContext:(UIView *)context {
  [self hideProgressHUDInContext:context delay:0.f];
}

- (void)hideProgressHUDWithDelay:(CGFloat )delay {
  [self hideProgressHUDInContext:self.navigationController.view ?: self.view delay:delay];
}

- (void)hideProgressHUDInContext:(UIView *)context delay:(CGFloat )delay {
  void (^completion)(void) = ^() {
    [MBProgressHUD hideHUDForView:context animated:YES];
  };
  if (delay > 0.f) {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), completion);
  } else {
    if (completion) {
      completion();
    }
  }
}


@end
