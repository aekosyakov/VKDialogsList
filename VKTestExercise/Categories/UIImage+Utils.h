//
//  UIImage+Utils.h
//  Flowers
//
//  Created by aleksey kosylo on 23/01/2017.
//  Copyright © 2017 Cube Innovations, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Utils)
+ (UIImage *)newImageWithColor:(UIColor *)color;

- (UIImage *)fixOrientation;

@end
