//
//  UITableView+HandlingRows.h
//  Flowers
//
//  Created by Alex Kosyakov on 1/11/17.
//  Copyright © 2017 Cube Innovations, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (HandlingRows)
- (void)insertIndexPaths:(nonnull NSArray <NSIndexPath *> *)indexPaths;
- (void)insertIndexPaths:(nonnull NSArray <NSIndexPath *> *)indexPaths rowAnimation:(UITableViewRowAnimation )animation;

- (void)deleteIndexPaths:(nonnull NSArray <NSIndexPath *> *)indexPaths;
- (void)deleteIndexPaths:(nonnull NSArray <NSIndexPath *> *)indexPaths rowAnimation:(UITableViewRowAnimation )animation;
@end
