//
//  VKTMessagesListDataSource.m
//  VKTestExercise
//
//  Created by Alex Kosyakov on 1/15/18.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import "VKTMessagesListDataSource.h"
#import "VKTSerialOperationQueue.h"
#import "UITableView+HandlingRows.h"
#import "VKTMessageFetchResult.h"
#import "VKTSmartTableView.h"
#import "NSIndexPath+Extensions.h"
#import "VKTMessageCell.h"
#import "VKTMessage+Extensions.h"
#import "UITableView+MessageCell.m"

@interface VKTMessagesListDataSource() <UITableViewDataSource, UITableViewDelegate, VKTFetchDelegate>
@property (assign, nonatomic) BOOL connectionHadBreaks;
@end

@implementation VKTMessagesListDataSource

- (instancetype)init {
  if (self = [super init]) {
    self.connectionHadBreaks = ![VKTNetworkReachability isReachable];
    [VKTNetworkReachability startObserving:^(BOOL reachable) {
      if (reachable && self.connectionHadBreaks) {
        [self refreshData];
        self.connectionHadBreaks = NO;
      } else {
        self.connectionHadBreaks = YES;
        self.tableView.loadedItemsCount = self.fetcher.items.count;;
      }
      [self.tableView endRefreshing];
    }];
  }
  return self;
}


- (void)setTableView:(VKTSmartTableView *)tableView {
    _tableView = tableView;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.estimatedRowHeight = 80.f;
    _tableView.loadedItemsCount = self.fetcher.items.count;
  
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerNib:[VKTMessageCell nibName] forCellReuseIdentifier:[VKTMessageCell reuseIdentifier]];
    __weak typeof(self) self_ = self;
    [_tableView atttachRefreshControlWithCompletion:^{
        [self_ refreshData];
    }];
}

- (void)setFetcher:(id<VKTFetcherProtocol>)fetcher {
    _fetcher = fetcher;
    _fetcher.delegate = self;
    _fetcher.delegate = self;
}

- (void)refreshData {
    if (!self.fetcher.items.count && [self.fetcher checkForPreloadedData] && ![VKTNetworkReachability isReachable]) {
        NSArray *indexPathsToInsert = [NSIndexPath indexPathsForCount:self.fetcher.items.count];
        if (!indexPathsToInsert.count) {
            [self.tableView reloadData];
        } else {
            [self.refreshControl beginRefreshing];
            [self.tableView insertIndexPaths:indexPathsToInsert rowAnimation:UITableViewRowAnimationAutomatic];
        }
        return;
    }
    [self.fetcher refreshData];
}

- (void)loadNextIfNeeded {
    if ([self.fetcher canLoadNext]) {
        [self.tableView startUploadingProgress];
        [self.fetcher loadNextPage];
    } else {
      [self.tableView setLoadedItemsCount:self.fetcher.items.count];
    }
}

- (void)resetData {
    NSArray *indexPathToDelete = [NSIndexPath indexPathsForCount:self.fetcher.items.count];
    [self.fetcher resetData];
    
    if (!indexPathToDelete.count) {
        [self.tableView reloadData];
    } else {
        [self.tableView deleteIndexPaths:indexPathToDelete];
    }
  
    [self.tableView setLoadedItemsCount:self.fetcher.items.count];
    
    [self.tableView hideFooterWithAnimation:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView hideFooterWithAnimation:NO];
    });
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.fetcher.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.row == self.fetcher.items.count - 1) {
    [self loadNextIfNeeded];
  }
  UITableViewCell <VKTMessageObjectProvider > *cell = [self.tableView messageCell];
  [self configureCell:cell forIndexPath:indexPath];
  return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
  [self configureCell:(UITableViewCell <VKTMessageObjectProvider > *) cell forIndexPath:indexPath];
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 80.f;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath { return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    [self showDeleteDialogSheetWithCompletion:^(BOOL delete) {
      if (delete) {
        [self.context showProgressHUD];
        [self.fetcher deleteItemAtIndex:indexPath.row];
      }
    }];

  }
}

- (void) configureCell:(UITableViewCell <VKTMessageObjectProvider > *) cell forIndexPath:(NSIndexPath *) indexPath {
  VKTMessage *message = self.fetcher.items[indexPath.row];
  if (message) {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
      dispatch_async(dispatch_get_main_queue(), ^{
        [(UITableViewCell <VKTMessageObjectProvider > *)cell reloadWithMessage:message];
      });
    });
  }
}


#pragma mark VKTFetchDelegate
- (void)fetcherDidFinishWithResult:(id <VKTFetchResultProtocol >)result {
    [self.context hideProgressHUDWithDelay:0.3];
    dispatch_async(dispatch_get_main_queue(), ^{
        if (!result) {
            [self.tableView endRefreshing];
            return;
        }
        if (result.indexPathsToInsert.count > 0) {
            if (result.fetchType == VKTFetchTypeLoadNext) {
                [UIView setAnimationsEnabled:NO];
                [self.tableView insertIndexPaths:result.indexPathsToInsert];
                [UIView setAnimationsEnabled:YES];
            } else {
                [self.tableView insertIndexPaths:result.indexPathsToInsert];
            }
        } else if (result.indexPathsToDelete.count > 0) {
            [self.tableView deleteIndexPaths:result.indexPathsToDelete rowAnimation:UITableViewRowAnimationFade];
            self.tableView.loadedItemsCount = self.fetcher.items.count;
        }
        else {
            [self.tableView setLoadedItemsCount:self.fetcher.items.count];
            [self.tableView reloadData];
        }
        [self.tableView endRefreshing];
    });
}



- (void)showDeleteDialogSheetWithCompletion:(void(^)(BOOL delete))completion {
  [self.context showActionSheetControllerWithTitle:NSLocalizedString(@"Wants_to_reset_history?", nil)
                              actionTitles:@[NSLocalizedString(@"Reset History", nil)]
                                completion:^(NSUInteger pressedIndex) {
                                  if (completion) {
                                    completion(YES);
                                  }
                                }];
  
}

@end
