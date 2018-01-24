//
//  VKTFont.m
//  VKTestExercise
//
//  Created by Alex Kosyakov on 1/22/18.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import "VKTFont.h"

@implementation VKTFont

+ (UIFont *)vkTextFontSize:(CGFloat )size {
  return [UIFont systemFontOfSize:size];
}

+ (UIFont *)vkTextFont {
  return [UIFont systemFontOfSize:15.f];
}

+ (UIFont *)vkTitleFontSize:(CGFloat )size {
  return [UIFont boldSystemFontOfSize:size];
}

+ (UIFont *)vkTitleFont {
  return [UIFont boldSystemFontOfSize:15.f];
}

@end
