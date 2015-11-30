//
//  UtilityBL.h
//  MoliStudy
//
//  Created by zhaoqin on 11/22/15.
//  Copyright © 2015 MoliStudy. All rights reserved.
//

#import <Foundation/Foundation.h>

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


@end
