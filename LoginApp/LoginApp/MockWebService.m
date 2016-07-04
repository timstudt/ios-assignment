//
//  MockWebService.m
//  LoginApp
//
//  Created by Tim Studt on 03/07/2016.
//  Copyright © 2016 ts. All rights reserved.
//

#import "MockWebService.h"

@interface MockWebService()

//+ (instancetype)sharedManager;
@property (nonatomic, strong) NSDateFormatter *defaultDateFormatter;
@end

@implementation MockWebService

static MockWebService *sharedInstance = nil;

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    
    return sharedInstance;
}

+ (void)loginWithEmail:(NSString *)email password:(NSString *)password completionHandler:(void(^)(NSString *sessionKey, NSError *error))completion {
    
    [self mockRequestCompletionHandler:^{
        NSError *error = nil;
        NSString *sessionKey = nil;
        NSString *username = [email removeDomainFromEmail];
        if ([username isEqualToString:password]) {
            sessionKey = [[self sharedInstance] generateSessionKey];
        } else {
            error = [NSError errorLoginFailed];
        }
        
        if (completion) {
            completion(sessionKey, error);
        }
    }];
}

+ (void)validateSessionKey:(NSString *)sessionKey completionHandler:(void(^)(BOOL success, NSError *error))completion {
    [self mockRequestCompletionHandler:^{
        BOOL isValid = [[self sharedInstance] isValidSessionKey:sessionKey];
        NSError *error = nil;
       
        if (!isValid) {
            error = [NSError errorInvalidSessionKey];
        }
        
        if (completion) {
            completion(isValid, error);
        }
    }];
}

+ (void)logoutCompletionHandler:(void(^)(BOOL success, NSError *error))completion {
    [self mockRequestCompletionHandler:^{
        //always succeed
        if (completion) {
            completion(YES, nil);
        }
    }];
}

+ (void)mockRequestCompletionHandler:(void(^)())completion {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (completion) {
            completion();
        }
    });
}

- (BOOL)isValidSessionKey:(NSString *)sessionKey {
    static NSTimeInterval timeOut = 1.0 * 60.0;
    NSDate *date = [[self defaultDateFromatter] dateFromString:sessionKey];
    return [[NSDate date] timeIntervalSinceDate:date] <= timeOut;
}

- (NSString *)generateSessionKey {
    return [[self defaultDateFromatter] stringFromDate:[NSDate date]];
}

- (NSDateFormatter *)defaultDateFromatter {
    if (!_defaultDateFormatter) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
        formatter.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
        formatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_GB"];
        _defaultDateFormatter = formatter;
    }
    return _defaultDateFormatter;
}

@end