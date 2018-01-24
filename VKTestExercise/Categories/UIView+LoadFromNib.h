//
//  UIView+LoadFromNib.h
//  VKTestExercise
//
//  Created by Alex Kosyakov on 23.12.2017.
//  Copyright © 2017 Alex Kosyakov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LoadFromNib)
#pragma mark - Nib Loading
+ (instancetype)loadFromNib;
+ (instancetype)loadNibNamed:(NSString *)name;
@end
