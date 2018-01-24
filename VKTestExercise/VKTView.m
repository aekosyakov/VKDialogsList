//
//  VKTView.m
//  VKTestExercise
//
//  Created by Alex Kosyakov on 23.12.2017.
//  Copyright © 2017 Alex Kosyakov. All rights reserved.
//

#import "VKTView.h"

@implementation VKTView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
     self.backgroundColor = [UIColor whiteColor];
}

@end
