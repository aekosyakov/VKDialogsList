//
//  VKTImageCache.h
//  VKTestExercise
//
//  Created by Alex Kosyakov on 13.01.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VKTImageCache : NSObject
+ (void)cacheImageData:(NSData *)date forURL:(NSURL *)url;
+ (NSData *)cachedImageDataForURL:(NSURL *)url;
+ (void)imageFromURL:(NSURL *)url completion:(void(^)(UIImage *image))completion;
@end
