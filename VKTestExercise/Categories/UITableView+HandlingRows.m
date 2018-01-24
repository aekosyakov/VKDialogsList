//
//  UITableView+HandlingRows.m
//  Flowers
//
//  Created by Alex Kosyakov on 1/11/17.
//  Copyright © 2017 Cube Innovations, Inc. All rights reserved.
//

#import "UITableView+HandlingRows.h"

@implementation UITableView (HandlingRows)

- (void)insertIndexPaths:(NSArray <NSIndexPath *> *)indexPaths {
  [self insertIndexPaths:indexPaths rowAnimation:UITableViewRowAnimationNone];
}

- (void)insertIndexPaths:(NSArray <NSIndexPath *> *)indexPaths rowAnimation:(UITableViewRowAnimation )animation {
  if (!indexPaths.count) {
    return;
  }
  [self beginUpdates];
  [self insertRowsAtIndexPaths:indexPaths withRowAnimation:animation];
  [self endUpdates];
}


- (void)deleteIndexPaths:(NSArray <NSIndexPath *> *)indexPaths {
  [self deleteIndexPaths:indexPaths rowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)deleteIndexPaths:(NSArray <NSIndexPath *> *)indexPaths rowAnimation:(UITableViewRowAnimation )animation {
  if (!indexPaths.count) {
    return;
  }
  [self beginUpdates];
  [self deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];
  [self endUpdates];
}





@end
