//
//  UserModel.m
//  LoginApp
//
//  Created by Tim Studt on 04/07/2016.
//  Copyright © 2016 ts. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

- (instancetype)initWithName: (NSString *)name {
    if (self = [super init]) {
        _name = name;
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@:\nname: %@", [self class], _name];
}
@end
