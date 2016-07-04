//
//  UIViewController+Helpers.m
//  LoginApp
//
//  Created by Tim Studt on 03/07/2016.
//  Copyright © 2016 ts. All rights reserved.
//

#import "UIViewController+Helpers.h"

@implementation UIViewController (Alert)

- (void)showAlertError:(NSError *)error completion:(void (^ __nullable)(void))completion {
    
    NSString *title = error.localizedDescription;
    NSString *message = error.localizedRecoverySuggestion;
    [self showAlertTitle:title message:message button:@"Ok" completion:completion];

}

- (void)showAlertTitle:(NSString *)title message:(NSString *)message button:(nullable NSString *)button completion:(void (^ __nullable)(void))completion{
    
    UIAlertController *alertView;
    alertView = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertView addAction:[UIAlertAction actionWithTitle:(button?: @"Ok") style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertView animated:YES completion:completion];
    
}

@end

@implementation UIViewController (KeyboardHandling)

#pragma mark - Keyboard notifications

- (void)unregisterForKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidChangeFrameNotification object:nil];
}

- (void)registerForKeyboardNotificationsWithSelector:(SEL) aSelector {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:aSelector name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:aSelector name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:aSelector name:UIKeyboardDidHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:aSelector name:UIKeyboardDidChangeFrameNotification object:nil];
    
}

@end
