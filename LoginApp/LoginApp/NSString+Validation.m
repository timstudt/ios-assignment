//
//  NSString+Validation.m
//  LoginApp
//
//  Created by Tim Studt on 03/07/2016.
//  Copyright © 2016 ts. All rights reserved.
//

#import "NSString+Validation.h"
#import "Constants.h"


@implementation NSString (Validation)
- (BOOL)isValidUsername {
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES[c] %@", kEmailRegex];
    
    return [emailTest evaluateWithObject:self];
}

- (BOOL)isValidPassword {
    return self.length >= kPasswordMinLength;
}

@end

@implementation NSString (Trimming)

- (NSString *)removeWhitespaces{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (BOOL)endsWithWhitespace{
    return [self hasSuffix:@" "];
}

- (NSString *)removeDomainFromEmail {
    return [self componentsSeparatedByString:@"@"].firstObject; //assuming there is max 1 '@' in valid email address
}
@end
