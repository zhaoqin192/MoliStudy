//
//  Subject.h
//  MoliStudy1
//
//  Created by zhaoqin on 10/25/15.
//  Copyright © 2015 张鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Subject : NSObject

@property(strong, nonatomic) NSMutableArray *content;
@property(strong, nonatomic) NSMutableArray *answers;
@property(copy, nonatomic) NSString *correctAnswer;
@property(strong, nonatomic) NSMutableArray *thinkLabelID;
@property(strong, nonatomic) NSMutableArray *thinkLabel;

- (void) initData;

@end
