//
//  VKTItemsCountView.m
//  VKTestExercise
//
//  Created by Alex Kosyakov on 21.01.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import "VKTItemsCountView.h"

@interface VKTItemsCountView()
@property (strong, nonatomic) UILabel *itemsCountLabel;
@end

@implementation VKTItemsCountView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _itemsCountLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _itemsCountLabel.center = self.center;
        _itemsCountLabel.backgroundColor = [UIColor whiteColor];
        _itemsCountLabel.textAlignment = NSTextAlignmentCenter;
        _itemsCountLabel.textColor = [VKTColor vkTextColor];
        _itemsCountLabel.font = [VKTFont vkTextFontSize:14.f];
        [self addSubview:_itemsCountLabel];
        [_itemsCountLabel addAutoresizingFlexibleMask];
    }
    return self;
}

- (void)setTotalItemsCount:(NSUInteger )totalItemsCount {
  if (!totalItemsCount) {
    self.itemsCountLabel.text = [self pluralFormDorDialogsCount:totalItemsCount];
    return;
  }
  
  self.itemsCountLabel.text = [NSString stringWithFormat:@"%li %@", (long)totalItemsCount, [self pluralFormDorDialogsCount:totalItemsCount]];
}


- (NSString *)pluralFormDorDialogsCount:(NSInteger)count {
  if (!count) {
    return NSLocalizedString(@"No_Dialogs", nil);
  }
  NSInteger count10 = count % 10;
  if ((count10 == 1) && ((count == 1) || (count > 20))) {
    return NSLocalizedString(@"Dialog_1", nil);
  } else if ((count10 > 1) && (count10 < 5) && ((count > 20) || (count < 10))) {
    return NSLocalizedString(@"Dialog2_5", nil);
  } else {
    return NSLocalizedString(@"Dialog5_9", nil);
  }
}


@end
