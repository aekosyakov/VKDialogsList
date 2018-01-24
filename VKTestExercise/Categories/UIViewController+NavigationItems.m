//
//  UIViewController+NavigationItems.m
//  Flowers
//
//  Created by Alex Kosyakov on 12/15/16.
//  Copyright © 2016 Cube Innovations, Inc. All rights reserved.
//

#import "UIViewController+NavigationItems.h"


@implementation UIViewController (NavigationItems)

- (void)addLeftBarButtonItem:(UIBarButtonItem * )leftItem {
  [self.navigationItem setLeftBarButtonItem:leftItem animated:NO];
}

- (void)addRightBarButtonItem:(UIBarButtonItem * )leftItem {
  [self.navigationItem setRightBarButtonItem:leftItem animated:NO];
}

- (UIBarButtonItem *)customBarButtomItemWithImage:(UIImage *)image
                                 highlightedImage:(UIImage*)imageHighlihghted
                                           target:(id)targer
                                           action:(SEL)action {
  UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
  
  button.frame = CGRectMake(0.0, 0.0, image.size.width, image.size.height);
  
  [button setImage:image forState:UIControlStateNormal];
  [button setImage:imageHighlihghted forState:UIControlStateHighlighted];
  [button addTarget:targer action:action forControlEvents:UIControlEventTouchUpInside];
  return [[UIBarButtonItem alloc] initWithCustomView:button];
}


- (UIBarButtonItem *)customBarButtomItemWithTitle:(NSString *)title
                                           target:(id)target
                                           action:(SEL)action {
  UILabel *titleLabel = [UILabel new];
  titleLabel.text = title;
  titleLabel.textColor = [UIColor whiteColor];
  [titleLabel sizeToFit];
  titleLabel.baselineAdjustment = UIBaselineAdjustmentAlignBaselines;
  titleLabel.backgroundColor = [UIColor orangeColor];
  [titleLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:target action:action]];
  titleLabel.userInteractionEnabled = YES;
  return [[UIBarButtonItem alloc] initWithCustomView:titleLabel];
}


@end
