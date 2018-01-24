//
//  VKTService+VKRequestApi.m
//  VKTestExercise
//
//  Created by Alex Kosyakov on 20.01.2018.
//  Copyright © 2018 Alex Kosyakov. All rights reserved.
//

#import "VKTService+VKRequestApi.h"
#import "VKSDKHeader.h"
@implementation VKTService (VKRequestApi)
- (void)requestVKAPIMethod:(NSString *)methodName
                    params:(NSDictionary *)params
                completion:(void(^)(VKResponse *response, NSError *error))completion {
    VKRequest *request = [VKRequest requestWithMethod:methodName
                                           parameters:params];
    
    [request executeWithResultBlock:^(VKResponse *response) {
        if (completion) {
            completion(response, nil);
        }
    } errorBlock:^(NSError *error) {
        if (completion) {
            completion(nil, error);;
        }
    }];
    self.request = request;
}
@end
