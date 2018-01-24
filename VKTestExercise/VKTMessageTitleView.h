//
//  VKTMessageTitleView.h
//  VKTestExercise
//
//  Created by Alex Kosyakov on 08.01.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VKTMessageViewProtocol.h"

@interface VKTMessageTitleView : UIView <VKTMessageTitleProtocol>
@property (strong, nonatomic) NSNumber *verified;
@property (strong, nonatomic) NSNumber *muted;
@property (strong, nonatomic) NSNumber *time;
@property (copy, nonatomic)   NSString *titleText;
@end
