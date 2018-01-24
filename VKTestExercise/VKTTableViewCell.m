//
//  VKTTableViewCell.m
//  VKTestExercise
//
//  Created by Alex Kosyakov on 05.01.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import "VKTTableViewCell.h"

@implementation VKTTableViewCell

- (NSString *)reuseIdentifier {
    return [self.class reuseIdentifier];
}

+ (NSString *)reuseIdentifier {
    return NSStringFromClass(self.class);
}

+ (UINib *)nibName {
    return [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
}

- (UINib *)nibName {
    return [[self class] nibName];
}

@end
