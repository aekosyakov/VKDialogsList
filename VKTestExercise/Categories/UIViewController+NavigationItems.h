//
//  UIViewController+NavigationItems.h
//  Flowers
//
//  Created by Alex Kosyakov on 12/15/16.
//  Copyright © 2016 Cube Innovations, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (NavigationItems)
- (void)addLeftBarButtonItem:(UIBarButtonItem * )leftItem;
- (void)addRightBarButtonItem:(UIBarButtonItem * )leftItem;

- (UIBarButtonItem *)customBarButtomItemWithImage:(UIImage *)image
                                 highlightedImage:(UIImage*)imageHighlihghted
                                           target:(id)targer
                                           action:(SEL)action;

- (UIBarButtonItem *)customBarButtomItemWithTitle:(NSString *)title
                                           target:(id)target
                                           action:(SEL)action;


@end
