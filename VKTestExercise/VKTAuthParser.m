//
//  VKTAuthParser.m
//  VKTestExercise
//
//  Created by Alex Kosyakov on 1/11/18.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import "VKTAuthParser.h"
#import "VKSDKHeader.h"
#import "VKTAuthServiceResult.h"

@implementation VKTAuthParser

- (id <VKTAuthResult > )resultWithResponse:(VKAuthorizationResult *)response {
  VKTAuthStatus authStatus = VKTAuthStatusUnknown;
  switch (response.state) {
    case VKAuthorizationAuthorized: {
      authStatus = VKTAuthStatusSuccess;
    } break;
    case VKAuthorizationUnknown:
    case VKAuthorizationError: {
      authStatus = VKTAuthStatusError;
    } break;
    default: break;
  }
  
  id <VKTAuthResult > serviceResult = [[VKTAuthServiceResult alloc] init];
  
  serviceResult.status = authStatus;
  serviceResult.error = response.error;
  serviceResult.serviceType = VKServiceTypeAuth;
  return serviceResult;
}

- (NSObject<VKTServiceResult> *)resultWithError:(NSError *)error {
    return nil;
}

@end
