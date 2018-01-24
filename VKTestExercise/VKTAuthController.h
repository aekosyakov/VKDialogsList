//
//  VKTAuthController.h
//  VKTestExercise
//
//  Created by Alex Kosyakov on 23.12.2017.
//  Copyright © 2017 Alex Kosyakov. All rights reserved.
//

#import "ContainerController.h"
#import "VKTAuthServiceProvider.h"

@interface VKTAuthController : VKTBaseViewController
@property (strong, nonatomic) id <VKTAuthServiceProvider > authService;
@property (copy, nonatomic) void ((^didFinishCompletion)(BOOL success));
@end


