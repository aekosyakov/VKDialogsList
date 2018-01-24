//
//  VKTImageCache+Model.h
//  VKTestExercise
//
//  Created by Alex Kosyakov on 13.01.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import "VKTImageCache.h"
#import "VKTMessageViewProtocol.h"
@interface VKTImageCache (Model)
+ (NSArray <UIImage *> *)cachedImagesArrayForModel:(id <VKTAvatarViewModelProtocol > )model;

+ (BOOL)hasDifferentURLsForModel:(id <VKTAvatarViewModelProtocol > )model;
@end
