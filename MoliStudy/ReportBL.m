//
//  ReportBL.m
//  MoliStudy
//
//  Created by zhaoqin on 11/22/15.
//  Copyright © 2015 MoliStudy. All rights reserved.
//

#import "ReportBL.h"
#import "Record.h"

@implementation ReportBL

static ReportBL *sharedManager = nil;

+ (ReportBL*)getInstance{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedManager = [[ReportBL alloc] init];
        sharedManager.reportArray = [[NSMutableArray alloc] init];
    });
    return sharedManager;
}

- (void)add:(Report *)report{
    [self.reportArray addObject:report];
}

- (NSMutableArray *)findAll{
    return self.reportArray;
}

@end
