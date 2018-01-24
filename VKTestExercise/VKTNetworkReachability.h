//
//  VKTNetworkReachability.h
//  VKTestExercise
//
//  Created by Alex Kosyakov on 03.01.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VKTNetworkReachability : NSObject
+ (void)startObserving:(void(^)(BOOL reachable))completion;
+ (BOOL)isReachable;
@end
