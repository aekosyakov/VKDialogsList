//
//  UILabel+TextSize.m
//  cube
//
//  Created by Alex Kosyakov on 12/1/16.
//  Copyright © 2016 Cube Innovations, Inc. All rights reserved.
//

#import "UILabel+TextSize.h"

@implementation UILabel (TextSize)

+ (instancetype)labelWithText:(NSString *)text font:(UIFont *)font {
  UILabel *label = [UILabel new];
  label.text = text;
  label.font = font;
  label.numberOfLines = 0;
  label.lineBreakMode = NSLineBreakByWordWrapping;
  label.textAlignment = NSTextAlignmentCenter;
  return label;
}

- (CGSize )textSizeInWidth:(CGFloat )width {
  return [self sizeThatFits:CGSizeMake(width, CGFLOAT_MAX)];
}

- (CGSize )textSizeInHeight:(CGFloat )height {
  return [self sizeThatFits:CGSizeMake(CGFLOAT_MAX, height)];
}

@end
