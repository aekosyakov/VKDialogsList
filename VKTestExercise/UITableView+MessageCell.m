//
//  UITableView+MessageCell.m
//  VKTestExercise
//
//  Created by Alex Kosyakov on 1/24/18.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import "UITableView+MessageCell.h"

#import "UIView+MessageExtensions.h"
#import "VKTMessageCell.h"
#import "VKTMessage+CoreDataClass.h"

@implementation UITableView (MessageCell)
- (UITableViewCell <VKTMessageObjectProvider >* _Nonnull)messageCell {
  return [self dequeueReusableCellWithIdentifier:NSStringFromClass([VKTMessageCell class])];;
}

@end
