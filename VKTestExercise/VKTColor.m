//
//  VKTColor.m
//  VKTestExercise
//
//  Created by Alex Kosyakov on 14.01.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import "VKTColor.h"
#import "UIColor+Utils.h"

static NSString *const kVKTitleColotHEX         = @"2C2D2E";
static NSString *const kVKTextColotHEX          = @"717579";
static NSString *const kVKAttachmentColotHEX    = @"456690";
static NSString *const kVKMainColotHEX          = @"517FBA";
static NSString *const kCellSeparatorColotHEX   = @"D7D8DA";

static UITableView *__tableView;

@implementation VKTColor

+ (UIColor *)vkTitleColor {
  return [UIColor colorFromHexString:kVKTitleColotHEX];
}

+ (UIColor *)vkTextColor {
  return [UIColor colorFromHexString:kVKTextColotHEX];
}

+ (UIColor *)vkAttachmentColor {
  return [UIColor colorFromHexString:kVKAttachmentColotHEX];
}

+ (UIColor *)vkMainColor {
  return [UIColor colorFromHexString:kVKMainColotHEX];
}

+ (UIColor *)cellSeparatorColor {
  return [UIColor colorFromHexString:kCellSeparatorColotHEX];
}
@end
