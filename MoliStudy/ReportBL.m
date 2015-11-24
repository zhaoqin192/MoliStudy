//
//  ReportBL.m
//  MoliStudy
//
//  Created by zhaoqin on 11/22/15.
//  Copyright © 2015 MoliStudy. All rights reserved.
//

#import "ReportBL.h"
#import "Report.h"
#import "DAOContext.h"
#import "ModelManager.h"

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

- (NSMutableArray *)findAll{
    return self.reportArray;
}

- (void)addArray:(NSArray *)array{
    NSManagedObjectContext *appContext = [DAOContext getInstance].appContext;
    for(NSDictionary *reportDic in array){
        Report *report = [NSEntityDescription insertNewObjectForEntityForName:@"Report" inManagedObjectContext:appContext];
        report.name = [reportDic objectForKey:@"name"];
        report.knowledgeID = [reportDic objectForKey:@"id"];
        report.score = [NSNumber numberWithInt:[[reportDic objectForKey:@"cur_score"] intValue]];
        report.variety = [NSNumber numberWithInt:[[reportDic objectForKey:@"change"] intValue]];
        [self.reportArray addObject:report];
    }
    [ModelManager getInstance].reportArray = self.reportArray;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NETWORKREQUEST_REPORT_SUCCESS" object:nil];
}

@end
