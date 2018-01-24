//
//  BaseViewController.m
//  VKTestExercise
//
//  Created by Alex Kosyakov on 20.12.2017.
//  Copyright © 2017 Alex Kosyakov. All rights reserved.
//

#import "VKTBaseViewController.h"
@interface VKTBaseViewController ()
@end
@implementation VKTBaseViewController
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (BOOL )networkIsRechable {
  return [VKTNetworkReachability isReachable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
