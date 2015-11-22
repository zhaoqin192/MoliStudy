//
//  DAOContext.h
//  MoliStudy
//
//  Created by zhaoqin on 11/22/15.
//  Copyright © 2015 MoliStudy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface DAOContext : NSObject

@property (retain, nonatomic) AppDelegate *appDelegate;
@property (retain, nonatomic) NSManagedObjectContext *appContext;

+ (DAOContext*)getInstance;

@end
