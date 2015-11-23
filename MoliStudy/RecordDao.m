//
//  RecordDao.m
//  MoliStudy
//
//  Created by zhaoqin on 11/22/15.
//  Copyright © 2015 MoliStudy. All rights reserved.
//

#import "RecordDao.h"
#import "Record.h"
#import "DAOContext.h"

@implementation RecordDao{
    AppDelegate *appDelegate;
    NSManagedObjectContext *appContext;
}

static RecordDao* sharedManager = nil;

- (id)init{
    self = [super init];
    appDelegate = [DAOContext getInstance].appDelegate;
    appContext = [DAOContext getInstance].appContext;
    return self;
}

-(void)save{
    [appDelegate saveContext];
}

+ (RecordDao*)sharedManager{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedManager = [[self alloc] init];
        NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Record" inManagedObjectContext:sharedManager->appContext];
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        [request setEntity:entityDescription];
        NSError *error = nil;
        NSArray *array =[sharedManager->appContext executeFetchRequest:request error:&error];
        if([array count] != 0){
            sharedManager.record = array[0];
        }
    });
    
    return sharedManager;
}

- (void)add:(Record *)model{
    self.record = model;
    [self save];
}

- (void)modify:(Record *)model{
    self.record.forecast = model.forecast;
    self.record.accuracy = model.accuracy;
    self.record.complete = model.complete;
    [self save];
}

- (Record*)findRecord{
    return self.record;
}

@end
