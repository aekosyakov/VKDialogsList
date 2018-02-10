//
//  VKTAuthController.m
//  VKTestExercise
//
//  Created by Alex Kosyakov on 23.12.2017.
//  Copyright © 2017 Alex Kosyakov. All rights reserved.
//

#import "VKTAuthController.h"
#import "UIView+CoreAnimation.h"
#import "VKTService+Extensions.h"

@interface VKTAuthController ()
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@end

@implementation VKTAuthController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setupView];
  [self setupAuthCallback];
  [self startWorking];
}
    
- (void)startWorking {
  NSString *token = [VKTUserToken token];
  if (token.length > 0) {
    [self authorizeUser];
   }

  [VKTNetworkReachability startObserving:^(BOOL reachable) {
    [self finishSuccess:NO];
   }];
}

- (void)setupAuthCallback {
  __weak typeof(self) self_ = self;
  self.authService.resultCompletion = ^(id <VKTAuthResult> result) {
      [self_ authServiceDidFinishWithResult:result];
  };
}
    
- (void)authServiceDidFinishWithResult:(id <VKTAuthResult> )result {
    switch (result.status) {
        case VKTAuthStatusSuccess: {
            [self finishSuccess:YES];
        } break;
        case VKTAuthStatusError:
        case VKTAuthStatusUnknown: {
            [self finishSuccess:NO];
            //show error
        } break;
    }
}
    
- (void)finishSuccess:(BOOL)success {
    [self hideProgressHUD];
    if (self.didFinishCompletion) {
        self.didFinishCompletion(success);
    }
}


- (void)setupView {
  self.view.backgroundColor = [VKTColor vkMainColor];
  self.logoImageView.image  = [VKTImage vkLogoImage];

  [self.loginButton setTitle:NSLocalizedString(@"Login", nil) forState:UIControlStateNormal];
  [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  [self.loginButton setBackgroundColor:[VKTColor vkMainColor]];
  [self.loginButton makeRoundCorner:10.f];
  [self.loginButton addBorderColor:[UIColor whiteColor] borderWidth:1.f];
  [self.loginButton addTarget:self action:@selector(loginButtonDidPress:) forControlEvents:UIControlEventTouchUpInside];
  
  self.loginButton.hidden = NO;
  [self.loginButton addFadeTransition:0.3];
}

- (void)authorizeUser {
  [self showProgressHUD];
  [self.authService authorizeUserIfNeeded];
}


- (void)loginButtonDidPress:(UIButton *)button {
  [self authorizeUser];
}
    
@end
