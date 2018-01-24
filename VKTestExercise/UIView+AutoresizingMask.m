//
//  UIView+AutoresizingMask.m
//  Flowers
//
//  Created by Alexander Kosyakov on 05.01.17.
//  Copyright © 2017 Cube Innovations, Inc. All rights reserved.
//

#import "UIView+AutoresizingMask.h"

@implementation UIView (AutoresizingMask)

- (void)addFlexibleWidthMask {
  self.translatesAutoresizingMaskIntoConstraints = YES;
  
  [self setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
  [self setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
  [self setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin];
  [self setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin];
  [self setAutoresizingMask:UIViewAutoresizingFlexibleRightMargin];
}

- (void)addFlexibleHeightMask {
  self.translatesAutoresizingMaskIntoConstraints = YES;
  
  [self setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
  [self setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin];
  [self setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin];
  [self setAutoresizingMask:UIViewAutoresizingFlexibleRightMargin];
  [self setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin];
}

- (void)addRoundFlexibleMask {
  self.translatesAutoresizingMaskIntoConstraints = YES;
  
  [self setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
  [self setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
  
  [self setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin];
  [self setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin];
  [self setAutoresizingMask:UIViewAutoresizingFlexibleRightMargin];
  [self setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin];
}

- (void)addClipToLeftMask {
  self.translatesAutoresizingMaskIntoConstraints = YES;
  
  [self setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
  [self setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin];
  [self setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin];
  [self setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin];
}

- (void)addClipToRightMask {
  self.translatesAutoresizingMaskIntoConstraints = YES;
  
  [self setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
  [self setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin];
  [self setAutoresizingMask:UIViewAutoresizingFlexibleRightMargin];
  [self setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin];
}


@end
