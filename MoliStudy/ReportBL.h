//
//  ReportBL.h
//  MoliStudy
//
//  Created by zhaoqin on 11/22/15.
//  Copyright © 2015 MoliStudy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Report;

@interface ReportBL : NSObject

@property (strong, nonatomic) NSMutableArray *reportArray;

+ (ReportBL*)getInstance;

- (void)add:(Report*) report;
- (NSMutableArray *)findAll;

@end
