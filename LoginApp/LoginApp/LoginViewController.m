//
//  LoginViewController.m
//  LoginApp
//
//  Created by Tim Studt on 03/07/2016.
//  Copyright © 2016 ts. All rights reserved.
//

#import "LoginViewController.h"
#import "SessionManager.h"
#import "SpinnerView.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UIView *viewContainer;
@property (weak, nonatomic) IBOutlet UITextField *userAccountTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;
@property (nonatomic) CGFloat originalBottomConstraintConstant;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerViewWidthConstraint;
@end

@implementation LoginViewController

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.originalBottomConstraintConstant = self.bottomConstraint.constant;
    [self registerForKeyboardNotificationsWithSelector:@selector(changeToolbarFrame:)];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self hideKeyboard];
    
    [self unregisterForKeyboardNotifications];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self showContainerView:YES animated:YES completionHandler:nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

/*
 // In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Actions

- (IBAction)didTapLogin:(id)sender {
    
    [self hideKeyboard];
    
    [SpinnerView showInView:self.viewContainer];

    NSString *username = self.userAccountTextField.text;
    NSString *password = self.passwordTextField.text;
   
    [SessionManager loginWithUsername:username
                             password:password
                    completionHandler:^(BOOL success, NSError *error) {
        [SpinnerView hide];
        if (success) {
            [self performSegueWithIdentifier:@"LoginToMain" sender:self];
        } else {
            [self showAlertError:error completion:nil];
        }
    }];
}

- (IBAction)didTapCancel:(id)sender {
    [self showContainerView:NO animated:YES completionHandler:^{
        [self dismissViewControllerAnimated:NO
                                 completion:nil];
    }];
}

#pragma mark - TextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    [textField removeTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    NSError *error = nil;
    
    if (textField == self.userAccountTextField) {
        if (textField.text.isValidUsername) {
            [self.passwordTextField becomeFirstResponder];
        } else {
            error = [NSError errorInvalidUsername];
        }
    } else if (textField == self.passwordTextField && !textField.text.isValidPassword) {
        error = [NSError errorInvalidPassword];
    }
    
    if (error) {
        [self showAlertError:error completion:nil];
    }

    return error == nil;
}

- (void)textFieldDidChange:(UITextField *)textField {

    [self updateButton];
}

#pragma mark - keyboardNotifications

- (void)changeToolbarFrame:(NSNotification *)notification
{
    NSValue* keyboardFrame = [notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrameRect = [keyboardFrame CGRectValue];
    
    CGPoint convertedPoint = [[UIApplication sharedApplication].keyWindow convertPoint:keyboardFrameRect.origin toView:self.view];

    self.bottomConstraint.constant = self.originalBottomConstraintConstant + (self.view.bounds.size.height - convertedPoint.y);
    
    [UIView animateWithDuration:[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
        [self.view layoutIfNeeded];
        
    }];
}

#pragma mark - private methods

- (void)hideKeyboard {
    
    if (self.userAccountTextField.isFirstResponder) {
        [self.userAccountTextField resignFirstResponder];
    } else if (self.passwordTextField.isFirstResponder) {
        [self.passwordTextField resignFirstResponder];
    }
}

- (BOOL)validateTextFields {
    
    return  self.userAccountTextField.text.isValidUsername && self.passwordTextField.text.isValidPassword;
}

- (void)setupUI {
    
    [self showContainerView:NO];
    
    [self updateButton];
}

- (void)updateButton {
    
    self.loginButton.enabled = [self validateTextFields];
}

- (void)showContainerView:(BOOL)show {
    [self showContainerView:show animated:NO completionHandler:nil];
}

- (void)showContainerView:(BOOL)show animated:(BOOL)animated completionHandler:(void(^)())completion {
    
    CGFloat width = show ? 250.0 : 0.0;
    
    self.containerViewWidthConstraint.constant = width;

    if (animated) {
        if (!show) {
            //hide first
            [self showContainerContent:NO];
        }
        [UIView animateWithDuration:0.3
                              delay:0.2
             usingSpringWithDamping:0.8
              initialSpringVelocity:0.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.view.alpha = show ? 1.0 : 0.0;
                             [self.view layoutIfNeeded];
                         } completion:^(BOOL finished) {
                             if (show) {
                                 //show after animation
                                 [self showContainerContent:YES];
                             }
                             if (completion) {
                                 completion();
                             }
                         }];
    } else {
        [self showContainerContent:show];
        self.view.alpha = show ? 1.0 : 0.0;
        [self.view layoutIfNeeded];
        if (completion) {
            completion();
        }
    }
}

- (void)showContainerContent:(BOOL)show {
    self.userAccountTextField.hidden = !show;
    self.passwordTextField.hidden = !show;
    self.loginButton.hidden = !show;
    self.cancelButton.hidden = !show;
}

@end
