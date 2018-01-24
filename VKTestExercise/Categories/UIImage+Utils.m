//
//  UIImage+Utils.m
//  Flowers
//
//  Created by aleksey kosylo on 23/01/2017.
//  Copyright © 2017 Cube Innovations, Inc. All rights reserved.
//

#import "UIImage+Utils.h"

@implementation UIImage (Utils)

+ (UIImage *)newImageWithColor:(UIColor *)color {
  CGRect rect = CGRectMake(0.0f, 0.0f, 20.0f, 20.0f);
  UIGraphicsBeginImageContext(rect.size);
  CGContextRef context = UIGraphicsGetCurrentContext();

  CGContextSetFillColorWithColor(context, [color CGColor]);
  CGContextFillRect(context, rect);

  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();

  return image;
}

- (UIImage *)fixOrientation {
  if (self.imageOrientation == UIImageOrientationUp) return self;

  UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
  [self drawInRect:(CGRect){0, 0, self.size}];
  UIImage *normalizedImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return normalizedImage;
}

@end
