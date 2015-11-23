//
//  Think-LabelModel.m
//  
//
//  Created by 张鹏 on 15/8/14.
//
//

#import "Think-LabelModel.h"

@implementation Think_LabelModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
    if ([key isEqual: @"id"]) {
        self.ID = [value intValue];
    }
}

@end
