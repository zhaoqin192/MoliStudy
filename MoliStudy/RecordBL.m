//
//  RecordBL.m
//  MoliStudy
//
//  Created by zhaoqin on 11/22/15.
//  Copyright © 2015 MoliStudy. All rights reserved.
//

#import "RecordBL.h"
#import "Record.h"
#import "RecordDao.h"
#import "DAOContext.h"

@implementation RecordBL

- (Record*) findRecord{
    RecordDao *dao = [RecordDao sharedManager];
    return [dao findRecord];
}

- (void) addWithForecast:(NSNumber *)forecast withTotal:(NSNumber *)total withCorrect:(NSNumber *)correct{
    RecordDao *dao = [RecordDao sharedManager];
    NSManagedObjectContext *appContext = [DAOContext getInstance].appContext;
    Record *record = [NSEntityDescription insertNewObjectForEntityForName:@"Record" inManagedObjectContext:appContext];
    record.forecast = forecast;
    record.complete = [NSNumber numberWithInt:[total intValue]];
    record.accuracy = [NSString stringWithFormat:@"%f", correct.floatValue / total.floatValue];
    [dao add:record];
}


@end
