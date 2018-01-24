//
//  UITableView+MessageCell.h
//  VKTestExercise
//
//  Created by Alex Kosyakov on 1/24/18.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VKTMessageViewProtocol.h"

@interface UITableView (MessageCell)
- (UITableViewCell <VKTMessageObjectProvider >* _Nonnull)messageCell;
@end
