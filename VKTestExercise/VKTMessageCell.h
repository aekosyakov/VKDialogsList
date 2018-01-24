//
//  VKTMessageCell.h
//  VKTestExercise
//
//  Created by Alex Kosyakov on 05.01.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import "VKTTableViewCell.h"
#import "VKTMessageViewProtocol.h"
@class VKTMessage;
@interface VKTMessageCell : VKTTableViewCell <VKTMessageObjectProvider>
@end
