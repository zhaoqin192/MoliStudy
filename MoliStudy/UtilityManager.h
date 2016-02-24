//
//  UtilityBL.h
//  MoliStudy
//
//  Created by zhaoqin on 11/22/15.
//  Copyright © 2015 MoliStudy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSA.h"

#define FONT_SIZE 16.0f
#define CELL_CONTENT_WIDTH ScreenWidth
#define CELL_CONTENT_MARGIN 10.0f
#define color [UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1]

@interface UtilityManager : NSObject
/**
 *  encrypt password using RSA
 *
 *  @param password text
 *
 *  @return a string as param for network
 */
+ (NSString *) encryptPassword:(NSString *)password;

+ (NSString *) removeHTMLTag:(NSString *)input;

+ (CGFloat) dynamicHeight:(NSString *)input;


@end
