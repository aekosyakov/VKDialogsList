//
//  UIStoryboard+ViewControllers.h
//  VKTestExercise
//
//  Created by Alex Kosyakov on 02.01.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UIStoryboard (ViewControllers)

+ (UIViewController *)launchController;
+ (UIViewController *)mainController;
+ (UIViewController *)authController;
+ (UIViewController *)authControllerWithCompletion:(void(^)(BOOL success))completion ;
+ (UIViewController *)dialogListContoller;
@end
