//
//  thinklabellist_model.m
//  
//
//  Created by 张鹏 on 15/8/14.
//
//

#import "thinklabellist_model.h"

@implementation thinklabellist_model

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
    if ([key isEqual: @"id"]) {
        self.ID = value;
    }
}

@end
