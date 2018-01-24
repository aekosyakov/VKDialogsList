//
//  NSIndexPath+Extensions.h
//  Flowers
//
//  Created by Alex Kosyakov on 1/11/17.
//  Copyright © 2017 Cube Innovations, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSIndexPath (Extensions)
+ (NSArray *)indexPathsForCount:(NSUInteger )count;
+ (NSArray *)indexPathsForCount:(NSUInteger )count fromIndex:(NSUInteger )index;
@end
