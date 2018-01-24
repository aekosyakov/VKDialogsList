//
//  UIView+LoadFromNib.m
//  VKTestExercise
//
//  Created by Alex Kosyakov on 23.12.2017.
//  Copyright © 2017 Alex Kosyakov. All rights reserved.
//

#import "UIView+LoadFromNib.h"

@implementation UIView (LoadFromNib)

#pragma mark - Nib Loading
+ (instancetype)loadFromNib {
    return [self loadNibNamed:NSStringFromClass([self class])];
}
+ (instancetype)loadNibNamed:(NSString *)name {
    return [[NSBundle mainBundle] loadNibNamed:name owner:nil options:nil].firstObject;
}



@end
