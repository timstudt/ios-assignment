//
//  UIView+Helpers.m
//  LoginApp
//
//  Created by Tim Studt on 04/07/2016.
//  Copyright © 2016 ts. All rights reserved.
//

#import "UIView+Helpers.h"

@implementation UIView (AutoLayout)

- (void)addDefaultConstraints {
    
    if (self.superview == nil) {
        return;
    }
    //Superview's default margin = 12
    NSArray *constraintsH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(-12)-[self]-(-12)-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self)];
    NSArray *constraintsV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(-12)-[self]-(-12)-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self)];
    [self.superview addConstraints:constraintsH];
    [self.superview addConstraints:constraintsV];
}

@end
