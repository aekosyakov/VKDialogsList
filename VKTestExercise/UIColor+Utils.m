
//
//  UIColor+Utils.m
//  VKTestExercise
//
//  Created by Alex Kosyakov on 1/22/18.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import "UIColor+Utils.h"

static CGFloat const MaxColorValue = 255.0f;
@implementation UIColor (Utils)

+ (UIColor *)colorFromHexString:(NSString *)hexString {
  NSString *colorString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
  CGFloat alpha, red, blue, green;
  switch(colorString.length) {
    case 3: // #RGB
      alpha = 1.0f;
      red =   [self colorComponentFromString:colorString start:0 length:1];
      green = [self colorComponentFromString:colorString start:1 length:1];
      blue =  [self colorComponentFromString:colorString start:2 length:1];
      break;
    case 4: // #ARGB
      alpha = [self colorComponentFromString:colorString start:0 length:1];
      red =   [self colorComponentFromString:colorString start:1 length:1];
      green = [self colorComponentFromString:colorString start:2 length:1];
      blue =  [self colorComponentFromString:colorString start:3 length:1];
      break;
    case 6: // #RRGGBB
      alpha = 1.0f;
      red =   [self colorComponentFromString:colorString start:0 length:2];
      green = [self colorComponentFromString:colorString start:2 length:2];
      blue =  [self colorComponentFromString:colorString start:4 length:2];
      break;
    case 8: // #AARRGGBB
      alpha = [self colorComponentFromString:colorString start:0 length:2];
      red =   [self colorComponentFromString:colorString start:2 length:2];
      green = [self colorComponentFromString:colorString start:4 length:2];
      blue =  [self colorComponentFromString:colorString start:6 length:2];
      break;
    default:
      return nil;
  }
  return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (CGFloat)colorComponentFromString:(NSString *)string start:(NSUInteger)start length:(NSUInteger)length {
  NSString *substring = [string substringWithRange:NSMakeRange(start, length)];
  NSString *fullHex = length == 2 ? substring : [substring stringByAppendingString:substring];
  long num = strtol(fullHex.UTF8String, NULL, 16);
  return num / MaxColorValue;
}

@end
