//
//  Subject.m
//  MoliStudy1
//
//  Created by zhaoqin on 10/25/15.
//  Copyright © 2015 张鹏. All rights reserved.
//

#import "Subject.h"

@implementation Subject

- (void) initData{
    self.content = [[NSMutableArray alloc] init];
    self.answers = [[NSMutableArray alloc] init];
    self.correctAnswer = [[NSString alloc] init];
    self.thinkLabelID = [[NSMutableArray alloc] init];
    self.thinkLabel = [[NSMutableArray alloc] init];
    self.questionID = [[NSString alloc] init];
}

@end
