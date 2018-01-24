//
//  VKTChatsListViewController.h
//  VKTestExercise
//
//  Created by Alex Kosyakov on 04.01.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import "VKTBaseViewController.h"
#import "VKTMessagesServiceProvider.h"

@interface VKTDialogsListController : VKTBaseViewController
@property (strong, nonatomic) id <VKTMessagesServiceProvider > messagesService;
@end
