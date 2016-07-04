//
//  UIViewController+Helpers.h
//  LoginApp
//
//  Created by Tim Studt on 03/07/2016.
//  Copyright © 2016 ts. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface UIViewController (Alert)

- (void)showAlertError:(NSError *)error completion:(void (^ __nullable)(void))completion;
- (void)showAlertTitle:(NSString *)title message:(NSString *)message button:(nullable NSString *)button completion:(void (^ __nullable)(void))completion;

@end

@interface UIViewController (KeyboardHandling)

- (void)unregisterForKeyboardNotifications;
- (void)registerForKeyboardNotificationsWithSelector:(SEL) aSelector;

@end
NS_ASSUME_NONNULL_END

