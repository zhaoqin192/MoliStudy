//
//  RecordBL.h
//  MoliStudy
//
//  Created by zhaoqin on 11/22/15.
//  Copyright © 2015 MoliStudy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Record;
@class RecordDao;

@interface RecordBL : NSObject

- (Record*) findRecord;
- (void) addWithForecast:(NSNumber *)forecast withTotal:(NSNumber *)total withCorrect:(NSNumber *)correct;
@end
