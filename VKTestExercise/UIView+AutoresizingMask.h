//
//  UIView+AutoresizingMask.h
//  Flowers
//
//  Created by Alexander Kosyakov on 05.01.17.
//  Copyright © 2017 Cube Innovations, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AutoresizingMask)
- (void)addRoundFlexibleMask;

- (void)addClipToLeftMask;

- (void)addClipToRightMask;
@end
