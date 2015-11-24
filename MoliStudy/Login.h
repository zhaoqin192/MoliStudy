//
//  Login.h
//  Coding_iOS
//
//  Created by 王 原闯 on 14-7-31.
//  Copyright (c) 2014年 Coding. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Login : NSObject
//请求
@property (readwrite, nonatomic, strong) NSString *email, *password;

+ (void)setPreUserEmail:(NSString *)emailStr;
+ (NSString *)preUserEmail;

@end
