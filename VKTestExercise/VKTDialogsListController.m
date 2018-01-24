//
//  VKTChatsListViewController.m
//  VKTestExercise
//
//  Created by Alex Kosyakov on 04.01.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import "VKTDialogsListController.h"
#import "VKTMessagesListDataSource.h"
#import "VKTMessagesListFetcher.h"
#import "VKTService+Extensions.h"
#import "VKTSmartTableView.h"

@import CoreData;
@interface VKTDialogsListController ()
@property (weak, nonatomic) IBOutlet VKTSmartTableView *tableView;
@property (strong, nonatomic) VKTMessagesListDataSource *fetchDataSource;
@property (strong, nonatomic) UIBarButtonItem *settingsBarButton;
@end

@implementation VKTDialogsListController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self setupDataSource];
}

- (void)setupView {
  self.title = NSLocalizedString(@"DialogListTitle", nil);
  self.settingsBarButton = [self customBarButtomItemWithImage:[VKTImage vkSettingsIcon]
                                             highlightedImage:nil target:self
                                                       action:@selector(settingsButtonDidPress:)];
  [self addRightBarButtonItem:self.settingsBarButton];
}

- (void)settingsButtonDidPress:(UIButton *)button {
  [self showSettingsSheet];
  [self.settingsBarButton.customView addRoundAnimationRotationsCount:1/4];
}

- (void)setupDataSource {
  self.fetchDataSource = [[VKTMessagesListDataSource alloc] init];
  self.fetchDataSource.fetcher = [[VKTMessagesListFetcher alloc] initWithMessageService:self.messagesService];
  self.fetchDataSource.tableView = self.tableView;
  self.fetchDataSource.context = self;
    
  [self.fetchDataSource refreshData];
}

- (void)showSettingsSheet {
  [self showActionSheetControllerWithTitle:NSLocalizedString(@"Settings", nil)
                              actionTitles:@[NSLocalizedString(@"Reset Data", nil),
                                             NSLocalizedString(@"Sign Out", nil)]
                                completion:^(NSUInteger pressedIndex) {
                                  [self handleActionSheetPressedIndex:pressedIndex];
  }];
}

- (void)handleActionSheetPressedIndex:(NSUInteger )pressedIndex {
  switch (pressedIndex) {
    case 0: {
      [self.fetchDataSource resetData];
    } break;
    case 1: {
      [self.fetchDataSource resetData];
      [[VKTService authService] logOut];
    } break;
      
    default:
      break;
  }
}


@end
