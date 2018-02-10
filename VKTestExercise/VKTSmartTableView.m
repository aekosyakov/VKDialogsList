//
//  VKTSmartFooterTableView.m
//  VKTestExercise
//
//  Created by Alex Kosyakov on 21.01.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import "VKTSmartTableView.h"
#import "VKTItemsCountView.h"
#import "VKTAnimatableView.h"

static CGFloat const kCustomRefreshControllHeight = 40.f;
static CGFloat const kFooterHeight = 70.f;

@interface VKTSmartTableView() <UIScrollViewDelegate>
@property (strong, nonatomic) VKTItemsCountView *itemsCountFooter;
@property (strong, nonatomic) VKTAnimatableView *uploadProgressFooter;
@property (strong, nonatomic) VKTAnimatableView *customRefreshControl;
@property (strong, nonatomic) UIRefreshControl *refreshControll;
@property (copy, nonatomic) void (^didStartRefreshCompletion)(void);
@end

@implementation VKTSmartTableView

- (void)atttachRefreshControlWithCompletion:(void(^)(void))completion {
    if (self.refreshControll != nil) {
        return;
    }
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventValueChanged];
    if (@available(iOS 10.0, *)) {
        self.refreshControl = refreshControl;
    } else {
        [self addSubview:refreshControl];
    }
    
    self.refreshControll = refreshControl;
    self.refreshControll.backgroundColor = [UIColor clearColor];
    self.refreshControll.tintColor = [UIColor clearColor];
    
    VKTAnimatableView *animatableView = [[VKTAnimatableView alloc] initWithFrame:self.refreshControll.bounds];
    animatableView.backgroundColor = [UIColor whiteColor];
    animatableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.refreshControll addSubview:animatableView];
    self.customRefreshControl = animatableView;
    [animatableView addConstraintsToFillView:self.refreshControll];
    
    _didStartRefreshCompletion = completion;
}

- (void)refreshData {
    if (![self numberOfRowsInSection:0]) {
        [self hideFooterWithAnimation:YES];
    }
    if (self.didStartRefreshCompletion) {
        self.didStartRefreshCompletion();
    }
    
    if (![VKTNetworkReachability isReachable]) {

      [self endRefreshing];
    }
}

- (void)endRefreshing {
    [self hideFooterWithAnimation:NO];
    [UIView animateWithDuration:0.03 animations:^{
        [self.refreshControll endRefreshing];
    }];
}

- (void)hideFooterWithAnimation:(BOOL)hide {
    if (self.tableFooterView.hidden != hide) {
        self.tableFooterView.hidden = hide;
        [self.tableFooterView addFadeTransition];
    }
}

- (void)setLoadedItemsCount:(NSUInteger )itemsCount {
    if (itemsCount > 0 || [self numberOfRowsInSection:0] == 0) {
        [self attachAllItemsCountFooterIfNeeded];
        [self.itemsCountFooter setTotalItemsCount:[self numberOfRowsInSection:0]];
    } else {
        [self attachProgressFooterIfNeeded];
    }
}

- (void)startUploadingProgress {
    [self attachProgressFooterIfNeeded];
}

- (void)attachProgressFooterIfNeeded {
    if (![self.tableFooterView isKindOfClass:[VKTAnimatableView class]]) {
        self.tableFooterView = nil;
        self.tableFooterView = [self uploadProgressFooter];
    }
}

- (void)attachAllItemsCountFooterIfNeeded {
    if (![self.tableFooterView isKindOfClass:[VKTItemsCountView class]]) {
        self.tableFooterView = nil;
        self.tableFooterView = [self itemsCountFooter];
    }
}

- (VKTItemsCountView *)itemsCountFooter {
    if (!_itemsCountFooter) {
        _itemsCountFooter = [[VKTItemsCountView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, kFooterHeight)];
    }
    return _itemsCountFooter;
}

- (VKTAnimatableView *)uploadProgressFooter {
    if (!_uploadProgressFooter) {
        _uploadProgressFooter = [[VKTAnimatableView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, kCustomRefreshControllHeight)];
    }
    return _uploadProgressFooter;
}


@end
