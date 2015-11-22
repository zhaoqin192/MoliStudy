//
//  RecordDao.h
//  MoliStudy
//
//  Created by zhaoqin on 11/22/15.
//  Copyright © 2015 MoliStudy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Record;

@interface RecordDao : NSObject

@property (strong, nonatomic) Record* record;

+ (RecordDao*)sharedManager;
- (void)add:(Record*)model;
- (void)modify:(Record*)model;
- (Record*)findRecord;

@end
