//
//  VKTAvatarView.m
//  VKTestExercise
//
//  Created by Alex Kosyakov on 06.01.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import "VKTAvatarView.h"
#import "VKTImageCache+Model.h"
@interface VKTAvatarView()
@property (strong, nonatomic) id <VKTAvatarViewModelProtocol > viewModel;
@property (strong, nonatomic) NSArray <UIImage *> *avatarImages;
@property (weak, nonatomic) IBOutlet UIView *imageViewContainer;
@property (weak, nonatomic) IBOutlet UIView *placeholderViewContainer;
@property (weak, nonatomic) IBOutlet UIImageView *mainPlaceholderImageView;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imageViews;
@end

@implementation VKTAvatarView

@synthesize type;

- (VKTAvatarType )avatarViewType  {
    return (VKTAvatarType )self.viewModel.urls.count;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self layoutIfNeeded];
    self.mainPlaceholderImageView.image = nil;
    self.placeholderViewContainer.hidden = NO;
    self.mainPlaceholderImageView.image = [UIImage imageNamed:@"unloadAvatar"];
    [self cleaAllPhotos];
}

- (void)reloadWithModel:(id <VKTAvatarViewModelProtocol > )model {
    _viewModel = model;
  
    [self cleaAllPhotos];
    NSArray *imagesArray = [VKTImageCache cachedImagesArrayForModel:model];
    if (!imagesArray.count) {
        [self updateUI];
    } else {
        [self showAllPhotosFromArray:imagesArray];
    }
}

- (void)updateUI {
    if (self.viewModel.userDeleted) {
        [self showDeletedProfile];
        return;
    }
    
    if (!self.viewModel.urls.count) {
        [self showUnloadPhotoPlaceholder];
        return;
    }
    
    
    NSMutableArray *images = [NSMutableArray array];
    dispatch_group_t group = dispatch_group_create();
    
    for (NSURL *url in self.viewModel.urls) {
        dispatch_group_enter(group);
        [VKTImageCache imageFromURL:url completion:^(UIImage *image) {
            if (image) {
                [images addObject:image];
            }
            dispatch_group_leave(group);
        }];
    }
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        self.avatarImages = [NSArray arrayWithArray:images];
        if (!images.count) {
            [self showUnloadPhotoPlaceholder];
        } else {
            [self reloadWithModel:self.viewModel];
        }
        
    });

}

- (void)showDeletedProfile {
    self.mainPlaceholderImageView.image = [UIImage imageNamed:@"deleted"];
    self.placeholderViewContainer.hidden = NO;
}

- (void)showUnloadPhotoPlaceholder {
    self.mainPlaceholderImageView.image = [UIImage imageNamed:@"unloaded"];
    self.placeholderViewContainer.hidden = NO;
}

- (void)showFromCache {
    if (!self.avatarImages.count) {
    dispatch_async(dispatch_queue_create("com.vkttestexercise.asynchCacheloader", NULL), ^(void) {
        NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:self.viewModel.urls.count];
        for (int i = 0; i < self.viewModel.urls.count; i ++) {
            NSURL *url = self.viewModel.urls[i];
            NSObject *object = [VKTImageCache cachedImageDataForURL:url];
            if (object && [object isKindOfClass:[NSData class]]) {
                UIImage *image = [UIImage imageWithData:(NSData *)object];
                [tempArray addObject:image];
            }
        }
        self.avatarImages = [NSArray arrayWithArray:tempArray];
        [self showAllPhotosFromArray:self.avatarImages];
        });
    } else {
        [self showAllPhotosFromArray:self.avatarImages];
    }
    
    self.placeholderViewContainer.hidden = YES;
}

- (void)showAllPhotosFromArray:(NSArray <UIImage *> *)array {
    
    for (int i = 0; i < array.count; i ++) {
        UIImage *image = array[i];
        for (UIImageView *imageView in self.imageViews) {
            if (imageView.tag == i) {
                dispatch_async(dispatch_get_main_queue(), ^{
                     imageView.image = image;
                });
            }
        }
    }

    self.placeholderViewContainer.hidden = YES;
}

- (void)cleaAllPhotos {
    dispatch_async(dispatch_get_main_queue(), ^{
        for (UIImageView *imageView in self.imageViews) {
            imageView.image = nil;
        }
    });
}

@end

