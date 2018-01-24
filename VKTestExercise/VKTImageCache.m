//
//  VKTImageCache.m
//  VKTestExercise
//
//  Created by Alex Kosyakov on 13.01.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import "VKTImageCache.h"

static NSDictionary *__imageCacheDictionary;

@implementation VKTImageCache

+ (void)cacheImageData:(NSData *)data forURL:(NSURL *)url {
    if (!url.absoluteString.length || !data) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:[url absoluteString]];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSData *)cachedImageDataForURL:(NSURL *)url {
    if (!url.absoluteString.length) {
        return nil;
    }
    return [[NSUserDefaults standardUserDefaults] objectForKey:[url absoluteString]];
}

+ (void)imageFromURL:(NSURL *)url completion:(void(^)(UIImage *image))completion {
  dispatch_async(dispatch_queue_create("com.vkttestexercise.asynchimageloader", NULL), ^(void) {
    NSData *imageData = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:imageData];
    [[self class] cacheImageData:imageData forURL:url];
    dispatch_async(dispatch_get_main_queue(), ^{
      if (completion) {
        completion(image);
      }
    });
  });
  
}



@end
