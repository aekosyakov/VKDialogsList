//
//  ContainerController.h
//  VKTestExercise
//
//  Created by Alex Kosyakov on 23.12.2017.
//  Copyright © 2017 Alex Kosyakov. All rights reserved.
//

#import "VKTBaseViewController.h"
@protocol VKTContainerProvider <NSObject>
@property (strong, nonatomic, readonly) id containerView;
- (void)changeContainerTo:(id )viewController;
- (void)addToContainer:(UIView *)viewToAdd;

@optional
- (void)addFadeEffect;
@end

@interface ContainerController : VKTBaseViewController <VKTContainerProvider>
@property (strong, nonatomic, readonly) UIView *containerView;
@end
