//
//  VKTMessagesListDataSource.h
//  VKTestExercise
//
//  Created by Alex Kosyakov on 1/15/18.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VKTFetcherProtocol.h"
@class VKTSmartTableView;
@interface VKTMessagesListDataSource : NSObject
@property (strong, nonatomic) id <VKTFetcherProtocol > fetcher;
@property (strong, nonatomic) VKTSmartTableView *tableView;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (strong, nonatomic) UIViewController *context;
- (void)refreshData;
- (void)resetData;
@end
