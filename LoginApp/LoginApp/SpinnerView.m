//
//  SpinnerView.m
//  LoginApp
//
//  Created by Tim Studt on 03/07/2016.
//  Copyright © 2016 ts. All rights reserved.
//

#import "SpinnerView.h"
#import "AppDelegate.h"

@interface SpinnerView()
@property (nonatomic, strong) UIActivityIndicatorView *spinner;
@end

@implementation SpinnerView

static SpinnerView *sharedInstance = nil;

#pragma mark - Class functions

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
        sharedInstance.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.45];
    });
    
    return sharedInstance;
}

+ (void)show {
    [[SpinnerView sharedInstance] showInView:nil];
}

+ (void)showInView:(UIView *)view {
    [[SpinnerView sharedInstance] showInView:view];
}

+ (void)hide {
    [[SpinnerView sharedInstance] hide];
}

#pragma mark - Instance methods

- (void)showInView:(UIView *)view {
    
    if (view) {
        self.frame = view.bounds;
        self.translatesAutoresizingMaskIntoConstraints = NO;
        [view addSubview:self];
        [self addDefaultConstraints];
    } else {
        UIWindow *window = [[UIApplication sharedApplication].delegate window];
        self.frame = window.bounds;
        self.translatesAutoresizingMaskIntoConstraints = NO;
        [window addSubview:self];
        [self addDefaultConstraints];
    }
    [self show];
}

- (void)show {
    [self.spinner startAnimating];
}

- (void)hide {
    [self.spinner stopAnimating];
    [self removeFromSuperview];
}

#pragma mark - setters/getters

- (UIActivityIndicatorView *)spinner {
    
    if (!_spinner) {
        UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithFrame:self.bounds];
        spinner.hidesWhenStopped = YES;
        spinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
        spinner.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:spinner];
        [spinner addDefaultConstraints];
        _spinner = spinner;
    }
    return _spinner;
}

@end
