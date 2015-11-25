//
//  TextStyle.m
//  MoliStudy1
//
//  Created by 王霄 on 15/10/28.
//  Copyright © 2015年 张鹏. All rights reserved.
//

#import "TextStyle.h"

@implementation TextStyle

- (instancetype)init
{
    self = [super init];
    if (self) {
        _foregroundColor = @{
             @"f_red"    : @"#ff6f6f",
             @"f_blue"   : @"#bfe5ff",
             @"f_green"  : @"#d2eaa7",
             @"f_yellow" : @"#fcfe87",
             @"f_orange" : @"#ffd39f",
             @"f_purple" : @"#fac6e8",
             @"f_gray"   : @"#d1d1d1",
             @"f_blank"  : @"#111111"  //黑色是我自己设的值
                             };
        _backgroundColor = @{
            @"bg_gray"   : @"#ababab",
            @"bg_blue"   : @"#8acfff",
            @"bg_green"  : @"#add85f",
            @"bg_orange" : @"#ffaf51",
            @"bg_purple" : @"#f598d6",
            @"bg_yellow" : @"#fafd24",
            @"bg_red"    : @"#FFBEBE",
                             };
        _priority = @[ @"bg_gray"   ,
                       @"bg_blue"   ,
                       @"bg_green"  ,
                       @"bg_orange" ,
                       @"bg_purple" ,
                       @"bg_yellow" ,
                       @"bg_red"
                    ];
    }
    return self;
}

- (NSComparisonResult)compare:(TextStyle*)style{
    NSComparisonResult result = [[NSNumber numberWithInt:self.order] compare:[NSNumber numberWithInt:style.order]];
    return result;
}

@end
