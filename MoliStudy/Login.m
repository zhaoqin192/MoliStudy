//
//  Login.m
//  MoliStudy
//
//  Created by 王霄 on 15/12/2.
//  Copyright © 2015年 MoliStudy. All rights reserved.
//

#import "Login.h"

#define kLoginPreUserEmail @"pre_user_email"

@implementation Login

- (instancetype)init
{
    self = [super init];
    if (self) {
        _email = @"";
        _password = @"";
    }
    return self;
}

@end
