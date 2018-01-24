//
//  VKTImageCache+Model.m
//  VKTestExercise
//
//  Created by Alex Kosyakov on 13.01.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import "VKTImageCache+Model.h"

static NSMutableDictionary *__imagesByMessageIDSDictionary;
static NSMutableDictionary *__urlsByMessageIDSDictionary;

@implementation VKTImageCache (Model)

+ (BOOL)hasDifferentURLsForModel:(id <VKTAvatarViewModelProtocol > )model {
    NSArray *cachedURLs = __urlsByMessageIDSDictionary[model.messageID];
    for (NSURL *url in model.urls) {
        if (![cachedURLs containsObject:url]) {
            return YES;
        }
    }
    return NO;
}

+ (NSArray <UIImage *> *)cachedImagesArrayForModel:(id <VKTAvatarViewModelProtocol > )model {
    
    NSArray *imagesArray = __imagesByMessageIDSDictionary[model.messageID.stringValue];
    if (!__imagesByMessageIDSDictionary) {
        __imagesByMessageIDSDictionary = [NSMutableDictionary dictionary];
    }
    
    if (!__urlsByMessageIDSDictionary) {
        __urlsByMessageIDSDictionary = [NSMutableDictionary dictionary];
    }
    if (!imagesArray.count) {
        NSMutableArray *tempImagesArray = [NSMutableArray arrayWithCapacity:model.urls.count];
        NSMutableArray *tempURLsArray = [NSMutableArray arrayWithCapacity:model.urls.count];
        
        
            for (int i = 0; i < model.urls.count; i ++) {
                NSURL *url = model.urls[i];
                NSObject *object = [VKTImageCache cachedImageDataForURL:url];
                if (object && [object isKindOfClass:[NSData class]]) {
                    UIImage *image = [UIImage imageWithData:(NSData *)object];
                    [tempImagesArray addObject:image];
                    [tempURLsArray addObject:url];
                }
                
                
            }
        imagesArray = [NSArray arrayWithArray:tempImagesArray];
        NSArray *urlsArray   = [NSArray arrayWithArray:tempURLsArray];
        if (imagesArray.count > 0) {
          __imagesByMessageIDSDictionary[model.messageID] = imagesArray;
        }
        
        if (urlsArray.count > 0) {
        __urlsByMessageIDSDictionary[model.messageID]   = urlsArray;
        }
    }
    
    
    return imagesArray;
    
}



@end
