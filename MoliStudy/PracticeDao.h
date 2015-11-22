//
//  PracticeDao.h
//  MoliStudy
//
//  Created by zhaoqin on 11/22/15.
//  Copyright © 2015 MoliStudy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Practice;

@interface PracticeDao : NSObject
//保存数据列表
@property (strong, nonatomic) NSMutableArray* listData;

+ (PracticeDao*)sharedManager;

- (void)add:(Practice*)model;
- (void)remove:(Practice*)model;
- (void)modifiy:(Practice*)model;
- (NSMutableArray*)findAll;

@end
