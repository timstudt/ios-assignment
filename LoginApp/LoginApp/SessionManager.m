//
//  SessionManager.m
//  LoginApp
//
//  Created by Tim Studt on 03/07/2016.
//  Copyright © 2016 ts. All rights reserved.
//

#import "SessionManager.h"
#import "UserModel.h"

#import "MockWebService.h"

@implementation SessionManager

static SessionManager *sharedInstance = nil;

#pragma mark - Class functions

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    
    return sharedInstance;
}

+ (BOOL)loginWithUsername:(NSString *)username password:(NSString *)password completionHandler:(void(^)(BOOL success, NSError *error))completion {

    return [[SessionManager sharedManager] loginWithUsername:username password:password completionHandler:completion];
}

+ (void)logoutCompletionHandler:(void(^)(BOOL success, NSError *error))completion {
    [[SessionManager sharedManager] logoutCompletionHandler:completion];
}

#pragma mark - methods

- (BOOL)isValidSession {
    //ToDo: call MockWebService for validation
    return self.sessionKey != nil;
}

- (BOOL)loginWithUsername:(NSString *)username password:(NSString *)password completionHandler:(void(^)(BOOL success, NSError *error))completion {
    
    if (![username isValidUsername] || ![password isValidPassword]) {
        if (completion) {
            completion(NO, [NSError errorLoginFailed]); //return nsError
        }
        return NO;
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        //call webservice on Background queue
        [MockWebService loginWithEmail:username password:password completionHandler:^(NSString *sessionKey, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                //run completion on Main queue
                if (sessionKey) {
                    //ToDo: archive or store in keychain
                    self.sessionKey = sessionKey;
                    self.user = [[UserModel alloc] initWithName:[username removeDomainFromEmail]];
            
                }
                
                if (completion) {
                    completion(sessionKey != nil, error); //forward parameters
                }
            });
        }];
    });
    
    return YES;
}

- (void)logoutCompletionHandler:(void(^)(BOOL success, NSError *error))completion {

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        [MockWebService logoutCompletionHandler:^(BOOL success, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (success) {
                    self.user = nil;
                    self.sessionKey = nil;
                }
                if (completion) {
                    completion(success, error); //forward parameters
                }
            });
        }];
    });
}

@end
