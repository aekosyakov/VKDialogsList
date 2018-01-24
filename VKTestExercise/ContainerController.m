//
//  ContainerController.m
//  VKTestExercise
//
//  Created by Alex Kosyakov on 23.12.2017.
//  Copyright © 2017 Alex Kosyakov. All rights reserved.
//

#import "ContainerController.h"
#import "AppDelegate.h"

@interface ContainerController ()
@property (strong, nonatomic, readwrite) UIView *containerView;
@end

@implementation ContainerController

- (void)viewDidLoad {
  [super viewDidLoad];
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  self.containerView.frame = self.view.bounds;
}

- (void)addToContainer:(UIView *)viewToAdd {
  for (UIView *subview in self.containerView.subviews) {
    [subview removeFromSuperview];
  }
  
  viewToAdd.frame = self.containerView.bounds;
  [self.containerView addSubview:viewToAdd];
  [viewToAdd addAutoresizingFlexibleMask];
}

- (void)changeContainerTo:(UIViewController *)vc {
  [self resetContainer];
  [self addChildViewController:vc];
  vc.view.frame = self.containerView.bounds;
  [self.containerView addSubview:vc.view];
  [vc didMoveToParentViewController:self];
}

- (void)addFadeEffect {
  [self.containerView addFadeTransition];
}

- (void)resetContainer {
  if (self.childViewControllers.count > 0) {
      UIViewController *vc = [self.childViewControllers lastObject];
      [vc willMoveToParentViewController:nil];
      [vc.view removeFromSuperview];
      [vc removeFromParentViewController];
  }
  
  for (UIView *view in self.containerView.subviews) {
      [view removeFromSuperview];
  }
}

- (UIView *)containerView {
  if (!_containerView) {
      [self.view layoutIfNeeded];
      _containerView = [[UIView alloc] initWithFrame:self.view.bounds];
      [self.view addSubview:_containerView];
      [_containerView addAutoresizingFlexibleMask];
  }
  _containerView.frame = self.view.bounds;
  return _containerView;
}

@end
