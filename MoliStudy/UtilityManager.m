//
//  UtilityBL.m
//  MoliStudy
//
//  Created by zhaoqin on 11/22/15.
//  Copyright © 2015 MoliStudy. All rights reserved.
//

#import "UtilityManager.h"
#import "RSA.h"

@implementation UtilityManager

+ (NSString*) encryptPassword:(NSString *)password{
    RSA *rsa = [[RSA alloc] init];
    [rsa encryptWithString:password];
    return rsa.str1;
}

+ (NSString *) removeHTMLTag:(NSString *)input{
    NSString *result = [[NSString alloc] init];
    NSString *pattern = @"(<.*?>)";
    NSRegularExpression *regular;
    regular = [[NSRegularExpression alloc] initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    result = [regular stringByReplacingMatchesInString:input options:NSRegularExpressionCaseInsensitive range:NSMakeRange(0, [input length]) withTemplate:@"-"];
    return result;
}

@end
