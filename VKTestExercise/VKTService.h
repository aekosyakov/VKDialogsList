//
//  VKService.h
//  VKTestExercise
//
//  Created by Alex Kosyakov on 23.12.2017.
//  Copyright © 2017 Alex Kosyakov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VKTServiceProvider.h"
extern NSString *const kVKAPP_ID;
@class VKRequest;
@interface VKTService : NSObject <VKTServiceProvider>
@property (strong, nonatomic) VKRequest *request;
- (void)callDelegateWithResult:(id <VKTServiceResult > )result;
@end
