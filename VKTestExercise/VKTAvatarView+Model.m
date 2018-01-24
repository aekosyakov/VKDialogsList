//
//  VKTAvatarView+Model.m
//  VKTestExercise
//
//  Created by Alex Kosyakov on 13.01.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import "VKTAvatarView+Model.h"
@implementation VKTAvatarView (Model)
+ (instancetype)loadWithModel:(id <VKTAvatarViewModelProtocol > )model {
    VKTAvatarType type  = (VKTAvatarType )model.urls.count;
    VKTAvatarView *view = [VKTAvatarView loadNibNamed:VKTAvatarNibNameByType(type)];
    view.type = type;
    [view reloadWithModel:model];
    return view;
}

@end
