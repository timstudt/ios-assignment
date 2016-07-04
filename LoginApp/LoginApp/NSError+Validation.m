//
//  NSError+Validation.m
//  LoginApp
//
//  Created by Tim Studt on 03/07/2016.
//  Copyright © 2016 ts. All rights reserved.
//

#import "NSError+Validation.h"

static NSString *const kLoginAppErrorDomain = @"com.ts.demo.LoginApp.errordomain";

@implementation NSError (Validation)

+ (instancetype) errorLoginFailed {
    
    NSDictionary *userInfo = @{
                               NSLocalizedDescriptionKey: NSLocalizedString(@"Login failed.", nil),
                               NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString(@"The username or password is incorrect. Please try again.", nil)
                               };
    NSError *error = [NSError errorWithDomain:kLoginAppErrorDomain
                                         code:-666
                                     userInfo:userInfo];
    return error;
}

+ (instancetype) errorInvalidSessionKey {
    
    NSDictionary *userInfo = @{
                               NSLocalizedDescriptionKey: NSLocalizedString(@"Session timeout.", nil),
                               NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString(@"Please log in again.", nil)
                               };
    NSError *error = [NSError errorWithDomain:kLoginAppErrorDomain
                                         code:-667
                                     userInfo:userInfo];
    return error;
}

+ (instancetype) errorInvalidUsername {
   
    NSDictionary *userInfo = @{
                               NSLocalizedDescriptionKey: NSLocalizedString(@"Invalid email.", nil),
                               NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString(@"The username has to be a valid @shopgun email address.", nil)
                               };
    NSError *error = [NSError errorWithDomain:kLoginAppErrorDomain
                                         code:-668
                                     userInfo:userInfo];
    return error;
}

+ (instancetype) errorInvalidPassword {
    
    NSDictionary *userInfo = @{
                               NSLocalizedDescriptionKey: NSLocalizedString(@"Invalid password.", nil),
                               NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString(@"The password has to be at least 6 characters long.", nil)
                               };
    NSError *error = [NSError errorWithDomain:kLoginAppErrorDomain
                                         code:-669
                                     userInfo:userInfo];
    return error;
}

@end
