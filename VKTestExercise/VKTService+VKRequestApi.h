//
//  VKTService+VKRequestApi.h
//  VKTestExercise
//
//  Created by Alex Kosyakov on 20.01.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import "VKTService.h"

static NSString *const kGetDialogsMethodName    = @"messages.getDialogs";
static NSString *const kDeleteDialogsMethodName = @"messages.deleteDialog";
static NSString *const kChatsGetMethodName      = @"messages.getChat";
static NSString *const kUsersGetInfoMethodName  = @"users.get";
static NSString *const kGroupsGetInfoMethodName = @"groups.getById";


@interface VKTService (VKRequestApi)
- (void)requestVKAPIMethod:(NSString *)methodName
                    params:(NSDictionary *)params
                completion:(void(^)(VKResponse *response, NSError *error))completion;
@end
