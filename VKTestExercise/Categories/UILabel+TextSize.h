//
//  UILabel+TextSize.h
//  cube
//
//  Created by Alex Kosyakov on 12/1/16.
//  Copyright © 2016 Cube Innovations, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (TextSize)
+ (instancetype)labelWithText:(NSString *)text font:(UIFont *)font;
- (CGSize )textSizeInWidth:(CGFloat )width;
- (CGSize )textSizeInHeight:(CGFloat )height;
@end
