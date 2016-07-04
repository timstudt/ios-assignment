//
//  MockWebService.h
//  LoginApp
//
//  Created by Tim Studt on 03/07/2016.
//  Copyright © 2016 ts. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MockWebService : NSObject

//+ (instancetype)sharedManager;

+ (void)loginWithEmail:(NSString *)email password:(NSString *)password completionHandler:(void(^)(NSString *sessionKey, NSError *error))completion;
+ (void)logoutCompletionHandler:(void(^)(BOOL success, NSError *error))completion;
+ (void)validateSessionKey:(NSString *)sessionKey completionHandler:(void(^)(BOOL success, NSError *error))completion;

@end
