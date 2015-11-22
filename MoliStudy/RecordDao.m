//
//  RecordDao.m
//  MoliStudy
//
//  Created by zhaoqin on 11/22/15.
//  Copyright © 2015 MoliStudy. All rights reserved.
//

#import "RecordDao.h"
#import "Record.h"

@implementation RecordDao

static RecordDao* sharedManager = nil;

+ (RecordDao*)sharedManager{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedManager = [[self alloc] init];
        sharedManager.record = [[Record alloc] init];
    });
    
    return sharedManager;
}

- (void)add:(Record *)model{
    self.record = model;
}

- (void)modify:(Record *)model{
    self.record.forecast = model.forecast;
    self.record.accuracy = model.accuracy;
    self.record.complete = model.complete;
}

- (Record*)findRecord{
    return self.record;
}

@end
