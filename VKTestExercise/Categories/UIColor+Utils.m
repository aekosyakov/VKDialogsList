//
// UIColor (Utils)
// EE Utilities
//
// Copyright (c) 2013 Eugene Egorov. All rights reserved.
//

#import "UIColor+Utils.h"

const CGFloat MaxColorValue = 255.0f;

@implementation UIColor (Utils)

#pragma mark - Hex

- (NSString *)hexString
{
  CGFloat red, green, blue, alpha;
  if([self getRed:&red green:&green blue:&blue alpha:&alpha])
    return [NSString stringWithFormat:
      @"%02X%02X%02X%02X",
      (int)(alpha * MaxColorValue), (int)(red * MaxColorValue), (int)(green * MaxColorValue), (int)(blue * MaxColorValue)];
  else
    return @"";
}

+ (UIColor *)colorFromHexString:(NSString *)hexString
{
  NSString *colorString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
  CGFloat alpha, red, blue, green;
  switch(colorString.length) {
    case 3: // #RGB
      alpha = 1.0f;
      red = [self colorComponentFromString:colorString start:0 length:1];
      green = [self colorComponentFromString:colorString start:1 length:1];
      blue = [self colorComponentFromString:colorString start:2 length:1];
      break;
    case 4: // #ARGB
      alpha = [self colorComponentFromString:colorString start:0 length:1];
      red = [self colorComponentFromString:colorString start:1 length:1];
      green = [self colorComponentFromString:colorString start:2 length:1];
      blue = [self colorComponentFromString:colorString start:3 length:1];
      break;
    case 6: // #RRGGBB
      alpha = 1.0f;
      red = [self colorComponentFromString:colorString start:0 length:2];
      green = [self colorComponentFromString:colorString start:2 length:2];
      blue = [self colorComponentFromString:colorString start:4 length:2];
      break;
    case 8: // #AARRGGBB
      alpha = [self colorComponentFromString:colorString start:0 length:2];
      red = [self colorComponentFromString:colorString start:2 length:2];
      green = [self colorComponentFromString:colorString start:4 length:2];
      blue = [self colorComponentFromString:colorString start:6 length:2];
      break;
    default:
      return nil;
  }
  return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (CGFloat)colorComponentFromString:(NSString *)string start:(NSUInteger)start length:(NSUInteger)length
{
  NSString *substring = [string substringWithRange:NSMakeRange(start, length)];
  NSString *fullHex = length == 2 ? substring : [substring stringByAppendingString:substring];
  long num = strtol(fullHex.UTF8String, NULL, 16);
  return num / MaxColorValue;
}

#pragma mark - Integer components

+ (UIColor *)colorWithIntegerRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(NSInteger)alpha
{
  return [self colorWithRed:red / MaxColorValue green:green / MaxColorValue blue:blue / MaxColorValue alpha:alpha / MaxColorValue];
}

UIColor *RGBA(CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha) {
  return [UIColor colorWithRed:red/255.f green:green/255.f blue:blue/255.f alpha:alpha];
}

UIColor *SingleRGBA(CGFloat redGreenBlue, CGFloat alpha) {
  return RGBA(redGreenBlue,redGreenBlue,redGreenBlue,alpha);
}

@end
