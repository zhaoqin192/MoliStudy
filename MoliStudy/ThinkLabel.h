//
//  ThinkLabel.h
//  MoliStudy1
//
//  Created by zhaoqin on 10/25/15.
//  Copyright © 2015 张鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThinkLabel : NSObject

@property(strong, nonatomic) NSString *name;
@property(strong, nonatomic) NSMutableArray *noteArray;

- (void) initData;

@end
