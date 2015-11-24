//
//  ModelManager.h
//  MoliStudy1
//
//  Created by zhaoqin on 10/25/15.
//  Copyright © 2015 张鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelManager : NSObject

/**
 *  Subject of array
 */
@property(strong, nonatomic) NSMutableArray *subjectArray;

/**
 *  Report of array
 */
@property(strong, nonatomic) NSMutableArray *reportArray;

/**
 *  get Singleton of ModelManager
 *
 *  @return Singleton
 */
+ (ModelManager *) getInstance;

@end
