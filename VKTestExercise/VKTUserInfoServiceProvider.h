//
//  VKTUserInfoServiceProvider.h
//  VKTestExercise
//
//  Created by Alex Kosyakov on 08.01.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import "VKTServiceProvider.h"
@protocol VKTUserInfoResult <VKTServiceResult>
@end
@protocol VKTUserInfoParser <VKTServiceParser>
- (NSObject <VKTUserInfoResult > *)resultWithError:(NSError *)error;
- (void)makeResultFromResponse:(VKResponse *)response completion:(void(^)(NSObject <VKTUserInfoResult > * result))completion;
@end

@protocol VKTUserInfoServiceProvider <VKTServiceProvider>
@property (strong, nonatomic) id <VKTUserInfoParser >parser;
- (void)getUsersInfo:(NSArray <NSNumber *> *)ids;
- (void)getGroupsInfo:(NSArray <NSNumber *> *)ids;
@end
