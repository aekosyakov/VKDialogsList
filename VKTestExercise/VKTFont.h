//
//  VKTFont.h
//  VKTestExercise
//
//  Created by Alex Kosyakov on 1/22/18.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VKTFont : NSObject
+ (UIFont *)vkTitleFontSize:(CGFloat )size;
+ (UIFont *)vkTitleFont;

+ (UIFont *)vkTextFontSize:(CGFloat )size;
+ (UIFont *)vkTextFont;
@end
