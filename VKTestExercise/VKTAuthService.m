//
//  VKAuthService.m
//  VKTestExercise
//
//  Created by Alex Kosyakov on 23.12.2017.
//  Copyright © 2017 Alex Kosyakov. All rights reserved.
//

#import "VKTAuthService.h"
#import "VKSDKHeader.h"
#import "VKTUserToken.h"
#import "AppDelegate.h"

NSString *const kVKTAuthServiceDidLoginNotificationName  = @"VKTAuthServiceDidLoginNotification";
NSString *const kVKTAuthServiceDidLogoutNotificationName = @"VKTAuthServiceDidLogoutNotification";

@interface VKTAuthService() <VKSdkDelegate, VKSdkUIDelegate>
@end

@implementation VKTAuthService
@synthesize parser;

- (NSArray *)permissionsScope {
    return @[VK_PER_MESSAGES];
}

- (instancetype)init {
    if (self = [super init]) {
      [self initVKSDK];
    }
    return self;
}

- (void)authorizeUserIfNeeded {
    [self wakeUpSession];
}

- (void)initVKSDK {
  [VKSdk initializeWithAppId:kVKAPP_ID];
  [[VKSdk instance] registerDelegate:self];
  [[VKSdk instance] setUiDelegate:self];
}

- (void)logOut {
  [VKSdk forceLogout];
  [VKTUserToken resetToken];
  [[NSNotificationCenter defaultCenter] postNotificationName:kVKTAuthServiceDidLogoutNotificationName object:nil];
}

- (void)wakeUpSession {
    [VKSdk wakeUpSession:[self permissionsScope] completeBlock:^(VKAuthorizationState state, NSError *error) {
        VKMutableAuthorizationResult *result = [[VKMutableAuthorizationResult alloc] init];
        result.state = state;
        result.error = error;
        
        [self handleAuthorizationResult:result];
    }];
}

- (void)authorize {
    [VKSdk authorize:[self permissionsScope]];
}

- (void)handleAuthorizationResult:(VKAuthorizationResult *)result {
    BOOL authorized = NO;
    switch (result.state) {
        case VKAuthorizationAuthorized: {
            authorized = YES;
        } break;
        case VKAuthorizationInitialized: {
            [self authorize];
            return;
        }
        case VKAuthorizationPending:
        case VKAuthorizationWebview:
        case VKAuthorizationSafariInApp: {
            return;
        } break;
        case VKAuthorizationError:
        case VKAuthorizationUnknown: {
        } break;
            
        default:
            break;
    }
    
    if (result.token) {
        [VKTUserToken updateToken:result.token.accessToken];
    }
  
    if (result.token.userId) {
      [VKTUserToken setUserID:@(result.token.userId.integerValue)];
    }
    if (authorized) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kVKTAuthServiceDidLoginNotificationName object:nil];
    }
    
    id <VKTAuthResult > authResult = [self.parser resultWithResponse:result];
    [self callDelegateWithResult:authResult];
}

#pragma mark VKSDKDelegate
- (void)vkSdkAccessAuthorizationFinishedWithResult:(VKAuthorizationResult *)result {
    [self handleAuthorizationResult:result];
}

- (void)vkSdkUserAuthorizationFailed {
    VKMutableAuthorizationResult *result = [[VKMutableAuthorizationResult alloc] init];
    result.state = VKAuthorizationError;
    result.error = [NSError errorWithDomain:@"" code:0 userInfo:@{}];
    
    [self handleAuthorizationResult:result];
}

- (void)vkSdkAuthorizationStateUpdatedWithResult:(VKAuthorizationResult *)result {
    [self handleAuthorizationResult:result];
}

- (void)vkSdkAccessTokenUpdated:(VKAccessToken *)newToken oldToken:(VKAccessToken *)oldToken {
  [VKTUserToken updateToken:newToken.accessToken];
  if (newToken.userId) {
    [VKTUserToken setUserID:@(newToken.userId.integerValue)];
  }
  
}

#pragma mark VKSdkUIDelegate
- (void)vkSdkShouldPresentViewController:(UIViewController *)controller {
  [[AppDelegate topController] presentViewController:controller animated:YES completion:nil];
}

- (void)vkSdkNeedCaptchaEnter:(VKError *)captchaError {
  VKCaptchaViewController *vc = [VKCaptchaViewController captchaControllerWithError:captchaError];
  [vc presentIn:[AppDelegate topController]];
}

- (void)vkSdkTokenHasExpired:(VKAccessToken *)expiredToken {
    [VKTUserToken resetToken];
    [self authorize];
}

@end
