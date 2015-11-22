//
//  DAOContext.m
//  MoliStudy
//
//  Created by zhaoqin on 11/22/15.
//  Copyright © 2015 MoliStudy. All rights reserved.
//

#import "DAOContext.h"

@implementation DAOContext

static DAOContext *sharedManager = nil;

+ (DAOContext*)getInstance{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedManager = [[DAOContext alloc] init];
        sharedManager.appDelegate = [[UIApplication sharedApplication] delegate];
        sharedManager.appContext = [sharedManager.appDelegate managedObjectContext];
    });
    return sharedManager;
}

@end
