//
//  UIViewController+Alerts.m
//  Flowers
//
//  Created by Alex Kosyakov on 1/10/17.
//  Copyright © 2017 Cube Innovations, Inc. All rights reserved.
//

#import "UIViewController+Alerts.h"

@implementation UIViewController (Alerts)

#pragma mark UIAlertControllerStyleActionSheet

- (void)showActionSheetControllerWithTitle:(NSString *)title actionTitles:(NSArray <NSString *> *)titles
                                completion:(void(^)(NSUInteger pressedIndex))completion {
    UIAlertController *vc = [UIAlertController alertControllerWithTitle:title
                                                                message:nil
                                                         preferredStyle:UIAlertControllerStyleActionSheet];
    void (^innerCompletion)(UIAlertAction *action) = ^(UIAlertAction *action) {
      if (completion) {
        completion([titles indexOfObject:action.title]);
      }
    };
    for (int k = 0; k < titles.count; k ++) {
      NSString *title = titles[k];
      UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:innerCompletion];
      [vc addAction:action];
    }
    [vc addAction:[self cancelActionWithCompletion:innerCompletion]];
  
    [self presentViewController:vc animated:YES completion:nil];
}


#pragma One Action
- (void)showSimpleAlertWithMessage:(NSString *)message {
  [self showSimpleAlertWithMessage:message title:nil];
}

- (void)showSimpleAlertWithMessage:(NSString *)message title:(NSString *)title {
  [self showSimpleAlertWithMessage:message title:title actions:@[[self okAction]]];
}

- (void)showSimpleAlertWithMessage:(NSString *)message title:(NSString *)title actions:(NSArray<UIAlertAction *> *)actions {
  UIAlertController *ac = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
  [actions enumerateObjectsUsingBlock:^(UIAlertAction *action, NSUInteger idx, BOOL *stop) {
    [ac addAction:action];
  }];
  [self presentViewController:ac animated:YES completion:nil];
}


#pragma YES/NO Actions
- (void)showSimpleYesNoAlertWithMessage:(NSString *)message completion:(void(^)(BOOL answer))completion {
  [self showSimpleYesNoAlertWithMessage:message title:nil completion:completion];
}

- (void)showSimpleYesNoAlertWithMessage:(NSString *)message okTitle:(NSString *)okTitle cancelTitle:(NSString *)cancelTitle completion:(void(^)(BOOL answer))completion {
  [self showSimpleYesNoAlertWithMessage:message title:nil okTitle:okTitle cancelTitle:cancelTitle completion:completion];
}

- (void)showSimpleYesNoAlertWithMessage:(NSString *)message title:(NSString *)title completion:(void(^)(BOOL answer))completion {
  [self showSimpleYesNoAlertWithMessage:message title:title okTitle:NSLocalizedString(@"ОК", nil) cancelTitle:NSLocalizedString(@"CANCEL", nil) completion:completion];
}


- (void)showSimpleYesNoAlertWithMessage:(NSString *)message title:(NSString *)title okTitle:(NSString *)okTitle cancelTitle:(NSString *)cancelTitle  completion:(void(^)(BOOL answer))completion {
  UIAlertController *ac = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
  void (^actionCompletion)(UIAlertAction *action) = ^(UIAlertAction *action) {
    if (completion) {
      completion(action.style == UIAlertActionStyleDefault);
    }
  };
  [ac addAction:[self defaultAction:okTitle completion:actionCompletion]];
  [ac addAction:[self cancelAction:cancelTitle completion:actionCompletion]];
  [self presentViewController:ac animated:YES completion:nil];
}


#pragma UIAlertActions

- (UIAlertAction *)okAction {
  return [self okActionWithCompletion:NULL];
}


- (UIAlertAction *)cancelAction {
  return [self cancelActionWithCompletion:NULL];
}


- (UIAlertAction *)okAction:(NSString *)title {
  return [self defaultAction:title completion:NULL];
}


- (UIAlertAction *)cancelAction:(NSString *)title  {
  return [self cancelAction:title completion:NULL];
}

- (UIAlertAction *)okActionWithCompletion:(void (^ __nullable)(UIAlertAction *action))handler {
  return [self defaultAction:NSLocalizedString(@"OK", nil) completion:handler];
}

- (UIAlertAction *)cancelActionWithCompletion:(void (^ __nullable)(UIAlertAction *action))handler {
  return [self cancelAction:NSLocalizedString(@"CANCEL", nil) completion:handler];
}


- (UIAlertAction *)defaultAction:(NSString *)title completion:(void (^ __nullable)(UIAlertAction *action))handler {
  return [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:handler];
}

- (UIAlertAction *)cancelAction:(NSString *)title completion:(void (^ __nullable)(UIAlertAction *action))handler {
  return [UIAlertAction actionWithTitle:title style:UIAlertActionStyleCancel handler:handler];
}

@end
