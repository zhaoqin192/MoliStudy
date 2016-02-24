//
//  UtilityBL.m
//  MoliStudy
//
//  Created by zhaoqin on 11/22/15.
//  Copyright © 2015 MoliStudy. All rights reserved.
//

#import "UtilityManager.h"


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

//  根据字符串长度动态改变控件高度
+ (CGFloat) dynamicHeight:(NSString *)input{
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    
    NSAttributedString *attributedText = [[NSAttributedString alloc]initWithString:input attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:FONT_SIZE]}];
    CGRect rect = [attributedText boundingRectWithSize:constraint
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    CGSize size = rect.size;
    CGFloat height = MAX(size.height, 60.0f);
    return height + CELL_CONTENT_MARGIN * 2;
}

@end
