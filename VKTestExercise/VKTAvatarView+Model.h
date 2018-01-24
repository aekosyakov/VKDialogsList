//
//  VKTAvatarView+Model.h
//  VKTestExercise
//
//  Created by Alex Kosyakov on 13.01.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import "VKTAvatarView.h"
#import "VKTMessageViewProtocol.h"
@interface VKTAvatarView (Model)
+ (instancetype)loadWithModel:(id <VKTAvatarViewModelProtocol > )model;
@end
