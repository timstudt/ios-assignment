//
//  NSError+Validation.h
//  LoginApp
//
//  Created by Tim Studt on 03/07/2016.
//  Copyright © 2016 ts. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError (Validation)

+ (instancetype) errorLoginFailed;
+ (instancetype) errorInvalidUsername;
+ (instancetype) errorInvalidPassword;
+ (instancetype) errorInvalidSessionKey;

@end
