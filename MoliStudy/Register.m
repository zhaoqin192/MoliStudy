//
//  Register.m
//  MoliStudy
//
//  Created by 王霄 on 15/12/2.
//  Copyright © 2015年 MoliStudy. All rights reserved.
//

#import "Register.h"

@implementation Register

- (instancetype)init
{
    self = [super init];
    if (self) {
        _phoneNumber = @"";
        _keyCode = @"";
        _password = @"";
    }
    return self;
}

@end
