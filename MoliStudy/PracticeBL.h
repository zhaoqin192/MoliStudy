//
//  PracticeBL.h
//  MoliStudy
//
//  Created by zhaoqin on 11/22/15.
//  Copyright © 2015 MoliStudy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Practice.h"
#import "PracticeDao.h"

@interface PracticeBL : NSObject

- (void) addPractice:(Practice*)model;
- (NSMutableArray*) findAll;
- (void) updatePracticeList:(NSArray *)array;
@end
