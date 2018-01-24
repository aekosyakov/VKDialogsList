//
//  VKTDateTransformer.h
//  VKTestExercise
//
//  Created by Alex Kosyakov on 1/12/18.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import "VKTView.h"
@interface VKTDateTransformer : VKTView
+ (NSString *)getTimeStringFromTimestamp:(NSNumber *)time;
@end
