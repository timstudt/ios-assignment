//
//  ViewController.m
//  LoginApp
//
//  Created by Tim Studt on 03/07/2016.
//  Copyright © 2016 ts. All rights reserved.
//

#import "ViewController.h"
#import "SpinnerView.h"
#import "SessionManager.h"
#import "UserModel.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *loginButton;
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (IBAction)prepareForUnwind:(UIStoryboardSegue *)segue {
    [self updateUI];
}

- (void)setupUI {
    
    [self.navigationItem setHidesBackButton:YES];
    [self showLoggedInView:[SessionManager sharedManager].isValidSession];
    
}

- (void)updateUI {
    [self showLoggedInView:[SessionManager sharedManager].isValidSession];
}

- (IBAction)didTapLoginButton:(id)sender {
    if ([[SessionManager sharedManager] isValidSession]) {
        [SpinnerView show];
        [SessionManager logoutCompletionHandler:^(BOOL success, NSError *error) {
            [SpinnerView hide];
            [self showLoggedInView:NO];
        }];
    } else {
        [self performSegueWithIdentifier:@"MainToLogin" sender:self];
    }
}

- (void)showLoggedInView:(BOOL)show {
    self.title = [SessionManager sharedManager].user.name;
    if (show ) {
        self.loginButton.title = @"Log Out";
        self.contentImageView.image = [UIImage imageNamed:@"woohoo"];
    } else {
        self.loginButton.title = @"Log In";
        self.contentImageView.image = nil;
        [self.view layoutIfNeeded];
    }
}

@end
