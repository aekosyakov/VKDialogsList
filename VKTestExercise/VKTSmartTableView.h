//
//  VKTSmartFooterTableView.h
//  VKTestExercise
//
//  Created by Alex Kosyakov on 21.01.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VKTSmartTableView : UITableView
@property (assign, nonatomic) NSUInteger loadedItemsCount;
- (void)startUploadingProgress;
- (void)hideFooterWithAnimation:(BOOL)hide;
- (void)atttachRefreshControlWithCompletion:(void(^)(void))completion;
- (void)endRefreshing;
@end
