//
//  NSString+Validation.h
//  LoginApp
//
//  Created by Tim Studt on 03/07/2016.
//  Copyright © 2016 ts. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Validation)

- (BOOL)isValidUsername;
- (BOOL)isValidPassword;

@end

@interface NSString (Trimming)

- (NSString *)removeWhitespaces;
- (BOOL)endsWithWhitespace;
- (NSString *)removeDomainFromEmail;

@end
