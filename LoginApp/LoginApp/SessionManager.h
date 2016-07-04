//
//  SessionManager.h
//  LoginApp
//
//  Created by Tim Studt on 03/07/2016.
//  Copyright © 2016 ts. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserModel;

@interface SessionManager : NSObject

+ (instancetype)sharedManager;

+ (BOOL)loginWithUsername:(NSString *)username password:(NSString *)password completionHandler:(void(^)(BOOL success, NSError *error))completion;
+ (void)logoutCompletionHandler:(void(^)(BOOL success, NSError *error))completion;

- (BOOL)isValidSession;

@property (nonatomic, strong) NSString *sessionKey;
@property (nonatomic, strong) UserModel *user;
@end
