//
//  VKTImage.m
//  VKTestExercise
//
//  Created by Alex Kosyakov on 1/22/18.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import "VKTImage.h"

@implementation VKTImage

+ (UIImage *)vkSettingsIcon {
  NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:@"VKSdkResources" withExtension:@"bundle"]];
  UIImage *settingsImage = [UIImage imageWithContentsOfFile:[bundle pathForResource:@"vk_settings" ofType:@"png"]];
  return settingsImage;
}

+ (UIImage *)vkLogoImage {
  NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:@"VKSdkResources" withExtension:@"bundle"]];
  UIImage *image = [UIImage imageWithContentsOfFile:[bundle pathForResource:@"ic_vk_logo_nb" ofType:@"png"]];
  return image;
}

+ (UIImage *)vkOnlineIconImage {
  return [UIImage imageNamed:@"online"];
}

+ (UIImage *)vkOnlineMobileImage {
  return [UIImage imageNamed:@"online_mobile"];
}

+ (UIImage *)vkMutedIconImage {
  return [UIImage imageNamed:@"muted"];
}

+ (UIImage *)vkVerifiedIconImage {
  return [UIImage imageNamed:@"verified"];
}

@end
