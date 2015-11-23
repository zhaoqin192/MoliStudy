//
//  ModelManager.m
//  MoliStudy1
//
//  Created by zhaoqin on 10/25/15.
//  Copyright © 2015 张鹏. All rights reserved.
//

#import "ModelManager.h"

@implementation ModelManager

static ModelManager *manager = nil;

+ (ModelManager *) getInstance{
    if(manager == nil){
        manager = [[ModelManager alloc] init];
        manager.subjectArray = [[NSMutableArray alloc] init];
        
    }
    return manager;
}



@end
