//
//  UIStoryboard+ViewControllers.m
//  VKTestExercise
//
//  Created by Alex Kosyakov on 02.01.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import "UIStoryboard+ViewControllers.h"
#import "VKTService+Extensions.h"

#import "VKTAuthController.h"
#import "VKTMainController.h"
#import "VKTDialogsListController.h"


@implementation UIStoryboard (ViewControllers)

#pragma mark Storyboards
+ (instancetype)mainStoryboard {
  return [UIStoryboard storyboardWithName:@"Main" bundle:nil];
}

+ (instancetype)launchStoryboard {
  return [UIStoryboard storyboardWithName:@"LaunchScreen" bundle:nil];
}

#pragma mark Launch Controller

+ (UIViewController *)launchController {
  return [[UIStoryboard launchStoryboard] instantiateInitialViewController];
}

#pragma mark Main Controller

+ (VKTMainController *)mainController {
  return [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier:NSStringFromClass([VKTMainController class])];
}

#pragma mark Authotization

+ (VKTAuthController *)authControllerWithCompletion:(void(^)(BOOL success))completion  {
  VKTAuthController *vc = (VKTAuthController *)[self authController];
  vc.didFinishCompletion = completion;
  return vc;
}


+ (VKTAuthController *)authController {
  VKTAuthController *vc = [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier:NSStringFromClass([VKTAuthController class])];
  vc.authService = [VKTService authService];
  return vc;
}


#pragma mark Chats

+ (VKTDialogsListController *)dialogListContoller {
  VKTDialogsListController *vc = [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier:NSStringFromClass([VKTDialogsListController class])];
  vc.messagesService = [VKTService messagesService];
  return vc;
}



@end
