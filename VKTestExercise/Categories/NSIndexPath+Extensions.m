//
//  NSIndexPath+Extensions.m
//  Flowers
//
//  Created by Alex Kosyakov on 1/11/17.
//  Copyright © 2017 Cube Innovations, Inc. All rights reserved.
//

#import "NSIndexPath+Extensions.h"

@implementation NSIndexPath (Extensions)

+ (NSArray *)indexPathsForCount:(NSUInteger )count {
  NSMutableArray *newIndexPaths = [NSMutableArray arrayWithCapacity:count];
  for (int k = 0; k < count; k++) {
    [newIndexPaths addObject:[NSIndexPath indexPathForRow:k inSection:0]];
  }
  return [NSArray arrayWithArray:newIndexPaths];
}

+ (NSArray *)indexPathsForCount:(NSUInteger )count fromIndex:(NSUInteger )index {
  NSMutableArray *newIndexPaths = [NSMutableArray arrayWithCapacity:count];
  for (NSUInteger k = index; k < (index + count); k++) {
    [newIndexPaths addObject:[NSIndexPath indexPathForRow:k inSection:0]];
  }
  return [NSArray arrayWithArray:newIndexPaths];
}

@end
