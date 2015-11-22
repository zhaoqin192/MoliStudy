//
//  PracticeDao.m
//  MoliStudy
//
//  Created by zhaoqin on 11/22/15.
//  Copyright © 2015 MoliStudy. All rights reserved.
//

#import "PracticeDao.h"
#import "Practice.h"
#import "AppDelegate.h"

@implementation PracticeDao{
    AppDelegate *appDelegate;
    NSManagedObjectContext *appContext;
}

static PracticeDao* sharedManager = nil;

- (id)init{
    self = [super init];
    appDelegate = [[UIApplication sharedApplication] delegate];
    appContext = [appDelegate managedObjectContext];
    return self;
}

- (void)save{
    [appDelegate saveContext];
}

+ (PracticeDao*)sharedManager{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedManager = [[self alloc] init];
        sharedManager.listData = [[NSMutableArray alloc] init];
        
        NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Practice" inManagedObjectContext:sharedManager->appContext];
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        [request setEntity:entityDescription];
        NSError *error = nil;
        NSArray *requestArray = [sharedManager->appContext executeFetchRequest:request error:&error];
        if([requestArray count] != 0){
            for(Practice *practice in requestArray){
                [sharedManager.listData addObject:practice];
            }
        }
        
    });
    return sharedManager;
}

- (void)add:(Practice *)model{
    [self.listData addObject:model];
    [self save];
}

- (void)remove:(Practice *)model{
    for(Practice* practice in self.listData){
        if([practice.itemID isEqualToString:model.itemID]){
            [self.listData removeObject:model];
            break;
        }
    }
}

- (void)modifiy:(Practice *)model{
    for(Practice* practice in self.listData){
        if([practice.itemID isEqualToString:model.itemID]){
            practice.name = model.name;
            practice.finished = model.finished;
            practice.total = model.total;
        }
    }
    [self save];
}

- (NSMutableArray*)findAll{
    return self.listData;
}

@end
