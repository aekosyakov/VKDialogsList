//
//  VKTMainController.m
//  VKTestExercise
//
//  Created by Alex Kosyakov on 23.12.2017.
//  Copyright © 2017 Alex Kosyakov. All rights reserved.
//

#import "VKTMainController.h"
#import "UIStoryboard+ViewControllers.h"
#import "VKTPeerIDs.h"

@interface VKTOfflineModeConditions: NSObject
+ (BOOL)confirmed;
@end
@implementation VKTOfflineModeConditions
+ (BOOL)confirmed {
    BOOL networkIsRechable = [VKTNetworkReachability isReachable];
    BOOL userWasAuthorized = @([VKTUserToken token].length).boolValue;
    BOOL hasPreloadedData  = @([VKTPeerIDs getActualIDs].count).boolValue;
    return !networkIsRechable && userWasAuthorized && hasPreloadedData;
}
@end

@interface VKTMainController ()
@property (copy, nonatomic) void ((^didFinishCompletion)(BOOL success));
@end

@interface VKTMainController(Routing)
- (void)openDialogList;
- (void)checkAuthorizationWithCompletion:(void(^)(BOOL success))completion;
@end

@implementation VKTMainController(Routing)
- (void)openDialogList {
    UIViewController *dialogListController = [UIStoryboard dialogListContoller];
    VKTNavigationController *navController = [[VKTNavigationController alloc] initWithRootViewController:dialogListController];
    
    [self changeContainerTo:navController];
    [self addFadeEffect];
}


- (void)checkAuthorizationWithCompletion:(void(^)(BOOL success))completion {
    UIViewController *authController = [UIStoryboard authControllerWithCompletion:completion];
    [self changeContainerTo:authController];
}
@end


#import "VKTAuthServiceProvider.h"

@implementation VKTMainController

- (void)dealloc {
  [self removeObservers];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setupObservers];
  [self startWorking];
}

- (void)startWorking {
    __weak typeof (self) self_ = self;
    self.didFinishCompletion = ^(BOOL success) {
        if (success || [VKTOfflineModeConditions confirmed]) {
            [self_ openDialogList];
        }
    };
    
    [self checkAuthorizationWithCompletion:self.didFinishCompletion];
}

#pragma mark NSNotifications
- (void)setupObservers {
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(startWorking) name:kVKTAuthServiceDidLogoutNotificationName
                                             object:nil];
}
- (void)removeObservers {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
