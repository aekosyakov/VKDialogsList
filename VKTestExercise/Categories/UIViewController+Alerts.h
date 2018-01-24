//
//  UIViewController+Alerts.h
//  Flowers
//
//  Created by Alex Kosyakov on 1/10/17.
//  Copyright © 2017 Cube Innovations, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Alerts)
- (void)showActionSheetControllerWithTitle:(NSString *_Nullable)title actionTitles:(NSArray <NSString *> *_Nullable)titles
                                completion:(void(^_Nullable)(NSUInteger pressedIndex))completion;

- (void)showSimpleAlertWithMessage:(NSString *_Nonnull)message;
- (void)showSimpleAlertWithMessage:(NSString *_Nullable)message title:(NSString *_Nullable)title;
- (void)showSimpleAlertWithMessage:(NSString *_Nullable)message title:(NSString *_Nullable)title actions:(NSArray<UIAlertAction *> *_Nullable)actions;


- (void)showSimpleYesNoAlertWithMessage:(NSString *_Nullable)message completion:(void(^_Nonnull)(BOOL answer))completion;
- (void)showSimpleYesNoAlertWithMessage:(NSString *_Nullable)message title:(NSString *_Nullable)title completion:(void(^_Nullable)(BOOL answer))completion;
- (void)showSimpleYesNoAlertWithMessage:(NSString *_Nullable)message okTitle:(NSString *_Nullable)okTitle cancelTitle:(NSString *_Nullable)cancelTitle completion:(void(^_Nullable)(BOOL answer))completion;

- (UIAlertAction *_Nonnull)defaultAction:(NSString *_Nullable)title completion:(void (^ __nullable)(UIAlertAction * _Nullable action))handler;
- (UIAlertAction *_Nonnull)cancelAction:(NSString *_Nullable)title completion:(void (^ __nullable)(UIAlertAction * _Nullable action))handler;

@end
