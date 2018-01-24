//
//  VKTOnlineStatusView.m
//  VKTestExercise
//
//  Created by Alex Kosyakov on 13.01.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import "VKTOnlineStatusView.h"

@interface VKTOnlineStatusView()
@property (weak, nonatomic) IBOutlet UIImageView *onlineIconImageView;
@end

@implementation VKTOnlineStatusView
@synthesize onlineStatus;

- (void)awakeFromNib {
  [super awakeFromNib];
  self.backgroundColor = [UIColor clearColor];
}

- (void)setOnlineStatus:(VKTUserOnlineStatus)onlineStatus {
    UIImage *image = nil;
    switch (onlineStatus) {
        case VKTUserOnline: {
            image = [VKTImage vkOnlineIconImage];
        } break;
        case VKTUserOnlineMobile: {
            image = [VKTImage vkOnlineMobileImage];
        } break;
        case VKTUserOffline: {
          image = nil;
        }
    }
    self.onlineIconImageView.image = image;
}

@end
