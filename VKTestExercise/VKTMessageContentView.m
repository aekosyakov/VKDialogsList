//
//  VKTMessageContentView.m
//  VKTestExercise
//
//  Created by Alex Kosyakov on 14.01.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import "VKTMessageContentView.h"
#import "VKTUserMessageContentView.h"
#import "VKTFriendMessageContentView.h"
#import "VKTMessage+Extensions.h"

@interface VKTMessageContentView()
@property (strong, nonatomic) UIView <VKTMessageContentViewProtocol > * userMessageContentView;
@property (strong, nonatomic) UIView <VKTMessageContentViewProtocol > * friendMessageContentView;

@end
@implementation VKTMessageContentView

- (void)reloadWithModel:(id <VKTMessageContentViewModelProtocol > )model {
    if (!model.message.isOut.boolValue && ![model.message isChat] && ![model.message.user_id isEqualToNumber:[VKTUserToken userID]]) {
        if (self.subviews.count > 0) {
            [self.friendMessageContentView removeFromSuperview];
            self.friendMessageContentView = nil;
        }
        
        if (!self.userMessageContentView) {
            self.userMessageContentView = [VKTUserMessageContentView loadFromNib];
            self.userMessageContentView.frame = self.bounds;
            [self addSubview:self.userMessageContentView];
            [self.userMessageContentView addAutoresizingFlexibleMask];
        }
        
        [self.userMessageContentView reloadWithModel:model];

    } else {
        if (self.subviews.count > 0) {
            [self.userMessageContentView removeFromSuperview];
            self.userMessageContentView = nil;
        }
        
        if (!self.friendMessageContentView) {
            self.friendMessageContentView = [VKTFriendMessageContentView loadFromNib];
            self.friendMessageContentView.frame = self.bounds;
            [self addSubview:self.friendMessageContentView];
            [self.friendMessageContentView addAutoresizingFlexibleMask];
        }
        [self.friendMessageContentView reloadWithModel:model];
    }
}


@end
