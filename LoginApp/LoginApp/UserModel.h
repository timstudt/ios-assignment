//
//  UserModel.h
//  LoginApp
//
//  Created by Tim Studt on 04/07/2016.
//  Copyright © 2016 ts. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property (nonatomic, strong) NSString *name;

- (instancetype)initWithName: (NSString *)name;

@end
