//
//  AccountDao.m
//  MoliStudy
//
//  Created by zhaoqin on 11/22/15.
//  Copyright © 2015 MoliStudy. All rights reserved.
//

#import "AccountDao.h"
#import "Account.h"
#import "AppDelegate.h"

@implementation AccountDao{
    AppDelegate *appDelegate;
    NSManagedObjectContext *appContext;
}

static AccountDao* sharedManager = nil;

- (id)init{
    self = [super init];
    appDelegate = [[UIApplication sharedApplication] delegate];
    appContext = [appDelegate managedObjectContext];
    return self;
}

- (void)save{
    [appDelegate saveContext];
}

+ (AccountDao*)sharedManager{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedManager = [[self alloc] init];
        NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Account" inManagedObjectContext:sharedManager->appContext];
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        [request setEntity:entityDescription];
        NSError *error = nil;
        NSArray *array = [sharedManager->appContext executeFetchRequest:request error:&error];
        if([array count] != 0){
            sharedManager.account = array[0];
        }
    });
    
    return sharedManager;
}

- (void)add:(Account *)model{
    self.account = model;
    [self save];
}

- (void)modified:(Account *)model{
    self.account.accountName = model.accountName;
    self.account.password = model.password;
    self.account.userID = model.userID;
    self.account.userName = model.userName;
    self.account.currentAcademy = model.currentAcademy;
    self.account.targetAcademy = model.targetAcademy;
    [self save];
}

- (Account*)findAccount{
    return self.account;
}

@end
