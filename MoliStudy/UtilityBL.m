//
//  UtilityBL.m
//  MoliStudy
//
//  Created by zhaoqin on 11/22/15.
//  Copyright © 2015 MoliStudy. All rights reserved.
//

#import "UtilityBL.h"
#import "RSA.h"

@implementation UtilityBL

+ (NSString*) encryptPassword:(NSString *)password{
    RSA *rsa = [[RSA alloc] init];
    [rsa encryptWithString:password];
    return rsa.str1;
}

@end
