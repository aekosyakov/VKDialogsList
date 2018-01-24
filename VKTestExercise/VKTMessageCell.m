//
//  VKTMessageCell.m
//  VKTestExercise
//
//  Created by Alex Kosyakov on 05.01.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import "VKTMessageCell.h"
#import "UIView+MessageExtensions.h"
#import "VKTMessage+Extensions.h"
#import "VKTMessageViewProtocol.h"
#import "VKTSerialOperationQueue.h"

@interface VKTMessageCell()
@property (strong, nonatomic) VKTMessage *message;
@property (strong, nonatomic) UIView <VKTMessageObjectProvider >*messageView;
@property (strong, nonatomic) VKTSerialOperationQueue *serialQueue;
@end

@implementation VKTMessageCell

- (void)awakeFromNib {
  [super awakeFromNib];
  self.backgroundColor = [UIColor whiteColor];
  self.contentView.backgroundColor = [UIColor whiteColor];
  self.selectionStyle = UITableViewCellSelectionStyleNone;
  self.serialQueue = [[VKTSerialOperationQueue alloc] init];
}

- (void)reloadWithMessage:(VKTMessage *_Nonnull)object {
    _message = object;
    [self updateUI];
}

- (void)updateUI {
    [self.serialQueue cancelAllOperations];
    NSBlockOperation *operation = [[NSBlockOperation alloc] init];
    __weak typeof (NSBlockOperation) *_operation = operation;
    [operation addExecutionBlock:^{
        if (_operation.cancelled) {
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.messageView reloadWithMessage:self.message];
        });
    }];
    [self.serialQueue addOperation:operation];
}

- (UIView <VKTMessageObjectProvider > *)messageView {
    if (!_messageView) {
        [self layoutIfNeeded];
        [self.contentView layoutIfNeeded];
        _messageView = [UIView messageView];
        _messageView.frame = self.contentView.bounds;
        [self.contentView addSubview:_messageView];
        [_messageView addAutoresizingFlexibleMask];
    }
    return _messageView;
}

@end
