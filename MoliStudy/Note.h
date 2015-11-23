//
//  Note.h
//  MoliStudy1
//
//  Created by zhaoqin on 10/25/15.
//  Copyright © 2015 张鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Note : NSObject

@property(strong, nonatomic) NSString *positionStart;
@property(strong, nonatomic) NSString *positionEnd;
@property(strong, nonatomic) NSString *style;
@property(strong, nonatomic) NSString *noteContent;

//- (void) initData;

@end
