//
//  VKTNavigationController.m
//  VKTestExercise
//
//  Created by Alex Kosyakov on 14.01.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import "VKTNavigationController.h"

@implementation VKTNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super initWithRootViewController:rootViewController]) {
        [self initNavigationStyle];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if  (self = [super initWithCoder:aDecoder]) {
        [self initNavigationStyle];
    }
    return self;
}

- (void)initNavigationStyle {
    self.navigationBar.opaque = YES;
    self.navigationBar.translucent = NO;
  
    UIColor *foregroundColor = [UIColor whiteColor];
    UIFont *titleFont = [VKTFont vkTitleFontSize:18.f];
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : foregroundColor,
                                               NSFontAttributeName : titleFont};

    self.navigationBar.barTintColor = [VKTColor vkMainColor];
}

@end
